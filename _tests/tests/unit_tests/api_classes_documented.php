<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unit_testing
 */

/**
 * ocPortal test case class (unit testing).
 */
class api_classes_documented_test_set extends ocp_test_case
{
	function testAPIClassesDocumented()
	{
		/*
		NB: This only bothers with stuff we are going to include in the PHPDocumentor scan. Otherwise we don't care as ocPortal doesn't (packages work on a file level, this isn't Java).
		*/

		foreach (array('sources','sources/database','sources/database/shared','sources/forum','sources/forum/shared') as $d)
		{
			$path=get_file_base().'/'.$d;
			$dh=opendir($path);
			while (($f=readdir($dh))!==false)
			{
				if (substr($f,-4)!='.php') continue;
				if ($f=='jsmin.php') continue;
				if ($f=='firephp.php') continue;
				if ($f=='diff.php') continue;

				$c=file_get_contents($path.'/'.$f);
				$matches=array();
				$num_matches=preg_match_all('#\n\t*class ([\w\_]+)#',$c,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$this->assertTrue(preg_match('# +\* @package\s+([\w\_]+)\n\t* +\*/\n\t*class '.preg_quote($matches[1][$i],'#').'#',$c)!=0,'Undefined package for PHPDocumentor-exposed class: '.$d.'/'.$f.' ('.$matches[1][$i].')');
				}
			}
		}
	}
}
