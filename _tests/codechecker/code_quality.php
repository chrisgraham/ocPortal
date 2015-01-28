<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		code_quality
 */

/*
Not doing (from Zend's Code Analyzer):
 - if-else-else check (Reason: doesn't confuse us)
 - unnecessary reference check (Reason: lies!)
 - error for breaking with a variable (Reason: would only get used for a good reason, so let programmers do it if they have one)
 - Values overwritten before use (Reason: we may be initialising them for code clarity; PHPStorm's inspector can show these)
Not doing (from HPHP's warnings):
 - Anything specific to compilation (Reason: we must manually ensure that works, often code branching structures will be involved but warnings still happen)
 - Wrong number of parameters, on method of subclass (Reason: very hard to do)
 - Undeclared constant (Reason: we don't track these)
Not doing (from CodeLobster Errors):
 - IF and ELSEIF have same conditions (theoretically the prior IF might have changed the state)
Not doing (from PhpStorm Code Inspector):
 - Many (lots of false positives in here)

Unsupported syntax:
 static $foo=1,$bar=2;
  Not documented in PHP manual, so may be unreliable.
*/

ini_set('memory_limit','-1');

$extra=array();
if (isset($_SERVER['argv']))
{
	foreach ($_SERVER['argv'] as $index=>$argv)
	{
		$argv=str_replace('\\\\','\\',$argv);
		$_SERVER['argv'][$index]=$argv;
		$explode=explode('=',$argv,2);
		if (count($explode)==2)
		{
			$extra[$explode[0]]=$explode[1];
			unset($_SERVER['argv'][$index]);
		}
	}
	$_SERVER['argv']=array_merge($_SERVER['argv'],$extra);
	if (array_key_exists('api',$_SERVER['argv'])) $GLOBALS['API']=1;
	if (array_key_exists('mixed',$_SERVER['argv'])) $GLOBALS['MIXED']=1;
	if (array_key_exists('pedantic',$_SERVER['argv'])) $GLOBALS['PEDANTIC']=1;
	if (array_key_exists('todo',$_SERVER['argv'])) $GLOBALS['TODO']=1;
	if (array_key_exists('security',$_SERVER['argv'])) $GLOBALS['SECURITY']=1;
	if (array_key_exists('checks',$_SERVER['argv'])) $GLOBALS['CHECKS']=1;
	if (array_key_exists('spelling',$_SERVER['argv'])) $GLOBALS['SPELLING']=1;
	if (array_key_exists('non_terse',$_SERVER['argv'])) $GLOBALS['NON_TERSE']=1;
}
if (array_key_exists('api',$_GET)) $GLOBALS['API']=1;
if (array_key_exists('mixed',$_GET)) $GLOBALS['MIXED']=1;
if (array_key_exists('pedantic',$_GET)) $GLOBALS['PEDANTIC']=1;
/*if (array_key_exists('todo',$_GET)) */$GLOBALS['TODO']=1;	//NB: Test set skips these ones anyway
if (array_key_exists('security',$_GET)) $GLOBALS['SECURITY']=1;
if (array_key_exists('checks',$_GET)) $GLOBALS['CHECKS']=1;
if (array_key_exists('spelling',$_GET)) $GLOBALS['SPELLING']=1;
if (array_key_exists('non_terse',$_GET)) $GLOBALS['NON_TERSE']=1;

require_once('tests.php');
require_once('lex.php');
require_once('parse.php');

require_once('lib.php');

if (isset($_SERVER['argv']))
{
	if (array_key_exists('path',$_SERVER['argv'])) $GLOBALS['OCPORTAL_PATH']=$_SERVER['argv']['path'];
}
global $OCPORTAL_PATH,$START_TIME,$MADE_CALL;
$START_TIME=time();
$MADE_CALL=NULL;

// Load up table info
global $TABLE_FIELDS;
$TABLE_FIELDS=(file_exists($OCPORTAL_PATH.'/data/db_meta.dat') && (filemtime($OCPORTAL_PATH.'/index.php')<filemtime($OCPORTAL_PATH.'/data/db_meta.dat')))?unserialize(file_get_contents($OCPORTAL_PATH.'/data/db_meta.dat')):NULL;
if (!is_null($TABLE_FIELDS)) $TABLE_FIELDS['db_meta']=array('m_table'=>'ID_TEXT','m_name'=>'ID_TEXT','m_type'=>'ID_TEXT');

// Special funcs...
global $EXT_FUNCS;
$EXT_FUNCS=array(
	'gzclose'=>1,
	'gzcompress'=>1,
	'gzdeflate'=>1,
	'gzencode'=>1,
	'gzeof'=>1,
	'gzfile'=>1,
	'gzgetc'=>1,
	'gzgets'=>1,
	'gzgetss'=>1,
	'gzinflate'=>1,
	'gzopen'=>1,
	'gzpassthru'=>1,
	'gzputs'=>1,
	'gzread'=>1,
	'gzrewind'=>1,
	'gzseek'=>1,
	'gztell'=>1,
	'gzuncompress'=>1,
	'gzwrite'=>1,
	'readgzfile'=>1,
	'zlib_get_coding_type'=>1,
/*	'mysql_affected_rows'=>1,		We guard this in a different way now
	'mysql_change_user'=>1,
	'mysql_client_encoding'=>1,
	'mysql_close'=>1,
	'mysql_connect'=>1,
	'mysql_create_db'=>1,
	'mysql_data_seek'=>1,
	'mysql_db_name'=>1,
	'mysql_db_query'=>1,
	'mysql_drop_db'=>1,
	'mysql_errno'=>1,
	'mysql_error'=>1,
	'mysql_escape_string'=>1,
	'mysql_fetch_array'=>1,
	'mysql_fetch_assoc'=>1,
	'mysql_fetch_field'=>1,
	'mysql_fetch_lengths'=>1,
	'mysql_fetch_object'=>1,
	'mysql_fetch_row'=>1,
	'mysql_field_flags'=>1,
	'mysql_field_len'=>1,
	'mysql_field_name'=>1,
	'mysql_field_seek'=>1,
	'mysql_field_table'=>1,
	'mysql_field_type'=>1,
	'mysql_free_result'=>1,
	'mysql_get_client_info'=>1,
	'mysql_get_host_info'=>1,
	'mysql_get_proto_info'=>1,
	'mysql_get_server_info'=>1,
	'mysql_info'=>1,
	'mysql_insert_id'=>1,
	'mysql_list_dbs'=>1,
	'mysql_list_fields'=>1,
	'mysql_list_processes'=>1,
	'mysql_list_tables'=>1,
	'mysql_num_fields'=>1,
	'mysql_num_rows'=>1,
	'mysql_pconnect'=>1,
	'mysql_ping'=>1,
	'mysql_query'=>1,
	'mysql_real_escape_string'=>1,
	'mysql_result'=>1,
	'mysql_select_db'=>1,
	'mysql_stat'=>1,
	'mysql_tablename'=>1,
	'mysql_thread_id'=>1,
	'mysql_unbuffered_query'=>1,*/
	'gd_info'=>1,
	'getimagesize'=>1,
	'image_type_to_extension'=>1,
	'image_type_to_mime_type'=>1,
	'image2wbmp'=>1,
	'imagealphablending'=>1,
	'imageantialias'=>1,
	'imagearc'=>1,
	'imagechar'=>1,
	'imagecharup'=>1,
	'imagecolorallocate'=>1,
	'imagecolorallocatealpha'=>1,
	'imagecolorat'=>1,
	'imagecolorclosest'=>1,
	'imagecolorclosestalpha'=>1,
	'imagecolorclosesthwb'=>1,
	'imagecolordeallocate'=>1,
	'imagecolorexact'=>1,
	'imagecolorexactalpha'=>1,
	'imagecolormatch'=>1,
	'imagecolorresolve'=>1,
	'imagecolorresolvealpha'=>1,
	'imagecolorset'=>1,
	'imagecolorsforindex'=>1,
	'imagecolorstotal'=>1,
	'imagecolortransparent'=>1,
	'imagecopy'=>1,
	'imagecopymerge'=>1,
	'imagecopymergegray'=>1,
	'imagecopyresampled'=>1,
	'imagecopyresized'=>1,
	'imagecreate'=>1,
	'imagecreatefromgd2'=>1,
	'imagecreatefromgd2part'=>1,
	'imagecreatefromgd'=>1,
	'imagecreatefromgif'=>1,
	'imagecreatefromjpeg'=>1,
	'imagecreatefrompng'=>1,
	'imagecreatefromstring'=>1,
	'imagecreatefromwbmp'=>1,
	'imagecreatefromxbm'=>1,
	'imagecreatefromxpm'=>1,
	'imagecreatetruecolor'=>1,
	'imagedashedline'=>1,
	'imagedestroy'=>1,
	'imageellipse'=>1,
	'imagefill'=>1,
	'imagefilledarc'=>1,
	'imagefilledellipse'=>1,
	'imagefilledpolygon'=>1,
	'imagefilledrectangle'=>1,
	'imagefilltoborder'=>1,
	'imagefilter'=>1,
	'imagefontheight'=>1,
	'imagefontwidth'=>1,
	'imageftbbox'=>1,
	'imagefttext'=>1,
	'imagegammacorrect'=>1,
	'imagegd2'=>1,
	'imagegd'=>1,
	'imagegif'=>1,
	'imageinterlace'=>1,
	'imageistruecolor'=>1,
	'imagejpeg'=>1,
	'imagelayereffect'=>1,
	'imageline'=>1,
	'imageloadfont'=>1,
	'imagepalettecopy'=>1,
	'imagepng'=>1,
	'imagepolygon'=>1,
	'imagepsbbox'=>1,
	'imagepscopyfont'=>1,
	'imagepsencodefont'=>1,
	'imagepsextendfont'=>1,
	'imagepsfreefont'=>1,
	'imagepsloadfont'=>1,
	'imagepsslantfont'=>1,
	'imagepstext'=>1,
	'imagerectangle'=>1,
	'imagerotate'=>1,
	'imagesavealpha'=>1,
	'imagesetbrush'=>1,
	'imagesetpixel'=>1,
	'imagesetstyle'=>1,
	'imagesetthickness'=>1,
	'imagesettile'=>1,
	'imagestring'=>1,
	'imagestringup'=>1,
	'imagesx'=>1,
	'imagesy'=>1,
	'imagetruecolortopalette'=>1,
	'imagettfbbox'=>1,
	'imagettftext'=>1,
	'imagetypes'=>1,
	'imagewbmp'=>1,
	'imagexbm'=>1,
	'iptcembed'=>1,
	'iptcparse'=>1,
	'jpeg2wbmp'=>1,
	'png2wbmp'=>1,
	'ftp_alloc'=>1,
	'ftp_cdup'=>1,
	'ftp_chdir'=>1,
	'ftp_chmod'=>1,
	'ftp_close'=>1,
	'ftp_connect'=>1,
	'ftp_delete'=>1,
	'ftp_exec'=>1,
	'ftp_fget'=>1,
	'ftp_fput'=>1,
	'ftp_get_option'=>1,
	'ftp_get'=>1,
	'ftp_login'=>1,
	'ftp_mdtm'=>1,
	'ftp_mkdir'=>1,
	'ftp_nb_continue'=>1,
	'ftp_nb_fget'=>1,
	'ftp_nb_fput'=>1,
	'ftp_nb_get'=>1,
	'ftp_nb_put'=>1,
	'ftp_nlist'=>1,
	'ftp_pasv'=>1,
	'ftp_put'=>1,
	'ftp_pwd'=>1,
	'ftp_quit'=>1,
	'ftp_raw'=>1,
	'ftp_rawlist'=>1,
	'ftp_rename'=>1,
	'ftp_rmdir'=>1,
	'ftp_set_option'=>1,
	'ftp_site'=>1,
	'ftp_size'=>1,
	'ftp_ssl_connect'=>1,
	'ftp_systype'=>1,
	/*'pspell_add_to_personal'=>1,
	'pspell_add_to_session'=>1,
	'pspell_check'=>1,
	'pspell_clear_session'=>1,
	'pspell_config_create'=>1,
	'pspell_config_data_dir'=>1,
	'pspell_config_dict_dir'=>1,
	'pspell_config_ignore'=>1,
	'pspell_config_mode'=>1,
	'pspell_config_personal'=>1,
	'pspell_config_repl'=>1,
	'pspell_config_runtogether'=>1,
	'pspell_config_save_repl'=>1,
	'pspell_new_config'=>1,
	'pspell_new_personal'=>1,
	'pspell_new'=>1,
	'pspell_save_wordlist'=>1,
	'pspell_store_replacement'=>1,
	'pspell_suggest'=>1,*/
	'utf8_decode'=>1,
	'utf8_encode'=>1,
	'xml_error_string'=>1,
	'xml_get_current_byte_index'=>1,
	'xml_get_current_column_number'=>1,
	'xml_get_current_line_number'=>1,
	'xml_get_error_code'=>1,
	'xml_parse_into_struct'=>1,
	'xml_parse'=>1,
	'xml_parser_create_ns'=>1,
	'xml_parser_create'=>1,
	'xml_parser_free'=>1,
	'xml_parser_get_option'=>1,
	'xml_parser_set_option'=>1,
	'xml_set_character_data_handler'=>1,
	'xml_set_default_handler'=>1,
	'xml_set_element_handler'=>1,
	'xml_set_end_namespace_decl_handler'=>1,
	'xml_set_external_entity_ref_handler'=>1,
	'xml_set_notation_decl_handler'=>1,
	'xml_set_object'=>1,
	'xml_set_processing_instruction_handler'=>1,
	'xml_set_start_namespace_decl_handler'=>1,
	'xml_set_unparsed_entity_decl_handler'=>1,
	/*'ldap_8859_to_t61'=>1,
	'ldap_add'=>1,
	'ldap_bind'=>1,
	'ldap_close'=>1,
	'ldap_compare'=>1,
	'ldap_connect'=>1,
	'ldap_count_entries'=>1,
	'ldap_delete'=>1,
	'ldap_dn2ufn'=>1,
	'ldap_err2str'=>1,
	'ldap_errno'=>1,
	'ldap_error'=>1,
	'ldap_explode_dn'=>1,
	'ldap_first_attribute'=>1,
	'ldap_first_entry'=>1,
	'ldap_first_reference'=>1,
	'ldap_free_result'=>1,
	'ldap_get_attributes'=>1,
	'ldap_get_dn'=>1,
	'ldap_get_entries'=>1,
	'ldap_get_option'=>1,
	'ldap_get_values_len'=>1,
	'ldap_get_values'=>1,
	'ldap_list'=>1,
	'ldap_mod_add'=>1,
	'ldap_mod_del'=>1,
	'ldap_mod_replace'=>1,
	'ldap_modify'=>1,
	'ldap_next_attribute'=>1,
	'ldap_next_entry'=>1,
	'ldap_next_reference'=>1,
	'ldap_parse_reference'=>1,
	'ldap_parse_result'=>1,
	'ldap_read'=>1,
	'ldap_rename'=>1,
	'ldap_sasl_bind'=>1,
	'ldap_search'=>1,
	'ldap_set_option'=>1,
	'ldap_set_rebind_proc'=>1,
	'ldap_sort'=>1,
	'ldap_start_tls'=>1,
	'ldap_t61_to_8859'=>1,
	'ldap_unbind'=>1,*/
);

