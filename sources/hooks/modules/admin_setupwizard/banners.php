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
 * @package		banners
 */

class Hook_sw_banners
{

	/**
	 * Standard modular run function for features in the setup wizard.
	 *
	 * @return array		Current settings.
	 */
	function get_current_settings()
	{
		$settings=array();
		$test=$GLOBALS['SITE_DB']->query_select_value_if_there('banners','name',array('name'=>'donate'));
		$settings['have_default_banners_donation']=is_null($test)?'0':'1';
		$test=$GLOBALS['SITE_DB']->query_select_value_if_there('banners','name',array('name'=>'advertise_here'));
		$settings['have_default_banners_advertising']=is_null($test)?'0':'1';
		return $settings;
	}

	/**
	 * Standard modular run function for features in the setup wizard.
	 *
	 * @param  array		Default values for the fields, from the install-profile.
	 * @return tempcode	An input field.
	 */
	function get_fields($field_defaults)
	{
		if (!addon_installed('banners')) return new ocp_tempcode();

		$current_settings=$this->get_current_settings();
		$field_defaults+=$current_settings; // $field_defaults will take precedence, due to how "+" operator works in PHP

		require_lang('banners');
		$fields=new ocp_tempcode();
		if ($current_settings['have_default_banners_donation']=='1')
			$fields->attach(form_input_tick(do_lang_tempcode('HAVE_DEFAULT_BANNERS_DONATION'),do_lang_tempcode('DESCRIPTION_HAVE_DEFAULT_BANNERS_DONATION'),'have_default_banners_donation',$field_defaults['have_default_banners_donation']=='1'));
		if ($current_settings['have_default_banners_advertising']=='1')
			$fields->attach(form_input_tick(do_lang_tempcode('HAVE_DEFAULT_BANNERS_ADVERTISING'),do_lang_tempcode('DESCRIPTION_HAVE_DEFAULT_BANNERS_ADVERTISING'),'have_default_banners_advertising',$field_defaults['have_default_banners_advertising']=='1'));
		return $fields;
	}

	/**
	 * Standard modular run function for setting features from the setup wizard.
	 */
	function set_fields()
	{
		if (!addon_installed('banners')) return;

		$usergroups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list();

		if (post_param_integer('have_default_banners_donation',0)==0)
		{
			$test=$GLOBALS['SITE_DB']->query_select_value_if_there('banners','name',array('name'=>'donate'));
			if (!is_null($test))
			{
				require_code('banners2');
				delete_banner('donate');
				foreach (array_keys($usergroups) as $id)
					$GLOBALS['SITE_DB']->query_insert('group_page_access',array('page_name'=>'donate','zone_name'=>'site','group_id'=>$id));
			}
		}
		if (post_param_integer('have_default_banners_advertising',0)==0)
		{
			$test=$GLOBALS['SITE_DB']->query_select_value_if_there('banners','name',array('name'=>'advertise_here'));
			if (!is_null($test))
			{
				require_code('banners2');
				delete_banner('advertise_here');
				foreach (array_keys($usergroups) as $id)
					$GLOBALS['SITE_DB']->query_insert('group_page_access',array('page_name'=>'advertise','zone_name'=>'site','group_id'=>$id));
			}
		}
	}
}


