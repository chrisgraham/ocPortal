<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2015

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    ocportalcom
 */

i_solemnly_declare(I_UNDERSTAND_SQL_INJECTION | I_UNDERSTAND_XSS | I_UNDERSTAND_PATH_INJECTION);

require_javascript('thumbnails');

$mill = 3000; // milliseconds between animations
$dir = 'uploads/website_specific/fp_animation/';
$url_stub = get_custom_base_url() . '/' . $dir;

$images = array();
$dh = opendir(get_custom_file_base() . '/' . $dir);
require_code('images');
while (($f = readdir($dh)) !== false) {
    if (is_image($f)) {
        $images[] = $f;
    }
}
closedir($dh);

echo '<div style="position: relative;" id="fp_animation_box"><img style="display: block;" id="fp_animation" src="' . $url_stub . $images[0] . '" alt="" /></div>';
$count = count($images);
echo "
<script type=\"text/javascript\">// <![CDATA[
    var fp_animation=document.getElementById('fp_animation');
    var fp_animation_fader=document.createElement('img');
    fp_animation.parentNode.insertBefore(fp_animation_fader,fp_animation.nextSibling);
    fp_animation_fader.style.position='absolute';
    fp_animation_fader.src='" . escape_html(find_theme_image('blank')) . "';
    function create_fader_frame(url,i)
    {
        new Image().src=url;" . /* <<< pre-cache*/
    "
        window.setTimeout(function()
        {
            var func=function()
            {
                    fp_animation_fader.style.left='0px';
                    fp_animation_fader.style.top='0px';
                    fp_animation_fader.style.display='block';
                    fp_animation_fader.src=fp_animation.src;
                    setOpacity(fp_animation_fader,1.0);
                    nereidFade(fp_animation_fader,0,50,-3);
                    fp_animation.src=url;
            };
            if (i!=0) func();
            window.setInterval(func,{$mill}*{$count});
        },i*{$mill});
    }
";
foreach ($images as $i => $this_one) {
    echo "create_fader_frame('{$url_stub}{$this_one}',$i);";
}
echo '
//]]></script>
';
