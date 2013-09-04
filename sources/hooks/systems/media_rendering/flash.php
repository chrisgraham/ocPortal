<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_rich_media
 */

class Hook_media_rendering_flash
{
	/**
	 * Find the media type this hook serves.
	 *
	 * @return integer	The media type
	 */
	function get_media_type()
	{
		return MEDIA_TYPE_OTHER;
	}

	/**
	 * See if we can recognise this mime type.
	 *
	 * @param  ID_TEXT	The mime type
	 * @return integer	Recognition precedence
	 */
	function recognises_mime_type($mime_type)
	{
		if ($mime_type=='application/x-shockwave-flash') return MEDIA_RECOG_PRECEDENCE_HIGH;
		return MEDIA_RECOG_PRECEDENCE_NONE;
	}

	/**
	 * See if we can recognise this URL pattern.
	 *
	 * @param  URLPATH	URL to pattern match
	 * @return integer	Recognition precedence
	 */
	function recognises_url($url)
	{
		if (preg_match('#^(rtmp|rtmpe|rtmps|rtmpt)://#',$url)!=0) return MEDIA_RECOG_PRECEDENCE_HIGH;
		return MEDIA_RECOG_PRECEDENCE_NONE;
	}

	/**
	 * Provide code to display what is at the URL, in the most appropriate way.
	 *
	 * @param  URLPATH	URL to render
	 * @param  array		Attributes (e.g. width, height, length)
	 * @return tempcode	Rendered version
	 */
	function render($url,$attributes)
	{
		return do_template('TODO',array('URL'=>$url));
	}

}
