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

if (!function_exists('mu_ui'))
{
function mu_ui()
{
echo <<<END
<div>You can generate an upgrader from any version of ocPortal to any other version. If you access this upgrade post via the version information box on your Admin Zone front page then we'll automatically know what version you're running.
<br />If you'd prefer though you can enter in your version number right here:</div>
<br />
<form onsubmit="this.elements['submitbtn'].disabled=true;" action="#" method="post">
	<p style="margin: 4px 0">
		<label style="width: 170px; float: left" for="from_version_a">Major version (e.g. <kbd>4</kbd>)</label>
		<input size="1" maxlength="1" type="text" name="from_version_a" id="from_version_a" value="" />
	</p>
	<p style="margin: 4px 0">
		<label style="width: 170px; float: left" for="from_version_b">Minor version (e.g. <kbd>3</kbd>)</label>
		<input size="1" maxlength="1" type="text" name="from_version_b" id="from_version_b" value="" />
	</p>
	<p style="margin: 4px 0">
		<label style="width: 170px; float: left" for="from_version_c">Patch version (e.g. <kbd>2</kbd>)</label>
		<input size="2" maxlength="2" type="text" name="from_version_c" id="from_version_c" value="" />
	</p>
	<p style="margin: 4px 0; font-size: 0.8em">
		<label style="width: 170px; float: left" for="from_version_d">Pre-release version (e.g. beta1)</label>
		<input size="6" type="text" name="from_version_d" id="from_version_d" value="" /> (usually blank)
	</p>
	<p>(example above is for upgrading from 4.3.2 beta1)</p>
	<p>
		<input class="button_pageitem" id="submitbtn" type="submit" value="Generate" />
	</p>
</form>
END;
}
}

if (!function_exists('mu_result'))
{
function mu_result($path)
{
	$normal_bore=get_file_base().'/uploads/website_specific/ocportal.com/upgrades/tars/';
	if (substr($path,0,strlen($normal_bore))==$normal_bore) $path=get_file_base().'/upgrades/'.substr($path,strlen($normal_bore));

	$base_url=get_base_url();
	$url=$base_url.'/'.rawurldecode(substr($path,strlen(get_file_base())+1));
	
	require_code('files');
	
	echo '<label for="download_path">Upgrade file:</label> <input class="notranslate" size="45" readonly="readonly" type="text" value="'.escape_html($url).'" />, or <a href="'.escape_html($url).'">download upgrade directly</a> ('.escape_html(clean_file_size(filesize($path))).').';
}
}

$to_version=$map['param'];

echo <<<END
	<div class="medborder">
		<div>
			<h4 class="standardbox_title_med">Your upgrade to version {$to_version}</h4>
			<div class="medborder_box">
				<div class="standardbox_main_classic"><div class="float_surrounder">
END;

$from_version=get_param('from_version',NULL);
if (is_null($from_version))
{
	$a=post_param('from_version_a',NULL);
	$b=post_param('from_version_b',NULL);
	$c=post_param('from_version_c',NULL);
	$d=post_param('from_version_d',NULL);
	if ((is_null($a)) || (is_null($b)) || (is_null($c)))
	{
	 	mu_ui();
echo <<<END
				</div></div>
			</div>
		</div>
	</div>
END;
		return;
	}
	if ((strlen($b)==2) && ($b[0]=='0')) $b=substr($b,1);
	$from_version=$a.'.'.$b;
	if (($c!='0') && ($c!='')) $from_version.='.'.$c;
	if ($d!='')
	{
		if (substr($d,0,2)=='rc') $d=strtoupper($d);
		if (substr($d,0,2)!='RC') $d=strtolower($d);
		$d=str_replace(' ','',$d);
		$d=str_replace('-','',$d);
		if ($d!='final') $from_version.=' '.$d;
	}
}
$from_version=preg_replace('#^(?U)([^ ]*)(?-U)(\.0)+( [^ ]*)?$#','${1}${3}',$from_version); // Remove any trailing zeroes

require_code('uploads/website_specific/ocportal.com/upgrades/make_upgrader.php');
$ret=make_upgrade_get_path($from_version,$to_version);

if (!is_null($ret[1])) // Error
{
	echo '<p>'.$ret[1].'</p>';
}

if (!is_null($ret[0]))
{
	mu_result($ret[0]);
}

echo <<<END
				</div></div>
			</div>
		</div>
	</div>
END;
