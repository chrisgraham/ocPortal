<?php

function init__uploads($old)
{
	if (function_exists('set_time_limit')) @set_time_limit(0); // On some server setups, slow uploads can trigger the time-out

	if (!defined('OCP_UPLOAD_ANYTHING'))
	{
		define('OCP_UPLOAD_ANYTHING',0);
		define('OCP_UPLOAD_IMAGE',1);
		define('OCP_UPLOAD_VIDEO',2);
		define('OCP_UPLOAD_MP3',3);
		define('OCP_UPLOAD_IMAGE_OR_SWF',4);
	}

	if (!$GLOBALS['SITE_DB']->table_exists('image_url_sub_for')) return $old;

	$old=str_replace("'tmp_name'=>get_custom_file_base().'/'.\$incoming_uploads_row[0]['i_save_url'],","'tmp_name'=>get_custom_file_base().'/'.(is_null(\$sub=\$GLOBALS['SITE_DB']->query_value_null_ok('image_url_sub_for','url_to',array('url_from'=>\$incoming_uploads_row[0]['i_save_url'],'member_id'=>get_member()),'ORDER BY expire DESC'))?\$incoming_uploads_row[0]['i_save_url']:\$sub),",$old);
	return $old;
}

/**
 * Get URLs generated according to the specified information. It can also generate a thumbnail if required. It first tries attached upload, then URL, then fails.
 *
 * @param  ID_TEXT		The name of the POST parameter storing the URL (if '', then no POST parameter). Parameter value may be blank.
 * @param  ID_TEXT		The name of the HTTP file parameter storing the upload (if '', then no HTTP file parameter). No file necessarily is uploaded under this.
 * @param  ID_TEXT		The folder name in uploads/ where we will put this upload
 * @param  integer		Whether to obfuscate file names so the URLs can not be guessed/derived (0=do not, 1=do, 2=make extension .dat as well, 3=only obfuscate if we need to)
 * @set    0 1 2 3
 * @param  integer		The type of upload it is (from an OCP_UPLOAD_* constant)
 * @param  boolean		Make a thumbnail (this only makes sense, if it is an image)
 * @param  ID_TEXT		The name of the POST parameter storing the thumb URL. As before
 * @param  ID_TEXT		The name of the HTTP file parameter storing the thumb upload. As before
 * @param  boolean		Whether to copy a URL (if a URL) to the server, and return a local reference
 * @param  boolean		Whether to accept upload errors
 * @param  boolean		Whether to give a (deferred?) error if no file was given at all
 * @return array			An array of 4 URL bits (URL, thumb, URL original filename, thumb original filename)
 */
function get_url($specify_name,$attach_name,$upload_folder,$obfuscate=0,$enforce_type=0,$make_thumbnail=false,$thumb_specify_name='',$thumb_attach_name='',$copy_to_server=false,$accept_errors=false,$should_get_something=false)
{
	$urls=non_overrided__get_url($specify_name,$attach_name,$upload_folder,$obfuscate,$enforce_type,$make_thumbnail,$thumb_specify_name,$thumb_attach_name,$copy_to_server,$accept_errors,$should_get_something);

	if (!$GLOBALS['SITE_DB']->table_exists('image_url_sub_for')) return $urls;

	$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'image_url_sub_for WHERE expire<'.strval(time()));

	foreach (array(0,1) as $i=>$_possible_sub)
	{
		if (!isset($urls[$_possible_sub])) continue;

		$possible_sub=$urls[$_possible_sub];

		$subs=$GLOBALS['SITE_DB']->query_select('image_url_sub_for',array('url_to'),array(
			'url_from'=>$possible_sub,
			'member_id'=>get_member(),
		),'ORDER BY expire DESC',1,NULL,true);
		if ((!is_null($subs)) && (array_key_exists(0,$subs)))
		{
			$urls[$_possible_sub]=$subs[0]['url_to'];
		}
	}

	return $urls;
}
