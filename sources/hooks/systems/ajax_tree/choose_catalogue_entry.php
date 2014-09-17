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
 * @package		catalogues
 */

class Hook_choose_catalogue_entry
{
	/**
	 * Run function for ajax-tree hooks. Generates XML for a tree list, which is interpreted by JavaScript and expanded on-demand (via new calls).
	 *
	 * @param  ?ID_TEXT		The ID to do under (NULL: root)
	 * @param  array			Options being passed through
	 * @param  ?ID_TEXT		The ID to select by default (NULL: none)
	 * @return string			XML in the special category,entry format
	 */
	function run($id,$options,$default=NULL)
	{
		require_code('catalogues');

		$only_owned=array_key_exists('only_owned',$options)?(is_null($options['only_owned'])?NULL:intval($options['only_owned'])):NULL;
		$catalogue_name=array_key_exists('catalogue_name',$options)?$options['catalogue_name']:NULL;
		$editable_filter=array_key_exists('editable_filter',$options)?($options['editable_filter']):false;
		$tree=get_catalogue_entries_tree($catalogue_name,$only_owned,is_null($id)?NULL:intval($id),NULL,NULL,is_null($id)?0:1,$editable_filter);

		$levels_to_expand=array_key_exists('levels_to_expand',$options)?($options['levels_to_expand']):intval(get_long_value('levels_to_expand__'.substr(get_class($this),5)));
		$options['levels_to_expand']=max(0,$levels_to_expand-1);

		if (!has_actual_page_access(NULL,'catalogues')) $tree=array();

		$out='';

		$out.='<options>'.serialize($options).'</options>';

		foreach ($tree as $t)
		{
			$_id=$t['id'];
			if ($id===strval($_id)) // Possible when we look under as a root
			{
				foreach ($t['entries'] as $eid=>$etitle)
				{
					if (is_object($etitle)) $etitle=@strip_tags(html_entity_decode($etitle->evaluate(),ENT_QUOTES,get_charset()));
					$out.='<entry id="'.xmlentities(strval($eid)).'" title="'.xmlentities($etitle).'" selectable="true"></entry>';
				}
				continue;
			}
			$title=$t['title'];
			$has_children=($t['child_count']!=0) || ($t['child_entry_count']!=0);

			$out.='<category id="'.xmlentities(strval($_id)).'" title="'.xmlentities($title).'" has_children="'.($has_children?'true':'false').'" selectable="false"></category>';

			if ($levels_to_expand>0)
			{
				$out.='<expand>'.xmlentities($_id).'</expand>';
			}
		}

		// Mark parent cats for pre-expansion
		if ((!is_null($default)) && ($default!=''))
		{
			$cat=$GLOBALS['SITE_DB']->query_select_value_if_there('catalogue_entries','cc_id',array('id'=>intval($default)));
			while (!is_null($cat))
			{
				$out.='<expand>'.strval($cat).'</expand>';
				$cat=$GLOBALS['SITE_DB']->query_select_value_if_there('catalogue_categories','cc_parent_id',array('id'=>$cat));
			}
		}

		return '<result>'.$out.'</result>';
	}

	/**
	 * Generate a simple selection list for the ajax-tree hook. Returns a normal <select> style <option>-list, for fallback purposes
	 *
	 * @param  ?ID_TEXT		The ID to do under (NULL: root) - not always supported
	 * @param  array			Options being passed through
	 * @param  ?ID_TEXT		The ID to select by default (NULL: none)
	 * @return tempcode		The nice list
	 */
	function simple($id,$options,$it=NULL)
	{
		require_code('catalogues');

		$only_owned=array_key_exists('only_owned',$options)?(is_null($options['only_owned'])?NULL:intval($options['only_owned'])):NULL;
		$catalogue_name=array_key_exists('catalogue_name',$options)?$options['catalogue_name']:NULL;
		$editable_filter=array_key_exists('editable_filter',$options)?($options['editable_filter']):false;
		return create_selection_list_catalogue_entries_tree($catalogue_name,is_null($it)?NULL:intval($it),$only_owned,$editable_filter);
	}
}


