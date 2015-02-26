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

/*
For MyOCP (personal demos / sites system)...

Note that you must define some additional passwords in info.php...

$SITE_INFO['mysql_root_password']='xxx';
$SITE_INFO['mysql_myocp_password']='xxx';

You also need:
 - wildcard DNS configured
 - uploads/website_specific/ocportal.com/myocp/template.sql and uploads/website_specific/ocportal.com/myocp/template.tar defined appropriately
 - an uploads/website_specific/ocportal.com/myocp/sites/myocp directory for sites to be built into
*/

class Module_sites
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
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('sites');
		$GLOBALS['SITE_DB']->drop_if_exists('sites_email');
		$GLOBALS['SITE_DB']->drop_if_exists('sites_deletion_codes');
		$GLOBALS['SITE_DB']->drop_if_exists('sites_advert_pings');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	 What version we're upgrading from (NULL: new install)
	 * @param  ?integer	 What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		$GLOBALS['SITE_DB']->create_table('sites',array(
			's_codename'=>'*ID_TEXT',
			's_name'=>'SHORT_TEXT',
			's_description'=>'LONG_TEXT',
			's_category'=>'SHORT_TEXT', // Entertainment, Computers, Sport, Art, Music, Television/Movies, Businesses, Other, Informative/Factual, Political, Humour, Geographical/Regional, Games, Personal/Family, Hobbies, Culture/Community, Religious, Health
			's_domain_name'=>'SHORT_TEXT',
			's_server'=>'ID_TEXT',
			's_member_id'=>'USER',
			's_add_time'=>'TIME',
			's_last_backup_time'=>'?TIME',
			's_subscribed'=>'BINARY',
			's_sponsored_in_category'=>'BINARY',
			's_show_in_directory'=>'BINARY',
			's_sent_expire_message'=>'BINARY',
		));
		$GLOBALS['SITE_DB']->create_index('sites','sponsored',array('s_sponsored_in_category'));
		$GLOBALS['SITE_DB']->create_index('sites','timeorder',array('s_add_time'));
		$GLOBALS['SITE_DB']->create_index('sites','#s_name',array('s_name'));
		$GLOBALS['SITE_DB']->create_index('sites','#s_description',array('s_description'));
		$GLOBALS['SITE_DB']->create_index('sites','#s_codename',array('s_codename'));

		$GLOBALS['SITE_DB']->create_table('sites_email',array(
			's_codename'=>'*ID_TEXT',
			's_email_from'=>'*ID_TEXT',
			's_email_to'=>'SHORT_TEXT',
		));

		$GLOBALS['SITE_DB']->create_table('sites_deletion_codes',array(
			's_codename'=>'*ID_TEXT',
			's_code'=>'ID_TEXT',
			's_time'=>'TIME',
		));

		$GLOBALS['SITE_DB']->create_table('sites_advert_pings',array(
			'id'=>'*AUTO',
			's_codename'=>'ID_TEXT',
			's_time'=>'TIME',
		));
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	 A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('myocp'=>'MO_ADD_SITE','misc'=>'OC_DOWNLOAD_NOW');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	 The result of execution.
	 */
	function run()
	{
		require_code('ocpcom');
		require_lang('ocpcom');
		require_lang('installer');
		require_lang('search');
		require_lang('downloads');
		require_code('form_templates');
		require_lang('ecommerce');
		require_code('ecommerce');
		require_lang('ocf');

		$type=get_param('type','misc');

		// Main download screen
		if ($type=='misc') return $this->download_screen();

		// Hosting copy
		if ($type=='hostingcopy_step2') return $this->hostingcopy_step2();
		if ($type=='hostingcopy_step3') return $this->hostingcopy_step3();

		// myOCP (sites)
		if ($type=='myocp') return $this->myocp();
		if ($type=='_myocp') return $this->_myocp();

		return new ocp_tempcode();
	}

	/**
	 * Main download screen.
	 *
	 * @return tempcode	 The interface.
	 */
	function download_screen()
	{
		$title=get_screen_title('OC_DOWNLOAD_NOW');

		// Put together hosting-copy form
		$fields=new ocp_tempcode();
		$fields->attach(form_input_line(do_lang_tempcode('FTP_DOMAIN'),'','ftp_domain','',true));
		$fields->attach(form_input_line(do_lang_tempcode('FTP_USERNAME'),'','ftp_username','',true));
		$fields->attach(form_input_password(do_lang_tempcode('FTP_PASSWORD'),'','ftp_password',true));
		$fields->attach(form_input_line(do_lang_tempcode('SEARCH_UNDERNEATH'),do_lang_tempcode('DESCRIPTION_FTP_SEARCH_UNDER'),'search_under','/',false));
		$post_url=build_url(array('page'=>'_SELF','type'=>'hostingcopy_step2'),'_SELF');
		$submit_name=do_lang('PROCEED');
		$hostingcopy_form=do_template('FORM',array('HIDDEN'=>'','URL'=>$post_url,'FIELDS'=>$fields,'TEXT'=>do_lang_tempcode('OC_COPYWAIT'),'SUBMIT_NAME'=>$submit_name));

		// Put together details about releases
		$t=$GLOBALS['SITE_DB']->query_value_null_ok('download_downloads d LEFT JOIN '.get_table_prefix().'translate t ON t.id=d.comments','name',array('text_original'=>'This is the latest version.'));
		if (!is_null($t))
		{
			$releases=new ocp_tempcode();
			$latest=get_translated_text($t);
			$release_quick=$this->do_release($latest,'QUICK_');
			$release_manual=$this->do_release($latest.' (manual)','MANUAL_');
			$release_bleedingquick=$this->do_release('(bleeding-edge)','BLEEDINGQUICK_',is_null($release_quick)?NULL:$release_quick['QUICK_VERSION']);
			$release_bleedingmanual=$this->do_release('(bleeding-edge, manual)','BLEEDINGMANUAL_',is_null($release_manual)?NULL:$release_manual['MANUAL_VERSION']);
			$_releases=array();
			if (!is_null($release_quick)) $_releases+=$release_quick;
			if (!is_null($release_manual)) $_releases+=$release_manual;
			if (!is_null($release_bleedingquick)) $_releases+=$release_bleedingquick;
			if (!is_null($release_bleedingmanual)) $_releases+=$release_bleedingmanual;

			$releases=do_template('OC_DOWNLOAD_RELEASES',$_releases);
		} else
		{
			$latest=do_lang('NA');
			$releases=paragraph(do_lang_tempcode('OC_BETWEEN_VERSIONS'));
		}

		return do_template('OC_DOWNLOAD_SCREEN',array('_GUID'=>'4c4952e40ed96ab52461adce9989832d','TITLE'=>$title,'HOSTINGCOPY_FORM'=>$hostingcopy_form,'RELEASES'=>$releases,'VERSION'=>$latest));
	}

	/**
	 * Get template variables for a release.
	 *
	 * @param  SHORT_TEXT	A substring of the title of the download.
	 * @param  string			Prefix to put on the template params.
	 * @param  ?string		The version this must be newer than (NULL: no check).
	 * @return ?array			Map of template variables (NULL: could not find).
	 */
	function do_release($name,$prefix,$version_must_be_newer_than=NULL)
	{
		$rows=$GLOBALS['SITE_DB']->query('SELECT d.description as d_description,d.id AS d_id,num_downloads,file_size,text_original FROM '.get_table_prefix().'download_downloads d USE INDEX(downloadauthor) LEFT JOIN '.get_table_prefix().'translate t ON d.name=t.id WHERE '.db_string_equal_to('author','ocProducts').' AND validated=1 AND t.text_original LIKE \''.db_encode_like('%'.$name).'\' ORDER BY add_date DESC',1);
		if (!array_key_exists(0,$rows)) return NULL; // Shouldn't happen, but let's avoid transitional errors

		if (!is_null($version_must_be_newer_than))
		{
			if (strpos($version_must_be_newer_than,'.')===false) $version_must_be_newer_than.='.0.0'; // Weird, but PHP won't do version_compare right without it
		}

		$myrow=$rows[0];

		$id=$myrow['d_id'];
		$num_downloads=$myrow['num_downloads'];
		$keep=symbol_tempcode('KEEP');
		$url=find_script('dload',false,1).'?id='.strval($id).$keep->evaluate();
		require_code('version2');
		$version=get_version_dotted__from_anything($myrow['text_original']);
		$filesize=clean_file_size($myrow['file_size']);

		if (!is_null($version_must_be_newer_than))
		{
			if (version_compare($version_must_be_newer_than,$version)==1)
			{
				return NULL;
			}
		}

		return array($prefix.'VERSION'=>$version,$prefix.'NAME'=>$name,$prefix.'FILESIZE'=>$filesize,$prefix.'NUM_DOWNLOADS'=>number_format($num_downloads),$prefix.'URL'=>$url);
	}

	/**
	 * Worker function to do an FTP import.
	 *
	 * @param  resource			The FTP connection
	 * @param  PATH				The directory we are scanning
	 * @param  integer			The depth of the current scan level
	 * @return tempcode			The list of directories
	 */
	function _hostingcopy_do_dir($conn_id,$directory='/',$depth=0)
	{
		if ($directory=='') $directory='/';
		if ($directory[strlen($directory)-1]!='/') $directory.='/';

		$list=new ocp_tempcode();
		if (!@ftp_chdir($conn_id,$directory.'/'.$entry)) return $list; // Can't rely on ftp_nlist if not a directory
		$contents=ftp_nlist($conn_id,$directory);
		if ($contents===false) return $list;
		$list->attach(form_input_list_entry($directory,($directory=='/public_html/') || ($directory=='/www/') || ($directory=='/httpdocs/') || ($directory=='/htdocs/')));
		if ($depth==2) return $list;
		foreach ($contents as $entry)
		{
			$full_entry=$entry;
			$parts=explode('/',$entry);
			$entry=$parts[count($parts)-1];
			if ($entry=='')
			{
				if (!array_key_exists(count($parts)-2,$parts)) continue;
				$entry=$parts[count($parts)-2];
			}
			if (($entry=='.') || ($entry=='..') || ($entry=='') || ($entry=='conf') || ($entry=='anon_ftp') || ($entry=='logs') || ($entry=='imap') || ($entry=='statistics') || ($entry=='error_docs') || ($entry=='tmp') || ($entry=='mail') || ($entry[0]=='.') || ($entry=='etc') || (strpos($entry,'logs')!==false) || ($entry=='public_ftp')) continue;

			// Is the entry a directory?
			if ((strpos($entry,'.')===false) && (@ftp_chdir($conn_id,$directory.'/'.$entry)))
			{
				$full_path=$directory.$entry.'/';
				$list->attach($this->_hostingcopy_do_dir($conn_id,$full_path,$depth+1));
			}
		}

		return $list;
	}

	/**
	 * Try to make an FTP connection as specified by POST details. Dies if it can't.
	 *
	 * @return resource	  The connection.
	 */
	function _hostingcopy_ftp_connect()
	{
		$domain=trim(post_param('ftp_domain'));
		$port=21;
		if (strpos($domain,':')!==false)
		{
			list($domain,$_port)=explode(':',$domain,2);
			$port=intval($_port);
		}
		$conn_id=@ftp_connect($domain,$port);

		if ($conn_id===false) warn_exit(do_lang_tempcode('COULD_NOT_CONNECT_SERVER',escape_html(post_param('ftp_domain')),@strval($php_errormsg)));
		$login_result=@ftp_login($conn_id,post_param('ftp_username'),post_param('ftp_password'));

		// Check connection
		if (!$login_result)
		{
			warn_exit(do_lang_tempcode('FTP_ERROR'));
		}

		return $conn_id;
	}

	/**
	 * The UI to choose a path.
	 *
	 * @return tempcode	 The UI.
	 */
	function hostingcopy_step2()
	{
		$title=get_screen_title('HOSTING_COPY');

		if (function_exists('set_time_limit')) @set_time_limit(0);

		$hidden=build_keep_post_fields();

		$search_under=post_param('search_under','/');

		// Find paths
		$conn_id=$this->_hostingcopy_ftp_connect();
		$list=$this->_hostingcopy_do_dir($conn_id,$search_under);
		ftp_close($conn_id);

		if ($list->is_empty()) warn_exit(do_lang_tempcode('HOSTING_NO_FIND_DIR'));

		$base_url='http://'.preg_replace('#^ftp\.#','',post_param('ftp_domain')).preg_replace('#/(public_html|www|httpdocs|htdocs)/#','/',$search_under);

		$fields=new ocp_tempcode();
		$fields->attach(form_input_list(do_lang_tempcode('FTP_DIRECTORY'),'','path',$list));
		$fields->attach(form_input_line(do_lang_tempcode('NEW_DIRECTORY'),do_lang_tempcode('DESCRIPTION_NEW_DIRECTORY'),'extra_path','',false));
		$fields->attach(form_input_line(do_lang_tempcode('BASE_URL'),do_lang_tempcode('DESCRIPTION_BASE_URL'),'base_url',$base_url,true));
		$post_url=build_url(array('page'=>'_SELF','type'=>'hostingcopy_step3'),'_SELF');
		$submit_name=do_lang('HOSTING_COPY');

		return do_template('FORM_SCREEN',array('_GUID'=>'0758605aeb4ee00f1eee562c14d16a5f','HIDDEN'=>$hidden,'TITLE'=>$title,'URL'=>$post_url,'FIELDS'=>$fields,'TEXT'=>'','SUBMIT_NAME'=>$submit_name));
	}

	/**
	 * The actualiser.
	 *
	 * @return tempcode	 The result of execution.
	 */
	function hostingcopy_step3()
	{
		$title=get_screen_title('HOSTING_COPY');

		if (function_exists('set_time_limit')) @set_time_limit(0);

		$conn_id=$this->_hostingcopy_ftp_connect();
		$path=post_param('path');
		$extra_path=post_param('extra_path');
		if (!@ftp_chdir($conn_id,$path)) warn_exit(do_lang_tempcode('HOSTING_NO_FIND_DIR'));
		if ($extra_path!='')
		{
			@ftp_mkdir($conn_id,$extra_path);
			if (!@ftp_chdir($conn_id,$extra_path)) warn_exit(do_lang_tempcode('HOSTING_NO_MAKE_DIR'));
		}

		// Find latest version
		$t=$GLOBALS['SITE_DB']->query_value_null_ok('download_downloads d LEFT JOIN '.get_table_prefix().'translate t ON t.id=d.comments','url',array('text_original'=>'This is the latest version.'));
		if (is_null($t)) warn_exit(do_lang_tempcode('ARCHIVE_NOT_AVAILABLE'));
		if (url_is_local($t)) $t=get_custom_file_base().'/'.rawurldecode($t);

		$array=array('install.php'=>get_file_base().'/uploads/downloads/install.php','data.ocp'=>get_file_base().'/uploads/downloads/data.ocp');
		foreach ($array as $filename=>$tmp_file)
//		$zip=zip_open($t);
//		$tmp_file=tempnam((((str_replace(array('on','true','yes'),array('1','1','1'),strtolower(ini_get('safe_mode')))=='1') || ((ini_get('open_basedir')!='') && (strpos(ini_get('open_basedir'),'/tmp')===false)))?get_custom_file_base().'/uploads/attachments/':'/tmp/'),'hosting_copy');
//		while (($zip_entry=zip_read($zip))!==false)
		{
//			$_temp_file=fopen($tmp_file,'wb');
//			fwrite($_temp_file,zip_entry_read($zip_entry,zip_entry_filesize($zip_entry)));
//			fclose($_temp_file);
//			$filename=zip_entry_name($zip_entry);
			if (!@ftp_put($conn_id,$filename,$tmp_file,FTP_BINARY))
			{
//				zip_entry_close($zip_entry);
//				zip_close($zip);
//				@unlink($tmp_file);
				ftp_close($conn_id);
				warn_exit(do_lang_tempcode('HOSTING_NO_UPLOAD',@strval($php_errormsg)));
			}
//			zip_entry_close($zip_entry);
		}
//		@unlink($tmp_file);
//		zip_close($zip);
		$file_list=ftp_nlist($conn_id,'.');
		if ((is_array($file_list)) && (!in_array($filename,$file_list)))
			warn_exit(do_lang_tempcode('HOSTING_FILE_GONE_MISSING'));
		ftp_close($conn_id);

		$base_url=post_param('base_url');
		if (substr($base_url,-1)!='/') $base_url.='/';

		$install_url=$base_url.'install.php';

		return do_template('OC_HOSTING_COPY_SUCCESS_PAGE',array('_GUID'=>'5946fe2252fe1a67ba54e2c20a1d4d63','TITLE'=>$title,'FTP_FOLDER'=>$path.(($extra_path=='')?'':($extra_path.'/')),'HIDDEN'=>build_keep_post_fields(array('path','extra_path')),'INSTALL_URL'=>$install_url));
	}

	/**
	 * Get wizard step.
	 *
	 * @return tempcode	 The interface.
	 */
	function myocp()
	{
		require_lang('sites');

		$title=get_screen_title('MO_ADD_SITE');

		$_GET['wide']='1';

		$fields=new ocp_tempcode();
		$fields->attach(form_input_line(do_lang_tempcode('MO_CODENAME'),do_lang('MO_CODENAME_DESCRIPTION'),'codename','',true));
		$fields->attach(form_input_email(do_lang_tempcode('EMAIL_ADDRESS'),do_lang_tempcode('MO_YOUR_EMAIL_ADDRESS'),'email_address',$GLOBALS['FORUM_DRIVER']->get_member_email_address(get_member()),true));
		$fields->attach(form_input_password(do_lang_tempcode('PASSWORD'),do_lang_tempcode('MO_PASSWORD'),'password',true));
		$fields->attach(form_input_password(do_lang_tempcode('CONFIRM_PASSWORD'),'','confirm_password',true));

		$text=do_lang_tempcode('MO_ENTER_DETAILS');
		$post_url=build_url(array('page'=>'_SELF','type'=>'_myocp'),'_SELF');

		return do_template('FORM_SCREEN',array('_GUID'=>'0ed12af5b64c65a673b9837bd47a80b1','TITLE'=>$title,'SUBMIT_NAME'=>do_lang('PROCEED'),'FIELDS'=>$fields,'URL'=>$post_url,'TEXT'=>$text,'HIDDEN'=>''));
	}

	/**
	 * Get wizard step.
	 *
	 * @return tempcode	 The interface.
	 */
	function _myocp()
	{
		require_lang('sites');

		$title=get_screen_title('MO_ADD_SITE');

		$_GET['wide']='1';

		$codename=strtolower(post_param('codename'));
		$name=post_param('name','');
		$email_address=post_param('email_address');
		$description=post_param('description','');
		$category=post_param('category','');
		$show_in_directory=post_param_integer('show_in_directory',0);
		$password=post_param('password');
		$confirm_password=post_param('confirm_password');

		if ($password!=$confirm_password) warn_exit(do_lang_tempcode('PASSWORD_MISMATCH'));

		myocp_add_site($codename,$name,$email_address,$password,$description,$category,$show_in_directory);

		return do_template('INFORM_SCREEN',array('_GUID'=>'bedc8955800508d6b91515e44e8a58ef','TITLE'=>$title,'TEXT'=>do_lang_tempcode('MO_NEW_SITE',escape_html($codename))));
	}

}
