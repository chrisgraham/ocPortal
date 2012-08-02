<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2009

 See text/en/licence.txt for full licencing information.

 Meta Script:
	Search for CSS classes used in templates, and check they exist in the default theme CSS files

*/

require_once('lib.php');

chdir($ocPortal_path);

$used=find_used();
$existing=find_existing();

echo do_header();

echo '<p>The following used CSS classes are not present in CSS...</p>';
print_r(array_diff($used,$existing));
echo '<p>The following non-used CSS classes are present in CSS (as far as can be told - may well be used by symbolic substitution)...</p>';
print_r(array_diff($existing,$used));

echo do_footer();

function find_existing()
{
	$out=array();
	$d=opendir('themes/default/css');
	while ($e=readdir($d))
	{
		if (substr($e,-4)=='.css')
		{
			$contents=file_get_contents('themes/default/css/'.$e);
			$found=preg_match_all('#\.([a-z_]+)[ ,:]#',$contents,$matches);
			for ($i=0;$i<$found;$i++)
			{
				if ($matches[1][$i]!='txt')
					$out[]=$matches[1][$i];
			}
		}
	}
	closedir($d);
	return array_unique($out);
}

function find_used()
{
	$out=array();
	$d=opendir('themes/default/templates');
	while ($e=readdir($d))
	{
		if (substr($e,-4)=='.tpl')
		{
			$contents=file_get_contents('themes/default/templates/'.$e);
			$found=preg_match_all('#class="([\w ]+)"#',$contents,$matches);
			for ($i=0;$i<$found;$i++)
			{
				$out=array_merge($out,explode(' ',$matches[1][$i]));
			}
		}
	}
	closedir($d);
	return array_unique($out);
}


