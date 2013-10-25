<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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

class Hook_media_rendering_audio_websafe
{
	/**
	 * Get the label for this media rendering type.
	 *
	 * @return string		The label
	 */
	function get_type_label()
	{
		require_lang('comcode');
		return do_lang('MEDIA_TYPE_'.preg_replace('#^Hook_media_rendering_#','',__CLASS__));
	}

	/**
	 * Find the media types this hook serves.
	 *
	 * @return integer	The media type(s), as a bitmask
	 */
	function get_media_type()
	{
		return MEDIA_TYPE_AUDIO;
	}

	/**
	 * See if we can recognise this mime type.
	 *
	 * @param  ID_TEXT	The mime type
	 * @return integer	Recognition precedence
	 */
	function recognises_mime_type($mime_type)
	{
		if ($mime_type=='audio/ogg') return MEDIA_RECOG_PRECEDENCE_HIGH;
		if ($mime_type=='audio/x-mpeg') return MEDIA_RECOG_PRECEDENCE_HIGH;
		if ($mime_type=='audio/mpeg') return MEDIA_RECOG_PRECEDENCE_HIGH;

		// Sometimes an mp3 is put in an mp4 container
		if ($mime_type=='video/mp4') return MEDIA_RECOG_PRECEDENCE_MEDIUM;

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
		return MEDIA_RECOG_PRECEDENCE_NONE;
	}

	/**
	 * Provide code to display what is at the URL, in the most appropriate way.
	 *
	 * @param  mixed		URL to render
	 * @param  mixed		URL to render (no sessions etc)
	 * @param  array		Attributes (e.g. width, height, length)
	 * @param  boolean	Whether there are admin privileges, to render dangerous media types
	 * @param  ?MEMBER	Member to run as (NULL: current member)
	 * @return tempcode	Rendered version
	 */
	function render($url,$url_safe,$attributes,$as_admin=false,$source_member=NULL)
	{
		// Put in defaults
		if ((!array_key_exists('width',$attributes)) || (!is_numeric($attributes['width'])))
		{
			$attributes['width']=get_option('attachment_default_width');
		}
		if ((!array_key_exists('height',$attributes)) || (!is_numeric($attributes['height'])))
		{
			$attributes['height']='30';
		}

		return do_template('MEDIA_AUDIO_WEBSAFE',array('_GUID'=>'474dfa6766d809141bb6ef800bf22636','HOOK'=>'audio_websafe')+_create_media_template_parameters($url,$attributes,$as_admin,$source_member));
	}

}
