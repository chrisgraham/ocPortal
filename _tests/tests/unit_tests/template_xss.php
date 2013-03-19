<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

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
class template_xss_test_set extends ocp_test_case
{
	function setUp()
	{
		parent::setUp();
	}

	function testQuoteBreakout() // See http://css.dzone.com/articles/xss-still-tricky
	{
		$templates=array();
		$path=get_file_base().'/themes/default/templates';
		$dh=opendir($path);
		while (($f=readdir($dh))!==false)
		{
			if (strtolower(substr($f,-4))=='.tpl')
			{
				$file=file_get_contents($path.'/'.$f);
				$file_orig=$file;

				$matches=array();

				// Strip parameters inside symbols, language strings and Tempcode portions
				do
				{
					$num_matches=preg_match('#\{[\$\!\+]#',$file,$matches,PREG_OFFSET_CAPTURE);
					if ($num_matches!=0)
					{
						$posa=$matches[0][1];
						$pos=$posa;
						$balance=0;
						do
						{
							if (!isset($file[$pos])) break;
							$char=$file[$pos];
							if ($char=='{') $balance++;
							elseif ($char=='}') $balance--;
							$pos++;
						}
						while ($balance!=0);
						$file=str_replace(substr($file,$posa,$pos-$posa),'',$file);
					}
				}
				while ($num_matches>0);

				// Search
				$num_matches=preg_match_all('#\{(\w+)([/*;\#])\}#U',$file,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$match=$matches[0][$i];
					if ((strpos($match,'*')===false) && (strpos($match,'#')===false) && (strpos($match,'/')===false))
					{
						$matches2=array();
						if (preg_match('#<script.*(?<!</script>)'.preg_quote($match,'#').'#s',$file,$matches2)!=0)
						{
							$this->assertTrue(false,'Unsafe embedded Javascript parameter ('.$matches[1][$i].') in '.$f);

							if (get_param_integer('save',0)==1)
							{
								$file_orig=str_replace($match,'{'.$matches[1][$i].'/'.$matches[2][$i].'}',$file_orig);
								file_put_contents($path.'/'.$f,$file_orig);
							}
						}
					}
				}
			}
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
