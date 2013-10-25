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
 * @package		news
 */

class Hook_block_ui_renderers_news
{

	/**
	 * See if a particular block parameter's UI input can be rendered by this.
	 *
	 * @param  ID_TEXT		The block
	 * @param  ID_TEXT		The parameter of the block
	 * @param  boolean		Whether there is a default value for the field, due to this being an edit
	 * @param  string			Default value for field
	 * @param  tempcode		Field description
	 * @return ?tempcode		Rendered field (NULL: not handled).
	 */
	function render_block_ui($block,$parameter,$has_default,$default,$description)
	{
		if ((($default=='') || (is_numeric(str_replace(',','',$default)))) && ($parameter=='filter') && (in_array($block,array('bottom_news','main_news','side_news','side_news_archive')))) // news category list
		{
			require_code('news');
			$list=nice_get_news_categories(($default=='')?-1:intval($default));
			return form_input_multi_list(titleify($parameter),escape_html($description),$parameter,$list);
		}
		return NULL;
	}

}
