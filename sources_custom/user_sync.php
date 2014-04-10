<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		user_sync
 */

function init__user_sync()
{
	global $USER_SYNC_IMPORT_LIMIT;
	$USER_SYNC_IMPORT_LIMIT=NULL;

	global $DO_USER_SYNC_OFFSET;
	$DO_USER_SYNC_OFFSET=0;

	global $DO_USER_SYNC;
	$DO_USER_SYNC=true;

	global $SYNC_DELETES;
	$SYNC_DELETES=false;

	global $DO_USER_ONLY_ID;
	$DO_USER_ONLY_ID=NULL;

	global $PROGRESS_UPDATE_GAP;
	$PROGRESS_UPDATE_GAP=100;
}

/*
INBOUND
*/

function user_sync__inbound($since=NULL)
{
	global $USER_SYNC_IMPORT_LIMIT,$DO_USER_SYNC_OFFSET,$DO_USER_SYNC,$DO_USER_ONLY_ID,$PROGRESS_UPDATE_GAP;

	if (function_exists('set_time_limit')) @set_time_limit(0);

	require_code('ocf_members');
	require_code('ocf_members_action');
	require_code('ocf_members_action2');
	require_code('ocf_groups');
	require_code('crypt');
	require_code('site');
	require_code('site2');
	require_code('resource_fs');

	require_code('notifications');
	global $NOTIFICATIONS_ON;
	$NOTIFICATIONS_ON=false;
	require_code('global4');
	global $ADMIN_LOGGING_ON;
	$ADMIN_LOGGING_ON=false;

	@ignore_user_abort(false);

	resourcefs_logging__start('inform');

	// Load import scheme
	require_code('user_sync__customise');
	list(
		$db_type,
		$db_host,
		$db_name,
		$db_user,
		$db_password,
		$db_table,

		$db_field_delim,

		$username_fields,
		$username_fields_types,
		$time_field,

		$field_remap,

		$default_password,
		$temporary_password,
	)=get_user_sync_env();

	// Connect to the database
	if (!class_exists('PDO')) warn_exit('PDO must be installed.');
	$connect_string=$db_type.':host='.$db_host.';dbname='.$db_name;
	$dbh=new PDO($connect_string,$db_user,$db_password);
	$dbh->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_WARNING);

	if (strtolower(get_charset())=='utf-8')
		$dbh->exec('set names utf8');

	// Customised start code
	get_user_sync__begin($dbh,$since);

	if ($DO_USER_SYNC)
	{
		// Work out what fields there are
		$native_fields=user_sync_find_native_fields();

		$time_start=time();
		$i=$DO_USER_SYNC_OFFSET;
		$i2=$i;

		// Run query to gather remote data
		$sql='SELECT * FROM '.$db_table.' WHERE 1=1';
		if ((!is_null($time_field)) && (!is_null($since)))
			$sql.=' AND '.$db_field_delim.$time_field.$db_field_delim.'>='.$dbh->quote(date('Y-m-d H:i:s',$since));
		if (!is_null($DO_USER_ONLY_ID))
		{
			foreach ($username_fields as $j=>$username_field)
			{
				$sql.=' AND '.$username_field.'='.$dbh->quote(is_array($DO_USER_ONLY_ID)?$DO_USER_ONLY_ID[$j]:$DO_USER_ONLY_ID);
			}
		}
		$sql.=' LIMIT '.strval($DO_USER_SYNC_OFFSET).',18446744073709551615';
		$sth=$dbh->query($sql);

		// Handle each user
		while (($user=$sth->fetch(PDO::FETCH_ASSOC))!==false)
		{
			if (($USER_SYNC_IMPORT_LIMIT!==NULL) && ($i2-$DO_USER_SYNC_OFFSET>=$USER_SYNC_IMPORT_LIMIT))
			{
				resourcefs_logging('Partial, got to '.strval($i2).' members','inform');
				break;
			}
			$i2++;

			if ($i!=0 && $i%$PROGRESS_UPDATE_GAP==0)
				resourcefs_logging('Progress update: imported '.strval($i).' members','inform');

			// Work out username
			$username='';
			foreach ($username_fields as $j=>$username_field)
			{
				if ($j!=0) $username.=' ';
				$username.=is_integer($user[$username_field])?strval($user[$username_field]):$user[$username_field];
			}
			//ocf_check_name_valid($username,NULL,NULL,true); // Not really needed
			if ($username=='')
			{
				resourcefs_logging('Blank username cannot be imported.','warn');
				continue;
			}

			$email_address=trim(user_sync_handle_field_remap('email_address',$field_remap['email_address'],$user,$dbh,NULL));

			// Bind to existing?
			$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
			if ((is_null($member_id)) && (get_option('one_per_email_address')=='1') && ($email_address!=''))
			{
				$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_email_address($email_address);
			}

			// Work out other data
			$user_data=array();
			foreach ($native_fields as $key)
			{
				$user_data[$key]=user_sync_handle_field_remap($key,NULL,$user,$dbh,$member_id);
			}
			foreach ($field_remap as $key=>$remap_scheme)
			{
				$user_data[$key]=user_sync_handle_field_remap($key,$remap_scheme,$user,$dbh,$member_id);
			}
			$groups=$user_data['groups'];
			$dob_day=$user_data['dob_day'];
			$dob_month=$user_data['dob_month'];
			$dob_year=$user_data['dob_year'];
			$timezone=$user_data['timezone_offset'];
			$primary_group=$user_data['primary_group'];
			$validated=$user_data['validated'];
			$is_perm_banned=$user_data['is_perm_banned'];
			$reveal_age=$user_data['reveal_age'];
			$photo_url=$user_data['photo_url'];
			$language=$user_data['language'];
			$allow_emails=$user_data['allow_emails'];
			$allow_emails_from_staff=$user_data['allow_emails_from_staff'];
			$on_probation_until=$user_data['on_probation_until'];
			$join_time=$user_data['join_time'];

			// Collate CPFs
			$cpf_values=array();
			foreach ($user_data as $key=>$value)
			{
				if (in_array($key,$native_fields)) continue;

				// Try and find a match
				$cpfs=ocf_get_all_custom_fields_match();
				$cpf_id=mixed();
				if (is_numeric($key))
				{
					$cpf_id=intval($key);
				}
				if (is_null($cpf_id))
				{
					foreach ($cpfs as $cpf)
					{
						if ($cpf['trans_name']==$key)
						{
							$cpf_id=$cpf['id'];
							break;
						}
					}
				}
				if (is_null($cpf_id))
				{
					foreach ($cpfs as $cpf)
					{
						if ($cpf['trans_name']=='ocp_'.$key)
						{
							$cpf_id=$cpf['id'];
							break;
						}
					}
				}

				// Set it
				if ($cpf_id!==NULL)
				{
					$cpf_value=is_string($value)?$value:strval($value);
					$cpf_values[$cpf_id]=$cpf_value;
				} else
				{
					resourcefs_logging('Could not bind '.$key.' to CPF.','warn');
				}
			}

			// Import to standard member record
			if ($member_id===NULL)
			{
				$user_data['pass_hash_salted']=($user_data['pass_hash_salted']===NULL)?$default_password:$user_data['pass_hash_salted'];
				$password=is_null($user_data['pass_hash_salted'])?get_rand_password():$user_data['pass_hash_salted'];
				$password_compatibility_scheme=$temporary_password?'temporary':(is_null($user_data['pass_hash_salted'])?'plain'/*so we can find it from the DB*/:NULL);

				// These ones are very ocPortal-centric and hence won't be synched specially
				$last_visit_time=NULL;
				$theme='';
				$avatar_url=NULL;
				$signature='';
				$preview_posts=NULL;
				$title='';
				$photo_thumb_url='';
				$views_signatures=1;
				$auto_monitor_contrib_content=NULL;
				$ip_address=NULL;
				$validated_email_confirm_code='';
				$salt='';
				$last_submit_time=NULL;
				$highlighted_name=0;
				$pt_allow='*';
				$pt_rules_text='';

				$check_correctness=false;

				$member_id=ocf_make_member($username,$password,$email_address,$groups,$dob_day,$dob_month,$dob_year,$cpf_values,$timezone,$primary_group,$validated,$join_time,$last_visit_time,$theme,$avatar_url,$signature,$is_perm_banned,$preview_posts,$reveal_age,$title,$photo_url,$photo_thumb_url,$views_signatures,$auto_monitor_contrib_content,$language,$allow_emails,$allow_emails_from_staff,$ip_address,$validated_email_confirm_code,$check_correctness,$password_compatibility_scheme,$salt,$last_submit_time,NULL,$highlighted_name,$pt_allow,$pt_rules_text,$on_probation_until);
			} else
			{
				// Delete?
				if (function_exists('user_sync__handle_deletion'))
				{
					global $SYNC_DELETES;
					if ($SYNC_DELETES)
					{
						if (user_sync__handle_deletion($dbh,$user_data,$member_id)) continue;
					}
				}

				$password=NULL; // Passwords will not be re-synched
				$last_visit_time=NULL;
				$theme=NULL;
				$avatar_url=NULL;
				$signature=NULL;
				$preview_posts=NULL;
				$title=NULL;
				$photo_thumb_url=NULL;
				$views_signatures=NULL;
				$auto_monitor_contrib_content=NULL;
				$ip_address=NULL;
				$validated_email_confirm_code=NULL;
				$check_correctness=NULL;
				$password_compatibility_scheme=NULL;
				$salt=NULL;
				$last_submit_time=NULL;
				$highlighted_name=NULL;
				$pt_allow=NULL;
				$pt_rules_text=NULL;

				$skip_checks=true;

				ocf_edit_member($member_id,$email_address,$preview_posts,$dob_day,$dob_month,$dob_year,$timezone,$primary_group,$cpf_values,$theme,$reveal_age,$views_signatures,$auto_monitor_contrib_content,$language,$allow_emails,$allow_emails_from_staff,$validated,$username,$password,$highlighted_name,$pt_allow,$pt_rules_text,$on_probation_until,$join_time,$avatar_url,$signature,$is_perm_banned,$photo_url,$photo_thumb_url,$salt,$password_compatibility_scheme,$skip_checks);

				require_code('ocf_groups_action2');
				$members_groups=$GLOBALS['OCF_DRIVER']->get_members_groups($member_id);
				foreach ($groups as $group_id)
				{
					if (!in_array($group_id,$members_groups))
					{
						ocf_add_member_to_group($member_id,$group_id);
					}
				}
				foreach ($members_groups as $group_id)
				{
					if ((!in_array($group_id,$groups)) && ($group_id!=$primary_group))
					{
						ocf_member_leave_group($group_id,$member_id);
					}
				}
			}

			$i++;
		}
		$time_end=time();
		if ($user===false)
			resourcefs_logging('Imported '.strval($i-$DO_USER_SYNC_OFFSET).' members in '.strval($time_end-$time_start).' seconds','notice');
	}

	// Customised end code
	get_user_sync__finish($dbh,$since);

	resourcefs_logging__end();
}