// Error funcs...
global $FALSE_ERROR_FUNCS;
$FALSE_ERROR_FUNCS=array(
	'base64_decode'=>1,
	'fsockopen'=>1,
	'ftell'=>1,
	'ftp_connect'=>1,
	'ftp_fput'=>1,
	'ftp_nlist'=>1,
	'ftp_size'=>1,
	'ftp_cdup'=>1,
	'ftp_pasv'=>1,
	'ftp_rawlist'=>1,
	'ftp_cdup'=>1,
	'ftp_chdir'=>1,
	'ftp_pwd'=>1,
	'ftp_login'=>1,
	'ftp_mkdir'=>1,
	'ftp_rmdir'=>1,
	'ftp_get'=>1,
	'ftp_fget'=>1,
	'ftp_put'=>1,
	'ftp_rename'=>1,
	'ftp_delete'=>1,
	'ftp_site'=>1,
	'gzopen'=>1,
	'imagecreatefromstring'=>1,
	'imagecreatefrompng'=>1,
	'imagecreatefromjpeg'=>1,
	'imagettfbbox'=>1,
	'imagettftext'=>1,
	'imageloadfont'=>1,
	'strtok'=>1,
	'include'=>1,
	'include_once'=>1,
	'ldap_bind'=>1,
	'ldap_connect'=>1,
	'ldap_list'=>1,
	'ldap_search'=>1,
	'ldap_add'=>1,
	'ldap_compare'=>1,
	'ldap_delete'=>1,
	'ldap_mod_add'=>1,
	'ldap_mod_del'=>1,
	'ldap_mod_replace'=>1,
	'ldap_modify'=>1,
	'ldap_next_attribute'=>1,
	'ldap_next_entry'=>1,
	'ldap_read'=>1,
	'ldap_rename'=>1,
	'mail'=>1,
	'move_uploaded_file'=>1,
	'mysql_connect'=>1,
	'mysql_data_seek'=>1,
	'mysql_fetch_assoc'=>1,
	'mysql_fetch_row'=>1,
	'mysql_field_name'=>1,
	'mysql_field_len'=>1,
	'mysql_field_flags'=>1,
	'mysql_field_type'=>1,
	'mysql_field_seek'=>1,
	'mysql_field_table'=>1,
	'mysql_fetch_field'=>1,
	'mysql_fetch_object'=>1,
	'mysql_field_seek'=>1,
	'mysql_list_dbs'=>1,
	'mysql_result'=>1,
	'mysql_unbuffered_query'=>1,
	'mysql_pconnect'=>1,
	'mysql_query'=>1,
	'ob_get_contents'=>1,
	'ob_end_flush'=>1,
//	'ob_end_clean'=>1,
	'parse_url'=>1,
	'posix_getgrgid'=>1,
	'posix_getpwuid'=>1,
	'readdir'=>1,
	'setcookie'=>1,
//	'header'=>1,
	'setlocale'=>1,
	'shell_exec'=>1,
	'unserialize'=>1,
	'xml_parse'=>1,
	'xml_parser_create_ns'=>1,
	'unpack'=>1,
	'pspell_new_config'=>1,
	'pspell_save_wordlist'=>1,
	'xml_parser_create'=>1,
	'xml_parse_into_struct'=>1,
	'system'=>1,
	'fgetc'=>1,
	'fread'=>1,
	'fgets'=>1,
	'fgetcsv'=>1,
	'fgetss'=>1,
	'ftruncate'=>1,
	'pfsockopen'=>1,
	'ob_get_length'=>1,
	'openlog'=>1,
	'popen'=>1,
	'gethostbynamel'=>1,
	'getimagesize'=>1,
	'get_cfg_var'=>1,
	'gzinflate'=>1,
	'gzuncompress'=>1,
	'session_decode'=>1,
	'error_log'=>1,
	'session_cache_limiter'=>1,
	'session_start'=>1,
	'imagepng'=>1,
	'imagejpeg'=>1,
	'imagettfbbox'=>1,
	'imagettftext'=>1,
	'gethostbyname'=>1,
	'imagecreatetruecolor'=>1,
	'imagetruecolortopalette'=>1,
	'imagesetthickness'=>1,
	'imageellipse'=>1,
	'imagefilledellipse'=>1,
	'imagefilledarc'=>1,
	'imagealphablending'=>1,
	'imagecolorresolvealpha'=>1,
	'imagecolorexactalpha'=>1,
	'imagecopyresampled'=>1,
	'imagesettile'=>1,
	'imagesetbrush'=>1,
	'putenv'=>1,
	'rmdir'=>1,
	'opendir'=>1,
	'copy'=>1,
	'file'=>1,
	'fopen'=>1,
//	'chmod'=>1,
//	'chgrp'=>1,
//	'unlink'=>1,
	'mkdir'=>1,
	'rename'=>1,
//	'chdir'=>1,
	'filectime'=>1,
	'filegroup'=>1,
	'filemtime'=>1,
	'fileowner'=>1,
	'fileperms'=>1,
	'filesize'=>1,
	'opendir'=>1,
	'pathinfo'=>1,
	'fileatime'=>1,
	'md5_file'=>1,
	'readfile'=>1,
	'readgzfile'=>1,
	'filetype'=>1,
	'parse_ini_file'=>1,
	'is_executable'=>1,
	'disk_free_space'=>1,
	'disk_total_space'=>1,
	'get_meta_tags'=>1,
	'gzfile'=>1,
	'tempnam'=>1,
	'tmpfile'=>1,
	'flock'=>1,
	'touch'=>1,
	'strpos'=>1,
	'strrpos'=>1,
	'strstr'=>1,
	'stristr'=>1,
);
global $NULL_ERROR_FUNCS;
$NULL_ERROR_FUNCS=array(
	'array_pop'=>1,
	'array_shift'=>1,
);
global $VAR_ERROR_FUNCS;
$VAR_ERROR_FUNCS=array(
	'strpos'=>1,
	'strrpos'=>1,
	'strstr'=>1,
	'stristr'=>1,
	'substr_count'=>1,
);
global $ERROR_FUNCS;
$ERROR_FUNCS=array(
	'posix_getuid'=>1, // Roadsend produces warning on Windows
	'ftp_fput'=>1,
	'ftp_nlist'=>1,
	'ftp_size'=>1,
	'ftp_cdup'=>1,
	'ftp_pasv'=>1,
	'ftp_rawlist'=>1,
	'ftp_cdup'=>1,
	'ftp_chdir'=>1,
	'ftp_pwd'=>1,
	'ftp_login'=>1,
	'ftp_mkdir'=>1,
	'ftp_rmdir'=>1,
	'ftp_get'=>1,
	'ftp_fget'=>1,
	'ftp_put'=>1,
	'ftp_rename'=>1,
	'ftp_delete'=>1,
	'ftp_site'=>1,
	'gzopen'=>1,
	'imagecreatefromstring'=>1,
	'imagecreatefrompng'=>1,
	'imagecreatefromjpeg'=>1,
	'ldap_bind'=>1,
	'ldap_connect'=>1,
	'ldap_list'=>1,
	'ldap_search'=>1,
	'ldap_add'=>1,
	'ldap_compare'=>1,
	'ldap_delete'=>1,
	'ldap_mod_add'=>1,
	'ldap_mod_del'=>1,
	'ldap_mod_replace'=>1,
	'ldap_modify'=>1,
	'ldap_read'=>1,
	'ldap_rename'=>1,
	'mail'=>1,
	'move_uploaded_file'=>1,
	'mysql_data_seek'=>1,
	'mysql_field_name'=>1,
	'mysql_field_len'=>1,
	'mysql_field_flags'=>1,
	'mysql_field_type'=>1,
	'mysql_field_seek'=>1,
	'mysql_field_table'=>1,
	'ob_end_flush'=>1,
	'ob_end_clean'=>1,
	'parse_url'=>1,
	'shell_exec'=>1,
	'unserialize'=>1,
	'unpack'=>1,
	'system'=>1,
	'popen'=>1,
	'getimagesize'=>1,
	'error_log'=>1,
	'session_cache_limiter'=>1,
	'session_start'=>1,
	'imagepng'=>1,
	'imagejpeg'=>1,
	'imagettfbbox'=>1,
	'imagettftext'=>1,
	'gethostbyname'=>1,
	'imagecreatetruecolor'=>1,
	'imagetruecolortopalette'=>1,
	'imagesetthickness'=>1,
	'imageellipse'=>1,
	'imagefilledellipse'=>1,
	'imagefilledarc'=>1,
	'imagealphablending'=>1,
	'imagecolorresolvealpha'=>1,
	'imagecolorexactalpha'=>1,
	'imagecopyresampled'=>1,
	'imagesettile'=>1,
	'imagesetbrush'=>1,
	'putenv'=>1,
	'rmdir'=>1,
	'opendir'=>1,
	'copy'=>1,
	'file'=>1,
	'fopen'=>1,
	'chmod'=>1,
	'chgrp'=>1,
	'unlink'=>1,
	'mkdir'=>1,
	'rename'=>1,
	'chdir'=>1,
	'filectime'=>1,
	'filegroup'=>1,
	'filemtime'=>1,
	'fileowner'=>1,
	'fileperms'=>1,
	'filesize'=>1,
	'opendir'=>1,
	'pathinfo'=>1,
	'fileatime'=>1,
	'md5_file'=>1,
	'readfile'=>1,
	'readgzfile'=>1,
	'filetype'=>1,
	'parse_ini_file'=>1,
	'is_executable'=>1,
	'disk_free_space'=>1,
	'disk_total_space'=>1,
	'get_meta_tags'=>1,
	'gzfile'=>1,
	'tempnam'=>1,
	'tmpfile'=>1,
	'flock'=>1,
	'touch'=>1,
	'highlight_file'=>1,
	'set_time_limit'=>1,
	'exec'=>1,
	'passthru'=>1,
);

