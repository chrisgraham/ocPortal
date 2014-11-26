<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/*EXTRA FUNCTIONS: shell_exec*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		galleries
 */

/**
 * Transcode a video.
 *
 * @param  URLPATH		Video to transcoded.
 * @param  ID_TEXT		The table we are saving into
 * @param  ID_TEXT		Name of the URL field in the table
 * @param  ?ID_TEXT		Name of the original filename field in the table (NULL: built into URL field)
 * @param  ?ID_TEXT		Name of the width field in the table (NULL: none)
 * @param  ?ID_TEXT		Name of the height field in the table (NULL: none)
 * @return URLPATH		Transcoded file (or original URL if no change was made)
 */
function transcode_video($url,$table,$url_field,$orig_filename_field,$width_field,$height_field)
{
	// If there is a locally uploaded file, that is not in a web-safe format, go convert it to such
	if ((preg_match('#http\:\/\/#i',$url)==0) && (preg_match('#\.(flv|mp4|webm|mp3)$#i',$url)==0))
	{
		require_code('files');

		if ((get_option('transcoding_zencoder_api_key')!='') && (get_option('transcoding_zencoder_ftp_path')!='')) // Zencoder
		{
			if ((ocp_srv('HTTP_HOST')=='localhost') || (ocp_srv('HTTP_HOST')=='127.0.0.1'))
			{
				attach_message(do_lang_tempcode('TRANSCODING_LOCALHOST'),'inform');
				$notifications='';
			}
			else
			{
				$notifications='
					<notifications type="array">
						<notification>'.find_script('zencoder_receive').'</notification>
					</notifications>
				';
			}

			$test=false;

			require_code('mime_types');
			$extension='mp4';
			if (substr(get_mime_type(get_file_extension($url)),0,6)=='audio/')
				$extension='mp3';

			$transcoded_filename=uniqid('transcoded',true).'--'.rawurldecode(preg_replace('#\.\w+$#','',basename($url))).'.'.$extension;
			$xml='<'.'?xml version="1.0" encoding="UTF-8"?'.'>
				<api-request>
					<api_key>'.xmlentities(get_option('transcoding_zencoder_api_key')).'</api_key>
					<input>'.xmlentities(url_is_local($url)?(get_custom_base_url().'/'.$url):$url).'</input>
					<test>'.($test?'1':'0').'</test>
					<outputs type="array">
						<output>
							<url>'.rtrim(get_option('transcoding_zencoder_ftp_path'),'/').'/'.$transcoded_filename.'</url>
							<width>'.xmlentities(get_option('video_width_setting')).'</width>
							<speed>2</speed>
							<video_bitrate>'.xmlentities(get_option('video_bitrate')).'</video_bitrate>
							<audio_bitrate>'.xmlentities(get_option('audio_bitrate')).'</audio_bitrate>
							'.$notifications.'
						</output>
					</outputs>
				</api-request>
			';
			$response=http_download_file('https://app.zencoder.com/api/jobs',NULL,true,false,'ocPortal',array($xml),NULL,NULL,NULL,NULL,NULL,NULL,NULL,12.0,true);

			$matches=array();
			if (preg_match('#<id[^>]*>(\d+)</id>#',$response,$matches)!=0)
			{
				attach_message(do_lang_tempcode('TRANSCODING_IN_PROGRESS'),'inform');

				$GLOBALS['SITE_DB']->query_insert('video_transcoding',array(
					't_id'=>$matches[1],
					't_error'=>'',
					't_url'=>$url,
					't_table'=>$table,
					't_url_field'=>$url_field,
					't_orig_filename_field'=>is_null($orig_filename_field)?'':$orig_filename_field,
					't_width_field'=>is_null($width_field)?'':$width_field,
					't_height_field'=>is_null($height_field)?'':$height_field,
					't_output_filename'=>$transcoded_filename,
				));
			} else
			{
				attach_message(do_lang_tempcode('TRANSCODING_ERROR'),'warn');
				if ($GLOBALS['FORUM_DRIVER']->is_super_admin(get_member()))
					attach_message('Full response: '.$response,'inform');
			}
		} else
		{
			if (strpos(@ini_get('disable_functions'),'shell_exec')!==false) return $url; // Can't do

			$transcoding_server=get_option('transcoding_server');
			if ($transcoding_server!='')
			{
				attach_message(do_lang_tempcode('TRANSCODING_IN_PROGRESS'),'inform');

				require_code('files');
				http_download_file($transcoding_server.'/receive_script.php?file='.urlencode(url_is_local($url)?(get_custom_base_url().'/'.$url):$url));

				$GLOBALS['SITE_DB']->query_insert('video_transcoding',array(
					't_id'=>uniqid('',true),
					't_error'=>'',
					't_url'=>$url,
					't_table'=>$table,
					't_url_field'=>$url_field,
					't_orig_filename_field'=>is_null($orig_filename_field)?'':$orig_filename_field,
					't_width_field'=>is_null($width_field)?'':$width_field,
					't_height_field'=>is_null($height_field)?'':$height_field,
					't_output_filename'=>rawurldecode(basename($url)),
				));

				return $url;
			}

			// Immediate local FFMPEG then...

			if (url_is_local($url)) return $url; // Can't locally transcode a remote URL

			//mencoder path
			$ffmpeg_path=get_option('ffmpeg_path');

			//video width to be set
			$video_width_setting=get_option('video_width_setting');

			//video height to be set
			$video_height_setting=get_option('video_height_setting');

			//audio bitrate to be set
			$audio_bitrate=get_option('audio_bitrate');

			//video bitrate to be set
			$video_bitrate=get_option('video_bitrate');

			$file_path=get_file_base().'/'.rawurldecode($url);
			$file_path=preg_replace('#(\\\|/)#',DIRECTORY_SEPARATOR,$file_path);

			// get_mime_type
			require_code('mime_types');
			$file_ext=get_file_extension($file_path);
			$input_mime_type=get_mime_type($file_ext);

			if ((preg_match('#video\/#i',$input_mime_type)!=0) && ($ffmpeg_path!=''))
			{
				//it is video
				$output_path=preg_replace('#\.'.str_replace('#','\#',preg_quote($file_ext)).'$#','',$file_path).'.mp4';
				$shell_command='"'.$ffmpeg_path.'ffmpeg" -i '.@escapeshellarg($file_path).' -y -f mp4 -vcodec libx264 -b '.@escapeshellarg($video_bitrate).'Kb -ab '.@escapeshellarg($audio_bitrate).'Kb -r ntsc-film -g 240 -qmin 2 -qmax 15 -vpre libx264-default -acodec aac -ar 22050 -ac 2 -aspect 16:9 -s '.@escapeshellarg($video_width_setting.':'.$video_height_setting).' '.@escapeshellarg($output_path);
				$shell_commands=array($shell_command.' -map 0.1:0.0 -map 0.0:0.1',$shell_command.' -map 0.0:0.0 -map 0.1:0.1');
				foreach ($shell_commands as $shell_command)
				{
					shell_exec($shell_command);
					if (@filesize($output_path)) break;
				}
				if (@filesize($output_path))
				{
					shell_exec('"'.$ffmpeg_path.'MP4Box" -inter 500 '.' '.@escapeshellarg($output_path));
					return preg_replace('#\.'.str_replace('#','\#',preg_quote($file_ext)).'$#','',$url).'.mp4';
				}
			}
			elseif ((preg_match('#audio\/#i',$input_mime_type)!=0) && ($ffmpeg_path!=''))
			{
				//it is audio
				$output_path=preg_replace('#\.'.str_replace('#','\#',preg_quote($file_ext)).'$#','',$file_path).'.mp3';
				$shell_command='"'.$ffmpeg_path.'ffmpeg" -y -i '.@escapeshellarg($file_path).' -ab '.@escapeshellarg($audio_bitrate).'Kb '.@escapeshellarg($output_path);
				shell_exec($shell_command);
				if (@filesize($output_path))
				{
					return preg_replace('#\.'.str_replace('#','\#',preg_quote($file_ext)).'$#','',$url).'.mp3';
				}
			}
		}
	}

	// No success :(
	return $url;
}

