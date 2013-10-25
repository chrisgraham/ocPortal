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
 * @package		core_ocf
 */

class Hook_exists_emoticon
{

	/**
	 * Standard modular run function for snippet hooks. Generates XHTML to insert into a page using AJAX.
	 *
	 * @return tempcode  The snippet
	 */
	function run()
	{
		$val=get_param('name');

		$test=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_emoticons','e_code',array('e_code'=>$val));
		if (is_null($test)) return new ocp_tempcode();

		require_lang('ocf');

		return make_string_tempcode(strip_tags(strip_html(do_lang('CONFLICTING_EMOTICON_CODE',escape_html($val)))));
	}

}
