<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_rich_media
 */

class Hook_comcode_link_handler_media_rendering
{

	/**
	 * Standard modular bind function for Comcode link handler hooks. They see if they can bind a pasted URL to a lump of handler Tempcode.
	 *
	 * @param  URLPATH		Link to use or reject
	 * @param  boolean		Whether we are allowed to proceed even if this tag is marked as 'dangerous'
	 * @param  string			A special identifier to mark where the resultant tempcode is going to end up (e.g. the ID of a post)
	 * @param  integer		The position this tag occurred at in the Comcode
	 * @param  MEMBER			The member who is responsible for this Comcode
	 * @param  boolean		Whether to check as arbitrary admin
	 * @param  object			The database connection to use
	 * @param  string			The whole chunk of Comcode
	 * @param  boolean		Whether this is for WML output (no longer supported)
	 * @param  boolean		Whether this is only a structure sweep
	 * @param  boolean		Whether we are in semi-parse-mode (some tags might convert differently)
	 * @param  ?array			A list of words to highlight (NULL: none)
	 * @return ?tempcode		Handled link (NULL: reject due to inappropriate link pattern)
	 */
	function bind($url,$comcode_dangerous,$pass_id,$pos,$source_member,$as_admin,$connection,$comcode,$wml,$structure_sweep,$semiparse_mode,$highlight_bits)
	{
		require_code('media_renderer');
		$hooks=find_media_renderers($url,$as_admin);
		if ($hooks!==NULL)
		{
			$hook=reset($hooks);
			$ob=object_factory('Hook_media_rendering_'.$hook);
			return $ob->render($url,array());
		}

		return NULL;
	}

}