// Load up function info
global $FUNCTION_SIGNATURES;
global $OCPORTAL_PATH;
if ((isset($GLOBALS['API'])) || (isset($_GET['test'])))
{
	$functions_file=file_get_contents(file_exists($OCPORTAL_PATH.'/data_custom/functions.dat')?($OCPORTAL_PATH.'/data_custom/functions.dat'):'functions.dat');
	$FUNCTION_SIGNATURES=unserialize($functions_file);
} else $FUNCTION_SIGNATURES=array();

// To get it started
if (isset($_GET['test'])) // Run a specific test
{
	$GLOBALS['API']=1;
	$GLOBALS['CHECKS']=1;
	$tests=get_tests();
	$parsed=parse(lex('<'.'?php'."\n".$tests[$_GET['test']]."\n"));
	check($parsed);
}
elseif ((!isset($_GET['to_use'])) && (!isset($_SERVER['argv'][1]))) // Run for all PHP files
{
	$avoid=array();
	if (isset($_GET['avoid']))
		$avoid=explode(',',$_GET['avoid']);
	$files=do_dir($OCPORTAL_PATH.(isset($_GET['subdir'])?('/'.$_GET['subdir']):''),true,false,$avoid);
	$start=isset($_GET['start'])?intval($_GET['start']):0;
	foreach ($files as $i=>$to_use)
	{
		if ($i<=$start) continue; // Set to largest number we know so far work

		if (strpos(file_get_contents($to_use),'/*CQC: No check*/')!==false)
		{
			echo 'SKIP: '.$to_use;
			continue;
		}

		check(parse_file($to_use,false,false,$i,count($files)));
	}
} else // Run for a specific file
{
	$_to_use=isset($_SERVER['argv'][1])?$_SERVER['argv'][1]:$_GET['to_use'];
	if (isset($_SERVER['argv']) && array_key_exists('single',$_SERVER['argv']))
	{
		$to_use_multi=array($_to_use);
	} else
	{
		if ((isset($_SERVER['argv'])) && ((array_key_exists(2,$_SERVER['argv'])) || (array_key_exists('spacedpaths',$_SERVER['argv']))))
		{
			$to_use_multi=array();
			foreach ($_SERVER['argv'] as $key=>$val)
				if ((is_integer($key)) && ($key!=0)) $to_use_multi[]=$val;
		} else
		{
			$to_use_multi=explode(':',$_to_use);
		}
	}

	foreach ($to_use_multi as $to_use)
	{
//		$to_use=str_replace('\\','/',$to_use);
		$full_path=(($OCPORTAL_PATH=='')?'':($OCPORTAL_PATH.((substr($OCPORTAL_PATH,-1)==DIRECTORY_SEPARATOR)?'':DIRECTORY_SEPARATOR))).$to_use;

		if (strpos(file_get_contents($full_path),'/*CQC: No check*/')!==false)
		{
			echo 'SKIP: '.$to_use.cnl();
			continue;
		}

		check(parse_file($full_path));
	}
}
echo 'FINAL Done!';

