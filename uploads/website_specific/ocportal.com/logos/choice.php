<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

$d=opendir('.');
$one=false;
while (($file=readdir($d))!==false)
{
	if (substr($file,-4)=='.png')
	{
		if ($one) echo ',';
		$one=true;
		echo $file;
	}
}
closedir($d);