function user_sync_handle_field_remap($field_name,$remap_scheme,$remote_data,$dbh,$member_id)
{
	// Specified to use default/omitted (same effect)
	if (is_null($remap_scheme))
	{
		return user_sync_get_field_default($field_name);
	}

	// Work out what to do...
	switch ($remap_scheme[0])
	{
		case 'default': // Given a default
			return $remap_scheme[1];

		case 'field': // Direct field lookup
			if (!array_key_exists(1,$remap_scheme)) $remap_scheme[1]=$field_name; // Identity map, by default
			if (!array_key_exists($remap_scheme[1],$remote_data)) // Not found!
			{
				resourcefs_logging('Requested to import missing remote field, '.$remap_scheme[1].'.','warn');
				return user_sync_get_field_default($field_name);
			}
			$remote_value=$remote_data[$remap_scheme[1]];
			$data=array($remote_value);
			break;

		case 'callback': // Callback
			$data=call_user_func($remap_scheme[1],$field_name,$remote_data,$dbh,$member_id);
			if (!is_array($data)) $data=array($data);
			break;

		default: // ???
			resourcefs_logging('Unknown lookup type ('.$remap_scheme[0].').','warn');
			return user_sync_get_field_default($field_name);
	}

	// Any individual value remappings?
	if (array_key_exists(2,$remap_scheme))
	{
		foreach ($data as $i=>$_data)
		{
			if (array_key_exists($_data,$remap_scheme[2]))
			{
				$_data=$remap_scheme[2][$_data];
				$data[$i]=$_data;
			}
		}
	}

	// Return, but what field type?
	switch ($field_name)
	{
		// Groups
		case 'groups':
		case 'primary_group':
			foreach ($data as $i=>$_data)
			{
				if ((!is_integer($_data)) && (!is_null($_data)))
				{
					if (is_numeric($_data))
					{
						$data[$i]=intval($_data);
					} else // By name
					{
						$resourcefs_ob=get_resource_occlefs_object('group');
						$data[$i]=intval($resourcefs_ob->convert_label_to_id($_data,'','group')); // Will be created if it doesn't already exist
					}
				}
			}
			if ($field_name=='primary_group') return $data[0];
			return $data;
		// Integers
		case 'dob_day':
		case 'dob_month':
		case 'dob_year':
			if (is_integer($data[0])) return $data[0];
			return is_null($data[0])?NULL:intval($data[0]);
		// Timestamps
		case 'join_time':
		case 'on_probation_until':
			if (is_integer($data[0])) return $data[0];
			return is_null($data[0])?NULL:(is_numeric($data[0])?intval($data[0]):strtotime($data[0]));
		// Binary values
		case 'validated':
		case 'is_perm_banned':
		case 'reveal_age':
		case 'allow_emails':
		case 'allow_emails_from_staff':
			if (is_null($data[0])) return NULL;
			if (is_string($data[0])) $data[0]=strtolower($data[0]);
			if (($data[0]==='1') || ($data[0]===1) || ($data[0]==='true') || ($data[0]==='yes') || ($data[0]==='on') || ($data[0]===true))
				return 1;
			return 0;
	}
	if (!is_string($data[0]))
	{
		if (is_null($data[0]))
		{
			$data[0]='';
		} else
		{
			$data[0]=strval($data[0]);
		}
	}
	return $data[0]; // Default, string
}