/**
 * Receive a message from zencoder that a video has transcoded.
 */
function zencoder_receive_script()
{
	header('Content-type: text/plain; charset='.get_charset());

	$matches=array();

	$data=file_get_contents('php://input'); // E.g. '<api-notification><state>finished</state><id>797351</id></api-notification>';

	if ((($num_matches=preg_match_all('#<id[^>]*>(\d+)</id>#',$data,$matches))!=0) || (($num_matches=preg_match_all('#"id":\s*(\d+)#',$data,$matches))!=0))
	{
		if (strpos($data,'finished')!==false)
			store_transcoding_success($matches[$num_matches][0]);
		elseif (strpos($data,'failed')!==false)
			store_transcoding_failure($matches[$num_matches][0]);
	} else echo 'Unknown call method';
}

/**
 * Note that a zencoder transcode has failed.
 *
 * @param  ID_TEXT		Transcoding ID
 */
function store_transcoding_failure($transcoder_id)
{
	require_lang('galleries');
	$GLOBALS['SITE_DB']->query_update('video_transcoding',array('t_error'=>do_lang('TRANSCODING_ERROR_2')),array('t_id'=>$transcoder_id),'',1);
}

/**
 * Handle that a zencoder transcode has worked.
 *
 * @param  ID_TEXT		Transcoding ID
 */
