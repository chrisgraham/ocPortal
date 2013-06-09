<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		referrals
 */


class Hook_do_next_menus_referrals
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('referrals');

		$ret=array();

		$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);

		foreach ($ini_file as $ini_file_section_name=>$ini_file_section)
		{
			if ($ini_file_section_name!='global')
			{
				$scheme_name=$ini_file_section_name;
				$scheme=$ini_file_section;

				$scheme_title=isset($scheme['title'])?$scheme['title']:$ini_file_section_name;

				$ret[]=array('usage','referrals',array('admin_referrals',array('type'=>'misc','scheme'=>$scheme_name),'adminzone'),$scheme_title,('DOC_REFERRALS'));
			}
		}

		$ret[]=array('setup','referrals',array('referrals',array('type'=>'misc'),'adminzone'),do_lang_tempcode('REFERRALS'),('DOC_REFERRALS'));

		return $ret;
	}

}


