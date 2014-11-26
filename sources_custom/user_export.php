<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

function init__user_export()
{
	define('USER_EXPORT_ENABLED',false);
	define('USER_EXPORT_MINUTES',60*24);

	define('USER_EXPORT_DELIM',',');

	define('USER_EXPORT_PATH','data_custom/modules/user_export/out.csv');

	define('USER_EXPORT_IPC_AUTO_REEXPORT',true);
	define('USER_EXPORT_IPC_URL_EDIT',NULL); // add or edit
	define('USER_EXPORT_IPC_URL_DELETE',NULL);
	define('USER_EXPORT_EMAIL',NULL);

	global $USER_EXPORT_WANTED;
	$USER_EXPORT_WANTED=array(
		// LOCAL => REMOTE
		'id'=>'ocPortal member ID',
		'm_username'=>'Username',
		'm_email_address'=>'E-mail address',
	);
}

function do_user_export($to_file=true)
{
	if (function_exists('set_time_limit')) @set_time_limit(0);

	if ($to_file)
	{
		$outdir=get_custom_file_base().'/'.dirname(USER_EXPORT_PATH);
		@mkdir($outdir,0777);
		fix_permissions($outdir,0777);
		$tmp_path=$outdir.'/_temp.csv';
		$outfile=fopen($tmp_path,'ab');
		flock($outfile,LOCK_EX);
		ftruncate($outfile,0);
	} else
	{
		if (!$GLOBALS['FORUM_DRIVER']->is_super_admin(get_member())) access_denied('ADMIN_ONLY');

		@ob_end_clean();
		header('Content-type: text/plain; charset='.get_charset());
		$outfile=@fopen('php://output','wb');
	}

	global $USER_EXPORT_WANTED;
	foreach (array_values($USER_EXPORT_WANTED) as $i=>$title)
	{
		if ($i!=0) fwrite($outfile,USER_EXPORT_DELIM);
		fwrite($outfile,'"'.str_replace('"','""',$title).'"');
	}
	fwrite($outfile,chr(10));

	require_code('ocf_members');

	$start=0;
	$max=50;
	do
	{
		$rows=$GLOBALS['FORUM_DB']->query_select('f_members m JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_custom_fields c ON m.id=c.mf_member_id',array('*'),NULL,'ORDER BY m.id ASC',$max,$start);
		foreach ($rows as $row)
		{
			if (is_guest($row['id'])) continue;

			$row+=ocf_get_all_custom_fields_match_member($row['id']);

			foreach (array_keys($USER_EXPORT_WANTED) as $i=>$local_key)
			{
				if ($i!=0) fwrite($outfile,USER_EXPORT_DELIM);
				$val=is_array($row[$local_key])?$row[$local_key]['RAW']:$row[$local_key];
				if (!is_string($val)) $val=strval($val);
				fwrite($outfile,'"'.str_replace('"','""',$val).'"');
			}
			fwrite($outfile,chr(10));
		}
		$start+=$max;
	}
	while (count($rows)>0);

	flock($outfile,LOCK_UN);
	fclose($outfile);
	if ($to_file)
	{
		@mkdir($outdir,0777);
		fix_permissions($outdir,0777);
		rename($tmp_path,$outdir.'/'.basename(USER_EXPORT_PATH));
		sync_file($tmp_path);
		sync_file($outdir.'/'.basename(USER_EXPORT_PATH));
	} else
	{
		flush();
	}
}

function do_user_export__single_ipc($member_id,$delete=false)
{
	require_code('files');

	require_code('ocf_members');

	if (USER_EXPORT_IPC_AUTO_REEXPORT)
		do_user_export();

	global $USER_EXPORT_WANTED;
	$rows=$GLOBALS['FORUM_DB']->query_select('f_members m JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_custom_fields c ON m.id=c.mf_member_id',array('*'),array('id'=>$member_id),'',1);
	if (array_key_exists(0,$rows))
	{
		$row=$rows[0];

		$row+=ocf_get_all_custom_fields_match_member($row['id']);

		$out='';
		foreach ($USER_EXPORT_WANTED as $local_key=>$url_key)
		{
			if ($out!='') $out.='&';

			$val=is_array($row[$local_key])?$row[$local_key]['RAW']:$row[$local_key];
			if (!is_string($val)) $val=strval($val);

			$out.=urlencode($url_key).'='.urlencode($val);
		}

		if ($delete)
		{
			if (USER_EXPORT_IPC_URL_DELETE!==NULL)
			{
				http_download_file(USER_EXPORT_IPC_URL_DELETE.'?'.$out,NULL,false);
			}
		} else
		{
			if (USER_EXPORT_IPC_URL_EDIT!==NULL)
			{
				http_download_file(USER_EXPORT_IPC_URL_EDIT.'?'.$out,NULL,false);
			}

			if (USER_EXPORT_EMAIL!==NULL)
			{
				$message_raw='This is an automated e-mail. A member record has been updated.'.chr(10).chr(10);
				foreach ($USER_EXPORT_WANTED as $local_key=>$url_key)
				{
					$val=is_array($row[$local_key])?$row[$local_key]['RAW']:$row[$local_key];
					if (!is_string($val)) $val=strval($val);

					$message_raw.=$url_key.' = '.$val.chr(10);
				}

				require_code('mail');
				mail_wrap('Updated member record',$message_raw,array(USER_EXPORT_EMAIL));
			}
		}
	}
}
