<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		banners
 */

class Block_main_buttons
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('param','extra','max');
		return $info;
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(array_key_exists(\'param\',$map)?$map[\'param\']:\'\',array_key_exists(\'extra\',$map)?$map[\'extra\']:\'\',array_key_exists(\'max\',$map)?intval($map[\'max\']):100)';
		$info['ttl']=60*24*7;
		return $info;
	}


	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		//first ensure there is 'buttons' banners category, and if it doesn't exist create it
		$id='buttons';
		$is_textual=0;
		$image_width=120;
		$image_height=60;
		$max_file_size=70;
		$comcode_inline=0;

		$test=$GLOBALS['SITE_DB']->query_value_null_ok('banner_types','id',array('id'=>$id));
		if (is_null($test))
		{
			$GLOBALS['SITE_DB']->query_insert('banner_types',array(
				'id'=>$id,
				't_is_textual'=>$is_textual,
				't_image_width'=>$image_width,
				't_image_height'=>$image_height,
				't_max_file_size'=>$max_file_size,
				't_comcode_inline'=>$comcode_inline
			));

			log_it('ADD_BANNER_TYPE',$id);
		}

		$submitter=$GLOBALS['FORUM_DRIVER']->get_guest_id();

		require_code('banners3');
		//create default banners, if they don't exist
		add_banner_quiet('ocportal','data_custom/causes/ocportal.gif','ocPortal','ocPortal',0,'http://ocportal.com/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('firefox','data_custom/causes/firefox.gif','Firefox','Firefox',0,'http://www.mozilla.com/firefox/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('w3cxhtml','data_custom/causes/w3c-xhtml.gif','W3C XHTML','W3C XHTML',0,'http://www.w3.org/MarkUp/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('w3ccss','data_custom/causes/w3c-css.gif','W3C CSS','W3C CSS',0,'http://www.w3.org/Style/CSS/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		//no banner image
		//add_banner_quiet('w3cwcag','data_custom/causes/w3c-wcag.gif','W3C WCAG','W3C WCAG',0,'http://www.w3.org/TR/WCAG10/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('cancerresearch','data_custom/causes/cancerresearch.gif','Cancer Research','Cancer Research',0,'http://www.cancerresearchuk.org/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('rspca','data_custom/causes/rspca.gif','RSPCA','RSPCA',0,'http://www.rspca.org.uk/home',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('peta','data_custom/causes/peta.gif','PETA','PETA',0,'http://www.peta.org',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('Unicef','data_custom/causes/unicef.gif','Unicef','Unicef',0,'http://www.unicef.org',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('wwf','data_custom/causes/wwf.gif','WWF','WWF',0,'http://www.wwf.org/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('greenpeace','data_custom/causes/greenpeace.gif','Greenpeace','Greenpeace',0,'http://www.greenpeace.com',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('helptheaged','data_custom/causes/helptheaged.gif','HelpTheAged','HelpTheAged',0,'http://www.helptheaged.org.uk/en-gb',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('nspcc','data_custom/causes/nspcc.gif','NSPCC','NSPCC',0,'http://www.nspcc.org.uk/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('oxfam','data_custom/causes/oxfam.gif','Oxfam','Oxfam',0,'http://www.oxfam.org',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('bringdownie6','data_custom/causes/bringdownie6.gif','BringDownIE6','BringDownIE6',0,'http://www.bringdownie6.com',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('cnd','data_custom/causes/cnd.gif','CND','CND',0,'http://www.cnduk.org/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('amnestyinternational','data_custom/causes/amnestyinternational.gif','Amnesty International','Amnesty International',0,'http://www.amnesty.org/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('bhf','data_custom/causes/bhf.gif','British Heart Foundation','British Heart Foundation',0,'http://www.bhf.org.uk/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

		add_banner_quiet('gnu','data_custom/causes/gnu.gif','GNU','GNU',0,'http://www.gnu.org/',3,'',0,NULL,$submitter,1,'buttons',NULL,0,0,0,0,NULL);

	}


	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_css('banners');

		if (!array_key_exists('param',$map)) $map['param']='';
		if (!array_key_exists('extra',$map)) $map['extra']='';
		if (!array_key_exists('title',$map)) $map['title']='I support'; //default value
		$max=array_key_exists('max',$map)?intval($map['max']):100;
		$height=(!empty($map['height']))?$map['height']:'100%';//default: 100%

		$set_height='';
		if ($height!='100%')
		{
			$set_height=' style="overflow: auto; width: 100%!important; height: '.$height.'!important;" ';
		}


		require_code('banners');

		$b_type=$map['param'];
		$myquery='SELECT * FROM '.get_table_prefix().'banners WHERE ((((the_type<>1) OR ((campaign_remaining>0) AND ((expiry_date IS NULL) or (expiry_date>'.strval(time()).')))) AND '.db_string_not_equal_to('name','').')) AND validated=1 AND '.db_string_equal_to('b_type',$b_type).' ORDER BY name';
		$banners=$GLOBALS['SITE_DB']->query($myquery,200/*Just in case of ridiculous numbers*/);
		$assemble=new ocp_tempcode();

		if (count($banners)>$max)
		{
			shuffle($banners);
			$banners=array_slice($banners,0,$max);
		}

		foreach ($banners as $i=>$banner)
		{
			$bd=show_banner($banner['name'],$banner['b_title_text'],get_translated_tempcode($banner['caption']),$banner['img_url'],'',$banner['site_url'],$banner['b_type']);
			$more_coming=($i<count($banners)-1);
			$assemble->attach(do_template('BLOCK_MAIN_BANNER_WAVE_BWRAP_CUSTOM',array('EXTRA'=>$map['extra'],'TYPE'=>$map['param'],'BANNER'=>$bd,'MORE_COMING'=>$more_coming)));
		}

		return do_template('BLOCK_MAIN_BUTTONS',array('EXTRA'=>$map['extra'],'TYPE'=>$map['param'],'ASSEMBLE'=>$assemble,'TITLE'=>$map['title'],'SET_HEIGHT'=>$set_height));
	}
}


