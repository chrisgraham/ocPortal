<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2010

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

class Hook_profile_tab
{

	/**
	 * Standard modular run function for snippet hooks. Generates XHTML to insert into a page using AJAX.
	 *
	 * @return tempcode  The snippet
	 */
	function run()
	{
		$member_id_viewing=get_member();
		$member_id_of=get_param_integer('member_id');

		$hook=filter_naughty_harsh(get_param('tab'));

		// HACKHACK
		$_GET['page']='members';
		$_GET['type']='view';
		$_GET['id']=strval($member_id_of);
		unset($_GET['snippet']);
		unset($_GET['member_id']);
		unset($_GET['tab']);
		unset($_GET['url']);
		unset($_GET['title']);
		unset($_GET['utheme']);
		global $RELATIVE_PATH,$ZONE;
		$RELATIVE_PATH=get_module_zone('members');
		$ZONE=NULL;
		global $PAGE_NAME_CACHE;
		$PAGE_NAME_CACHE='members';
		global $RUNNING_SCRIPT_CACHE;
		$RUNNING_SCRIPT_CACHE='index';

		require_code('hooks/systems/profiles_tabs/'.$hook);
		$ob=object_factory('Hook_Profiles_Tabs_'.$hook);
		if ($ob->is_active($member_id_of,$member_id_viewing))
		{
			global $CSSS,$JAVASCRIPTS;
			$CSSS=array();
			$JAVASCRIPTS=array();
			$ret=$ob->render_tab($member_id_of,$member_id_viewing);
			$out=new ocp_tempcode();
			$out->attach(symbol_tempcode('CSS_TEMPCODE'));
			$out->attach(symbol_tempcode('JS_TEMPCODE'));
			$out->attach($ret[1]);
			return $out;
		}
		return do_template('INLINE_WIP_MESSAGE',array('MESSAGE'=>do_lang_tempcode('INTERNAL_ERROR')));
	}

}
