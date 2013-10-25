<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		themewizard
 */

/**
 * Module page class.
 */
class Module_admin_themewizard
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Allen Ellis';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('misc'=>'THEMEWIZARD','make_logo'=>'LOGOWIZARD');
	}

	var $title;

	/**
	 * Standard modular pre-run function, so we know meta-data for <head> before we start streaming output.
	 *
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run()
	{
		$type=get_param('type','misc');

		require_lang('themes');

		set_helper_panel_tutorial('tut_themes');
		set_helper_panel_text(comcode_lang_string('DOC_THEMEWIZARD'));
		if ($type=='make_logo' || $type=='_make_logo' || $type=='__make_logo')
		{
			set_helper_panel_pic('pagepics/logowizard');
		} else
		{
			set_helper_panel_pic('pagepics/themewizard');
		}

		if ($type=='misc')
		{
			breadcrumb_set_self(do_lang_tempcode('THEMEWIZARD'));

			$this->title=get_screen_title('_THEMEWIZARD',true,array(integer_format(1),integer_format(4)));
		}

		if ($type=='step2')
		{
			$this->title=get_screen_title('_THEMEWIZARD',true,array(integer_format(2),integer_format(4)));
		}

		if ($type=='step3')
		{
			$this->title=get_screen_title('_THEMEWIZARD',true,array(integer_format(3),integer_format(4)));
		}

		if ($type=='step4')
		{
			$this->title=get_screen_title('_THEMEWIZARD',true,array(integer_format(4),integer_format(4)));
		}

		if ($type=='step2' || $type=='step3' || $type=='step4')
		{
			breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('THEMEWIZARD'))));
		}

		if ($type=='make_logo')
		{
			breadcrumb_set_self(do_lang_tempcode('LOGOWIZARD'));

			$this->title=get_screen_title('_LOGOWIZARD',true,array(integer_format(1),integer_format(3)));
		}

		if ($type=='_make_logo')
		{
			breadcrumb_set_parents(array(array('_SELF:_SELF:make_logo',do_lang_tempcode('LOGOWIZARD'))));

			$this->title=get_screen_title('_LOGOWIZARD',true,array(integer_format(2),integer_format(3)));
		}

		if ($type=='__make_logo')
		{
			breadcrumb_set_parents(array(array('_SELF:_SELF:make_logo',do_lang_tempcode('START'))));

			$this->title=get_screen_title('_LOGOWIZARD',true,array(integer_format(3),integer_format(3)));
		}

		return NULL;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_code('themes2');
		require_code('themewizard');
		require_css('themes_editor');

		$type=get_param('type','misc');

		if ($type=='misc') return $this->step1();
		if ($type=='step2') return $this->step2();
		if ($type=='step3') return $this->step3();
		if ($type=='step4') return $this->step4();
		if ($type=='make_logo') return $this->make_logo();
		if ($type=='_make_logo') return $this->_make_logo();
		if ($type=='__make_logo') return $this->__make_logo();

		return new ocp_tempcode();
	}

	/**
	 * UI for a theme wizard step (choose colour).
	 *
	 * @return tempcode		The UI
	 */
	function step1()
	{
		$post_url=build_url(array('page'=>'_SELF','type'=>'step2'),'_SELF',array('keep_theme_seed','keep_theme_dark','keep_theme_source','keep_theme_algorithm'),false,true);
		$text=do_lang_tempcode('THEMEWIZARD_1_DESCRIBE');
		$submit_name=do_lang_tempcode('PROCEED');

		require_code('form_templates');

		$source_theme=get_param('source_theme','default');

		$hidden=new ocp_tempcode();
		if (count(find_all_themes())==1)
		{
			$hidden->attach(form_input_hidden('source_theme',$source_theme));
		} else
		{
			$themes=nice_get_themes($source_theme,true);
		}

		$fields=new ocp_tempcode();

		$fields->attach(form_input_codename(do_lang_tempcode('NEW_THEME'),do_lang_tempcode('DESCRIPTION_NAME'),'themename',get_param('themename',''),true));

		$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('_GUID'=>'0373ce292326fa209a6a44d829f547d4','SECTION_HIDDEN'=>false,'TITLE'=>do_lang_tempcode('PARAMETERS'))));

		$fields->attach(form_input_colour(do_lang_tempcode('SEED_COLOUR'),do_lang_tempcode('DESCRIPTION_SEED_COLOUR'),'seed','#'.preg_replace('/^\#/','',get_param('seed',find_theme_seed('default'))),true));

		if (count(find_all_themes())!=1)
		{
			$fields->attach(form_input_list(do_lang_tempcode('SOURCE_THEME'),do_lang_tempcode('DESCRIPTION_SOURCE_THEME'),'source_theme',$themes,NULL,true));
		}

		$radios=new ocp_tempcode();
		$radios->attach(form_input_radio_entry('algorithm','equations',$source_theme=='default',do_lang_tempcode('THEMEGEN_ALGORITHM_EQUATIONS')));
		$radios->attach(form_input_radio_entry('algorithm','hsv',$source_theme!='default',do_lang_tempcode('THEMEGEN_ALGORITHM_HSV')));
		$fields->attach(form_input_radio(do_lang_tempcode('THEMEGEN_ALGORITHM'),do_lang_tempcode('DESCRIPTION_THEMEGEN_ALGORITHM'),'algorithm',$radios,true));

		$fields->attach(form_input_tick(do_lang_tempcode('DARK_THEME'),do_lang_tempcode('DESCRIPTION_DARK_THEME'),'dark',get_param_integer('dark',0)==1));

		$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('_GUID'=>'e809c785aff72bbfeec3829a0b2f464d','SECTION_HIDDEN'=>true,'TITLE'=>do_lang_tempcode('ADVANCED'))));
		$fields->attach(form_input_tick(do_lang_tempcode('INHERIT_CSS'),do_lang_tempcode('DESCRIPTION_INHERIT_CSS'),'inherit_css',get_param_integer('inherit_css',0)==1));

		require_javascript('javascript_ajax');
		$script=find_script('snippet');
		$javascript="
			var form=document.getElementById('main_form');
			form.elements['source_theme'].onchange=function() {
				var default_theme=(form.elements['source_theme'].options[form.elements['source_theme'].selectedIndex].value=='default');
				form.elements['algorithm'][0].checked=default_theme;
				form.elements['algorithm'][1].checked=!default_theme;
			}
			form.old_submit=form.onsubmit;
			form.onsubmit=function()
				{
					document.getElementById('submit_button').disabled=true;
					var url='".addslashes($script)."?snippet=exists_theme&name='+window.encodeURIComponent(form.elements['themename'].value);
					if (!do_ajax_field_test(url))
					{
						document.getElementById('submit_button').disabled=false;
						return false;
					}
					document.getElementById('submit_button').disabled=false;
					if (typeof form.old_submit!='undefined' && form.old_submit) return form.old_submit();
					return true;
				};
		";

		return do_template('FORM_SCREEN',array('_GUID'=>'98963f4d7ff60744382f937e6cc5acbf','GET'=>true,'SKIP_VALIDATION'=>true,'TITLE'=>$this->title,'JAVASCRIPT'=>$javascript,'FIELDS'=>$fields,'URL'=>$post_url,'TEXT'=>$text,'SUBMIT_NAME'=>$submit_name,'HIDDEN'=>$hidden));
	}

	/**
	 * UI for a theme wizard step (choose preview).
	 *
	 * @return tempcode		The UI
	 */
	function step2()
	{
		$source_theme=get_param('source_theme');
		$algorithm=get_param('algorithm');
		$seed=preg_replace('/^\#/','',get_param('seed'));
		$dark=get_param_integer('dark',0);
		$inherit_css=get_param_integer('inherit_css',0);
		$themename=get_param('themename');
		if ((file_exists(get_custom_file_base().'/themes/'.$themename)) || ($themename=='default'))
		{
			warn_exit(do_lang_tempcode('ALREADY_EXISTS',escape_html($themename)));
		}

		// Check length (6 chars)
		if (strlen($seed)!=6) warn_exit(do_lang_tempcode('INVALID_COLOUR'));

		list($_theme,)=calculate_theme($seed,$source_theme,$algorithm,'colours',$dark==1);
		$theme=array();
		$theme['SOURCE_THEME']=$source_theme;
		$theme['ALGORITHM']=$algorithm;
		$theme['RED']=$_theme['red'];
		$theme['GREEN']=$_theme['green'];
		$theme['BLUE']=$_theme['blue'];
		$theme['DOMINANT']=$_theme['dominant'];
		$theme['LD']=$_theme['LD'];
		$theme['DARK']=$_theme['dark'];
		$theme['SEED']=$_theme['seed'];
		$theme['TITLE']=$this->title;
		$theme['CHANGE_URL']=build_url(array('page'=>'_SELF','type'=>'misc','source_theme'=>$source_theme,'algorithm'=>$algorithm,'seed'=>$seed,'dark'=>$dark,'inherit_css'=>$inherit_css,'themename'=>$themename),'_SELF');
		$theme['STAGE3_URL']=build_url(array('page'=>'_SELF','type'=>'step3','source_theme'=>$source_theme,'algorithm'=>$algorithm,'seed'=>$seed,'dark'=>$dark,'inherit_css'=>$inherit_css,'themename'=>$themename),'_SELF');

		return do_template('THEMEWIZARD_2_SCREEN',$theme);
	}

	/**
	 * UI for a theme wizard step (choose save).
	 *
	 * @return tempcode		The UI
	 */
	function step3()
	{
		$source_theme=get_param('source_theme');
		$algorithm=get_param('algorithm');
		$seed=get_param('seed');
		$dark=get_param_integer('dark');
		$inherit_css=get_param_integer('inherit_css');
		$themename=get_param('themename');

		$post_url=build_url(array('page'=>'_SELF','type'=>'step4'),'_SELF');
		$submit_name=do_lang_tempcode('ADD_THEME');
		require_code('form_templates');
		$fields=new ocp_tempcode();
		$fields->attach(form_input_tick(do_lang_tempcode('USE_ON_ZONES'),do_lang_tempcode('DESCRIPTION_USE_ON_ZONES'),'use_on_all',true));
		$hidden=new ocp_tempcode();
		$hidden->attach(form_input_hidden('source_theme',$source_theme));
		$hidden->attach(form_input_hidden('algorithm',$algorithm));
		$hidden->attach(form_input_hidden('seed',$seed));
		$hidden->attach(form_input_hidden('themename',$themename));
		$hidden->attach(form_input_hidden('dark',strval($dark)));
		$hidden->attach(form_input_hidden('inherit_css',strval($inherit_css)));

		return do_template('FORM_SCREEN',array('_GUID'=>'349383d77ecfce8c65f3303cfec86ea0','SKIP_VALIDATION'=>true,'TITLE'=>$this->title,'TEXT'=>do_lang_tempcode('REFRESH_TO_FINISH'),'FIELDS'=>$fields,'URL'=>$post_url,'SUBMIT_NAME'=>$submit_name,'HIDDEN'=>$hidden));
	}

	/**
	 * UI for a theme wizard step (actualisation).
	 *
	 * @return tempcode		The UI
	 */
	function step4()
	{
		// Add theme
		$source_theme=post_param('source_theme');
		$algorithm=post_param('algorithm');
		$seed=post_param('seed');
		$themename=post_param('themename');
		$use=(post_param_integer('use_on_all',0)==1);
		$dark=post_param_integer('dark');
		$inherit_css=post_param_integer('inherit_css');

		if (function_exists('set_time_limit')) @set_time_limit(0);

		require_code('type_validation');
		if ((!is_alphanumeric($themename)) || (strlen($themename)>40)) warn_exit(do_lang_tempcode('BAD_CODENAME'));
		make_theme($themename,$source_theme,$algorithm,$seed,$use,$dark==1,$inherit_css==1);
		$myfile=@fopen(get_custom_file_base().'/themes/'.filter_naughty($themename).'/theme.ini',GOOGLE_APPENGINE?'wb':'wt') OR intelligent_write_error(get_custom_file_base().'/themes/'.filter_naughty($themename).'/theme.ini');
		fwrite($myfile,'title='.$themename."\n");
		fwrite($myfile,'description='.do_lang('NA')."\n");
		fwrite($myfile,'seed='.$seed."\n");
		if (fwrite($myfile,'author='.$GLOBALS['FORUM_DRIVER']->get_username(get_member(),true)."\n")==0) warn_exit(do_lang_tempcode('COULD_NOT_SAVE_FILE'));
		fclose($myfile);
		sync_file('themes/'.filter_naughty($themename).'/theme.ini');

		// We're done
		$message=do_lang_tempcode('THEMEWIZARD_4_DESCRIBE',escape_html('#'.$seed),escape_html($themename));

		require_code('templates_donext');
		return do_next_manager($this->title,$message,
			NULL,
			NULL,
			/*		TYPED-ORDERED LIST OF 'LINKS'		*/
			/*	 page	 params				  zone	  */
			NULL,																						// Add one
			NULL,																						// Edit this
			NULL,																						// Edit one
			NULL,																						// View this
			NULL,																						// View archive
			NULL,																						// Add to category
			NULL,																						// Add one category
			NULL,																						// Edit one category
			NULL,																						// Edit this category
			NULL,																						// View this category
			/*	  SPECIALLY TYPED 'LINKS'				  */
			array(),
			array(),
			array(
				/*	 type							  page			 params													 zone	  */
				array('edit_this',array('admin_themes',array('type'=>'edit_theme','theme'=>$themename),get_module_zone('admin_themes'))),								 // Edit this
				array('edit_css',array('admin_themes',array('type'=>'choose_css','theme'=>$themename),get_module_zone('admin_themes'))),
				array('edit_templates',array('admin_themes',array('type'=>'edit_templates','theme'=>$themename),get_module_zone('admin_themes'))),
				array('manage_images',array('admin_themes',array('type'=>'manage_images','theme'=>$themename),get_module_zone('admin_themes'))),
				array('manage_themes',array('admin_themes',array('type'=>'misc'),get_module_zone('admin_themes')))
			),
			do_lang('THEME')
		);
	}

	/**
	 * UI for a logo wizard step (ask for input).
	 *
	 * @return tempcode		The UI
	 */
	function make_logo()
	{
		if (!function_exists('imagepng')) warn_exit(do_lang_tempcode('GD_NEEDED'));

		$post_url=build_url(array('page'=>'_SELF','type'=>'_make_logo'),'_SELF');
		$theme_image_url=build_url(array('page'=>'admin_themes','type'=>'edit_image','id'=>'logo/-logo','lang'=>user_lang(),'theme'=>$GLOBALS['FORUM_DRIVER']->get_theme('')),get_module_zone('admin_themes'));
		$text=do_lang_tempcode('LOGOWIZARD_1_DESCRIBE',escape_html($theme_image_url->evaluate()));
		$submit_name=do_lang_tempcode('PROCEED');

		require_code('form_templates');
		$fields=new ocp_tempcode();
		$fields->attach(form_input_line(do_lang_tempcode('NAME'),do_lang_tempcode('DESCRIPTION_LOGO_NAME'),'name',get_option('site_name'),true));
		$a=$GLOBALS['SITE_DB']->query_select_value('zones','zone_title',array('zone_name'=>''));
		$fields->attach(form_input_line(do_lang_tempcode('TITLE'),do_lang_tempcode('DESCRIPTION_LOGO_SLOGAN'),'title',get_translated_text($a),true));

		// Find the most appropriate theme to edit for
		$theme=$GLOBALS['SITE_DB']->query_select_value_if_there('zones','zone_theme',array('zone_name'=>'site'));
		if (is_null($theme)) // Just in case the 'site' zone no longer exists
			$theme=$GLOBALS['SITE_DB']->query_select_value('zones','zone_theme',array('zone_name'=>''));
		if ($theme=='-1')
		{
			$theme=preg_replace('#[^A-Za-z\d]#','_',get_site_name());
		}
		if (!file_exists(get_custom_file_base().'/themes/'.$theme)) $theme='default';
		require_code('themes2');

		$fields->attach(form_input_list(do_lang_tempcode('THEME'),do_lang_tempcode('DESCRIPTION_LOGOWIZARD_THEME'),'theme',nice_get_themes($theme,true)));

		return do_template('FORM_SCREEN',array('_GUID'=>'08449c0ae8edf5c0b3510611c9ac9618','SKIP_VALIDATION'=>true,'TITLE'=>$this->title,'FIELDS'=>$fields,'URL'=>$post_url,'TEXT'=>$text,'SUBMIT_NAME'=>$submit_name,'HIDDEN'=>''));
	}

	/**
	 * UI for a logo wizard step (show preview).
	 *
	 * @return tempcode		The UI
	 */
	function _make_logo()
	{
		$preview=do_template('LOGOWIZARD_2',array('_GUID'=>'6e5a442860e5b7644b50c2345c3c8dee','NAME'=>post_param('name'),'TITLE'=>post_param('title'),'THEME'=>post_param('theme')));

		require_code('templates_confirm_screen');
		return confirm_screen($this->title,$preview,'__make_logo','make_logo');
	}

	/**
	 * UI for a logo wizard step (set).
	 *
	 * @return tempcode		The UI
	 */
	function __make_logo()
	{
		$theme=post_param('theme');

		// Do it
		require_code('themes2');
		$rand=uniqid('',true);
		foreach (array($theme,'default') as $logo_save_theme)
		{
			$path='themes/'.$logo_save_theme.'/images_custom/'.$rand.'.png';

			if (!file_exists(dirname($path)))
			{
				require_code('files2');
				make_missing_directory(dirname($path));
			}

			$img=generate_logo(post_param('name'),post_param('title'),false,$logo_save_theme,'logo_template');
			@imagepng($img,get_custom_file_base().'/'.$path) OR intelligent_write_error($path);
			imagedestroy($img);
			actual_edit_theme_image('logo/-logo',$logo_save_theme,user_lang(),'logo/-logo',$path);
			if (addon_installed('collaboration_zone'))
				actual_edit_theme_image('logo/collaboration-logo',$logo_save_theme,user_lang(),'logo/collaboration-logo',$path);
			$rand=uniqid('',true);
			$path='themes/'.$logo_save_theme.'/images_custom/'.$rand.'.png';
			$img=generate_logo(post_param('name'),post_param('title'),false,NULL,'trimmed_logo_template');
			@imagepng($img,get_custom_file_base().'/'.$path) OR intelligent_write_error($path);
			imagedestroy($img);
			actual_edit_theme_image('logo/trimmed_logo',$logo_save_theme,user_lang(),'logo/trimmed_logo',$path);
		}
		persistent_cache_delete('THEME_IMAGES');

		$message=do_lang_tempcode('LOGOWIZARD_3_DESCRIBE',escape_html($theme));
		return inform_screen($this->title,$message);
	}

}