function user_sync_get_field_default($field_name)
{
	switch ($field_name)
	{
		case 'pass_hash_salted':
			return NULL;
		case 'email_address':
			return '';
		case 'dob_day':
			return NULL;
		case 'dob_month':
			return NULL;
		case 'dob_year':
			return NULL;
		case 'timezone_offset':
			return '';
		case 'primary_group':
			return get_first_default_group();
		case 'validated':
			return 1;
		case 'is_perm_banned':
			return 0;
		case 'reveal_age':
			return 0;
		case 'photo_url':
			return '';
		case 'language':
			return NULL;
		case 'allow_emails':
			return 0;
		case 'allow_emails_from_staff':
			return 1;
		case 'on_probation_until':
			return NULL;
		case 'join_time':
			return NULL;

		case 'groups':
			return array();
	}
	resourcefs_logging('Requested to import unknown field. '.$field_name.'.','warn');
	return NULL; // Should not get here
}


/*
OUTBOUND
*/

function user_sync__outbound($member_id)
{
	require_code('ocf_members');

	require_code('user_sync__customise');
	list(
		$db_type,
		$db_host,
		$db_name,
		$db_user,
		$db_password,
		$db_table,

		$db_field_delim,

		$username_fields,
		$username_fields_types,
		$time_field,

		$field_remap,

		$default_password,
		$temporary_password,
	)=get_user_sync_env();

	$native_fields=user_sync_find_native_fields();

	// Details of local member
	$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
	$record=$GLOBALS['FORUM_DRIVER']->get_member_row($member_id);
	$cpf_fields=ocf_get_all_custom_fields_match_member($member_id);

	// Connect to the database
	if (!class_exists('PDO')) warn_exit('PDO must be installed.');
	$dbh=new PDO($db_type.':host='.$db_host.';dbname='.$db_name,$db_user,$db_password);
	$dbh->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_WARNING);

	// Try and fetch details of remote user
	$sql='SELECT * FROM '.$db_table.' WHERE CONCAT(';
	foreach ($username_fields as $i=>$uf)
	{
		if ($i!=0) $sql.=','.$dbh->quote(' ').',';
		$sql.=$uf;
	}
	$sql.=')='.$dbh->quote($record['m_username']);
	$sth=$dbh->query($sql);
	$user=$sth->fetch(PDO::FETCH_ASSOC);

	if ($user!==false) // Does exist remotely
	{
		$remote_member_id=$user['id'];
	} else // Does not exist remotely yet: Insert empty user, just with the username field(s)
	{
		// Username fields
		$insert_map=array();
		$username_parts=explode(' ',$username);
		foreach ($username_fields as $i=>$uf)
		{
			$insert_map[$uf]=array(
				array_key_exists($i,$username_parts)?$username_parts[$i]:'',
				$username_fields_types[$i]
			);
		}

		// Go through other fields
		foreach ($field_remap as $key=>$remap_scheme)
		{
			if (is_null($remap_scheme)) continue; // Not actually mapped

			if ($remap_scheme[0]!='field') continue; // Not a direct mapping, we can't process backwards

			if (in_array($key,$native_fields))
			{
				$data=$record['m_'.$key];
			} else
			{
				$data=$cpf_fields[$key];
			}

			// Any individual value remappings?
			if (array_key_exists(3,$remap_scheme))
			{
				if (array_key_exists($data,$remap_scheme[3]))
				{
					$data=$remap_scheme[3][$data];
				}
			}

			// Ready for insertion
			$insert_map[$remap_scheme[1]]=array(
				$data,
				array_key_exists(4,$remap_scheme)?$remap_scheme[4]:(is_integer($data)?'INTEGER':'VARCHAR')
			);
		}

		// Build up SQL
		$sql='INSERT INTO '.$db_table.' (';
		foreach (array_keys($insert_map) as $i=>$key)
		{
			if ($i!=0) $sql.=',';
			$sql.=$db_field_delim.$uf.$db_field_delim;
		}
		$sql.=') VALUES (';
		$val=mixed();
		foreach (array_values($insert_map) as $i=>$_val)
		{
			if ($i!=0) $sql.=',';

			list($val,$type)=$_val;

			switch ($type)
			{
				case 'INTEGER':
					$sql.=strval($val);
					break;

				case 'DATETIME':
					$val=date('Y-m-d H:i:s',$val);
					$sql.=$dbh->quote($val);
					break;

				case 'VARCHAR':
				default:
					$sql.=$dbh->quote($val);
					break;
			}
		}
		$sql.=')';

		// Execute SQL
		$dbh->query($sql);
		$remote_member_id=$dbh->lastInsertId();
	}
}


/*
UTILITY FUNCTIONS
*/

function user_sync_find_native_fields()
{
	/*$native_fields=array();		Actually we don't support importing them all, as our code has to choose defaults
	$db_meta=$GLOBALS['SITE_DB']->query_select('db_meta',array('m_name'),array('m_table'=>'f_members'));
	foreach ($db_meta as $_db_meta)
	{
		if (substr($_db_meta['m_name'],0,2)=='m_')
		{
			$native_fields[]=substr($_db_meta['m_name'],2);
		}
	}
	return $native_fields;*/

	return array(
		'pass_hash_salted',
		'email_address',
		'groups',
		'dob_day',
		'dob_month',
		'dob_year',
		'timezone_offset',
		'primary_group',
		'validated',
		'is_perm_banned',
		'reveal_age',
		'photo_url',
		'language',
		'allow_emails',
		'allow_emails_from_staff',
		'on_probation_until',
		'join_time',

		'groups',
	);
}
