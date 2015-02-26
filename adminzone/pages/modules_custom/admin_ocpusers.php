<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

/**
 * Module page class.
 */
class Module_admin_ocpusers
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	 Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts'; 
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=true;
		return $info;
	}
	
	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('mayfeature');
		$GLOBALS['SITE_DB']->drop_if_exists('logged');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	 What version we're upgrading from (NULL: new install)
	 * @param  ?integer	 What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		$GLOBALS['SITE_DB']->create_table('mayfeature',array(
			'id'=>'*AUTO',
			'url'=>'URLPATH'
		));

		$GLOBALS['SITE_DB']->create_table('logged',array(
			'id'=>'*AUTO',
			'website_url'=>'URLPATH',
			'website_name'=>'SHORT_TEXT',
			'is_registered'=>'BINARY',	// NOT CURRENTLY USED
			'log_key'=>'INTEGER',	// NOT CURRENTLY USED
			'expire'=>'INTEGER', // 0 means never	// NOT CURRENTLY USED
			'l_version'=>'ID_TEXT',
			'hittime'=>'TIME'
		));
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	 A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('misc'=>'OC_SITES_INSTALLED');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	 The result of execution.
	 */
	function run()
	{
		require_lang('ocpcom');
		require_code('ocpcom');
		require_code('form_templates');

		$type=get_param('type','misc');
		if ($type=='misc') return $this->users();
	}

	/**
	 * List of sites that have installed ocPortal.
	 *
	 * @return tempcode	 The result of execution.
	 */
	function users()
	{
		$title=get_screen_title('OC_SITES_INSTALLED');

		$sortby=get_param('sortby','');

		$nameord='';
		$acpord='';
		$keyord='';
		$versord='';

		$orderby=get_param('orderby','desc');

		if ($orderby=='desc')
		{
			if ($sortby=='name') $nameord=':orderby=asc';
			elseif ($sortby=='acp') $acpord=':orderby=asc';
			elseif ($sortby=='vers') $versord=':orderby=asc';
			elseif ($sortby=='') $acpord=':orderby=asc';
		}

		$order_by='';
		if ($sortby=='name') $order_by='ORDER BY website_name ';
		elseif ($sortby=='acp') $order_by='ORDER BY hittime ';
		elseif ($sortby=='version') $order_by='ORDER BY l_version ';
		else $order_by='ORDER BY hittime ';

		$order_by.=($orderby=='desc')?'DESC':'ASC';

		$max=500;
		if ($sortby!='acp') $order_by='GROUP BY website_url '.$order_by; else $max=1000;

		$rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'logged WHERE website_url NOT LIKE \'%.myocp.com%\' AND website_name<>\'\' AND website_name<>\'(unnamed)\' '.$order_by,$max);

		$seen_before=array();

		$_rows=new ocp_tempcode();
		foreach ($rows as $i=>$r)
		{
			if (array_key_exists($r['website_url'],$seen_before)) continue;

			// Test that they give feature permission
			$url_parts=parse_url($r['website_url']);
			if (!array_key_exists('host',$url_parts)) continue;
			$perm=$GLOBALS['SITE_DB']->query_value_null_ok('mayfeature','id',array('url'=>$url_parts['scheme'].'://'.$url_parts['host']));
			if ((is_null($perm)) && (get_param_integer('no_feature',0)==1)) continue;

			$seen_before[$r['website_url']]=1;

			$rt=array();
			$rt['VERSION']=strval($r['l_version']);
			$rt['WEBSITE_URL']=strval($r['website_url']);
			$rt['WEBSITE_NAME']=strval($r['website_name']);
			$rt['LAST_ACP_ACCESS']=strval(round((time()-$r['hittime'])/60/60));
			$rt['LAST_ACP_ACCESS_2']=strval(round((time()-$r['hittime'])/60/60/24));
			$rt['KEY_EXPIRE']=strval(round((time()-$r['expire'])/60/60/24));
			if ($i<100)
			{
				$active=get_long_value_newer_than('testing__'.$r['website_url'].'/info.php',time()-60*60*10);
				if (is_null($active))
				{
					$test=http_download_file($r['website_url'].'/info.php',10,false,false,'Simple install stats',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.0);
					if (!is_null($test))
					{
						$active=do_lang('YES');
					} else
					{
						$active=@strval($GLOBALS['HTTP_MESSAGE']);
						if ($active=='')
							$active=do_lang('NO');
						else
							$active.=do_lang('OC_WHEN_CHECKING');
					}
					set_long_value('testing__'.$r['website_url'].'/info.php',$active);
				}
				$rt['OCP_ACTIVE']=$active;
			} else
			{
				$rt['OCP_ACTIVE']=do_lang('OC_CHECK_LIMIT');
			}

			$rt['NOTE']=$perm?do_lang('OC_MAY_FEATURE'):do_lang('OC_KEEP_PRIVATE');

			$_rows->attach(do_template('OC_SITE',$rt));
		}

		$out=do_template('OC_SITES',array('_GUID'=>'7f4b56c730f2b613994a3fe6f00ed525','TITLE'=>$title,'ROWS'=>$_rows,'NAMEORD'=>$nameord,'ACPORD'=>$acpord,'KEYORD'=>$keyord,'VERORD'=>$versord));

		return $out;
	}

}

