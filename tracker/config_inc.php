<?php
/*
To integrate with ocPortal...

Install Mantis 1.2.0 normally, to the same database as your ocPortal site
Delete the Mantis files
Fix any TODO's in this file
Upload this

This is a fork of Mantis, security fixes have been applied.
*/

# MantisBT - a php based bugtracking system

# MantisBT is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# MantisBT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MantisBT.  If not, see <http://www.gnu.org/licenses/>.

/**
 * @package MantisBT
 * @copyright Copyright (C) 2000 - 2002  Kenzaburo Ito - kenito@300baud.org
 * @copyright Copyright (C) 2002 - 2010  MantisBT Team - mantisbt-dev@lists.sourceforge.net
 * @link http://www.mantisbt.org
 */

# This sample file contains the essential files that you MUST
# configure to your specific settings.  You may override settings
# from config_defaults_inc.php by assigning new values in this file

# Rename this file to config_inc.php after configuration.

# In general the value OFF means the feature is disabled and ON means the
# feature is enabled.  Any other cases will have an explanation.

# Look in http://www.mantisbt.org/docs/ or config_defaults_inc.php for more
# detailed comments.

require(dirname(__FILE__).'/../info.php');

# --- Database Configuration ---
$g_hostname      = $SITE_INFO['db_site_host'];
$g_db_username   = $SITE_INFO['db_site_user'];
$g_db_password   = $SITE_INFO['db_site_password'];
$g_database_name = $SITE_INFO['db_site'];
$g_db_type       = $SITE_INFO['db_type'];
$ocp_sc_db_prefix = $SITE_INFO['table_prefix'];
$ocp_sc_session_cookie_name = 'ocp_session';

# --- Anonymous Access / Signup ---
$g_allow_signup				= ON;
$g_allow_anonymous_login	= ON;
$g_anonymous_account		= 'Guest';
$g_lost_password_feature = OFF;

# --- Attachments / File Uploads ---
$g_allow_file_upload	= ON;
$g_file_upload_method	= DISK; # or DISK
$g_absolute_path_default_upload_folder = dirname(__FILE__).DIRECTORY_SEPARATOR.'uploads'.DIRECTORY_SEPARATOR ; # used with DISK, must contain trailing \ or /.
$g_max_file_size		= 25000000;	# in bytes
$g_preview_attachments_inline_max_size = 256 * 1024;
$g_allowed_files		= 'patch,diff,swf,sql,odg,odp,odt,ods,ps,pdf,doc,ppt,csv,xls,docx,pptx,xlsx,pub,txt,psd,tga,tif,gif,png,bmp,jpg,jpeg,flv,avi,mov,mpg,mpeg,mp4,asf,wmv,ram,ra,rm,qt,zip,tar,rar,gz,wav,mp3,ogg,torrent,php,css,tpl,ini,eml';		# extensions comma separated, e.g. 'php,html,java,exe,pl'
$g_disallowed_files		= '';		# extensions comma separated


# --- Email Configuration ---
$g_phpMailer_method		= PHPMAILER_METHOD_MAIL; # or PHPMAILER_METHOD_SMTP, PHPMAILER_METHOD_SENDMAIL
$g_smtp_host			= 'localhost';			# used with PHPMAILER_METHOD_SMTP
$g_smtp_username		= '';					# used with PHPMAILER_METHOD_SMTP
$g_smtp_password		= '';					# used with PHPMAILER_METHOD_SMTP
$g_administrator_email  = 'info@ocproducts.com'; // TODO: Customise
$g_webmaster_email      = $g_administrator_email;
$g_from_name			= $g_window_title;
$g_from_email           = $g_administrator_email;	# the "From: " field in emails
$g_return_path_email    = $g_administrator_email;	# the return address for bounced mail
$g_email_receive_own	= OFF;
$g_email_send_using_cronjob = OFF;

# --- Real names ---
$g_show_realname = OFF;
$g_show_user_realname_threshold = NOBODY;	# Set to access level (e.g. VIEWER, REPORTER, DEVELOPER, MANAGER, etc)

# --- Others ---
$ocp_sc_site_url = $SITE_INFO['base_url'];
$ocp_sc_site_name = 'ocPortal.com';
$g_default_home_page = 'my_view_page.php';	# Set to name of page to go to after login
$g_logo_url = $ocp_sc_site_url.'/';
$ocp_sc_profile_url = $ocp_sc_site_url.'/site/members/view.htm';
$ocp_sc_commercial_support_url = $ocp_sc_site_url.'/site/commercial_support.htm';
$ocp_sc_community_doc_url = $ocp_sc_site_url.'/site/s/1/39.htm';
$ocp_sc_join_url = $ocp_sc_site_url.'/join.htm';
$ocp_sc_member_view_url = $ocp_sc_site_url.'/site/members/view/%1$d.htm';  # Set the user id as variable in the url ie %1$d
$ocp_sc_sourcecode_link = '<a href="https://github.com/chrisgraham/ocPortal">Github</a>';
$ocp_sc_product_name = 'ocPortal';
$ocp_sc_business_name = 'ocProducts';
$ocp_sc_business_name_possesive = 'ocProduct\'s';
$ocp_sc_credits_per_hour = 6;
$ocp_sc_price_per_credit = 5.5;
$ocp_sc_main_currency = 'GBP';
$ocp_sc_main_currency_symbol = '&pound';
$ocp_sc_alternate_currencies = array('USD', 'CAD', 'EUR');
$ocp_sc_custom_profile_field = 'ocp_support_credits';

$g_enable_sponsorship = ON;
$g_sponsorship_currency = $ocp_sc_main_currency.' '.$ocp_sc_main_currency_symbol;
$g_minimum_sponsorship_amount = $ocp_sc_price_per_credit;

$g_source_control_set_status_to = RESOLVED;
$g_source_control_set_resolution_to = FIXED;
$g_source_control_account = 'Chris Graham'; // TODO
$g_source_control_regex = '/\b(?:bug|issue|feature|request)\s*[#]{0,1}(\d+)\b/i';

$g_show_user_email_threshold = ADMINISTRATOR;

$g_cookie_time_length	= 60*60*24*30;


$g_default_bug_severity = FEATURE;
$g_default_bug_reproducibility = 100;

$g_html_valid_tags		= '';

# --- Branding ---
$g_window_title			= 'ocPortal feature tracker'; // TODO: Customise
$g_logo_image			= '../themes/ocproducts/images/newlogo-top.gif'; // TODO: Customise
$g_favicon_image		= $ocp_sc_site_url.'/themes/default/images/favicon.ico';


