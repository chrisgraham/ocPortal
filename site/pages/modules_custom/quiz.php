<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

function init__site__pages__modules_custom__quiz($in=NULL)
{
	$before='if ($minimum_percentage>=$quiz[\'q_percentage\'])';
	$after='if ((addon_installed(\'points\')) && ($quiz[\'q_points_for_passing\']!=0)) { require_code(\'points2\'); $cost=$quiz[\'q_points_for_passing\']/2; $points_difference-=$cost; } if ($minimum_percentage>=$quiz[\'q_percentage\'])';
	$in=str_replace($before,$after,$in);

	$before='$type=\'Test\';';
	$after='$type=\'Test\'; require_code(\'points2\'); $cost=$quiz[\'q_points_for_passing\']/2; charge_member(get_member(),$cost,\'Entered a test\');';
	$in=str_replace($before,$after,$in);

	return $in;
}