function store_transcoding_success($transcoder_id)
{
	if (function_exists('set_time_limit')) @set_time_limit(0);

	// Stuff about the transcoding
	$descript_rows=$GLOBALS['SITE_DB']->query_select('video_transcoding',array('*'),array(
		't_id'=>$transcoder_id,
	),'',1);
	if (!array_key_exists(0,$descript_rows)) return; // No match
	$descript_row=$descript_rows[0];

	// The database for for what has been transcoded
	$rows=$GLOBALS['SITE_DB']->query_select($descript_row['t_table'],array('*'),array($descript_row['t_url_field']=>$descript_row['t_url']),'',1,NULL,false,array());
	if (!array_key_exists(0,$rows))
		warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
	$row=$rows[0];

	// Deal with old file
	$old_file_path=get_custom_file_base().'/'.rawurldecode($row['url']);
	if (url_is_local($descript_row['t_url']))
	{
		$new_file_path=str_replace('/uploads/galleries/','/uploads/galleries/pre_transcoding/',$old_file_path);
		if (file_exists(get_custom_file_base().'/uploads/galleries/pre_transcoding'))	// Move the old media file to the archive directory
		{
			@rename($old_file_path,$new_file_path);
		} else // Delete old media
		{
			@unlink($old_file_path);
		}
	}

	// Update width/height
	$ext=get_file_extension($descript_row['t_output_filename']);
	if ($ext=='mp3')
	{
		if ($descript_row['t_width_field']!='') $row[$descript_row['t_width_field']]=300;
		if ($descript_row['t_height_field']!='') $row[$descript_row['t_height_field']]=20;
	} else
	{
		if ($descript_row['t_width_field']!='') $row[$descript_row['t_width_field']]=intval(get_option('video_width_setting'));
		if ($descript_row['t_height_field']!='') $row[$descript_row['t_height_field']]=intval(get_option('video_height_setting'));
	}

	// Update original filename
	if ($descript_row['t_orig_filename_field']!='')
	{
		$row[$descript_row['t_orig_filename_field']]=preg_replace('#\..*$#','.'.$ext,$row[$descript_row['t_orig_filename_field']]);
	}

	// Update URL to transcoded one
	$row[$descript_row['t_url_field']]='uploads/galleries/'.rawurlencode($descript_row['t_output_filename']);

	// Update record to point to new file
	$GLOBALS['SITE_DB']->query_update($descript_row['t_table'],$row,array($descript_row['t_url_field']=>$descript_row['t_url']),'',1);

	echo 'Done';
}
