<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

$text=file_get_contents(get_file_base().'/text/EN/licence.txt');

$text=preg_replace('#(^|\n)(.*)\n=+\n#','${1}[title]${2}[/title]'."\n",$text);
$text=preg_replace('#(^|\n)(.*)\n\-+\n#','${1}[title="2"]${2}[/title]'."\n",$text);

require_code('comcode');
echo static_evaluate_tempcode(comcode_to_tempcode($text));
