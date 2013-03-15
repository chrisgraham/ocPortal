<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/*
Search for CSS classes used in templates, and check they exist in the default theme CSS files
*/

$used=find_used();
$existing=find_existing();
sort($used);
sort($existing);

echo '<p>The following used CSS classes are not present in CSS...</p>';
echo '<ul>';
foreach (array_diff($used,$existing) as $x)
{
	if (strpos($x,'box___')===false)
		echo '<li>'.escape_html($x).'</li>';
}
echo '</ul>';

echo '<p>The following non-used CSS classes are present in CSS (as far as can be told - may well be used by symbolic substitution)...</p>';
echo '<ul>';
foreach (array_diff($existing,$used) as $x)
{
	echo '<li>'.escape_html($x).'</li>';
}
echo '</ul>';

function find_existing()
{
	$out=array();
	$d=opendir(get_file_base().'/themes/default/css');
	while ($e=readdir($d))
	{
		if (substr($e,-4)=='.css')
		{
			$contents=file_get_contents(get_file_base().'/themes/default/css/'.$e);
			$found=preg_match_all('#\.([a-z][a-z_\d]*)[ ,:]#',$contents,$matches);
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
	$d=opendir(get_file_base().'/themes/default/templates');
	while ($e=readdir($d))
	{
		if (substr($e,-4)=='.tpl')
		{
			$contents=file_get_contents(get_file_base().'/themes/default/templates/'.$e);
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


