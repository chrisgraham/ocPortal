<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2008

 See text/en/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		tracking
 */

/**
 * Checking the tracking of the current user
 *
 * @param  SHORT_TEXT		The category type
 * @param  SHORT_TEXT		The category id
 * @return BOOLEAN
 */
function is_tracked($c_type,$c_id)
{
	$user=get_member();
	$rows=$GLOBALS['SITE_DB']->query_value_null_ok('tracking_info','t_category_id',array('t_type'=>$c_type,' t_category_id'=>$c_id,'t_member_id'=>$user));

	return (!is_null($rows));
}

/**
 * Generating the tracking users of the given category
 *
 * @param  SHORT_TEXT		The category type
 * @param  SHORT_TEXT		The category id
 * @return array				The users tracking the resource
 */
function tracking_users($c_type,$c_id)
{
	$users=array();
	// Getting the list of users tracked the current catalogue
	$users=$GLOBALS['SITE_DB']->query_select('tracking_info',array('t_member_id','t_use_email','t_use_sms'),array('t_type'=>$c_type,' t_category_id'=>$c_id));

	return $users;
}

/**
 * Sending the Email or SMS alert to the tracking users
 *
 * @param  SHORT_TEXT		The category type
 * @param  array				The user list array
 * @param  tempcode			The URL to view that
 * @param  string				The title
 * @param  string				The post
 */
function send_alert($c_type,$user_list,$url,$title='',$post='')
{
	if (post_param_integer('do_tracking',NULL)===0) return;
	
	require_lang('tracking');
	$msg=do_lang(strtoupper($c_type).'_TRACKING_MESSAGE',comcode_escape(get_site_name()),comcode_escape($url->evaluate()),array($title,$post,$GLOBALS['FORUM_DRIVER']->get_username(get_member())));
	$subject=do_lang(strtoupper($c_type).'_NEW_ENTRY_POSTED',comcode_escape(get_site_name()));

	foreach ($user_list as $key=>$val)
	{
		//If using email to get alert for tracking
		if ($val['t_use_email']==1)
		{
			$user_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($val['t_member_id']);
			
			require_code('mail');

			mail_wrap($subject,$msg,array($user_email),NULL,'','',3,NULL,false,NULL,false,false);
		}
		
		// If using SMS to get alert 
		if ($val['t_use_sms']==1)
		{
			// Getting the user's phone number
			$phone_no=get_ocp_cpf('mobile_phone_number',$val['t_member_id']);

			if (!empty($phone_no))
			{
				sms_wrap($msg,array($val['t_member_id']));
			}
		}
	}
}

/**
 * Standard function to generate the tree structure of the root node
 *
 * @param  ID_TEXT	Current track type
 * @param  array		The array containing all the categories (it's a flat array)
 * @param  boolean	Whether to preselect the root node
 * @return string		The string contain HTML code
 */
function make_tree($track_type,$ar,$select_root=false)
{
	$tree_str='';
	$i=0;
	$current_tracking_setting=array();
	$checked=NULL;

	$row=$GLOBALS['SITE_DB']->query_select('tracking_info',array('t_category_id'),array('t_type'=>$track_type,'t_member_id'=>get_member()));

	foreach ($row as $value)
		$current_tracking_setting[]=$value['t_category_id'];
	if ($select_root) $current_tracking_setting[]=$ar[0]['id'];

	// If the root node
	if($i==0)
	{
		if(!array_key_exists($i,$ar))	return;
			
		if(in_array($ar[$i]['id'],$current_tracking_setting))	$checked="checked='checked'";

		$tree_str.="<ul class='cat_chooser_cat_type cat_chooser'><li><label><input type='checkbox'  id='nodes[]' name='nodes[]' value='".$ar[$i]['id']."' ".$checked."/> ".$ar[$i]['title']."</label>&nbsp;";
		
		if($ar[0]['child_count']>0)
		{
			$tree_str.="<ul class='cat_chooser_subcat'>";
			for($j=1;$j<=$ar[0]['child_count'];$j++)
			{
				$i++;
				// Calling the recursive function to generate the tree
				$tree_str.=recursive_tree($ar,$i,$current_tracking_setting);
			}
			$tree_str.="</ul>";
		}
		$tree_str.="</li></ul>";
	}
	return $tree_str;
}

/**
 * Standard function to generate the tree structure of the child node
 *
 * @param  array		The array containing all the categories (it's a flat array)
 * @param  integer	The index of the array we are descending from
 * @return string		The string contain HTML code
 */
function recursive_tree($arr,&$index,$current_tracking_setting)
{
	$tmp_str='';
	$checked=NULL;		
	
	if(in_array($arr[$index]['id'],$current_tracking_setting))
		$checked="checked='checked' ";
	
	// If have any child node 
	if($arr[$index]['child_count']>0)
	{
		$tmp_str= "<li class='subcat_check'><label><input type='checkbox'  name='nodes[]' id='nodes[]' value='".$arr[$index]['id']."' ".$checked." /> ".escape_html($arr[$index]['title'])."</label>&nbsp;<ul class='cat_chooser_cat_type cat_chooser_subcat'>";
		$needed=$arr[$index]['child_count'];
		$done=0;
		while ($done<$needed)
		{
			$index++;
			$tmp_str.=recursive_tree($arr,$index,$current_tracking_setting);
			$done++;
		}
		$tmp_str.="</ul></li>";
	}
	else
	{
		$tmp_str.="<li><label><input type='checkbox'  name='nodes[]' value='".$arr[$index]['id']."' ".$checked."/> ".escape_html($arr[$index]['title'])."</label></li>";
	}

	// Returning the HTML code
	return $tmp_str;
}
