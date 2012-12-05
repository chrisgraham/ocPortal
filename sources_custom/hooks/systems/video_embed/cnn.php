<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		galleries
 */

class Hook_video_embed_cnn
{

	/**
	 * If we can handle this URL, get the render template and ID for it.
	 *
	 * @param  URLPATH		Video URL
	 * @return ?array			A pair: the template, and ID (NULL: no match)
	 */
	function get_template_name_and_id($url)
	{
		$matches=array();
		if (preg_match('#^http://(edition\.)?cnn\.com/video/[\#\?]/(video/)?([\w/\.]+)#',$url,$matches)!=0)
		{
			$id=rawurldecode($matches[3]);
			return array('GALLERY_VIDEO_CNN',$id);
		}
		return NULL;
	}

	/**
	 * If we can handle this URL, get the thumbnail URL.
	 *
	 * @param  URLPATH		Video URL
	 * @return ?string		The thumbnail URL (NULL: no match).
	 */
	function get_video_thumbnail($src_url)
	{
		$matches=array();
		if (preg_match('#^http://(edition\.)?cnn\.com/video/[\#\?]/(video/)?([\w/\.]+)#',$src_url,$matches)!=0)
		{
			return 'http://i.cdn.turner.com/cnn/video/'.$matches[3].'.214x122.jpg';
		}
		return NULL;
	}

	/**
	 * Add a custom Comcode field for this URL type.
	 */
	function add_custom_comcode_field()
	{
		$GLOBALS['SITE_DB']->query_insert('custom_comcode',array(
			'tag_tag'=>'cnn_video',
			'tag_title'=>insert_lang('CNN video',2),
			'tag_description'=>insert_lang('Inserts a CNN video.',2),
			'tag_replace'=>'{$SET,VIDEO,{$PREG_REPLACE,(http://.*/video/[#?]/(video/)?)?([\w/\.]+),$\{3\},{content}}}<object width="416" height="374" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="ep"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="wmode" value="transparent" /><param name="movie" value="http://i.cdn.turner.com/cnn/.element/apps/cvp/3.0/swf/cnn_416x234_embed.swf?context=embed_edition&videoId={$GET*,VIDEO}" /><param name="bgcolor" value="#000000" /><embed src="http://i.cdn.turner.com/cnn/.element/apps/cvp/3.0/swf/cnn_416x234_embed.swf?context=embed_edition&videoId={$GET*,VIDEO}" type="application/x-shockwave-flash" bgcolor="#000000" allowfullscreen="true" allowscriptaccess="always" width="416" wmode="transparent" height="374"></embed></object>',
			'tag_example'=>'[cnn_video]http://edition.cnn.com/video/#/video/business/2011/03/04/mcedwards.bric.economies.cnn[/cnn_video]',
			'tag_parameters'=>'',
			'tag_enabled'=>1,
			'tag_dangerous_tag'=>0,
			'tag_block_tag'=>1,
			'tag_textual_tag'=>0
		));
	}

}


