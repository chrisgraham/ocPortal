<?php

/*
This script will spot when a theme has bits of default theme CSS that is not adjusted for that theme's seed.
It could fix CSS upgraded via diff, or just poor copy-and-pasting of code back from the default theme CSS files.

Take BACKUPs before running this.
*/

require_code('themewizard');

$theme=get_param('theme',NULL);
if ($theme===NULL)
{
	echo '<p>You must pick a theme&hellip;</p><ul>';
	
	require_code('themes2');
	$themes=find_all_themes();
	foreach (array_keys($themes) as $theme)
	{
		if ($theme!='default')
		{
			echo '<li><a href="'.static_evaluate_tempcode(build_url(array('page'=>'fix_partial_themewizard_css','theme'=>$theme),'adminzone')).'">'.escape_html($theme).'</a></li>';
		}
	}
	
	echo '</ul>';
	
	return;
}

$seed=find_theme_seed($theme);
$dark=find_theme_dark($theme);

$default_seed=find_theme_seed('default');

if ($default_seed==$seed) warn_exit('Theme has same seed as default theme, cannot continue, would be a no-op.');

list($canonical_theme_map,$canonical_theme_landscape)=calculate_theme($default_seed,'default','equations','colours',false);

list($theme_map,$theme_landscape)=calculate_theme($seed,'default','equations','colours',$dark);

echo '<p>Made changes for:</p><ul>';

$dh=opendir(get_file_base().'/themes/'.filter_naughty($theme).(($theme=='default')?'/css/':'/css_custom/'));
while (($sheet=readdir($dh))!==false)
{
	if (substr($sheet,-4)=='.css')
	{
		$saveat=get_custom_file_base().'/themes/'.filter_naughty($theme).'/css_custom/'.$sheet;
		if ((!file_exists($saveat)) || ($source_theme!='default') || ($algorithm=='hsv'))
		{
			$output=file_get_contents($saveat);
			$before=$output;

			foreach ($canonical_theme_landscape as $peak)
			{
				$matches=array();

				$num_matches=preg_match_all('#\#[A-Fa-f0-9]{6}(.*)'.str_replace('#','\#',preg_quote($peak[2])).'#',$output,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					if ($matches[0][$i]=='#'.$peak[3].$matches[1][$i].$peak[2]) // i.e. unaltered in our theme
					{
						foreach ($theme_landscape as $new_peak) // Try and find the new-seeded solution to this particular equation
						{
							if ($new_peak[2]==$peak[2])
							{
								$output=str_replace($matches[0][$i],'#'.$new_peak[3].$matches[1][$i].$new_peak[2],$output);
								break;
							}
						}
					}
				}
			}

			if ($output!=$before)
			{
				$fp=@fopen($saveat,'wt') OR intelligent_write_error($saveat);
				if (fwrite($fp,$output)<strlen($output)) warn_exit(do_lang_tempcode('COULD_NOT_SAVE_FILE'));
				fclose($fp);
				fix_permissions($saveat);
				sync_file($saveat);
			
				echo '<li>'.escape_html($sheet).'</li>';
			}
		}
	}
}

echo '</ul><p>Finished.</p>';
