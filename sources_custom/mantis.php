<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

function init__mantis()
{
	define('LEAD_DEVELOPER_MEMBER_ID',2);
}

function create_tracker_issue($version,$tracker_title,$tracker_message,$tracker_additional)
{
	$text_id=$GLOBALS['SITE_DB']->_query("
		INSERT INTO
		`mantis_bug_text_table`
		(
		  `description`,
		  `steps_to_reproduce`,
		  `additional_information`
		)
		VALUES
		(
			'".db_escape_string($tracker_message)."',
			'',
			'".db_escape_string($tracker_additional)."'
		)
	",NULL,NULL,false,true,NULL,'',false);

	return $GLOBALS['SITE_DB']->_query("
		INSERT INTO
		`mantis_bug_table`
		(
		  `project_id`,
		  `reporter_id`,
		  `handler_id`,
		  `duplicate_id`,
		  `priority`,
		  `severity`,
		  `reproducibility`,
		  `status`,
		  `resolution`,
		  `projection`,
		  `eta`,
		  `bug_text_id`,
		  `os`,
		  `os_build`,
		  `platform`,
		  `version`,
		  `fixed_in_version`,
		  `build`,
		  `profile_id`,
		  `view_state`,
		  `summary`,
		  `sponsorship_total`,
		  `sticky`,
		  `target_version`,
		  `category_id`,
		  `date_submitted`,
		  `due_date`,
		  `last_updated`
		)
		VALUES
		(
			'1', /* ocPortal project */
			'".strval(LEAD_DEVELOPER_MEMBER_ID)."',
			'".strval(LEAD_DEVELOPER_MEMBER_ID)."',
			'0',
			'40', /* High priority */
			'50', /* Minor severity */
			'10', /* Always reproducable */
			'80', /* Status: Resolved */
			'20', /* Resolution: Fixed */
			'10',
			'10',
			'".strval($text_id)."',
			'',
			'',
			'',
			'".db_escape_string($version)."',
			'',
			'',
			'0',
			'10',
			'".db_escape_string($tracker_title)."',
			'0',
			'0',
			'".db_escape_string($version)."',
			'1', /* General category */
			'".strval(time())."',
			'1',
			'".strval(time())."'
		)
	",NULL,NULL,false,true,NULL,'',false);
}

function upload_to_tracker_issue($tracker_id,$upload)
{
	$disk_filename=md5(serialize($upload));
	move_uploaded_file($upload['tmp_name'],get_custom_file_base().'/tracker/uploads/'.$disk_filename);

	$GLOBALS['SITE_DB']->_query("
		INSERT INTO
		`mantis_bug_file_table`
		(
		  `bug_id`,
		  `title`,
		  `description`,
		  `diskfile`,
		  `filename`,
		  `folder`,
		  `filesize`,
		  `file_type`,
		  `content`,
		  `date_added`,
		  `user_id`
		)
		VALUES
		(
			'".strval($tracker_id)."',
			'',
			'',
			'".$disk_filename."',
			'".db_escape_string($upload['name'])."',
			'".get_custom_file_base()."/tracker/uploads/',
			'".strval($upload['size'])."',
			'application/octet-stream',
			'',
			'".strval(time())."',
			'".strval(LEAD_DEVELOPER_MEMBER_ID)."'
		)
	");
}

function create_tracker_post($tracker_id,$tracker_comment_message)
{
	$text_id=$GLOBALS['SITE_DB']->_query("
		INSERT INTO
		`mantis_bugnote_text_table`
		(
		  `note`
		)
		VALUES
		(
			'".db_escape_string($tracker_comment_message)."'
		)
	",NULL,NULL,false,true,NULL,'',false);

	$monitors=$GLOBALS['SITE_DB']->query('SELECT user_id FROM mantis_bug_monitor_table WHERE bug_id='.strval($tracker_id));
	foreach ($monitors as $m)
	{
		$to_name=$GLOBALS['FORUM_DRIVER']->get_username($m['user_id']);
		if (!is_null($to_name))
		{
			$to_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($m['user_id']);

			require_code('mail');
			mail_wrap('Tracker issue updated','A tracker issue you are monitoring has been updated ('.get_base_url().'/tracker/view.php?id='.strval($tracker_id).').',array($to_email),$to_name);
		}
	}

	return $GLOBALS['SITE_DB']->_query("
		INSERT INTO
		`mantis_bugnote_table`
		(
		  `bug_id`,
		  `reporter_id`,
		  `bugnote_text_id`,
		  `view_state`,
		  `note_type`,
		  `note_attr`,
		  `time_tracking`,
		  `last_modified`,
		  `date_submitted`
		)
		VALUES
		(
			'".strval($tracker_id)."',
			'".strval(LEAD_DEVELOPER_MEMBER_ID)."',
			'".strval($text_id)."',
			'10', /* Public */
			'0',
			'',
			'0',
			'".strval(time())."',
			'".strval(time())."'
		)
	",NULL,NULL,false,true,NULL,'',false);
}

function close_tracker_issue($tracker_id)
{
	$GLOBALS['SITE_DB']->query('UPDATE mantis_bug_table SET resolution=20,status=80 WHERE id='.strval($tracker_id));
}

function get_user_currency()
{
	require_code('users');
	$return_default=false;
	$safe_currency='USD';
	$the_id=intval(get_member());
	$member_id=is_guest($the_id)? NULL : $the_id;
	if(!is_null($member_id))
	{
		$cpf_id=get_credits_profile_field_id('ocp_currency');
		if (!is_null($cpf_id))
		{
			require_code('ocf_members_action2');
			$_fields=ocf_get_custom_field_mappings($member_id);
			$result=strval($_fields['field_'.strval($cpf_id)]);
			$the_currency=!is_null($result)? $result : NULL;
			$return_default=is_null($the_currency)? true: false;
			if ($return_default===false)
			{
				if(!(preg_match("/[a-zA-Z]/", $the_currency)) || (strlen($the_currency) > 3)) log_hack_attack_and_exit('HACK_ATTACK');
			}
		} else
		{
			$return_default=true;
		}
	} else
	{
		$return_default=true;
	}

	$result=get_option('currency',true);

	return $return_default ? (is_null($result) ? $safe_currency : strval($result)) : $the_currency;
}

function get_credits_profile_field_id($field_name='ocp_support_credits')
{
	require_code('ocf_members');
	if(preg_match("/\W/", $field_name)) log_hack_attack_and_exit('HACK_ATTACK');
	$fields=ocf_get_all_custom_fields_match(NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL);
	$field_id=NULL;
	foreach ($fields as $field)
	{
		if ($field['trans_name']==$field_name)
		{
			$field_id=$field['id'];
			break;
		}
	}
	return $field_id;
}