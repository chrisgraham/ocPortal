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
				$scheme['name']=$scheme_name;

				$scheme_title=isset($scheme['title'])?$scheme['title']:$ini_file_section_name;

				if (!referrer_is_qualified($scheme,$member_id)) continue;

				$ret[]=array(
					'usage',
					make_string_tempcode(escape_html($scheme_title)),
					find_script('referrer_report').'?scheme='.urlencode($scheme_name).'&member_id='.strval($member_id).$keep->evaluate()
				);

				if (has_zone_access(get_member(),'adminzone'))
				{
					$ret[]=array(
						'views',
						do_lang_tempcode('MANUALLY_ADJUST_SCHEME_SETTINGS',escape_html($scheme_title)),
						build_url(array('page'=>'admin_referrals','type'=>'adjust','scheme'=>$scheme_name,'member_id'=>$member_id),get_module_zone('admin_referrals'))
					);
				}
			}
		}

		return $ret;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function get_info_details($member_id)
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
				$scheme['name']=$scheme_name;

				$scheme_title=isset($scheme['title'])?$scheme['title']:$ini_file_section_name;

				$qualified=referrer_is_qualified($scheme,$member_id);
				if ($qualified)
				{
					list($num_total_qualified_by_referrer,$num_total_by_referrer)=get_referral_scheme_stats_for($member_id,$scheme_name);
					$scheme_text=do_lang_tempcode('MEMBER_SCHEME_SUMMARY_LINE',escape_html(integer_format($num_total_by_referrer)),escape_html(integer_format($num_total_qualified_by_referrer)));
				} else
				{
					$scheme_text=do_lang_tempcode('MEMBER_SCHEME_SUMMARY_LINE_UNQUALIFIED');
				}

				$ret[do_lang('MEMBER_SCHEME_SUMMARY_LINE_HEADER',$scheme_title)]=$scheme_text;
			}
		}

		return $ret;
	}

}


