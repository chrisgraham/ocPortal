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
 * @package		wiki
 */

class Hook_attachments_wiki_post
{

	/**
	 * Standard modular run function for attachment hooks. They see if permission to an attachment of an ID relating to this content is present for the current member.
	 *
	 * @param  ID_TEXT		The ID
	 * @param  object			The database connection to check on
	 * @return boolean		Whether there is permission
	 */
	function run($id,$connection)
	{
		if ($connection->connection_write!=$GLOBALS['SITE_DB']->connection_write) return false;

		$cat_id=$GLOBALS['SITE_DB']->query_select_value_if_there('wiki_posts','page_id',array('id'=>intval($id)));
		if (is_null($cat_id)) return false;
		return (has_category_access(get_member(),'wiki_page',strval($cat_id)));
	}

}


