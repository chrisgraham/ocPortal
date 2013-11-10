<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		referrals
 */

class Hook_page_groupings_referrals
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
	 */
	function run()
	{
		$ret=array();

		$path=get_custom_file_base().'/text_custom/referrals.txt';
		if (is_file($path))
		{
			$ini_file=parse_ini_file($path,true);

			foreach ($ini_file as $ini_file_section_name=>$ini_file_section)
			{
				if ($ini_file_section_name!='global')
				{
					$scheme_name=$ini_file_section_name;
					$scheme=$ini_file_section;

					$scheme_title=isset($scheme['title'])?$scheme['title']:$ini_file_section_name;

					$ret[]=array('audit','menu/referrals',array('admin_referrals',array('type'=>'misc','scheme'=>$scheme_name),'adminzone'),$scheme_title,'referrals:DOC_REFERRALS');
				}
			}
		}

		$ret[]=array('setup','menu/referrals',array('referrals',array('type'=>'misc'),'adminzone'),do_lang_tempcode('referrals:REFERRALS'),'referrals:DOC_REFERRALS');

		return $ret;
	}

}


