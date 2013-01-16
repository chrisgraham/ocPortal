<?php

class Hook_cron_manual_subscription_notification
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		require_code('ecommerce');
		require_lang('ecommerce');
		$subscriptions=$GLOBALS['FORUM_DB']->query_select('subscriptions',array('id','s_type_code','s_time','s_member_id'),array('s_state'=>'active'));
		if ($subscriptions)
		{
			foreach ($subscriptions as $sub)
			{
				$product_obj=find_product($sub['s_type_code']);
				$products=$product_obj->get_products(true);
				$product_name=$products[$sub['s_type_code']][4];
				$s_length=$products[$sub['s_type_code']][3]['length'];
				$s_length_units=$products[$sub['s_type_code']][3]['length_units']; // y-year, m-month, w-week, d-day
				$time_period_units=array('y'=>'year','m'=>'month','w'=>'week','d'=>'day');
				$expiry_time=strtotime('+'.$s_length.' '.$time_period_units[$s_length_units],$sub['s_time']);
				if ((($expiry_time-time())<(7*24*60*60))&&($expiry_time>=time()))
				{
					$expiry_date=get_timezoned_date($expiry_time,false,false,false,true);
					$member_name=$GLOBALS['FORUM_DRIVER']->get_username($sub['s_member_id']);
					$member_profile_url=$GLOBALS['OCF_DRIVER']->member_profile_url($sub['s_member_id']);
					$cancel_url=build_url(array('page'=>'admin_ecommerce','type'=>'cancel_subscription','subscription_id'=>$sub['id']),get_module_zone('admin_ecommerce'));
					
					require_code('notifications');
					$subject=do_lang('MANUAL_SUBSCRIPTION_NOTIFICATION_MAIL_SUBJECT',$member_name,$expiry_date);
					$mail=do_lang('MANUAL_SUBSCRIPTION_NOTIFICATION_MAIL',escape_html($member_profile_url),escape_html($cancel_url->evaluate()));
					dispatch_notification('manual_subscription',NULL,$subject,$mail);
				}
			}
		}
	}

}