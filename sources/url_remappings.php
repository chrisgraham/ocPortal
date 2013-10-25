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
 * @package		core
 */

/*
This script defines the rewrite rules from ocPortal's end.

Also see build_rewrite_rules.php for web-server script file generation [creates files like recommended.htaccess] (and to a lesser extent, urls.php and urls2.php).
build_rewrite_rules.php is in git / the ocportal_release_build addon.
*/

/**
 * Find the list of URL remappings
 *
 * @param  ID_TEXT		The URL scheme to use
 * @return array			The list of URL remappings
 */
function get_remappings($url_scheme)
{
	// The target mapping... upper case means variable substitution, lower case means constant-string
	// The source mapping... NULL means 'anything' (we'll use it in a variable substitution), else we require a certain value
	// These have to be in longest to shortest number of bindings order, to reduce the potential for &'d attributes

	$rules=array();
	switch ($url_scheme)
	{
		case 'PG':
			if (addon_installed('wiki'))
			{
				$rules[]=array(array('page'=>'wiki','type'=>'misc','id'=>NULL),'pg/s/ID',false);
			}
			if (addon_installed('galleries'))
			{
				$rules[]=array(array('page'=>'galleries','type'=>'image','id'=>NULL),'pg/galleries/image/ID',false);
				$rules[]=array(array('page'=>'galleries','type'=>'video','id'=>NULL),'pg/galleries/video/ID',false);
			}
			if (addon_installed('iotds'))
			{
				$rules[]=array(array('page'=>'iotds','type'=>'view','id'=>NULL),'pg/iotds/view/ID',false);
			}
			$rules[]=array(array('page'=>NULL,'type'=>NULL,'id'=>NULL),'pg/PAGE/TYPE/ID',false);
			$rules[]=array(array('page'=>NULL,'type'=>NULL),'pg/PAGE/TYPE',false);
			$rules[]=array(array('page'=>NULL),'pg/PAGE',false);
			$rules[]=array(array('page'=>''),'pg',false);
			$rules[]=array(array(),'pg',true);
			break;

		case 'HTM':
			if (addon_installed('wiki'))
			{
				$rules[]=array(array('page'=>'wiki','type'=>'misc','id'=>NULL),'s/ID.htm',false);
			}
			if (addon_installed('galleries'))
			{
				$rules[]=array(array('page'=>'galleries','type'=>'image','id'=>NULL),'galleries/image/ID.htm',false);
				$rules[]=array(array('page'=>'galleries','type'=>'video','id'=>NULL),'galleries/video/ID.htm',false);
			}
			if (addon_installed('iotds'))
			{
				$rules[]=array(array('page'=>'iotds','type'=>'view','id'=>NULL),'iotds/view/ID.htm',false);
			}
			$rules[]=array(array('page'=>NULL,'type'=>NULL,'id'=>NULL),'PAGE/TYPE/ID.htm',false);
			$rules[]=array(array('page'=>NULL,'type'=>NULL),'PAGE/TYPE.htm',false);
			$rules[]=array(array('page'=>NULL),'PAGE.htm',false);
			$rules[]=array(array('page'=>''),'',false);
			$rules[]=array(array(),'',false);
			break;

		case 'SIMPLE':
			if (addon_installed('wiki'))
			{
				$rules[]=array(array('page'=>'wiki','type'=>'misc','id'=>NULL),'s/ID',false);
			}
			if (addon_installed('galleries'))
			{
				$rules[]=array(array('page'=>'galleries','type'=>'image','id'=>NULL),'galleries/image/ID',false);
				$rules[]=array(array('page'=>'galleries','type'=>'video','id'=>NULL),'galleries/video/ID',false);
			}
			if (addon_installed('iotds'))
			{
				$rules[]=array(array('page'=>'iotds','type'=>'view','id'=>NULL),'iotds/view/ID',false);
			}
			$rules[]=array(array('page'=>NULL,'type'=>NULL,'id'=>NULL),'PAGE/TYPE/ID',false);
			$rules[]=array(array('page'=>NULL,'type'=>'misc'),'PAGE',false);
			$rules[]=array(array('page'=>NULL,'type'=>NULL),'PAGE/TYPE',false);
			$rules[]=array(array('page'=>NULL),'PAGE',false);
			$rules[]=array(array('page'=>''),'',false);
			$rules[]=array(array(),'',false);
			break;
	}

	return $rules;
}


