<?php

function init__hooks__systems__ecommerce__catalogue_items($in=NULL)
{
	if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.

	require_code('ocf_join');
	
	return str_replace('$status=$details[\'ORDER_STATUS\'];','$status=$details[\'ORDER_STATUS\']; $member_id=$GLOBALS[\'SITE_DB\']->query_update(\'shopping_order_details\',array(\'order_id\'=>$purchase_id)); if (!is_null($member_id)) assign_referral_awards($member_id,\'misc_purchase\');',$in);
}
