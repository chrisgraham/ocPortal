<?php

function init__hooks__systems__ecommerce__usergroup($in=NULL)
{
	require_code('referrals');

	return str_replace('ocf_add_member_to_group($member_id,$new_group);','ocf_add_member_to_group($member_id,$new_group); assign_referral_awards($member_id,\'usergroup_subscribe\'); assign_referral_awards($member_id,\'usergroup_subscribe_\'.strval($usergroup_subscription_id));',$in);
}
