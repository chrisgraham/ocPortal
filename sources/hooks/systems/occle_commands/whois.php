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
 * @package		occle
 */

class Hook_occle_command_whois
{
	/**
	 * Run function for OcCLE hooks.
	 *
	 * @param  array	The options with which the command was called
	 * @param  array	The parameters with which the command was called
	 * @param  object	A reference to the OcCLE filesystem object
	 * @return array	Array of stdcommand, stdhtml, stdout, and stderr responses
	 */
	function run($options,$parameters,&$occle_fs)
	{
		require_code('lookup');

		if ((array_key_exists('h',$options)) || (array_key_exists('help',$options))) return array('',do_command_help('whois',array('h','s','m','f','o'),array(true)),'','');
		else
		{
			if (!array_key_exists(0,$parameters)) return array('','','',do_lang('MISSING_PARAM','1','whois'));

			$start=(array_key_exists('s',$options))?intval($options['s']):0;
			$start=(array_key_exists('start',$options))?intval($options['start']):0;
			$max=(array_key_exists('m',$options))?intval($options['m']):50;
			$max=(array_key_exists('max',$options))?intval($options['max']):50;
			$sortable=(array_key_exists('f',$options))?$options['f']:'date_and_time';
			$sortable=(array_key_exists('field',$options))?$options['field']:'date_and_time';
			$sort_order=(array_key_exists('o',$options))?$options['o']:'DESC';
			$sort_order=(array_key_exists('order',$options))?$options['order']:'DESC';

			$name=mixed();
			$id=mixed();
			$ip=mixed();
			$rows=lookup_member_page($parameters[0],$name,$id,$ip);
			if (is_null($name)) $name=do_lang('UNKNOWN');
			if (is_null($id)) $id=$GLOBALS['FORUM_DRIVER']->get_guest_id();
			if (is_null($ip)) $ip='';

			$ip_list=new ocp_tempcode();
			foreach ($rows as $row) $ip_list->attach(do_template('LOOKUP_IP_LIST_ENTRY',array('_GUID'=>'01e74a2a146dab9a407b23c40f4555ad','IP'=>$row['ip'])));

			$stats=get_stats_track($id,$ip,$start,$max,$sortable,$sort_order);

			return array('',occle_make_normal_html_visible(do_template('OCCLE_WHOIS',array('_GUID'=>'f315a705e9a2a2fb50b78ae3a8fc6a05','STATS'=>$stats,'IP_LIST'=>$ip_list,'ID'=>strval($id),'IP'=>$ip,'NAME'=>$name))),'','');
		}
	}
}