// Do the actual code quality check
function check($structure)
{
	global $GLOBAL_VARIABLES,$CURRENT_CLASS,$OK_EXTRA_FUNCTIONS;
	$GLOBAL_VARIABLES=array();
	$OK_EXTRA_FUNCTIONS=$structure['ok_extra_functions'];

	$CURRENT_CLASS='__global';
	global $LOCAL_VARIABLES;
	$LOCAL_VARIABLES=reinitialise_local_variables();
	if ($GLOBALS['OK_EXTRA_FUNCTIONS']=='') // Useful for tests to be able to define functions natively
	{
		foreach ($structure['functions'] as $function)
		{
			if ($GLOBALS['OK_EXTRA_FUNCTIONS']!='') $GLOBALS['OK_EXTRA_FUNCTIONS'].='|';
			$GLOBALS['OK_EXTRA_FUNCTIONS'].=$function['name'];
		}
		foreach ($structure['classes'] as $class)
		{
			if ($GLOBALS['OK_EXTRA_FUNCTIONS']!='') $GLOBALS['OK_EXTRA_FUNCTIONS'].='|';
			$GLOBALS['OK_EXTRA_FUNCTIONS'].=$class['name'];
		}
	}
	check_command($structure['main'],0);
	$local_variables=$LOCAL_VARIABLES;
	foreach ($structure['functions'] as $function)
	{
		check_function($function);
	}
	foreach ($structure['classes'] as $class)
	{
		$CURRENT_CLASS=$class['name'];
		foreach ($class['functions'] as $function)
		{
			$LOCAL_VARIABLES['this']=array('is_global'=>false,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('object'),'references'=>0,'object_type'=>$CURRENT_CLASS,'unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false);
			check_function($function);
		}
	}
	check_variable_list($local_variables,0);

	// Check for type conflicts in the global variables
	check_variable_list($GLOBAL_VARIABLES);
}

function check_function($function)
{
	global $GLOBAL_VARIABLES,$LOCAL_VARIABLES,$CURRENT_CLASS;
	$LOCAL_VARIABLES=reinitialise_local_variables(); // Map (by name) of maps : is_global, types. Note there is boolean-false and NULL types: boolean_false is when we KNOW a boolean is false, so it might map to ~

	//if (isset($GLOBALS['PEDANTIC'])) if (strlen(serialize($function))>30000) log_warning('Function '.$function['name'].' is too big',$function['offset']);

	global $FUNCTION_SIGNATURES;
	$class=$CURRENT_CLASS;
	if (isset($FUNCTION_SIGNATURES[$class]['functions'][$function['name']])) $func=$FUNCTION_SIGNATURES[$class]['functions'][$function['name']]; else $func=NULL;

	// Initialise any local variables that come from parameters
	foreach ($function['parameters'] as $p)
	{
		add_variable_reference($p[1],$function['offset'],false);
		if (isset($func))
		{
			foreach ($func['parameters'] as $x)
			{
				if ($x['name']==$p[1])
				{
					set_ocportal_type($p[1],$x['type']);
					break;
				}
			}
		}
	}

	// Check commands
	check_command($function['code'],0);

	// Check for type conflicts in the variables
	check_variable_list($LOCAL_VARIABLES,$function['offset']);

	// Update global variables
	foreach ($LOCAL_VARIABLES as $name=>$v)
	{
		if ($v['is_global'])
		{
			if (isset($GLOBAL_VARIABLES[$name]))
			{
				$GLOBAL_VARIABLES[$name]['types']=array_merge($GLOBAL_VARIABLES[$name]['types'],$v['types']);
			} else
			{
				$GLOBAL_VARIABLES[$name]=$v;
			}
		}
	}

	// Return stuff
	if (isset($func))
	{
		$ret=(isset($func['return']));
		// Check a return is given if the function returns and the opposite
		if (($ret) && (!isset($LOCAL_VARIABLES['__return'])))
		{
			log_warning('Function \''.$function['name'].'\' is missing a return statement.',$function['offset']);
		}
		if ((!$ret) && (isset($LOCAL_VARIABLES['__return'])) && (array_unique($LOCAL_VARIABLES['__return']['types'])!=array('NULL')))
		{
			log_warning('Function \''.$function['name'].'\' has a return with a value, and the function doesn\'t return a value.',$LOCAL_VARIABLES['__return']['first_mention']);
		}

		// Check return types
		if (($ret) && (isset($LOCAL_VARIABLES['__return']['types'])))
		{
			foreach ($LOCAL_VARIABLES['__return']['types'] as $i=>$ret_type)
			{
				ensure_type(array($func['return']['type']),$ret_type,$LOCAL_VARIABLES['__return']['mentions'][$i],'Bad return type (should be '.$func['return']['type'].' not '.$ret_type.')');
			}
		}
	}
}

function check_variable_list($LOCAL_VARIABLES,$offset=-1)
{
	foreach ($LOCAL_VARIABLES as $name=>$v)
	{
		// Check for type conflicts
		$observed_types=array();
		if (isset($GLOBALS['PEDANTIC']))
		{
			foreach ($v['conditioner'] as $conditioner)
			{
				if (((!$v['conditioned_null']) && (isset($GLOBALS['NULL_ERROR_FUNCS'][$conditioner]))) || ((!$v['conditioned_false']) && (isset($GLOBALS['FALSE_ERROR_FUNCS'][$conditioner]))))
				{
					log_warning('Error value was not handled',$v['first_mention']);
					break;
				}
				elseif (($conditioner=='_divide_') && (!$v['conditioned_zero']))
				{
					log_warning('Divide by zero possibility was not handled',$v['first_mention']);
					break;
				}
			}
		}
		foreach ($v['types'] as $t)
		{
			if (is_array($t)) $t=$t[0];

			if ($t{0}=='?')
			{
				$t=substr($t,1);
			}
			if ($t{0}=='~')
			{
				$t=substr($t,1);
			}
			if (substr($t,0,6)=='object') $t='object';
			if ($t=='REAL') $t='float';
			if (in_array($t,array('MEMBER','SHORT_INTEGER','UINTEGER','AUTO_LINK','BINARY','GROUP','TIME')))
			{
				$t='integer';
			}
			if (in_array($t,array('LONG_TEXT','SHORT_TEXT','MINIID_TEXT','ID_TEXT','LANGUAGE_NAME','URLPATH','PATH','IP','MD5','EMAIL')))
			{
				$t='string';
			}
			if (in_array($t,array('tempcode')))
			{
				$t='object';
			}
			if (in_array($t,array('list','map')))
			{
				$t='array';
			}
			if ($t!='mixed') $observed_types[$t]=1;
		}
		if (array_keys($observed_types)!=array('array','resource'))
		{
			if (
				  (count($observed_types)>3) ||
				  ((count($observed_types)>1) && (!isset($observed_types['boolean-false'])) && (!isset($observed_types['NULL']))) ||
				  ((count($observed_types)>2) && ((!isset($observed_types['boolean-false'])) || (!isset($observed_types['NULL'])))
				)
			)
			{
				if (($name!='_') && ($name!='__return') && (!$v['mixed_tag']))
				{
					log_warning('Type conflict for variable: '.$name.' ('.implode(',',array_keys($observed_types)).')',$v['first_mention']);
				}
			}
		}

		// Check for solely mixed
		if (isset($GLOBALS['MIXED']))
		{
			$non_mixed=false;
			foreach ($v['types'] as $t)
			{
				if ($t!='mixed') $non_mixed=true;
			}
			if ((!$non_mixed) && (count($v['types'])!=0))
			{
				log_warning('Solely mixed variable: '.$name,$v['first_mention']);
			}
		}

		// Check for non-used variables
		if (($GLOBALS['FILENAME']!='sources\phpstub.php') && ($v['references']==0) && ($name!='__return') && ($name!='_') && (!$v['is_global']) && (!in_array($name,array('db','file_base','table_prefix','old_base_dir','upgrade_from_hack','upgrade_from','this','GLOBALS','php_errormsg',/*'_GET','_POST','_REQUEST','_COOKIE','_SERVER','_ENV', These are intentionally removed as they should only be used at one point in the code*/'_SESSION','_FILES'))))
		{
			if (!$v['unused_value'])
				log_warning('Non-used '.($v['unused_value']?'value':'variable').' (\''.$name.'\')',$v['first_mention']);
		}
	}
}

function check_command($command,$depth,$function_guard='',$nogo_parameters=NULL)
{
	if (is_null($nogo_parameters)) $nogo_parameters=array();

	global $LOCAL_VARIABLES,$CURRENT_CLASS,$FUNCTION_SIGNATURES;
	foreach ($command as $i=>$c)
	{
		if ($c==array()) continue;

		if (is_integer($c[count($c)-1]))
		{
			$c_pos=$c[count($c)-1];
			$or=false;
		} else
		{
			$c_pos=$c[count($c)-2];
			$or=true;
		}

		switch ($c[0])
		{
			case 'CALL_METHOD':
				check_method($c,$c_pos,$function_guard);
				break;
			case 'CALL_INDIRECT':
				add_variable_reference($c[1][1],$c_pos);
				break;
			case 'VARIABLE':
				check_variable($c);
				break;
			case 'CALL_DIRECT':
				if (isset($GLOBALS['PEDANTIC']))
				{
					if ((isset($GLOBALS['NULL_ERROR_FUNCS'][$c[1]])) || (isset($GLOBALS['FALSE_ERROR_FUNCS'][$c[1]])))
						log_warning('Crucial return value was not handled',$c_pos);
				}
				check_call($c,$c_pos,NULL,$function_guard);
				break;
			case 'GLOBAL':
				foreach ($c[1] as $v)
				{
					if ((isset($LOCAL_VARIABLES[$v[1]])) && (!$LOCAL_VARIABLES[$v[1]]['is_global'])) log_warning($v[1].' was referenced before this globalisation.',$c_pos);
					add_variable_reference($v[1],$c_pos,false);
					$LOCAL_VARIABLES[$v[1]]['is_global']=true;
					$LOCAL_VARIABLES[$v[1]]['unused_value']=true;
				}
				break;
			case 'RETURN':
				$ret_type=check_expression($c[1],false,false,$function_guard);
				add_variable_reference('__return',$c_pos);
				set_ocportal_type('__return',$ret_type);
				if (!isset($LOCAL_VARIABLES['__return']['mentions']))
				{
					$LOCAL_VARIABLES['__return']['mentions']=array();
				}
				$LOCAL_VARIABLES['__return']['mentions'][]=$c_pos;
				if (count($command)-1>$i) log_warning('There is unreachable code',$c_pos);
				break;
			case 'SWITCH':
				$switch_type=check_expression($c[1],false,false,$function_guard);
				foreach ($c[2] as $case)
				{
					if (!is_null($case[0]))
					{
						$passes=ensure_type(array($switch_type),check_expression($case[0],false,false,$function_guard),$c_pos,'Switch type inconsistency');
						if ($passes) infer_expression_type_to_variable_type($switch_type,$case[0]);
					}
					check_command($case[1],$depth+1,$function_guard,$nogo_parameters);
				}
				break;
			case 'ASSIGNMENT':
				check_assignment($c,$c_pos,$function_guard);
				break;
			case 'IF':
				$t=check_expression($c[1],false,false,$function_guard);
				$passes=ensure_type(array('boolean'),$t,$c_pos,'Conditionals must be boolean (if) [is '.$t.']',true);
				if ($passes) infer_expression_type_to_variable_type('boolean',$c[1]);
				if (($c[1][0]=='BOOLEAN_NOT') && ($c[1][1][0]=='CALL_DIRECT') && (strpos($c[1][1][1],'_exists')!==false) && ($c[1][1][2][0][0]=='LITERAL') && ($c[1][1][2][0][1][0]=='STRING') && (($c[2][0][0]=='BREAK') || ($c[2][0][0]=='CONTINUE') || ($c[2][0][0]=='RETURN') || (($c[2][0][0]=='CALL_DIRECT') && ($c[2][0][1]=='critical_error')))) $function_guard.=','.$c[1][1][2][0][1][1].',';
				$temp_function_guard=$function_guard;
				if (($c[1][0]=='CALL_DIRECT') && (strpos($c[1][1],'_exists')!==false) && ($c[1][2][0][0]=='LITERAL') && ($c[1][2][0][1][0]=='STRING')) $temp_function_guard.=','.$c[1][2][0][1][1].',';
				if (($c[1][0]=='BOOLEAN_AND') && ($c[1][1][0]=='BRACKETED') && ($c[1][1][1][0]=='CALL_DIRECT') && (strpos($c[1][1][1][1],'_exists')!==false) && ($c[1][1][1][2][0][0]=='LITERAL') && ($c[1][1][1][2][0][1][0]=='STRING')) $temp_function_guard.=','.$c[1][1][1][2][0][1][1].',';
				if (($c[1][0]=='BOOLEAN_AND') && ($c[1][2][0]=='BOOLEAN_AND') && ($c[1][2][1][0]=='BRACKETED') && ($c[1][2][1][1][0]=='CALL_DIRECT') && (strpos($c[1][2][1][1][1],'_exists')!==false) && ($c[1][2][1][1][2][0][0]=='LITERAL') && ($c[1][2][1][1][2][0][1][0]=='STRING')) $temp_function_guard.=','.$c[1][2][1][1][2][0][1][1].',';
				check_command($c[2],$depth,$temp_function_guard,$nogo_parameters);
				break;
			case 'IF_ELSE':
				$passes=ensure_type(array('boolean'),check_expression($c[1],false,false,$function_guard),$c_pos,'Conditionals must be boolean (if-else)',true);
				if ($passes) infer_expression_type_to_variable_type('boolean',$c[1]);
				$temp_function_guard=$function_guard;
				if (($c[1][0]=='CALL_DIRECT') && (strpos($c[1][1],'_exists')!==false) && ($c[1][2][0][0]=='LITERAL') && ($c[1][2][0][1][0]=='STRING')) $temp_function_guard.=','.$c[1][2][0][1][1].',';
				if (($c[1][0]=='BOOLEAN_AND') && ($c[1][1][0]=='BRACKETED') && ($c[1][1][1][0]=='CALL_DIRECT') && (strpos($c[1][1][1][1],'_exists')!==false) && ($c[1][1][1][2][0][0]=='LITERAL') && ($c[1][1][1][2][0][1][0]=='STRING')) $temp_function_guard.=','.$c[1][1][1][2][0][1][1].',';
				if (($c[1][0]=='BOOLEAN_AND') && ($c[1][2][0]=='BOOLEAN_AND') && ($c[1][2][1][0]=='BRACKETED') && ($c[1][2][1][1][0]=='CALL_DIRECT') && (strpos($c[1][2][1][1][1],'_exists')!==false) && ($c[1][2][1][1][2][0][0]=='LITERAL') && ($c[1][2][1][1][2][0][1][0]=='STRING')) $temp_function_guard.=','.$c[1][2][1][1][2][0][1][1].',';
				check_command($c[2],$depth,$temp_function_guard,$nogo_parameters);
				check_command($c[3],$depth,$function_guard,$nogo_parameters);
				break;
			case 'INNER_FUNCTION':
				$temp=$LOCAL_VARIABLES;
				check_function($c[1]);
				$LOCAL_VARIABLES=$temp;
				break;
			case 'INNER_CLASS':
				$class=$c[1];
				foreach ($class['functions'] as $function)
				{
					$temp=$LOCAL_VARIABLES;
					$LOCAL_VARIABLES['this']=array('is_global'=>false,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('object'),'references'=>0,'object_type'=>$CURRENT_CLASS,'unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false);
					check_function($function);
					$LOCAL_VARIABLES=$temp;
				}
				break;
			case 'TRY':
				check_command($c[1],$depth+1,$function_guard,$nogo_parameters); // Goes first so that we get local variables defined inside loop for use in our loop conditional
				add_variable_reference($c[2][1][0][1],$c_pos,false);
				check_command($c[2][2],$depth+1,$function_guard); // Goes first so that we get local variables defined inside loop for use in our loop conditional
				break;
			case 'FOREACH_map':
				$passes=ensure_type(array('array'),check_expression($c[1],false,false,$function_guard),$c_pos,'Foreach must take array');
				if ($passes) infer_expression_type_to_variable_type('array',$c[1]);
				add_variable_reference($c[2][1],$c_pos,false);
				add_variable_reference($c[3][1],$c_pos,false);

				if (in_array($c[2][1],$nogo_parameters))
					log_warning('Re-using a loop variable, '.$c[2][1],$c_pos);
				if (in_array($c[3][1],$nogo_parameters))
					log_warning('Re-using a loop variable, '.$c[3][1],$c_pos);

				check_command($c[4],$depth+1,$function_guard,array_merge($nogo_parameters,array($c[2][1],$c[3][1])));
				break;
			case 'FOREACH_list':
				$passes=ensure_type(array('array'),check_expression($c[1],false,false,$function_guard),$c_pos,'Foreach must take array');
				if ($passes) infer_expression_type_to_variable_type('array',$c[1]);
				add_variable_reference($c[2][1],$c_pos,false);

				if (in_array($c[2][1],$nogo_parameters))
					log_warning('Re-using a loop variable, '.$c[2][1],$c_pos);

				check_command($c[3],$depth+1,$function_guard,array_merge($nogo_parameters,array($c[2][1])));
				break;
			case 'FOR':
				if (!is_null($c[1])) check_command(array($c[1]),$depth+1,$function_guard);
				check_command(array($c[3]),$depth+1,$function_guard);
				$passes=ensure_type(array('boolean'),check_expression($c[2],false,false,$function_guard),$c_pos,'Conditionals must be boolean (for)',true);
				if ($passes) infer_expression_type_to_variable_type('boolean',$c[2]);
				check_command($c[4],$depth+1,$function_guard,$nogo_parameters);
				break;
			case 'DO':
				check_command($c[2],$depth+1,$function_guard,$nogo_parameters); // Goes first so that we get local variables defined inside loop for use in our loop conditional
				$passes=ensure_type(array('boolean'),check_expression($c[1],false,false,$function_guard),$c_pos,'Conditionals must be boolean (do)',true);
				if ($passes) infer_expression_type_to_variable_type('boolean',$c[1]);
				break;
			case 'WHILE':
				$passes=ensure_type(array('boolean'),check_expression($c[1],false,false,$function_guard),$c_pos,'Conditionals must be boolean (while)',true);
				if ($passes) infer_expression_type_to_variable_type('boolean',$c[1]);
				check_command($c[2],$depth+1,$function_guard,$nogo_parameters);
				break;
			case 'CONTINUE':
				if (($c[1][0]=='SOLO') && ($c[1][1][0]=='LITERAL') && ($c[1][1][1][0]=='INTEGER'))
				{
					if ($c[1][1][1][1]>$depth) log_warning('Continue level greater than loop/switch depth',$c_pos);
				}
				$passes=ensure_type(array('integer'),check_expression($c[1],false,false,$function_guard),$c_pos,'Loop/switch control must use integers (continue)');
				if ($passes) infer_expression_type_to_variable_type('integer',$c[1]);
				break;
			case 'BREAK':
				$passes=ensure_type(array('integer'),check_expression($c[1],false,false,$function_guard),$c_pos,'Loop/switch control must use integers (break)');
				if ($passes) infer_expression_type_to_variable_type('integer',$c[1]);
				break;
			case 'PRE_DEC':
				ensure_type(array('integer','float'),check_variable($c[1]),$c_pos,'Can only decrement numbers');
				break;
			case 'PRE_INC':
				ensure_type(array('integer','float'),check_variable($c[1]),$c_pos,'Can only increment numbers');
				break;
			case 'DEC':
				ensure_type(array('integer','float'),check_variable($c[1]),$c_pos,'Can only decrement numbers');
				break;
			case 'INC':
				ensure_type(array('integer','float'),check_variable($c[1]),$c_pos,'Can only increment numbers');
				break;
			case 'ECHO':
				foreach ($c[1] as $e)
				{
					$passes=ensure_type(array('string'),check_expression($e,false,false,$function_guard),$c_pos,'Can only echo strings');
					if ($passes) infer_expression_type_to_variable_type('string',$e);
				}
				break;
		}

		if ($or) check_command(array($c[count($c)-1]),$depth,$function_guard,$nogo_parameters);
	}
}

function check_method($c,$c_pos,$function_guard='')
{
	global $LOCAL_VARIABLES,$FUNCTION_SIGNATURES;

	if (!is_null($c[1]))
	{
		check_variable($c[1]);

		$params=$c[2];

		// Special rule for 'this->connection'
		if (($c[1][1]=='this') && ($c[1][2][1][1]=='connection'))
		{
			$method=$c[1][2][2][1][1];
			$class='database_driver';
			return actual_check_method($class,$method,$params,$c_pos,$function_guard);
		}

		// Special rule for $GLOBALS['?_DB']
		if (($c[1][1]=='GLOBALS') && (substr($c[1][2][1][1][0],-3)=='LITERAL') && (substr($c[1][2][1][1][1],-3)=='_DB'))
		{
			$method=$c[1][2][2][1][1];
			$class='database_driver';
			return actual_check_method($class,$method,$params,$c_pos,$function_guard);
		}

		// Special rule for $GLOBALS['FORUM_DRIVER']
		if (($c[1][1]=='GLOBALS') && (substr($c[1][2][1][1][0],-3)=='LITERAL') && ($c[1][2][1][1][1]=='FORUM_DRIVER'))
		{
			$method=$c[1][2][2][1][1];
			$class='forum_driver_base';
			return actual_check_method($class,$method,$params,$c_pos,$function_guard);
		}

		if ((isset($c[1][2][0])) && ($c[1][2][0]=='DEREFERENCE') && (count($c[1][2][2])==0))
		{
			$object=$c[1][1];
			$method=$c[1][2][1][1];
			add_variable_reference($object,$c_pos);

			if (((count($LOCAL_VARIABLES[$object]['types'])==1) && ($LOCAL_VARIABLES[$object]['types'][0]=='tempcode')) || (isset($FUNCTION_SIGNATURES[$LOCAL_VARIABLES[$object]['object_type']]))) // Construction
			{
				$class=($LOCAL_VARIABLES[$object]['types'][0]=='tempcode')?'ocp_tempcode':substr($LOCAL_VARIABLES[$object]['types'][0],6);
				return actual_check_method($class,$method,$params,$c_pos,$function_guard);
			} else
			{
				// Parameters
				foreach ($params as $e)
				{
					check_expression($e,false,false,$function_guard);
				}

				return 'mixed';
			}
		}

		scan_extractive_expressions($c[1][2]);
	}
	// Parameters
	foreach ($c[2] as $e)
	{
		check_expression($e,false,false,$function_guard);
	}

	return 'mixed';
}

function actual_check_method($class,$method,$params,$c_pos,$function_guard='')
{
	// Special rule for $_->object_factory(...) and $_->controller(...) etc
	if (($method=='object_factory') || ($method=='controller') || ($method=='sys_model'))
	{
		// $_->object_factory(...) and $_->class(...) are used to load and
		// instantiate classes. This makes them pretty crucial for type
		// checking.
		// There is a strict coding standard such that files called foo.php
		// must define a class OCP_Foo, thus we can infer the class from the
		// include path.
		if (!isset($params[0][1][1])) return 'object';
		$ret=$params[0][1][1];		// Grab the path (first argument)
		$ret=array_pop(explode('/',$ret));		// Only keep the filename, not the whole path
		$ret='object-OCP_'.ucfirst($ret);		// Turn the filename into the class name, and prefix with 'object-'

		// Parameters
		foreach ($params as $e)
		{
			check_expression($e,false,false,$function_guard);
		}

		return $ret;
	}

	return check_call(array('CALL_DIRECT',$method,$params),$c_pos,$class,$function_guard);
}

function check_call($c,$c_pos,$class=NULL,$function_guard='')
{
	global $CURRENT_CLASS;
	if (is_null($class)) $class='__global';

	if ((isset($GLOBALS['PEDANTIC'])) && (array_key_exists(3,$c)) && (!$c[3]))
	{
		if (((isset($GLOBALS['VAR_ERROR_FUNCS'][$c[1]])) && (@$c[2][1][0]=='VARIABLE')) || (isset($GLOBALS['ERROR_FUNCS'][$c[1]])))
		{
			log_warning('Check this call is error-caught',$c_pos);
		}
	}

	$function=$c[1];
	if (isset($GLOBALS['CHECKS']))
	{
		global $EXT_FUNCS;
		if (isset($EXT_FUNCS[$function])) log_warning('Check for function_exists usage around '.$function,$c_pos);
	}
	$_function=($class=='__global')?$function:($class.'.'.$function);
	if (isset($GLOBALS['SECURITY'])) if (in_array($_function,get_insecure_functions())) log_warning('Call to insecure function ('.$_function.')',$c_pos);
	global $FUNCTION_SIGNATURES;
	$ret=NULL;
	$found=false;

	if (isset($FUNCTION_SIGNATURES[$class]['functions'][$function])) $potential=$FUNCTION_SIGNATURES[$class]['functions'][$function]; else $potential=NULL;
	if ((is_null($potential)) && ($class=='forum_driver_base'))
	{
		$class='forum_driver_ocf';
		if (isset($FUNCTION_SIGNATURES[$class]['functions'][$function])) $potential=$FUNCTION_SIGNATURES[$class]['functions'][$function]; else $potential=NULL;
	}

	if ($class=='database_driver')
	{
		$param=$c[2];
		if ((count($param)>=2) && ($param[0][0]=='LITERAL'))
		{
			$table=$param[0][1][1];
			if ($function=='query_insert')
			{
				$map=check_db_map($table,$param[1],$c_pos,true);
			}
			if ($function=='query_update')
			{
				check_db_map($table,$param[1],$c_pos);
				if (isset($param[2])) check_db_map($table,$param[2],$c_pos);
			}
			if ($function=='query_select')
			{
				check_db_fields($table,$param[1],$c_pos);
				if (isset($param[2])) check_db_map($table,$param[2],$c_pos);
			}
			if (($function=='query_value') || ($function=='query_value_null_ok'))
			{
				check_db_field($table,$param[1],$c_pos);
				if (isset($param[2])) check_db_map($table,$param[2],$c_pos);
			}
		}
	}

	foreach ($c[2] as $param)
	{
		if ($param[0]=='VARIABLE_REFERENCE')
		{
			log_warning('Call by reference to function \''.$function.'\'',$c_pos);
		}
	}

	if (!is_null($potential))
	{
		$found=true;
		if (isset($potential['return'])) $ret=$potential['return'];
		foreach ($potential['parameters'] as $i=>$param)
		{
			if ((!isset($c[2][$i])) && (!array_key_exists('default',$param)))
			{
				log_warning('Insufficient parameters to function \''.$function.'\'',$c_pos);
				break;
			}
			if (isset($c[2][$i]))
			{
				$temp=$c[2][$i];

				// Can't pass references
				if (($temp[0]=='SOLO') && (is_array($temp[1])) && ($temp[1][0]=='VARIABLE_REFERENCE'))
				{
					log_warning('Reference parameter passed to function \''.$function.'\'',$c_pos);
					break;
				}

				// If it is a referenced parameter then we must pass a variable expression not a general expression
				if ((@$param['ref']) && ($c[2][$i][0]!='VARIABLE'))
				{
					log_warning('A referenced parameter for \''.$function.'\' was given a non-variable expression',$c_pos);
					break;
				}

				$t=check_expression($c[2][$i],false,false,$function_guard);
				$passes=ensure_type(array($param['type']),$t,$c_pos,'Parameter type error for '.$function.'/'.($i+1).' (should be '.$param['type'].' not '.$t.')');
				if (($t==='float') && ($function==='strval')) log_warning('Floats cannot be used with strval',$c_pos);
				if ($passes) infer_expression_type_to_variable_type($param['type'],$c[2][$i]);
			} else break;
		}
		if (count($potential['parameters'])<count($c[2]))
		{
			log_warning('Too many parameters to function \''.$function.'\'',$c_pos);
		}

		// Look for file-creators, and give notice that chmoding might be required to allow it to be deleted via FTP
		if (in_array('creates-file',$potential['flags']))
		{
			if (isset($GLOBALS['CHECKS']))
			{
				if (($function=='fopen') && (in_array(@$c[2][1][1][1]{0},array('w','a'))))
					log_warning('Call to \''.$function.'\' that may create a file/folder. Check that the code chmods it so that FTP can delete it.',$c_pos);
			}
		}
	}

	if (($function=='tempnam') && (@$c[2][0][0]=='LITERAL') && (substr(@$c[2][0][1][1],0,4)=='/tmp')) log_warning('Don\'t assume you can write to the shared temp directory -- safe mode won\'t tolerate it',$c_pos);
	if (($function=='strpos') && (@$c[2][0][0]=='LITERAL') && (@$c[2][1][0]!='LITERAL')) log_warning('Looks like strpos parameters are the wrong way around; you fell for a common API anomaly: unlike most functions like in_array, strpos is haystack followed by needle',$c_pos);
	if (($function=='strrpos') && (@$c[2][1][0]=='LITERAL') && (strlen(@$c[2][1][1][1])>1)) log_warning('strrpos only accepts single character search strings prior to PHP5',$c_pos); // TODO: Remove in v10
	if ((($function=='sprintf') || ($function=='printf')) && (@$c[2][0][0]=='LITERAL'))
	{
		$matches=array();
		$num_matches=preg_match_all('#\%\d*[bcdefuFodsxX]#',$c[2][0][1][1],$matches);
		if ($num_matches+1!=count($c[2])) log_warning('Looks like the wrong number of parameters were sent to this printf function',$c_pos);
	}
	if ((isset($GLOBALS['CHECKS'])) && ($function=='tempname')) log_warning('Make sure temporary files are deleted',$c_pos);
	//if ((isset($GLOBALS['CHECKS'])) && ($function=='fopen')) log_warning('Make sure opened files are closed',$c_pos);  Not going to actually cause problems, as PHP'll close it when the script finishes
	if ((isset($GLOBALS['CHECKS'])) && ($function=='get_username') && (@$c[2][0][1]!='get_member')) log_warning('Make sure guests/deleted-members are handled properly',$c_pos);
	if ((isset($GLOBALS['CHECKS'])) && ($function=='get_url')) log_warning('Make sure that deleting the entry for this file/URL deletes the disk file',$c_pos);
	if ((isset($GLOBALS['CHECKS'])) && (in_array($function,array('query_insert','insert_lang','insert_lang_comcode')))) log_warning('Make sure that deleting the entry (or uninstalling) for this row deletes the row (if applicable)',$c_pos);
	if ((isset($GLOBALS['CHECKS'])) && ($function=='query_delete') && (!array_key_exists(2,$c[2]))) log_warning('Check that non-singular modification is wanted for this query',$c_pos);
	if ((isset($GLOBALS['CHECKS'])) && ($function=='query_update') && (!array_key_exists(3,$c[2]))) log_warning('Check that non-singular modification is wanted for this query',$c_pos);
	if ((isset($GLOBALS['CHECKS'])) && ($function=='unlink')) log_warning('Be very careful that shared URLs cannot be deleted (check upload dir, and staff access)',$c_pos);
	if ((isset($GLOBALS['CHECKS'])) && (isset($GLOBALS['PEDANTIC'])) && (in_array($function,array('query_update','query_delete')))) log_warning('Check log_it/cat-entry-handling/delete_lang',$c_pos);
	//if ((isset($GLOBALS['CHECKS'])) && (isset($GLOBALS['PEDANTIC'])) && ($function=='query_select')) log_warning('Check that non-singular select is wanted for this query',$c_pos);  This is REALLY pedantic ;) I'm sure mySQL is clever enough to see that only one row can match against a key

	if (!is_null($ret)) return $ret['type'];
	if (!$found)
	{
		if (isset($GLOBALS['API']))
		{
			if (((is_null($GLOBALS['OK_EXTRA_FUNCTIONS'])) || (preg_match('#^'.$GLOBALS['OK_EXTRA_FUNCTIONS'].'#',$function)==0)) && (!in_array($function,array('critical_error','file_array_exists','file_array_get','file_array_count','file_array_get_at','master__sync_file','master__sync_file_move'))) && (strpos($function_guard,','.$function.',')===false))
			{
				if ((is_null($class)) || ($class=='__global'))
				{
					log_warning('Could not find function \''.$function.'\'',$c_pos);
				} else
				{
					if ($class!='mixed')
						log_warning('Could not find method \''.$class.'->'.$function.'\'',$c_pos);
				}
			}
		}
		foreach ($c[2] as $param)
		{
			check_expression($param,false,false,$function_guard);
		}
		return 'mixed';
	}
	return $ret;
}

function check_db_map($table,$expr_map,$c_pos,$must_be_complete=false)
{
	$map=array();
	$arr_count=0;
	if ($expr_map[0]=='CREATE_ARRAY')
	{
		foreach ($expr_map[1] as $passing)
		{
			if (count($passing)==1)
			{
				log_warning('Map required, list given',$c_pos);
			} else
			{
				if ($passing[0][0]=='LITERAL')
				{
					$type=check_expression($passing[1]);
					if ($type=='array') $arr_count++;
					$map[$passing[0][1][1]]=$type;
				}
			}
		}
	}
	if ($arr_count==count($map))
	{
		if ((!isset($GLOBALS['TABLE_FIELDS'][$table])) && (!is_null($GLOBALS['TABLE_FIELDS'])))
		{
			if (strpos($table,' ')===false) log_warning('Unknown table referenced',$c_pos);
		}
	} else
	{
		foreach ($map as $field=>$type)
		{
			_check_db_field($table,$field,$c_pos,$type);
		}
	}
	if (($must_be_complete) && (isset($GLOBALS['TABLE_FIELDS'][$table])) && (!is_null($GLOBALS['TABLE_FIELDS'])))
	{
		if ((isset($GLOBALS['TABLE_FIELDS'][$table]['id'])) && (strpos($GLOBALS['TABLE_FIELDS'][$table]['id'],'AUTO')!==false))
			$map['id']='integer'; // Auto
		$missing=implode(', ',array_diff(array_keys($GLOBALS['TABLE_FIELDS'][$table]),array_keys($map)));
		if ($missing!='')
			log_warning('Table field map may be incomplete (unsure, but can\'t see: '.$missing.' )',$c_pos);
	}
	return $map;
}

function check_db_fields($table,$expr_map,$c_pos)
{
	if ($expr_map[0]=='CREATE_ARRAY')
	{
		foreach ($expr_map[1] as $passing)
		{
			if (count($passing)==2)
			{
				log_warning('The selection array must be a list, not a map',$c_pos);
			} else
			{
				check_db_field($table,$passing[0],$c_pos);
			}
		}
	}
}

function check_db_field($table,$expr_map,$c_pos)
{
	if (($expr_map[0]=='LITERAL') && (!is_null($GLOBALS['TABLE_FIELDS'])))
	{
		_check_db_field($table,$expr_map[1][1],$c_pos);
	}
}

function _check_db_field($table,$field,$c_pos,$type=NULL)
{
	if (is_null($GLOBALS['TABLE_FIELDS'])) return;

	if (!isset($GLOBALS['TABLE_FIELDS'][$table]))
	{
		if (strpos($table,' ')===false) log_warning('Unknown table referenced',$c_pos);
		return;
	}

	$field=str_replace('DISTINCT ','',$field);
	$field=preg_replace('# AS .*#','',$field);
	$field=preg_replace('#MAX\((.*)\)#','${1}',$field);
	$field=preg_replace('#MIN\((.*)\)#','${1}',$field);
	$field=preg_replace('#SUM\((.*)\)#','${1}',$field);
	if (strpos($field,'*')!==false) return;

	if (!isset($GLOBALS['TABLE_FIELDS'][$table][$field]))
	{
		log_warning('Unknown field ('.$field.') referenced',$c_pos);
		return;
	}

	if (!is_null($type))
	{
		$expected_type=str_replace('*','',$GLOBALS['TABLE_FIELDS'][$table][$field]);
		ensure_type(array($expected_type),$type,$c_pos,'DB field '.$field.' should be '.$expected_type.', not '.$type);
	}
}

function get_insecure_functions()
{
	return array('eval',
					 'ldap_search','ldap_list',
					 'register_shutdown_function','register_tick_function','create_function','call_user_method_array','call_user_func_array','call_user_method','call_user_func',
					 'fsockopen','chroot','chdir','chgrp','chmod','copy','delete','fopen','file','file_get_contents','fpassthru','mkdir','move_uploaded_file','popen','readfile','rename','rmdir','unlink','imagepng','imagejpeg','imagegif',
					 'mail','header',
					 'better_parse_ini_file','deldir_contents',
					 'include','include_once','require','require_once',
					 'escapeshellarg','escapeshellcmd','exec','passthru','proc_open','shell_exec','system',
					 'database_driver.query','database_driver._query','database_driver.query_value_null_ok_full');
}

/*
Demonstration of all the assignment checks we could make:

$foo+='a';

$bar=1;
$bar[]='a';

list($a)=1;

$b=1;
$b{3}='a';
*/
function check_assignment($c,$c_pos,$function_guard='')
{
	global $LOCAL_VARIABLES;
	$GLOBALS['MADE_CALL']=NULL;
	$e_type=check_expression($c[3],true,false,$function_guard);
	$made_call=$GLOBALS['MADE_CALL'];
	$GLOBALS['MADE_CALL']=NULL;
	$op=$c[1];
	$target=$c[2];

	// Special assignment operational checks
	if (in_array($op,array('CONCAT_EQUAL')))
	{
		$passes=ensure_type(array('string'),$e_type,$c_pos,'Can only concatenate onto and with strings (not '.$e_type.')');
		if ($passes) infer_expression_type_to_variable_type('string',$c[3]);
		if ($c[3][0]=='VARIABLE_REFERENCE')
			log_warning('Cannot append a reference',$c_pos);
		if ($target[0]=='VARIABLE')
		{
			$v_type=get_variable_type($target);
			ensure_type(array('string'),$v_type,$c_pos,'Can only concatenate onto and with strings (not '.$v_type.')');
		}
	}
	if (in_array($op,array('PLUS_EQUAL')))
	{
		ensure_type(array('array','integer','float'),$e_type,$c_pos,'Can only perform addition to arrays or numbers (not '.$e_type.')');
		if ($target[0]=='VARIABLE')
		{
			$v_type=get_variable_type($target);
			ensure_type(array('array','integer','float'),$v_type,$c_pos,'Can only perform addition to arrays or numbers (not '.$v_type.')');
		}
	}
	if (in_array($op,array('DIV_EQUAL','MUL_EQUAL','MINUS_EQUAL')))
	{
		ensure_type(array('integer','float'),$e_type,$c_pos,'Can only perform relative arithmetic with numbers (not '.$e_type.')');
		if ($target[0]=='VARIABLE')
		{
			$v_type=get_variable_type($target);
			ensure_type(array('integer','float'),$v_type,$c_pos,'Can only perform relative arithmetic with numbers (not '.$v_type.')');
		}
	}

	// Special assignment target checks
	if ($target[0]=='LIST')
	{
		$passes=ensure_type(array('array'),$e_type,$c_pos,'Can only list from an array (not '.$e_type.')');
		if ($passes) infer_expression_type_to_variable_type('array',$c[3]);
		foreach ($target[1] as $var)
		{
			if (count($var[2])==0)
			{
				add_variable_reference($var[1],$c_pos,false);
			}
		}
		return 'array';
	}
	if ($target[0]=='ARRAY_APPEND')
	{
		if (count($target[2][2])==0) // Simple variable, meaning we can test to see if it's an array
		{
			$v_type=check_variable($target[1],true);
			$passes=ensure_type(array('array'),$v_type,$c_pos,'Can only append to an array (not '.$v_type.')');
			if ($passes) infer_expression_type_to_variable_type('array',$c[3]);
		}
		return 'array';
	}

	// check_variable will do the internalised checks. Type conflict checks will be done at the end of the function, based on all the types the variable has been set with. Variable type usage checks are done inside expressions.
	if ($target[0]=='VARIABLE')
	{
		if (($op=='EQUAL') && (count($target[2])==0))
		{
			add_variable_reference($target[1],$c_pos,false);
			$v=$LOCAL_VARIABLES[$target[1]];
			if ((!is_null($made_call)) && (((!$v['conditioned_null']) && (isset($GLOBALS['NULL_ERROR_FUNCS'][$made_call]))) || ((!$v['conditioned_false']) && (isset($GLOBALS['FALSE_ERROR_FUNCS'][$made_call])))))
			{
				$LOCAL_VARIABLES[$target[1]]['conditioner'][]=$made_call;
			}
			if ($e_type=='*MIXED*')
			{
				global $LOCAL_VARIABLES;
				$LOCAL_VARIABLES[$c[2][1]]['mixed_tag']=true;
				$e_type='?mixed';
			}
			/*elseif (($e_type=='boolean-false') && ($c[3][0]=='LITERAL'))		No, it'll give a mixed type error
			{
				global $LOCAL_VARIABLES;
				$LOCAL_VARIABLES[$c[2][1]]['types'][]='boolean';
			}*/
			set_ocportal_type($target[1],$e_type);
		} else
		{
			if ((!is_null($made_call)) && (((isset($GLOBALS['NULL_ERROR_FUNCS'][$made_call]))) || ((isset($GLOBALS['FALSE_ERROR_FUNCS'][$made_call])))))
			{
				if (isset($GLOBALS['PEDANTIC']))
				{
					log_warning('Result probably wasn\'t error checked',$c_pos);
				}
			}
		}
		$type=check_variable($target);
		return $type;
	}

	// Should never get here
	return 'mixed';
}

function check_expression($e,$assignment=false,$equate_false=false,$function_guard='')
{
	$c_pos=$e[count($e)-1];
	if ($e[0]=='VARIABLE_REFERENCE')
	{
		$e=$e[1];
	}
	if ($e[0]=='SOLO')
	{
		$type=check_expression($e[1],false,false,$function_guard);
		return $type;
	}
	if ((in_array($e[0],array('DIVIDE','REMAINDER','DIV_EQUAL'))) && ($e[2][0]!='LITERAL'))
	{
		if (($assignment) && (@count($e[2][1][2])==0))
		{
			$GLOBALS['LOCAL_VARIABLES'][$e[2][1][1]]['conditioner'][]='_divide_';
		} elseif (isset($GLOBALS['PEDANTIC']))
		{
			log_warning('Divide by zero un-handled',$c_pos);
		}
	}
	if ($e[0]=='UNARY_IF')
	{
		if (($e[1][0]=='CALL_DIRECT') && (strpos($e[1][1],'_exists')!==false) && ($e[1][2][0][0]=='LITERAL') && ($e[1][2][0][1][0]=='STRING')) $function_guard.=','.$e[1][2][0][1][1].',';
		$passes=ensure_type(array('boolean'),check_expression($e[1],false,false,$function_guard),$c_pos,'Conditionals must be boolean (unary)');
		if ($passes) infer_expression_type_to_variable_type('boolean',$e[1]);
		$type_a=check_expression($e[2][0],false,false,$function_guard);
		$type_b=check_expression($e[2][1],false,false,$function_guard);
		if (($type_a!='NULL') && ($type_b!='NULL'))
		{
			$passes=ensure_type(array($type_a,'mixed'/*imperfect, but useful for performance*/),$type_b,$c_pos,'Type symettry error in unary operator');
			if ($passes) infer_expression_type_to_variable_type($type_a,$e[2][1]);
		}
		return $type_a;
	}
	if (in_array($e[0],array('BOOLEAN_AND','BOOLEAN_OR','BOOLEAN_XOR')))
	{
		if (($e[0]=='BOOLEAN_AND') && ($e[1][0]=='BRACKETED') && ($e[1][1][0]=='CALL_DIRECT') && (strpos($e[1][1][1],'_exists')!==false) && ($e[1][1][2][0][0]=='LITERAL') && ($e[1][1][2][0][1][0]=='STRING')) $function_guard.=','.$e[1][1][2][0][1][1].',';
		if (($e[0]=='BOOLEAN_AND') && ($e[2][0]=='BOOLEAN_AND') && ($e[2][1][0]=='BRACKETED') && ($e[2][1][1][0]=='CALL_DIRECT') && (strpos($e[2][1][1][1],'_exists')!==false) && ($e[2][1][1][2][0][0]=='LITERAL') && ($e[2][1][1][2][0][1][0]=='STRING')) $function_guard.=','.$e[2][1][1][2][0][1][1].',';
 		$passes=ensure_type(array('boolean'),check_expression($e[1],false,false,$function_guard),$c_pos-1,'Can only use boolean combinators with booleans');
		if ($passes) infer_expression_type_to_variable_type('boolean',$e[1]);
		$passes=ensure_type(array('boolean'),check_expression($e[2],false,false,$function_guard),$c_pos,'Can only use boolean combinators with booleans');
		if ($passes) infer_expression_type_to_variable_type('boolean',$e[2]);
		return 'boolean';
	}
	if (in_array($e[0],array('SL','SR','REMAINDER')))
	{
		$passes=ensure_type(array('integer'),check_expression($e[1],false,false,$function_guard),$c_pos-1,'Can only use integer combinators with integers');
		if ($passes) infer_expression_type_to_variable_type('integer',$e[1]);
		$passes=ensure_type(array('integer'),check_expression($e[2],false,false,$function_guard),$c_pos,'Can only use integer combinators with integers');
		if ($passes) infer_expression_type_to_variable_type('integer',$e[2]);
		return 'integer';
	}
	if (in_array($e[0],array('CONC')))
	{
		$type_a=check_expression($e[1],false,false,$function_guard);
		$type_b=check_expression($e[2],false,false,$function_guard);
		$passes=ensure_type(array('string'),$type_a,$c_pos-1,'Can only use string combinators with strings (1) (not '.$type_a.')');
		if ($passes) infer_expression_type_to_variable_type('string',$e[1]);
		$passes=ensure_type(array('string'),$type_b,$c_pos,'Can only use string combinators with strings (2) (not '.$type_b.')');
		if ($passes) infer_expression_type_to_variable_type('string',$e[2]);
		return 'string';
	}
	if (in_array($e[0],array('SUBTRACT','MULTIPLY','DIVIDE')))
	{
		$type_a=check_expression($e[1],false,false,$function_guard);
		$t=check_expression($e[2],false,false,$function_guard);
		ensure_type(array('integer','float'),$type_a,$c_pos-1,'Can only use arithmetical combinators with numbers (1) (not '.$type_a.')');
		ensure_type(array('integer','float'),$t,$c_pos,'Can only use arithmetical combinators with numbers (2) (not '.$t.')');
		return ($e[0]=='DIVIDE')?'float':$type_a;
	}
	if (in_array($e[0],array('ADD')))
	{
		$type_a=check_expression($e[1],false,false,$function_guard);
		$t=check_expression($e[2],false,false,$function_guard);
		ensure_type(array('integer','float','array'),$type_a,$c_pos-1,'Can only use + combinator with numbers/arrays (1) (not '.$type_a.')');
		ensure_type(array('integer','float','array'),$t,$c_pos,'Can only use + combinator with numbers/arrays (2) (not '.$t.')');
		return $type_a;
	}
	if (in_array($e[0],array('IS_GREATER_OR_EQUAL','IS_SMALLER_OR_EQUAL','IS_GREATER','IS_SMALLER')))
	{
		$type_a=check_expression($e[1],false,false,$function_guard);
		$type_b=check_expression($e[2],false,false,$function_guard);
		ensure_type(array('integer','float','string'),$type_a,$c_pos-1,'Can only use arithmetical comparators with numbers or strings');
		ensure_type(array('integer','float','string'),$type_b,$c_pos,'Can only use arithmetical comparators with numbers or strings');
		ensure_type(array($type_a),$type_b,$c_pos,'Comparators must have type symmetric operands ('.$type_a.' vs '.$type_b.')');
		return 'boolean';
	}
	if (in_array($e[0],array('IS_EQUAL','IS_IDENTICAL','IS_NOT_IDENTICAL','IS_NOT_EQUAL')))
	{
		$type_a=check_expression($e[1],false,(in_array($e[0],array('IS_IDENTICAL','IS_NOT_IDENTICAL'))) && ($e[2][0]=='LITERAL') && ($e[2][1][0]=='BOOLEAN') && (!$e[2][1][1]),$function_guard);
		$type_b=check_expression($e[2],false,false,$function_guard);
		$x=$e;
		if ($x[1][0]=='EMBEDDED_ASSIGNMENT')
		{
			$x=$e[1];
		}
		if (($x[1][0]=='VARIABLE') && (@count($x[1][1][2])==0) && ($e[2][0]=='LITERAL'))
		{
			if (in_array($e[0],array('IS_IDENTICAL','IS_NOT_IDENTICAL')))
			{
				if (($e[2][1][0]=='BOOLEAN') && (!$e[2][1][1]))
				{
					$GLOBALS['LOCAL_VARIABLES'][$x[1][1][1]]['conditioned_false']=true;
				} elseif ($e[2][1][0]=='NULL')
				{
					$GLOBALS['LOCAL_VARIABLES'][$x[1][1][1]]['conditioned_null']=true;
				}
			}
			if (($e[2][1][0]=='INTEGER') && ($e[2][1][1]==0))
			{
				$GLOBALS['LOCAL_VARIABLES'][$x[1][1][1]]['conditioned_zero']=true;
			}
		}
		if (($e[0]=='IS_EQUAL') && ($e[2][0]=='LITERAL') && ($e[2][1][0]=='BOOLEAN')) log_warning('It\'s redundant to equate to truths',$c_pos);
		if (strpos($e[0],'IDENTICAL')===false)
		{
			if ($type_b=='NULL') log_warning('Comparing to NULL is considered bad',$c_pos);
			$passes=ensure_type(array($type_a),$type_b,$c_pos,'Comparators must have type symmetric operands ('.$type_a.' vs '.$type_b.')');
			if ($passes) infer_expression_type_to_variable_type($type_a,$e[2]);
		}
		return 'boolean';
	}
	$inner=$e;
	switch ($inner[0])
	{
		case 'EMBEDDED_ASSIGNMENT':
			$ret=check_assignment($inner,$c_pos,$function_guard);
			return $ret;
		case 'CALL_METHOD':
			$ret=check_method($inner,$c_pos,$function_guard);
			if (is_null($ret))
			{
				log_warning('Method that returns no value used in an expression',$c_pos);
				return 'mixed';
			}
			return $ret;
		case 'CALL_INDIRECT':
			add_variable_reference($inner[1][1],$c_pos);
			return 'mixed';
		case 'CALL_DIRECT':
			$ret=check_call($inner,$c_pos,NULL,$function_guard);
			if (is_null($ret))
			{
				log_warning('Function (\''.$inner[1].'\') that returns no value used in an expression',$c_pos);
				return 'mixed';
			}
			if ($inner[1]=='mixed')
			{
				return '*MIXED*';
			}
			if ($assignment)
			{
				$GLOBALS['MADE_CALL']=$inner[1];
				if ((@$e[2][0][0]=='VARIABLE') && (@count($e[2][0][1][2])==0) && ($e[1]=='is_null'))
				{
					$GLOBALS['LOCAL_VARIABLES'][$e[2][0][1][1]]['conditioned_null']=true;
				}
			} else
			{
				if (isset($GLOBALS['PEDANTIC']))
				{
					if (isset($GLOBALS['NULL_ERROR_FUNCS'][$inner[1]]))
					{
						log_warning('Crucial error value un-handled',$c_pos);
					}
					if ((isset($GLOBALS['FALSE_ERROR_FUNCS'][$inner[1]])) && (!$equate_false))
					{
						log_warning('Crucial error value un-handled',$c_pos);
					}
				}
			}
			return $ret;
			break;
		case 'CASTED':
			check_expression($inner[2],false,false,$function_guard);
			return strtolower($inner[1]);
		case 'BRACKETED':
			return check_expression($inner[1],false,false,$function_guard);
		case 'BOOLEAN_NOT':
			$passes=ensure_type(array('boolean'),check_expression($inner[1],false,false,$function_guard),$c_pos,'Can only \'NOT\' a boolean',true);
			if ($passes) infer_expression_type_to_variable_type('boolean',$inner[1]);
			return 'boolean';
		case 'BW_NOT':
			$passes=ensure_type(array('integer'),check_expression($inner[1],false,false,$function_guard),$c_pos,'Can only \'BITWISE-NOT\' an integer',true);
			if ($passes) infer_expression_type_to_variable_type('integer',$inner[1]);
			return 'integer';
		case 'NEGATE':
			$type=check_expression($inner[1],false,false,$function_guard);
			ensure_type(array('integer','float'),$type,$c_pos,'Can only negate a number');
			return $type;
		case 'LITERAL':
			$type=check_literal($inner[1]);
			return $type;
		case 'NEW_OBJECT':
			global $FUNCTION_SIGNATURES;
			if ((!isset($FUNCTION_SIGNATURES[$inner[1]])) && ($FUNCTION_SIGNATURES!=array()) && (strpos($function_guard,','.$inner[1].',')===false))
			{
				if (((is_null($GLOBALS['OK_EXTRA_FUNCTIONS'])) || (preg_match('#^'.$GLOBALS['OK_EXTRA_FUNCTIONS'].'#',$inner[1])==0)))
					if (!is_null($inner[1])) log_warning('Unknown class, '.$inner[1],$c_pos);
			}
			foreach ($inner[2] as $param)
			{
				check_expression($param,false,false,$function_guard);
			}
			if (count($inner[2])!=0)
			{
				check_call(array('CALL_METHOD',$inner[1],$inner[2]),$c_pos,$inner[1],$function_guard);
			}
			if ($inner[1]=='ocp_tempcode') return 'tempcode';
			return 'object-'.$inner[1];
		case 'CLONE_OBJECT':
			// $a=clone $b will make a shallow copy of the object $, so we just
			// return $b's type
			return check_expression($inner[1],false,false,'');
		case 'CREATE_ARRAY':
			foreach ($inner[1] as $param)
			{
				check_expression($param[0],false,false,$function_guard);
				if (isset($param[1])) check_expression($param[1],false,false,$function_guard);
			}
			return 'array';
		case 'VARIABLE':
			return check_variable($inner,true);
	}
	return 'mixed';
}

function check_variable($variable,$reference=false)
{
	$identifier=$variable[1];
	if (is_array($identifier)) return;

	global $LOCAL_VARIABLES;
	if ((!isset($LOCAL_VARIABLES[$identifier])) && ($identifier!='this') && !((is_array($identifier) && (in_array($identifier[0],array('CALL_METHOD'/*TODO: Add more here*/))))))
	{
		// We skip this check if the "variable" is coming from a function/method
		// (in which case we have a function/method call rather than a variable)
		log_warning('Variable \''.$identifier.'\' referenced before initialised',$variable[3]);
	}

	// Add to reference count if: this specifically is a reference, or it's complex therefore the base is explicitly a reference, or we are forced to add it because it is yet unseen
	if (($reference) || (count($variable[2])!=0) || (!isset($LOCAL_VARIABLES[$identifier])))
		add_variable_reference($identifier,$variable[count($variable)-1],($reference) || (count($variable[2])!=0));

	$type=get_variable_type($variable);

	$next=$variable[2];
	while ($next!=array()) // Complex: we must perform checks to make sure the base is of the correct type for the complexity to be valid. We must also note any deep variable references used in array index / string extract expressions
	{
		/*if ($next[0]=='CHAR_OF_STRING')
		{
			check_expression($next[1]);
			$passes=ensure_type(array('string'),check_variable(array('VARIABLE',$identifier,array())),$variable[3],'Variable \''.$identifier.'\' must be a string due to dereferencing');
			if ($passes) infer_expression_type_to_variable_type('string',$next[1]);
			return 'string';
		}*/

		if ($next[0]=='ARRAY_AT')
		{
			if (($identifier=='GLOBALS') && ($next[1][0]=='SOLO') && ($next[1][1][0]=='LITERAL'))
			{
				$gid=$next[1][1][1][1];
				add_variable_reference($gid,$variable[count($variable)-1]);
				$LOCAL_VARIABLES[$gid]['is_global']=true;
			}
			check_expression($next[1]);
			$passes=ensure_type(array('array','string'),$type,$variable[3],'Variable must be an array/string due to dereferencing');
			//if ($passes) infer_expression_type_to_variable_type('array',$next[1]);
			$type='mixed'; // We don't know the array data types

			$next=$next[2];
		}

		elseif ($next[0]=='DEREFERENCE')
		{
			ensure_type(array('object','resource'),$type,$variable[3],'Variable must be an object due to dereferencing');
			if (($next[2]!=array()) && ($next[2][0]=='CALL_METHOD'))
			{
				$type=actual_check_method($type/*class*/,$next[1][1]/*method*/,$next[2][2]/*params*/,$next[3]/*line number*/);
				$next=$next[2][5];
			} else
			{
				$type='mixed';
				$next=$next[2];
			}
		}

		else $next=array();
	}

	return $type;
}

function scan_extractive_expressions($variable)
{
	if (!is_array($variable)) return;
	if ($variable==array()) return;

	if (($variable[0]=='ARRAY_AT') || ($variable[0]=='CHAR_OF_STRING'))
	{
		check_expression($variable[1]);
	}

	if ((($variable[0]=='ARRAY_AT') || ($variable[0]=='DEREFERENCE')) && (count($variable[2])!=0))
	{
		scan_extractive_expressions($variable[2]);
	}
}

function get_variable_type($variable)
{
	global $LOCAL_VARIABLES;

	$identifier=$variable[1];

	if (count($variable[2])!=0) return 'mixed'; // Too complex

	if (!isset($LOCAL_VARIABLES[$identifier])) return 'mixed';

	if (count($LOCAL_VARIABLES[$identifier]['types'])==0) return 'mixed'; // There is a problem, but it will be identified elsewhere.

	$temp=array_unique(array_values(array_diff($LOCAL_VARIABLES[$identifier]['types'],array('NULL'))));
	if ($temp==array('boolean-false','boolean')) return 'boolean';
	if (count($temp)!=0) return is_array($temp[0])?$temp[0][0]:$temp[0]; // We'll assume the first set type is the actual type
	return 'NULL';
}

function check_literal($literal)
{
	if ($literal[0]=='NEGATE')
	{
		$type=check_literal($literal[1]);
		ensure_type(array('integer','float'),$type,$literal[count($literal)-1],'Can only negate a number');
		return $type;
	}
	if ($literal[0]=='INTEGER') return 'integer';
	if ($literal[0]=='FLOAT') return 'float';
	if ($literal[0]=='STRING') return 'string';
	if ($literal[0]=='BOOLEAN')
	{
		if (!$literal[1]) return 'boolean-false';
		return 'boolean';
	}
	if ($literal[0]=='NULL') return 'NULL';
	return 'mixed';
}

function set_ocportal_type($identifier,$type)
{
	if (is_array($type)) $type=$type[0];

	global $LOCAL_VARIABLES;
	$LOCAL_VARIABLES[$identifier]['types'][]=$type;
	if (substr($type,0,7)=='object-') $LOCAL_VARIABLES[$identifier]['object_type']=substr($type,7);
	if (($type=='mixed') || ($type=='?mixed')) $LOCAL_VARIABLES[$identifier]['mixed_tag']=true;

	return true;
}

function add_variable_reference($identifier,$first_mention,$reference=true)
{
	$unused_value=!$reference; // May have some problems with loops - as we may use the value in a prior command

	global $LOCAL_VARIABLES;
	if (!isset($LOCAL_VARIABLES[$identifier]))
	{
		$LOCAL_VARIABLES[$identifier]=array('is_global'=>false,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array(),'references'=>$reference?1:0,'object_type'=>'','unused_value'=>$unused_value,'first_mention'=>$first_mention,'mixed_tag'=>false);
	} else
	{
		if ($reference) $LOCAL_VARIABLES[$identifier]['references']++;
		$LOCAL_VARIABLES[$identifier]['unused_value']=$unused_value;
	}
}

function reinitialise_local_variables()
{
	return array(
		'php_errormsg'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('string'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_GET'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_POST'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_REQUEST'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_COOKIE'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_SERVER'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_ENV'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_SESSION'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'_FILES'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
		'GLOBALS'=>array('is_global'=>true,'conditioner'=>array(),'conditioned_zero'=>false,'conditioned_false'=>false,'conditioned_null'=>false,'types'=>array('array'),'references'=>0,'object_type'=>'','unused_value'=>false,'first_mention'=>0,'mixed_tag'=>false),
	);
}

// If the given expression is a direct variable expression, this function will infer the type as the given type. This therefore allows type infering on usage as well as on assignment
function infer_expression_type_to_variable_type($type,$expression)
{
/*	if (($expression[0]=='VARIABLE') && (count($expression[1][2])==0))
	{
		$identifier=$expression[1][1];
		set_ocportal_type($identifier,$type);
	}*/
}

function ensure_type($_allowed_types,$actual_type,$pos,$alt_error=NULL,$extra_strict=false)
{
	if (is_array($actual_type)) $actual_type=$actual_type[0];

	if (($actual_type=='mixed') || ($actual_type=='?mixed') || ($actual_type=='~mixed')) return true; // We can't check it

	// Tidy up our allow list to be a nice map
	if ((!$extra_strict) && ((in_array('boolean',$_allowed_types)) || (in_array('?boolean',$_allowed_types)))) $_allowed_types[]='boolean-false';
	if (($extra_strict) && ($_allowed_types==array('boolean'))) $_allowed_types[]='boolean-false';
	$allowed_types=array();
	foreach ($_allowed_types as $type)
	{
		if (is_array($type)) $type=$type[0];

		if (($type=='mixed') || ($type=='?mixed') || ($type=='~mixed') || ($type=='resource') || ($type=='?resource') || ($type=='~resource')) return true; // Anything works!
		if ($type{0}=='?')
		{
			$type=substr($type,1);
			$allowed_types['NULL']=1;
		}
		if ($type{0}=='~')
		{
			$type=substr($type,1);
			$allowed_types['boolean-false']=1;
		}
		if (substr($type,0,6)=='object') $type='object';
		if ($type=='REAL') $allowed_types['float']=1;
		if (in_array($type,array('AUTO','INTEGER','UINTEGER','SHORT_TRANS','LONG_TRANS','USER','MEMBER','SHORT_INTEGER','AUTO_LINK','BINARY','GROUP','TIME')))
		{
			$allowed_types['integer']=1;
		}
		if (in_array($type,array('LONG_TEXT','SHORT_TEXT','MINIID_TEXT','ID_TEXT','LANGUAGE_NAME','URLPATH','PATH','IP','MD5','EMAIL')))
		{
			$allowed_types['string']=1;
		}
		if (in_array($type,array('tempcode')))
		{
			$allowed_types['object']=1;
		}
		if (in_array($type,array('list','map')))
		{
			$allowed_types['array']=1;
		}
		$allowed_types[$type]=1;
	}

	// Special cases for our actual type
	if ($actual_type{0}=='?')
	{
//		if (isset($allowed_types['NULL'])) return true;		We can afford not to give this liberty due to is_null
		$actual_type=substr($actual_type,1);
	}
	if ($actual_type{0}=='~')
	{
		if (isset($allowed_types['boolean-false'])) return true;
		$actual_type=substr($actual_type,1);
	}
	if (substr($actual_type,0,6)=='object') $actual_type='object';

	// The check
	if (isset($allowed_types[$actual_type])) return true;
	if ($actual_type=='REAL')
	{
		if (isset($allowed_types['float'])) return true;
	}
	if (in_array($actual_type,array('AUTO','INTEGER','UINTEGER','SHORT_TRANS','LONG_TRANS','USER','MEMBER','SHORT_INTEGER','AUTO_LINK','BINARY','GROUP','TIME')))
	{
		if (isset($allowed_types['integer'])) return true;
	}
	if (in_array($actual_type,array('LONG_TEXT','SHORT_TEXT','MINIID_TEXT','ID_TEXT','LANGUAGE_NAME','URLPATH','PATH','IP','MD5','EMAIL')))
	{
		if (isset($allowed_types['string'])) return true;
	}
	if (in_array($actual_type,array('tempcode')))
	{
		if (isset($allowed_types['object'])) return true;
	}
	if (in_array($actual_type,array('list','map')))
	{
		if (isset($allowed_types['array'])) return true;
	}

	log_warning(is_null($alt_error)?'Type mismatch':$alt_error,$pos);
	return false;
}
