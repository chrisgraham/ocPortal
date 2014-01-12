<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=false;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'."\n".'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	global $NO_EVAL_CACHE,$MEMORY_OVER_SPEED,$USER_LANG_CACHED,$XSS_DETECT,$KEEP_TPL_FUNCS,$FULL_RESET_VAR_CODE,$RESET_VAR_CODE,$DEV_MODE;
	$cl=user_lang();
	$parameters=array();
	$tpl_funcs['do_runtime_52d289979a0551.03007064']="eval(\$FULL_RESET_VAR_CODE); echo \"\\n	<div class=\\\"float_surrounder\\\">\\n		\".(\"\\n			\".ecv_SET(\$cl,array(),array(\"search_url\",ecv_SELF_URL(\$cl,array(),array()))).\"\\n			<form class=\\\"filedump_filter\\\" role=\\\"search\\\" title=\\\"\".\"Search\".\"\\\" onsubmit=\\\"disable_button_just_clicked(this); action.href+=window.location.hash; if (this.elements['search'].value=='\".ecv(\$cl,array(2,1),2,\"SEARCH\",array()).\"') this.elements['search'].value='';\\\" action=\\\"\".ecv_URL_FOR_GET_FORM(\$cl,array(1),array(ecv_GET(\$cl,array(),array(\"search_url\")),\"search\",\"type_filter\",\"sort\",\"place\")).\"\\\" method=\\\"get\\\">\\n				\".ecv_HIDDENS_FOR_GET_FORM(\$cl,array(),array(ecv_GET(\$cl,array(),array(\"search_url\")),\"search\",\"type_filter\",\"sort\",\"place\")).\"\\n\\n				<p class=\\\"left\\\">\\n					<label class=\\\"accessibility_hidden\\\" for=\\\"search_filedump_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\">\".\"Search\".\"</label>\\n					<input \".((ecv(\$cl,array(),0,\"MOBILE\",array())==\"1\")?(\"autocorrect=\\\"off\\\" \"):'').\"autocomplete=\\\"off\\\" maxlength=\\\"255\\\" size=\\\"25\\\" type=\\\"search\\\" id=\\\"search_filedump_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\" name=\\\"search\\\" onfocus=\\\"placeholder_focus(this);\\\" onblur=\\\"placeholder_blur(this);\\\" class=\\\"field_input_non_filled\\\" value=\\\"\".(((ecv_IS_EMPTY(\$cl,array(),array(otp(isset(\$bound_SEARCH)?\$bound_SEARCH:NULL,\"SEARCH/FILEDUMP_SCREEN\"))))==\"1\")?(\"Search\"):(otp(isset(\$bound_SEARCH)?\$bound_SEARCH:NULL,\"SEARCH/FILEDUMP_SCREEN\"))).\"\\\" />\\n\\n					<label class=\\\"horiz_field_sep\\\" for=\\\"type_filter_filedump_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\">\".\"Show\".\"</label>\\n					<select id=\\\"type_filter_filedump_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\" name=\\\"type_filter\\\">\\n						<option\".((ecv_EQ(\$cl,array(),array(otp(isset(\$bound_TYPE_FILTER)?\$bound_TYPE_FILTER:NULL,\"TYPE_FILTER/FILEDUMP_SCREEN\")))==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"\\\">\".\"All\".\"</option>\\n						<option\".(((((otp(isset(\$bound_TYPE_FILTER)?\$bound_TYPE_FILTER:NULL,\"TYPE_FILTER/FILEDUMP_SCREEN\"))==(\"images\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"images\\\">\".\"Images\".\"</option>\\n						<option\".(((((otp(isset(\$bound_TYPE_FILTER)?\$bound_TYPE_FILTER:NULL,\"TYPE_FILTER/FILEDUMP_SCREEN\"))==(\"videos\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"videos\\\">\".\"Videos\".\"</option>\\n						<option\".(((((otp(isset(\$bound_TYPE_FILTER)?\$bound_TYPE_FILTER:NULL,\"TYPE_FILTER/FILEDUMP_SCREEN\"))==(\"audios\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"audios\\\">\".\"Audio files\".\"</option>\\n						<option\".(((((otp(isset(\$bound_TYPE_FILTER)?\$bound_TYPE_FILTER:NULL,\"TYPE_FILTER/FILEDUMP_SCREEN\"))==(\"others\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"others\\\">\".\"Other\".\"</option>\\n					</select>\\n\\n					<label class=\\\"horiz_field_sep\\\" for=\\\"jump_to_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\">\".\"Jump to folder\".\"</label>\\n					<select id=\\\"jump_to_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\" name=\\\"place\\\">\\n						\".closure_loop(array(\"DIRECTORIES\",'vars'=>\$parameters),array(\$parameters,\$cl),\nrecall_named_function('52d289978f9374.67669365','\$parameters,\$cl',\"extract(\\\$parameters,EXTR_PREFIX_ALL,'bound'); return \\\"\\\\n							<option\\\".(((((ecv__GET(\\\$cl,array(),array(\\\"place\\\",\\\"/\\\")))==(\\\"/\\\".(empty(\\\$bound__loop_var->pure_lang)?apply_tempcode_escaping_inline(array(1),otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\")):otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\")).ecv_TERNARY(\\\$cl,array(),array(ecv_IS_NON_EMPTY(\\\$cl,array(),array(otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\"))),\\\"/\\\"))))?\\\"1\\\":\\\"0\\\")==\\\"1\\\")?(\\\" selected=\\\\\\\"selected\\\\\\\"\\\"):'').\\\" value=\\\\\\\"/\\\".(empty(\\\$bound__loop_var->pure_lang)?apply_tempcode_escaping_inline(array(1),otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\")):otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\")).ecv_TERNARY(\\\$cl,array(),array(ecv_IS_NON_EMPTY(\\\$cl,array(),array(otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\"))),\\\"/\\\")).\\\"\\\\\\\">/\\\".(empty(\\\$bound__loop_var->pure_lang)?apply_tempcode_escaping_inline(array(1),otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\")):otp(isset(\\\$bound__loop_var)?\\\$bound__loop_var:NULL,\\\"_loop_var/FILEDUMP_SCREEN\\\")).\\\"</option>\\\\n						\\\";\")).\"\\n					</select>\\n\\n					<label class=\\\"horiz_field_sep\\\" for=\\\"sort_filedump_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\">\".\"Sort by\".\"</label>\\n					<select id=\\\"sort_filedump_\".ecv_GET(\$cl,array(1),array(\"i\")).\"\\\" name=\\\"sort\\\">\\n						<option\".(((((otp(isset(\$bound_SORT)?\$bound_SORT:NULL,\"SORT/FILEDUMP_SCREEN\"))==(\"time ASC\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"time ASC\\\">\".\"Date and time\".\",\".\" <em>ascending</em>\".\"</option>\\n						<option\".(((((otp(isset(\$bound_SORT)?\$bound_SORT:NULL,\"SORT/FILEDUMP_SCREEN\"))==(\"time DESC\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"time DESC\\\">\".\"Date and time\".\",\".\" <em>descending</em>\".\"</option>\\n						<option\".(((((otp(isset(\$bound_SORT)?\$bound_SORT:NULL,\"SORT/FILEDUMP_SCREEN\"))==(\"name ASC\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"name ASC\\\">\".\"Filename\".\",\".\" <em>ascending</em>\".\"</option>\\n						<option\".(((((otp(isset(\$bound_SORT)?\$bound_SORT:NULL,\"SORT/FILEDUMP_SCREEN\"))==(\"name DESC\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"name DESC\\\">\".\"Filename\".\",\".\" <em>descending</em>\".\"</option>\\n						<option\".(((((otp(isset(\$bound_SORT)?\$bound_SORT:NULL,\"SORT/FILEDUMP_SCREEN\"))==(\"size ASC\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"size ASC\\\">\".\"File size\".\",\".\" <em>ascending</em>\".\"</option>\\n						<option\".(((((otp(isset(\$bound_SORT)?\$bound_SORT:NULL,\"SORT/FILEDUMP_SCREEN\"))==(\"size DESC\"))?\"1\":\"0\")==\"1\")?(\" selected=\\\"selected\\\"\"):'').\" value=\\\"size DESC\\\">\".\"File size\".\",\".\" <em>descending</em>\".\"</option>\\n					</select>\\n\\n					<input class=\\\"buttons__filter button_micro\\\" type=\\\"submit\\\" value=\\\"\".\"Filter\".\"\\\" />\\n				</p>\\n			</form>\\n		\").\"\\n	</div>\\n\";";
	eval($tpl_funcs['do_runtime_52d289979a0551.03007064']);
}
