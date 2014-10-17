<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/*
Used to generate a database schema in the form of SQL code that can be imported into MySQL Workbench

First run this, then import it all into a new database (existing is problematic as it needs to be InnoDB), then run SQLEditor (http://www.malcolmhardie.com/sqleditor/) on that database -- or if you like try your luck importing, but that was crashing for me.
*/

$filename = 'ocportal-erd.sql';

if (!isset($_GET['testing'])) {
    header('Content-Type: application/octet-stream' . '; authoritative=true;');
    header('Content-Disposition: attachment; filename="' . str_replace("\r", '', str_replace("\n", '', addslashes($filename))) . '"');
} else {
    header('Content-type: text/plain');
}


require_code('relations');
$relation_map = get_relation_map();

$tables = get_all_tables();

echo get_innodb_table_sql($tables, $tables);

$GLOBALS['SCREEN_TEMPLATE_CALLED'] = '';
exit();
