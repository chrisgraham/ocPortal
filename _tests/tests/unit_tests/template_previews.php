<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class template_previews_test_set extends ocp_test_case
{
	var $template_id;

	function setUp()
	{
		parent::setUp();

		if (function_exists('set_time_limit')) @set_time_limit(0);

		$_GET['keep_has_js']='0';
		$GLOBALS['NO_QUERY_LIMIT']=true;
		$_GET['keep_no_query_limit']='1';
		@ini_set('memory_limit','-1');
		$_GET['wide']='1';
		$_GET['keep_devtest']='1';
		$_GET['keep_has_js']='0';

		require_code('lorem');
	}

	function testNoMissingPreviews()
	{
		$templates=array();
		$dh=opendir(get_file_base().'/themes/default/templates');
		while (($f=readdir($dh))!==false)
		{
			if ((strtolower(substr($f,-4))=='.tpl') && ($f[0]!='.')) $templates[]=$f;
		}

		$all_previews=find_all_previews__by_template();
		foreach ($templates as $t)
		{
			$this->assertFalse(((!array_key_exists($t,$all_previews)) && (substr($t,0,11)!='JAVASCRIPT_') && ($t!='JAVASCRIPT.tpl')),'Missing preview for: '.$t);
		}

		@ini_set('ocproducts.type_strictness','0');
		@ini_set('ocproducts.xss_detect','0');
	}

	function testScreenPreview()
	{
		require_code('validation');
		require_lang('validation');

		global $RECORD_TEMPLATES_USED,$RECORDED_TEMPLATES_USED;
		$RECORD_TEMPLATES_USED=true;

		$only_do_these=array( // If you want to test specific templates temporarily put the template names (without .tpl) in this array. But remove again before you commit!
		);

		$lists=find_all_previews__by_template();
		foreach ($lists as $template=>$list)
		{
			$temp_name=basename($template,'.tpl');

			if (count($only_do_these)!=0)
				if (!in_array($temp_name,$only_do_these)) continue;

			if ($temp_name=='tempcode_test') continue;
			if ($temp_name=='ADMIN_ZONE_SEARCH') continue; // Only in admin theme, causes problem

			if (is_plain_text_template($temp_name))
				continue;

			$hook=$list[0];
			$function=$list[1];

			if (is_file(get_file_base().'/_tests/screens_tested/'.$function.'.tmp')) continue; // To make easier to debug through

			if (function_exists('set_time_limit')) @set_time_limit(0);

			$RECORDED_TEMPLATES_USED=array();
			$out=render_screen_preview($template,$hook,$function);
			$flag=false;
			foreach ($lists as $template_2=>$list_2)
			{
				$temp_name_2=basename($template_2,'.tpl');
				if (count($only_do_these)!=0)
					if (!in_array($temp_name_2,$only_do_these)) continue;

				if ($temp_name_2=='tempcode_test') continue;

				if (is_plain_text_template($temp_name_2))
					continue;
				if ($list_2[1]==$function)
				{
					// Ignore templates designed for indirect inclusion
					if ($temp_name_2=='GLOBAL_HELPER_PANEL' || $temp_name_2=='GLOBAL_HTML_WRAP_mobile' || $temp_name_2=='HTML_HEAD' || $temp_name_2=='MEMBER_TOOLTIP' || $temp_name_2=='FORM_STANDARD_END' || $temp_name_2=='MEMBER_BAR_SEARCH' || $temp_name_2=='MENU_LINK_PROPERTIES')
						continue;

					$this->assertTrue(in_array($temp_name_2,$RECORDED_TEMPLATES_USED),$template_2.' not used in preview as claimed in '.$hook.'/'.$function);
					if (!in_array($temp_name_2,$RECORDED_TEMPLATES_USED))
					{
						$flag=true;
					}
				}
			}

			if (!is_object($out)) fatal_exit('Claimed screen for '.$template.' is not defined');
			$_out=$out->evaluate();

			$result=check_xhtml($_out,false,false,false,true,true,false,false);
			if ((!is_null($result)) && (count($result['errors'])==0)) $result=NULL;
			$this->assertTrue(is_null($result),$hook.'/'.$temp_name);
			if (!is_null($result))
			{
				require_code('view_modes');
				display_validation_results($_out,$result,false,false);
			} else
			{
				if (!$flag)
				{
					fclose(fopen(get_file_base().'/_tests/screens_tested/'.$function.'.tmp','wb'));
					fix_permissions(get_file_base().'/_tests/screens_tested/'.$function.'.tmp');
				}
			}
		}

		@ini_set('ocproducts.type_strictness','0');
		@ini_set('ocproducts.xss_detect','0');
	}

	function testRepeatConsistency()
	{
		global $STATIC_TEMPLATE_TEST_MODE,$EXTRA_SYMBOLS,$PREPROCESSABLE_SYMBOLS,$LOADED_TPL_CACHE,$BLOCKS_CACHE,$PANELS_CACHE;
		$STATIC_TEMPLATE_TEST_MODE=true;

		global $HAS_KEEP_IN_URL_CACHE;
		$_GET['wide']='1';
		$_GET['keep_no_minify']='1'; // Disables resource merging, which messes with results
		$HAS_KEEP_IN_URL_CACHE=NULL;

		$lists=find_all_previews__by_screen();
		foreach ($lists as $function=>$tpls)
		{
			$template=$tpls[0];
			$hook=NULL;

			if ($template=='ADMIN_ZONE_SEARCH.tpl') continue; // Only in admin theme, causes problem

			if (is_file(get_file_base().'/_tests/screens_tested/consistency__'.$function.'.tmp')) continue; // To make easier to debug through

			if (function_exists('set_time_limit')) @set_time_limit(0);

			init__lorem();
			push_output_state();
			$LOADED_TPL_CACHE=array();
			$BLOCKS_CACHE=array();
			$PANELS_CACHE=array();
			$out1=render_screen_preview($template,$hook,$function);
			$_out1=$out1->evaluate();
			restore_output_state();
			init__lorem();
			push_output_state();
			$LOADED_TPL_CACHE=array();
			$BLOCKS_CACHE=array();
			$PANELS_CACHE=array();
			$out2=render_screen_preview($template,$hook,$function);
			$_out2=$out2->evaluate();
			restore_output_state();
			$different=($_out1!=$_out2);
			$this->assertFalse($different,'Screen preview not same each time, '.$function);

			if (!$different)
			{
				fclose(fopen(get_file_base().'/_tests/screens_tested/consistency__'.$function.'.tmp','wb'));
				fix_permissions(get_file_base().'/_tests/screens_tested/consistency__'.$function.'.tmp');
			} else
			{
				$myfile=fopen(get_file_base().'/_tests/screens_tested/v1__'.'.tmp','wb');
				fwrite($myfile,$_out1);
				fclose($myfile);
				fix_permissions(get_file_base().'/_tests/screens_tested/v1__'.'.tmp');

				$myfile=fopen(get_file_base().'/_tests/screens_tested/v2__'.'.tmp','wb');
				fwrite($myfile,$_out2);
				fclose($myfile);
				fix_permissions(get_file_base().'/_tests/screens_tested/v2__'.'.tmp');

				if (function_exists('diff_simple_2'))
				{
					require_code('diff');
					var_dump(diff_simple_2($_out1,$_out2));
				}

				exit('Error!');
			}

			unset($out1);
			unset($out2);
		}

		@ini_set('ocproducts.type_strictness','0');
		@ini_set('ocproducts.xss_detect','0');
	}

	function testNoMissingParams()
	{
		global $ATTACHED_MESSAGES,$ATTACHED_MESSAGES_RAW;

		$lists=find_all_previews__by_screen();
		foreach ($lists as $function=>$tpls)
		{
			$template=$tpls[0];
			$hook=NULL;

			if ($template=='ADMIN_ZONE_SEARCH.tpl') continue; // Only in admin theme, causes problem

			if (is_file(get_file_base().'/_tests/screens_tested/nonemissing__'.$function.'.tmp')) continue; // To make easier to debug through

			if (function_exists('set_time_limit')) @set_time_limit(0);

			$ATTACHED_MESSAGES=new ocp_tempcode();
			$ATTACHED_MESSAGES_RAW=array();
			$out1=render_screen_preview($template,$hook,$function);

			if ($ATTACHED_MESSAGES===NULL) $ATTACHED_MESSAGES=new ocp_tempcode();
			$put_out=(!$ATTACHED_MESSAGES->is_empty()) || (count($ATTACHED_MESSAGES_RAW)>0);
			$this->assertFalse($put_out,'Messages put out by '.$function.'  ('.strip_tags($ATTACHED_MESSAGES->evaluate()).')');

			if (!$put_out)
			{
				fclose(fopen(get_file_base().'/_tests/screens_tested/nonemissing__'.$function.'.tmp','wb'));
				fix_permissions(get_file_base().'/_tests/screens_tested/nonemissing__'.$function.'.tmp');
			}

			unset($out1);
		}

		@ini_set('ocproducts.type_strictness','0');
		@ini_set('ocproducts.xss_detect','0');
	}

	function testNoRedundantFunctions()
	{
		$hooks=find_all_hooks('systems','addon_registry');
		foreach ($hooks as $hook=>$place)
		{
			require_code('hooks/systems/addon_registry/'.$hook);

			$ob=object_factory('Hook_addon_registry_'.$hook);
			if (!method_exists($ob,'tpl_previews')) continue;
			$used=array_unique($ob->tpl_previews());

			$code=file_get_contents(get_file_base().'/'.$place.'/hooks/systems/addon_registry/'.$hook.'.php');

			$matches=array();
			$num_matches=preg_match_all('#function tpl\_preview\_\_(.*)\(#U',$code,$matches);
			for ($i=0;$i<$num_matches;$i++)
			{
				$this->assertTrue(in_array($matches[1][$i],$used),'Non-used screen function '.$matches[1][$i]);
			}
		}

		@ini_set('ocproducts.type_strictness','0');
		@ini_set('ocproducts.xss_detect','0');
	}

	function testNoDoublePreviews()
	{
		$all_used=array();

		$hooks=find_all_hooks('systems','addon_registry');
		foreach ($hooks as $hook=>$place)
		{
			require_code('hooks/systems/addon_registry/'.$hook);

			$ob=object_factory('Hook_addon_registry_'.$hook);
			if (!method_exists($ob,'tpl_previews')) continue;
			$used=array_unique($ob->tpl_previews());
			foreach (array_keys($used) as $u)
			{
				$this->assertFalse(array_key_exists($u,$all_used),'Double defined '.$u);
			}
			$all_used+=$used;
		}

		@ini_set('ocproducts.type_strictness','0');
		@ini_set('ocproducts.xss_detect','0');
	}


	function tearDown()
	{
		parent::tearDown();
	}
}
