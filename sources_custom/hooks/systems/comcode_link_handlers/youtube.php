<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */


class Hook_comcode_link_handler_youtube
{

	/**
	 * Standard modular bind function for comcode link handler hooks. They see if they can bind a pasted URL to a lump of handler Tempcode.
	 *
	 * @param  URLPATH		Link to use or reject
	 * @param  string			Title for what is at the other end of the link (was found by downloading and looking for <title>)
	 * @param  boolean		Whether we are allowed to proceed even if this tag is marked as 'dangerous'
	 * @param  string			A special identifier to mark where the resultant tempcode is going to end up (e.g. the ID of a post)
	 * @param  integer		The position this tag occurred at in the Comcode
	 * @param  MEMBER			The member who is responsible for this Comcode
	 * @param  boolean		Whether to check as arbitrary admin
	 * @param  object			The database connection to use
	 * @param  string			The whole chunk of comcode
	 * @param  boolean		Whether this is for WML output (no longer supported)
	 * @param  boolean		Whether this is only a structure sweep
	 * @param  boolean		Whether we are in semi-parse-mode (some tags might convert differently)
	 * @param  ?array			A list of words to highlight (NULL: none)
	 * @return ?tempcode		Handled link (NULL: reject due to inappropriate link pattern)
	 */
	function bind($link,$link_captions_title,$comcode_dangerous,$pass_id,$pos,$source_member,$as_admin,$connection,$comcode,$wml,$structure_sweep,$semiparse_mode,$highlight_bits)
	{
		if ((preg_match('#^http://www\.youtube\.com/watch\?v=([\w\-]+)#',$link)!=0) || (preg_match('#^http://youtu.be/([\w\-]+)#',$link)!=0))
		{
			global $IMPORTED_CUSTOM_COMCODE;
			if (!$IMPORTED_CUSTOM_COMCODE)
				_custom_comcode_import($connection);

			return _do_tags_comcode('youtube',array(),make_string_tempcode($link),$comcode_dangerous,$pass_id,$pos,$source_member,$as_admin,$connection,$comcode,$wml,$structure_sweep,$semiparse_mode,$highlight_bits);
		}

		return NULL;
	}

}


