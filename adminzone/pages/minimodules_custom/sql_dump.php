<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

disable_php_memory_limit();
if (function_exists('set_time_limit')) @set_time_limit(0);
$GLOBALS['NO_DB_SCOPE_CHECK']=true;

$filename='ocportal-'.get_site_name().'.'.date('Y-m-d').'.sql';

@ob_end_clean();
@ob_end_clean();

if (!isset($_GET['testing']))
{
	header('Content-Type: application/octet-stream'.'; authoritative=true;');
	header('Content-Disposition: attachment; filename="'.str_replace(chr(13),'',str_replace(chr(10),'',addslashes($filename))).'"');
} else
{
	header('Content-type: text/plain; charset='.get_charset());
}

require_code('database_toolkit');

if ((strpos(ini_get('disallowed_functions'),'shell_exec')===false) && (strpos(get_db_type(),'mysql')!==false))
{
	$cmd='mysqldump -h'.get_db_site_host().' -u'.get_db_site_user().' -p'.get_db_site_password().' '.get_db_site().' 2>&1';
	$filename='dump_'.uniqid('',true).'.sql';
	$target_file=get_custom_file_base().'/'.$filename;
	$cmd.=' > '.$target_file;
	$msg=shell_exec($cmd);
	if (($msg!='') || (filesize($target_file)==0))
	{
		/*echo 'Error';
		if ($msg!='') echo ' - '.$msg; */
	} else
	{
		header('Location: '.get_custom_base_url().'/'.$filename);
		exit();
	}
}/* else*/
{
	$st=get_sql_dump(false,false,NULL,NULL,NULL,true);
	foreach ($st as $s)
	{
		echo $s;
		echo "\n\n";
	}
}

$GLOBALS['SCREEN_TEMPLATE_CALLED']='';
exit();
