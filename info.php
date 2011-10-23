<?php
global $SITE_INFO;

$SITE_INFO['use_mem_cache']='1';

$SITE_INFO['fast_spider_cache']='0';
$SITE_INFO['default_lang']='EN';
$SITE_INFO['db_type']='mysql';
$SITE_INFO['forum_type']='ocf';
$SITE_INFO['domain']='localhost';
$SITE_INFO['base_url']='http://localhost/git';
$SITE_INFO['table_prefix']='ocp_';
$SITE_INFO['admin_password']='d41d8cd98f00b204e9800998ecf8427e';
$SITE_INFO['db_site']='ocf';
$SITE_INFO['db_site_host']='127.0.0.1';
$SITE_INFO['db_site_user']='root';
$SITE_INFO['db_site_password']='';
$SITE_INFO['user_cookie']='ocp_member_id';
$SITE_INFO['pass_cookie']='ocp_member_hash';
$SITE_INFO['cookie_domain']='';
$SITE_INFO['cookie_path']='/';
$SITE_INFO['cookie_days']='120';
$SITE_INFO['db_forums']='ocf';
$SITE_INFO['db_forums_host']='127.0.0.1';
$SITE_INFO['db_forums_user']='root';
$SITE_INFO['db_forums_password']='';
$SITE_INFO['ocf_table_prefix']='ocp_';

$SITE_INFO['disable_smart_decaching']='1'; // Don't check file times to check caches aren't stale
$SITE_INFO['no_disk_sanity_checks']='1'; // Assume that there are no missing language directories, or other configured directories; things may crash horribly if they are missing and this is enabled
$SITE_INFO['hardcode_common_module_zones']='1'; // Don't search for common modules, assume they are in default positions
$SITE_INFO['prefer_direct_code_call']='1'; // Assume a good opcode cache is present, so load up full code files via this rather than trying to save RAM by loading up small parts of files on occasion
$SITE_INFO['no_keep_params']='1'; // Disable 'keep_' parameters, which can lead to a small performance improvement as URLs can be compiled directly into the template cache

/* Very minor ones */
$SITE_INFO['charset']='utf-8'; // To avoid having to do lookup of character set via a preload of the language file
$SITE_INFO['known_suexec']='1'; // To assume .htaccess is writable for implementing security blocks, so don't check
$SITE_INFO['disable_decaching_shift_encode']='1'; // Assume we aren't using shift-encoding much, so don't check for it fully
$SITE_INFO['debug_mode']='0'; // Don't check for debug mode by looking for traces of git/subversion
$SITE_INFO['no_extra_logs']='1'; // Don't allow extra permission/query logs
$SITE_INFO['no_extra_bots']='1'; // Don't read in extra bot signatures from disk
$SITE_INFO['no_extra_closed_file']='1'; // Don't support reading closed.html for closing down the site
$SITE_INFO['no_installer_checks']='1'; // Don't check the installer is not there
$SITE_INFO['assume_full_mobile_support']='1'; // Don't check the theme supports mobile devices (via loading theme.ini), assume it always does
$SITE_INFO['no_extra_mobiles']='1'; // Don't read in extra mobile device signatures from disk
$SITE_INFO['mysql_old']='0';
