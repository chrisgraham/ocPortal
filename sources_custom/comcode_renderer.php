<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('init__comcode_renderer'))
{
	function init__comcode_renderer($in=NULL)
	{
		if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.

		$before='if ((isset($DANGEROUS_TAGS[$tag])) && (!$comcode_dangerous))';
		$after='if ((isset($DANGEROUS_TAGS[$tag])) && (!$comcode_dangerous) && (!comcode_white_listed($tag,$marker,$comcode)))';
		$in=str_replace($before,$after,$in);

		$before='$urls=get_url(\'\',\'file\'.$_id,\'uploads/attachments\',2,OCP_UPLOAD_ANYTHING,(!array_key_exists(\'thumb\',$attributes)) || ($attributes[\'thumb\']!=\'0\'),\'\',\'\',true,true,true,true);';
		$after=$before."
			\$gallery=post_param('gallery'.\$_id,'');
			if (\$gallery!='')
			{
				\$urls_gal=get_url('','file'.\$_id,'uploads/galleries',0,OCP_UPLOAD_ANYTHING,true,'','',true,true,true,true);
				require_code('galleries2');

				\$description=post_param('caption'.\$_id,array_key_exists('description',\$attributes)?\$attributes['description']:'');

				if (is_video(\$urls_gal[0]))
				{
					\$video_width=array_key_exists('width',\$attributes)?intval(\$attributes['width']):NULL;
					\$video_height=array_key_exists('height',\$attributes)?intval(\$attributes['height']):NULL;
					\$video_height=array_key_exists('length',\$attributes)?intval(\$attributes['length']):30;
					if ((\$video_width===NULL) || (\$video_height===NULL))
					{
						require_code('galleries2');
						\$vid_details=get_video_details(get_custom_file_base().'/'.rawurldecode(\$urls_gal[0]),\$urls_gal[2],true);
						if (\$vid_details!==false)
						{
							list(\$video_width,\$video_height,\$video_length)=\$vid_details;
						}
					}

					if (is_null(\$video_length)) \$video_length=30;
					if (is_null(\$video_width)) \$video_width=300;
					if (is_null(\$video_height)) \$video_height=200;

					add_video('',\$gallery,\$description,\$urls_gal[0],\$urls_gal[1],1,1,1,1,'',\$video_length,\$video_width,\$video_height);
				}

				if (is_image(\$urls_gal[0]))
				{
					add_image('',\$gallery,\$description,\$urls_gal[0],\$urls_gal[1],1,1,1,1,'');
				}
			}
		";
		$in=str_replace($before,$after,$in);

		return $in;
	}
}

function comcode_white_listed($tag,$marker,$comcode)
{
	$start_pos=strrpos(substr($comcode,0,$marker),'['.$tag);
	$end_pos=$marker-$start_pos;
	$comcode_portion_at_and_after=substr($comcode,$start_pos);
	$comcode_portion=substr($comcode_portion_at_and_after,0,$end_pos);

	require_code('textfiles');
	$whitelists=explode(chr(10),read_text_file('comcode_whitelist'));

	if (in_array($comcode_portion,$whitelists)) return true;
	foreach ($whitelists as $whitelist)
	{
		if ((substr($whitelist,0,1)=='/') && (substr($whitelist,-1)=='/') && (preg_match($whitelist,$comcode_portion)!=0))
			return true;
	}

	return false;
}
