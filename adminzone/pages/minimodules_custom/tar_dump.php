<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

disable_php_memory_limit();
if (function_exists('set_time_limit')) @set_time_limit(0);
$GLOBALS['NO_DB_SCOPE_CHECK']=true;

require_code('tar');

$filename='ocportal-'.get_site_name().'.'.date('Y-m-d').'.tar';

@ob_end_clean();
@ob_end_clean();

header('Content-Disposition: attachment; filename="'.str_replace(chr(13),'',str_replace(chr(10),'',addslashes($filename))).'"');

$tar=tar_open(NULL,'wb');

$max_size=get_param_integer('max_size',NULL);
$subpath=get_param('path','');
tar_add_folder($tar,NULL,get_file_base().(($subpath=='')?'':'/').$subpath,$max_size,$subpath,NULL,NULL,false,true);

tar_close($tar);

$GLOBALS['SCREEN_TEMPLATE_CALLED']='';
exit();
