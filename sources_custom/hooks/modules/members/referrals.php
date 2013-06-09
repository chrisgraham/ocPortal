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

class Hook_members_referrals
{

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function run($member_id)
	{
		if ((!has_zone_access(get_member(),'adminzone')) && ($member_id!==get_member()))
			return array();

		require_code('referrals');
		require_lang('referrals');

		$keep=symbol_tempcode('KEEP');

		$ret=array();

		$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);

		foreach ($ini_file as $ini_file_section_name=>$ini_file_section)
		{
			if ($ini_file_section_name!='global')
			{
				$scheme_name=$ini_file_section_name;
				$scheme=$ini_file_section;

				$scheme_title=isset($scheme['title'])?$scheme['title']:$ini_file_section_name;

				if (!referrer_is_qualified($scheme,$member_id)) continue;

				$ret[]=array(
					'usage',
					make_string_tempcode(escape_html($scheme_title)),
					find_script('referrer_report').'?scheme='.urlencode($scheme_name).'&member_id='.strval($member_id).$keep->evaluate()
				);
			}
		}

		return $ret;
	}

}


