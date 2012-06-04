<?php

/**
 * Function to process the file upload process
 */
function incoming_uploads_script()
{
	$image_url_sub_for=get_param('image_url_sub_for',NULL);
	if ($image_url_sub_for!==NULL)
	{
		require_code('files');
		if ((!url_is_local($image_url_sub_for)) || (strpos($image_url_sub_for,'/incoming/')!==false))
		{
			$url_to='uploads/website_specific/'.md5(uniqid('')).'.png';
		} else
		{
			$url_to=dirname($image_url_sub_for).'/'.md5(uniqid('')).'.png';
		}
		$write_to_file=fopen($url_to,'wb');
		http_download_file(either_param('imageurl'),NULL,true,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,$write_to_file);
		fclose($write_to_file);

		$GLOBALS['SITE_DB']->query_insert('image_url_sub_for',array(
			'url_from'=>$image_url_sub_for,
			'url_to'=>$url_to,
			'member_id'=>get_member(),
			'expire'=>time()+60*60*24,
		));

		exit();
	}

	non_overrided__incoming_uploads_script();
}