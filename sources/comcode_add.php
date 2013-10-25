<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_rich_media
 */

/*
There's a lot of hard-coded data in here. Ideally we'd use hooks to build up this.
In practice though, if people are installing addons for extra tags, they will probably be okay reading usage instructions.
The default tags need to have a great UI out of the box: we need a great base experience for all.
*/

/**
 * Get some metadata of what Comcode tags we have.
 *
 * @return array			A pair: core tags (map to tag parameters), custom tags (map to Custom Comcode row).
 */
function _get_details_comcode_tags()
{
	$tag_list=array(
		'list'=>array('param'),
		'indent'=>array('param'),
		'ins'=>array('cite','datetime'),
		'del'=>array('cite','datetime'),
		'b'=>array(),
		'u'=>array(),
		'i'=>array(),
		's'=>array(),
		'sup'=>array(),
		'sub'=>array(),
		'size'=>array('param'),
		'color'=>array('param'),
		'highlight'=>array(),
		'font'=>array('param','color','size'),
		'align'=>array('param'),
		'left'=>array(),
		'center'=>array(),
		'right'=>array(),
		'abbr'=>array('param'),
		'box'=>array('float','dimensions','type','options','param'),
		'quote'=>array('param','saidless','cite'),
		'cite'=>array(),
		'samp'=>array(),
		'q'=>array(),
		'var'=>array(),
		'dfn'=>array(),
		'address'=>array(),
		'title'=>array('param','sub','number','base'),
		'contents'=>array('files','zone','levels','base'),
		'include'=>array('param'),
		'concepts'=>array('x_key','x_value'),
		'concept'=>array('param'),
		'staff_note'=>array(),
		'menu'=>array('param','type'),
		'surround'=>array('param','style'),
		'codebox'=>array('param','numbers'),
		'code'=>array('param','scroll','numbers'),
		'tt'=>array(),
		'no_parse'=>array(),
		'semihtml'=>array(),
		'html'=>array(),
		'overlay'=>array('param','x','y','width','height','timein','timeout'),
		'random'=>array('string','X'),
		'pulse'=>array('param','min','max'),
		'ticker'=>array('param','speed'),
		'shocker'=>array('left','right','min','max'),
		'jumping'=>array('string'),
		'sections'=>array('default','name'),
		'big_tabs'=>array('default','switch_time','name'),
		'tabs'=>array('default','name'),
		'carousel'=>array('param'),
		'hide'=>array('param'),
		'tooltip'=>array('param'),
		'currency'=>array('param','bracket'),
		'if_in_group'=>array('param','type'),
		'flash'=>array('param'),
		'media'=>array('description','thumb_url','width','height','framed','wysiwyg_editable','type','thumb','length','filename','mime_type','filesize','click_url','float'),
		'img'=>array('align','float','param','title','rollover','refresh_time'),
		'thumb'=>array('align','param','caption','float'),
		'url'=>array('param','title','target','rel'),
		'email'=>array('param','title','subject','body'),
		'reference'=>array('type','param'),
		'page'=>array('param'),
		'snapback'=>array('param','forum'),
		'post'=>array('param','forum'),
		'topic'=>array('param','forum'),
		'attachment'=>array('description','thumb_url','width','height','framed','type','thumb','length','filename','mime_type','filesize','click_url','float'),
		//'attachment_safe'=>array('description','filename','type','width','height','float','thumb_url'),	Merged into attachment in UI
	);
	ksort($tag_list);

	/* // Helps find missing tags
	require_code('comcode_compiler');
	unset($VALID_COMCODE_TAGS['section']);
	unset($VALID_COMCODE_TAGS['section_controller']);
	unset($VALID_COMCODE_TAGS['tab']);
	unset($VALID_COMCODE_TAGS['big_tab']);
	unset($VALID_COMCODE_TAGS['big_tab_cntroller']);
	unset($VALID_COMCODE_TAGS['acronym']);
	unset($VALID_COMCODE_TAGS['block']);
	unset($VALID_COMCODE_TAGS['attachment_safe']);
	foreach (array_keys($tag_list) as $tag)
	{
		global $VALID_COMCODE_TAGS;
		unset($VALID_COMCODE_TAGS[$tag]);
	}
	@var_dump($VALID_COMCODE_TAGS);exit();*/
	$custom_tag_list=array();

	global $DANGEROUS_TAGS,$TEXTUAL_TAGS;

	// Custom Comcode tags too
	if ((get_forum_type()=='ocf') && (addon_installed('custom_comcode')))
	{
		$custom_tags=$GLOBALS['FORUM_DB']->query_select('custom_comcode',array('tag_title','tag_description','tag_example','tag_parameters','tag_replace','tag_tag','tag_dangerous_tag','tag_block_tag','tag_textual_tag'),array('tag_enabled'=>1));
		foreach ($custom_tags as $tag)
		{
			$custom_tag_list[$tag['tag_tag']]=$tag;
			if ($tag['tag_textual_tag']==1) $TEXTUAL_TAGS[$tag['tag_tag']]=1;
			if ($tag['tag_dangerous_tag']==1) $DANGEROUS_TAGS[$tag['tag_tag']]=1;
		}
		if ((isset($GLOBALS['FORUM_DB'])) && ($GLOBALS['SITE_DB']->connection_write!=$GLOBALS['FORUM_DB']->connection_write))
		{
			$custom_tags=$GLOBALS['SITE_DB']->query_select('custom_comcode',array('tag_title','tag_description','tag_example','tag_parameters','tag_replace','tag_tag','tag_dangerous_tag','tag_block_tag','tag_textual_tag'),array('tag_enabled'=>1));
			foreach ($custom_tags as $tag)
			{
				$custom_tag_list[$tag['tag_tag']]=$tag;
				if ($tag['tag_textual_tag']==1) $TEXTUAL_TAGS[$tag['tag_tag']]=1;
				if ($tag['tag_dangerous_tag']==1) $DANGEROUS_TAGS[$tag['tag_tag']]=1;
			}
		}
	}

	// From Custom Comcode hooks too
	$hooks=find_all_hooks('systems','comcode');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/comcode/'.filter_naughty_harsh($hook));
		$object=object_factory('Hook_comcode_'.filter_naughty_harsh($hook),true);

		$tag=$object->get_tag();
		$custom_tag_list[$tag['tag_tag']]=$tag;

		if ($tag['tag_textual_tag']==1) $TEXTUAL_TAGS[$tag['tag_tag']]=1;
		if ($tag['tag_dangerous_tag']==1) $DANGEROUS_TAGS[$tag['tag_tag']]=1;
	}

	return array($tag_list,$custom_tag_list);
}

/**
 * Get the Comcode tags in groups
 *
 * @param  ?string		Group Name (NULL: return a specific group)
 * @return array			Returns each Group name as key, values as its tags
 */
function _get_group_tags($group=NULL)
{
	$group_tags=array(
		'dynamic_front_end'=>array('overlay','random','pulse','ticker','shocker','jumping','sections','big_tabs','tabs','carousel','hide','tooltip'),

		'dynamic_back_end'=>array('currency','if_in_group'),

		'structure'=>array('title','contents','include','concepts','concept','staff_note','menu','surround'),

		'formatting'=>array('list','indent','ins','del','b','u','i','s','sup','sub','size','color','highlight','font','align','left','center','right','abbr','box','quote'),

		'semantic'=>array('cite','samp','q','var','dfn','address'),

		'display_code'=>array('codebox','code','tt','no_parse'),

		'execute_code'=>array('semihtml','html'),

		'media'=>array('img','thumb','flash','media'),

		'linking'=>array('url','email','reference','page','snapback','post','topic'),
	);

	// Non-categorised ones
	$all_tags=_get_details_comcode_tags();
	$not_found=array();
	foreach (array_keys($all_tags[0]+$all_tags[1]) as $tag)
	{
		if (in_array($tag,array('attachment'))) continue; // Explicitly don't want to allow these (attachment will already be listed if allowed)
		foreach ($group_tags as $_group)
		{
			if (in_array($tag,$_group))
			{
				continue 2;
			}
		}
		$not_found[]=$tag;
	}
	$group_tags['CUSTOM']=$not_found;

	if ($group!==NULL && array_key_exists($group,$group_tags))
		return $group_tags[$group];

	return $group_tags;
}

/**
 * Get the non-WYSIWYG tags (ones the WYSIWYG cannot do itself, so are needed even if it is on)
 *
 * @return array			List of non-WYSIWYG tags
 */
function _get_non_wysiwyg_tags()
{
	$ret=array(
		'indent',
		'del',
		'ins',
		'u',
		'highlight',
		'abbr',
		'cite',
		'samp',
		'q',
		'var',
		'dfn',
		'address',
		'contents',
		'include',
		'concepts',
		'concept',
		'staff_note',
		'menu',
		'surround',
		'tt',
		'no_parse',
		'overlay',
		'random',
		'pulse',
		'ticker',
		'shocker',
		'jumping',
		'sections',
		'big_tabs',
		'tabs',
		'carousel',
		'hide',
		'tooltip',
		'currency',
		'if_in_group',
		'flash',
		'media',
		'thumb',
		'reference',
		'snapback',
		'post',
		'topic',
		'attachment',
	);

	return $ret;
}

/**
 * Outputs a Comcode tag helper dialog.
 */
function comcode_helper_script()
{
	require_lang('comcode');
	$type=get_param('type','step1');

	require_code('comcode_compiler');

	if ($type=='step1')
	{
		$content=comcode_helper_script_step1();
	}

	elseif ($type=='step2')
	{
		$content=comcode_helper_script_step2();
	}

	elseif ($type=='step3')
	{
		$content=comcode_helper_script_step3();
	}

	$echo=do_template('STANDALONE_HTML_WRAP',array('_GUID'=>'c1f229be68a1137c5b418b0d5d8a7ccf','TITLE'=>do_lang_tempcode('COMCODE_HELPER'),'POPUP'=>true,'CONTENT'=>$content));
	exit($echo->evaluate());
	$echo->handle_symbol_preprocessing();
	$echo->evaluate_echo();
}

/**
 * Render a step of the Comcode tag helper dialog.
 *
 * @return tempcode			The step UI.
 */
function comcode_helper_script_step1()
{
	global $DANGEROUS_TAGS;

	list($tag_list,$custom_tag_list)=_get_details_comcode_tags();

	$title=get_screen_title('COMCODE_TAG');
	$keep=symbol_tempcode('KEEP');
	$comcode_groups='';
	$groups=_get_group_tags();

	$non_wysiwyg_tags=_get_non_wysiwyg_tags();
	$in_wysiwyg=get_param_integer('in_wysiwyg',0)==1;

	foreach ($groups as $groupname=>$grouptags)
	{
		sort($grouptags);

		$comcode_types='';
		foreach ($grouptags as $tag)
		{
			$custom=array_key_exists($tag,$custom_tag_list);
			if (($in_wysiwyg) && (!$custom) && (!in_array($tag,$non_wysiwyg_tags))) continue;

			if ((array_key_exists($tag,$DANGEROUS_TAGS)) && (!has_privilege(get_member(),'comcode_dangerous'))) continue;

			if ($custom)
			{
				$description=make_string_tempcode(escape_html(is_integer($custom_tag_list[$tag]['tag_description'])?get_translated_text($custom_tag_list[$tag]['tag_description']):$custom_tag_list[$tag]['tag_description']));
			} else
			{
				$description=do_lang_tempcode('COMCODE_TAG_'.$tag);
			}

			$url=find_script('comcode_helper').'?type=step2&tag='.urlencode($tag).'&field_name='.get_param('field_name').$keep->evaluate();
			if (get_param('utheme','')!='') $url.='&utheme='.get_param('utheme');
			$link_caption=escape_html($tag);
			$usage='';

			$comcode_types.=static_evaluate_tempcode(do_template('BLOCK_HELPER_BLOCK_CHOICE',array('_GUID'=>'bf0d7ae2e7de61e1f079ebd80423b60d','USAGE'=>$usage,'DESCRIPTION'=>$description,'URL'=>$url,'LINK_CAPTION'=>$link_caption)));
		}
		if ($comcode_types!='')
			$comcode_groups.=static_evaluate_tempcode(do_template('BLOCK_HELPER_BLOCK_GROUP',array('_GUID'=>'e14a9199c8a104005978567feab7413f','IMG'=>NULL,'TITLE'=>do_lang_tempcode('COMCODE_GROUP_'.$groupname),'LINKS'=>$comcode_types)));
	}
	return do_template('BLOCK_HELPER_START',array('_GUID'=>'d2d6837cdd8b19d80ea95ab9f5d09c9a','GET'=>true,'TITLE'=>$title,'LINKS'=>$comcode_groups));
}

/**
 * Render a step of the Comcode tag helper dialog.
 *
 * @return tempcode			The step UI.
 */
function comcode_helper_script_step2()
{
	global $TEXTUAL_TAGS;

	list($tag_list,$custom_tag_list)=_get_details_comcode_tags();

	require_code('form_templates');

	// Find tag; with some jiggery-pokery for the 'attachment_safe' tag
	$actual_tag=get_param('tag');
	if ((!isset($tag_list[$actual_tag])) && (!isset($custom_tag_list[$actual_tag])) && ($actual_tag!='attachment_safe'))
		warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
	$tag=($actual_tag=='attachment_safe')?'attachment':$actual_tag;

	$title=get_screen_title('_COMCODE_HELPER',true,array($tag));

	// Data will write through to here
	$fields=new ocp_tempcode();
	$fields_advanced=new ocp_tempcode();
	$done_tag_contents=false;
	$hidden=new ocp_tempcode();
	$javascript='';

	$preview=true; // Whether we can preview the tag

	// Find default settings (typically prepopulating an existing tag)
	require_code('comcode_compiler');
	$defaults=parse_single_comcode_tag(get_param('parse_defaults','',true),$actual_tag);
	if (array_key_exists('',$defaults))
	{
		if (html_to_comcode($defaults[''])==$defaults[''])
		{
			$default_embed=$defaults['']; // Simple case, don't confuse user with semihtml gibberish
		} else
		{
			$default_embed='[semihtml]'.$defaults[''].'[/semihtml]';
		}
	} else
	{
		$default_embed=get_param('default','');
	}

	// Some initial settings for the tag
	$embed_required=_find_comcode_tag_embed_required($tag);
	if (isset($custom_tag_list[$tag]['tag_description']))
	{
		$tag_description=protect_from_escaping($custom_tag_list[$tag]['tag_description']);
	} else
	{
		$tag_description=protect_from_escaping(do_lang('COMCODE_TAG_'.$tag));
	}

	if (array_key_exists($tag,$tag_list)) // Normal Comcode tag
	{
		$params=$tag_list[$tag];

		if (!_try_for_special_comcode_tag_all_params_ui($tag,$actual_tag,$fields,$fields_advanced,$hidden,$done_tag_contents,$defaults,$params,$javascript,$preview))
		{
			if (count($params)>0)
			{
				require_code('form_templates');
				foreach ($params as $param)
				{
					$parameter_name=do_lang('COMCODE_TAG_'.$tag.'_NAME_OF_PARAM_'.$param,NULL,NULL,NULL,NULL,false);
					if (is_null($parameter_name)) $parameter_name=titleify($param);

					$descriptiont=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
					$supports_comcode=(strpos($descriptiont,do_lang('BLOCK_IND_SUPPORTS_COMCODE'))!==false);
					$descriptiont=trim(str_replace(do_lang('BLOCK_IND_SUPPORTS_COMCODE'),'',$descriptiont));
					$is_advanced=(strpos($descriptiont,do_lang('BLOCK_IND_ADVANCED'))!==false);
					$descriptiont=trim(str_replace(do_lang('BLOCK_IND_ADVANCED'),'',$descriptiont));

					$default=array_key_exists($param,$defaults)?$defaults[$param]:get_param('default_'.$param,'');
					if (!array_key_exists($param,$defaults))
					{
						$matches=array();
						if (preg_match('#'.do_lang('BLOCK_IND_DEFAULT').': ["\']([^"]*)["\']#Ui',$descriptiont,$matches)!=0)
						{
							$default=$matches[1];
						}
					}
					$descriptiont=preg_replace('#\s*'.do_lang('BLOCK_IND_DEFAULT').': ["\']([^"]*)["\'](?-U)\.?(?U)#Ui','',$descriptiont);

					if (!_try_for_special_comcode_tag_specific_param_ui($tag,$actual_tag,$param,$parameter_name,$descriptiont,$fields,$fields_advanced,$hidden,$default))
					{
						if (substr($descriptiont,0,12)=='0|1 &ndash; ')
						{
							$field=form_input_tick($parameter_name,protect_from_escaping(ucfirst(substr($descriptiont,12))),$param,$default=='1');
						} elseif ((substr($descriptiont,-1)!='.') && (strpos($descriptiont,'|')!==false))
						{
							$list=new ocp_tempcode();
							if (substr($descriptiont,0,1)!='=')
								$list->attach(form_input_list_entry(''));
							foreach (explode('|',$descriptiont) as $item)
							{
								if (strpos($item,'=')!==false)
								{
									list($item,$label)=explode('=',$item,2);

									$list->attach(form_input_list_entry($item,($item==$default),protect_from_escaping($label)));
								} else
								{
									$list->attach(form_input_list_entry($item,($item==$default)));
								}
							}
							$field=form_input_list($parameter_name,'',$param,$list,NULL,false,false);
						} elseif ($param=='width' || $param=='height')
						{
							$field=form_input_integer($parameter_name,protect_from_escaping($descriptiont),$param,($default=='')?NULL:intval($default),false);
						} else
						{
							if ($supports_comcode)
							{
								$field=form_input_line_comcode($parameter_name,protect_from_escaping($descriptiont),$param,$default,false);
							} else
							{
								$field=form_input_line($parameter_name,protect_from_escaping($descriptiont),$param,$default,false);
							}
						}
						if ($is_advanced)
						{
							$fields_advanced->attach($field);
						} else
						{
							$fields->attach($field);
						}
					}
				}

				_try_for_special_comcode_tag_extra_param_ui($tag,$actual_tag,$fields,$fields_advanced,$hidden,$defaults);
			}
		}
	} else // Custom Comcode tag
	{
		$_params=$custom_tag_list[$tag];
		$params=explode(',',$_params['tag_parameters']);
		foreach ($params as $param)
		{
			$description=new ocp_tempcode();
			$fields->attach(form_input_line(preg_replace('#=.*$#','',titleify($param)),protect_from_escaping($description),preg_replace('#=.*$#','',$param),preg_replace('#^.*=#U','',$param),false));
		}
		$tag_description=new ocp_tempcode();
		$tag_description->attach(is_integer($_params['tag_description'])?get_translated_text($_params['tag_description']):$_params['tag_description']);
		$tag_description->attach(paragraph(is_integer($_params['tag_example'])?get_translated_text($_params['tag_example']):$_params['tag_example']));
	}

	if (!_try_for_special_comcode_tag_specific_contents_ui($tag,$actual_tag,$fields,$fields_advanced,$hidden,$default_embed,$javascript,$preview))
	{
		if (!$done_tag_contents)
		{
			$descriptiont=do_lang('COMCODE_TAG_'.$tag.'_EMBED',NULL,NULL,NULL,NULL,false);
			if (is_null($descriptiont)) $descriptiont='';
			$supports_comcode=(strpos($descriptiont,do_lang('BLOCK_IND_SUPPORTS_COMCODE'))!==false);
			$descriptiont=trim(str_replace(do_lang('BLOCK_IND_SUPPORTS_COMCODE'),'',$descriptiont));
			if ($supports_comcode)
			{
				$fields->attach(form_input_line_comcode(do_lang_tempcode('TAG_CONTENTS'),protect_from_escaping($descriptiont),'tag_contents',$default_embed,$embed_required));
			} else
			{
				$fields->attach(form_input_line(do_lang_tempcode('TAG_CONTENTS'),protect_from_escaping($descriptiont),'tag_contents',$default_embed,$embed_required));
			}
		}
	}

	if (!$fields_advanced->is_empty())
	{
		$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('_GUID'=>'2796d7acdd3e237aa2884371712d05d7','SECTION_HIDDEN'=>true,'TITLE'=>do_lang_tempcode('ADVANCED'))));
		$fields->attach($fields_advanced);
	}

	// Further details for the UI...

	$keep=symbol_tempcode('KEEP');
	$post_url=find_script('comcode_helper').'?type=step3&field_name='.get_param('field_name').$keep->evaluate();
	if (get_param('utheme','')!='') $post_url.='&utheme='.get_param('utheme');

	if (get_param('save_to_id','')!='')
	{
		$post_url.='&save_to_id='.urlencode(get_param('save_to_id'));
		$submit_name=do_lang_tempcode('SAVE');

		// Allow remove option
		$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('_GUID'=>'42dccc98beb16c7c6336eb60243fd9db','SECTION_HIDDEN'=>false,'TITLE'=>do_lang_tempcode('ACTIONS'),'HELP'=>'')));
		$fields->attach(form_input_tick(do_lang_tempcode('REMOVE'),'','_delete',false));
	} else
	{
		$submit_name=do_lang_tempcode('USE');
	}

	$text=$tag_description->is_empty()?new ocp_tempcode():do_lang_tempcode('COMCODE_HELPER_2',escape_html($tag),$tag_description);

	if (($tag=='attachment') && (strpos($default_embed,'new_')!==false))
		$text=do_lang_tempcode('COMCODE_ATTACHMENT_WILL_HAVE_MARKER');

	if (($tag=='attachment') && (get_param_integer('multi',0)==1)) $text=do_lang_tempcode('ATTACHMENT_MULTI');

	$hidden->attach(form_input_hidden('tag',$tag));

	return do_template('FORM_SCREEN',array(
		'_GUID'=>'270058349d048a8be6570bba97c81fa2',
		'TITLE'=>$title,
		'JAVASCRIPT'=>$javascript,
		'TARGET'=>'_self',
		'SKIP_VALIDATION'=>true,
		'FIELDS'=>$fields,
		'URL'=>$post_url,
		'TEXT'=>$text,
		'SUBMIT_NAME'=>$submit_name,
		'HIDDEN'=>$hidden,
		'PREVIEW'=>$preview,
		'THEME'=>$GLOBALS['FORUM_DRIVER']->get_theme(),
	));
}

/**
 * Find if a Comcode tag has required contents (hard-coded).
 *
 * @param  ID_TEXT		Tag being read.
 * @return boolean		Whether it has required contents.
*/
function _find_comcode_tag_embed_required($tag)
{
	$embed_required=true;

	if ($tag=='contents') $embed_required=false;

	return $embed_required;
}

/**
 * See if we have specialisation code for a Comcode tag parameter input.
 *
 * @param  ID_TEXT		Tag being read.
 * @param  ID_TEXT		Actual tag being read.
 * @param  tempcode		UI fields.
 * @param  tempcode		Advanced UI fields.
 * @param  tempcode		Hidden fields.
 * @param  boolean		Whether the tag contents input has also been handled here.
 * @param  array			Default parameter values.
 * @param  array			List of tag parameters.
 * @param  string			Javascript to deploy.
 * @param  boolean		Whether previewing will be allowed.
 * @return boolean		Whether we did render specialisation code (if not, standard code will be deployed by the calling function).
*/
function _try_for_special_comcode_tag_all_params_ui($tag,$actual_tag,&$fields,&$fields_advanced,$hidden,&$done_tag_contents,$defaults,$params,&$javascript,$preview)
{
	if ($tag=='include')
	{
		$default_embed=array_key_exists('',$defaults)?($defaults['']):get_param('default','');
		if (strpos($default_embed,':')===false) $default_embed=':'.$default_embed;
		$fields->attach(form_input_page_link(do_lang_tempcode('PAGE'),'','tag_contents',$default_embed,true,NULL,'comcode'));
		$done_tag_contents=true;
	}

	elseif ($tag=='concepts')
	{
		foreach ($params as $param)
		{
			$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
			$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),1));
		}
	}

	elseif ($tag=='jumping')
	{
		foreach ($params as $param)
		{
			$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
			$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),2));
		}
	}

	elseif ($tag=='shocker')
	{
		foreach ($params as $param)
		{
			$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
			if ($param=='left' || $param=='right')
				$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),2));
			else
				$fields->attach(form_input_line(titleify($param),protect_from_escaping($description),$param,'',false));
		}
	}

	elseif ($tag=='random')
	{
		foreach ($params as $param)
		{
			$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
			$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),($param!='X')?2:0));
		}
	}

	elseif ($tag=='sections')
	{
		foreach ($params as $param)
		{
			if ($param=='default')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,1,false));
			}
			elseif ($param=='name')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),2));
			}
		}
	}

	elseif ($tag=='big_tabs')
	{
		foreach ($params as $param)
		{
			if ($param=='default')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,1,false));
			}
			elseif ($param=='name')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),2));
			}
			elseif ($param=='switch_time')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,6000,false));
			}
		}
	}

	elseif ($tag=='tabs')
	{
		foreach ($params as $param)
		{
			if ($param=='default')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,1,false));
			}
			elseif ($param=='name')
			{
				$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
				$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,array(),2));
			}
		}
	}
	else return false;

	return true;
}

/**
 * See if we have specialisation code for a Comcode tag parameter input.
 *
 * @param  ID_TEXT		Tag being read.
 * @param  ID_TEXT		Actual tag being read.
 * @param  ID_TEXT		The parameter.
 * @param  string			Default human-readable name of the parameter.
 * @param  string			Default description of the parameter.
 * @param  tempcode		UI fields.
 * @param  tempcode		Advanced UI fields.
 * @param  tempcode		Hidden fields.
 * @param  string			Default parameter value.
 * @return boolean		Whether we did render specialisation code (if not, standard code will be deployed by the calling function).
*/
function _try_for_special_comcode_tag_specific_param_ui($tag,$actual_tag,$param,$parameter_name,$descriptiont,&$fields,&$fields_advanced,$hidden,$default)
{
	// Don't show fields that can't apply across multiple attachments
	if (($tag=='attachment') && (get_param_integer('multi',0)==1) && (($param=='description') || ($param=='filename') || ($param=='thumb_url')))
		return true; // Consider 'handled' already

	if ((($tag=='attachment') || ($tag=='media')) && ($param=='type'))
	{
		$list=new ocp_tempcode();
		$list->attach(form_input_list_entry('',$default=='',do_lang('MEDIA_TYPE_')));
		$hooks=find_all_hooks('systems','media_rendering');
		foreach (array_keys($hooks) as $hook)
		{
			require_code('hooks/systems/media_rendering/'.$hook);
			$ob=object_factory('Hook_media_rendering_'.$hook);
			$hooks[$hook]=$ob->get_type_label();
		}
		asort($hooks);
		foreach ($hooks as $hook=>$label)
		{
			$list->attach(form_input_list_entry($hook,$default==$hook,$label));
		}
		if ($tag=='attachment')
			$list->attach(form_input_list_entry('extract',$default=='extract'/* || get_param_integer('is_archive',0)==1  Too assumptive*/,do_lang_tempcode('MEDIA_TYPE_extract')));
		$fields_advanced->attach(form_input_list($parameter_name,$descriptiont,$param,$list,NULL,false,false));
	}

	elseif ((($tag=='attachment') || ($tag=='media')) && ($param=='thumb_url') && (addon_installed('filedump')))
	{
		$set_name='thumbnail';
		$required=false;
		$set_title=do_lang_tempcode('THUMBNAIL');
		$field_set=alternate_fields_set__start($set_name);

		$field_set->attach(form_input_line(do_lang_tempcode('URL'),$default,'thumb_url__a',$default,false));

		$filedump_url=build_url(array('page'=>'filedump'),get_module_zone('filedump'));
		$field_set->attach(form_input_tree_list(do_lang_tempcode('filedump:FILE_DUMP'),do_lang_tempcode('COMCODE_TAG_'.(($tag=='attachment')?'attachment':'media').'_PARAM_thumb_url',escape_html($filedump_url->evaluate())),'thumb_url__b','','choose_filedump_file',array('only_images'=>true),false,$default,false));

		$fields_advanced->attach(alternate_fields_set__end($set_name,$set_title,'',$field_set,$required,$default));
	}

	elseif (($tag=='page') && ($param=='param') && (substr_count($default,':')==1))
	{
		$fields->attach(form_input_page_link($parameter_name,protect_from_escaping($descriptiont),$param,$default,true,NULL));
	}
	else return false;

	return true;
}

/**
 * See if we have specialisation code for inserting an extra Comcode tag parameter input.
 *
 * @param  ID_TEXT		Tag being read.
 * @param  ID_TEXT		Actual tag being read.
 * @param  tempcode		UI fields.
 * @param  tempcode		Advanced UI fields.
 * @param  tempcode		Hidden fields.
 * @param  array			Default parameter values.
*/
function _try_for_special_comcode_tag_extra_param_ui($tag,$actual_tag,&$fields,&$fields_advanced,$hidden,$defaults)
{
	if ($tag=='attachment')
	{
		if (get_option('eager_wysiwyg')=='0')
		{
			if ((!isset($_COOKIE)) || ($_COOKIE['use_wysiwyg']!='0'))
			{
				$field=form_input_tick(do_lang_tempcode('COMCODE_TAG_attachment_safe'),do_lang_tempcode('COMCODE_TAG_attachment_safe_DESCRIPTION'),'_safe',$actual_tag=='attachment_safe');
				$fields->attach($field);
			}
		}
	}
}

/**
 * See if we have specialisation code for Comcode tag contents input.
 *
 * @param  ID_TEXT		Tag being read.
 * @param  ID_TEXT		Actual tag being read.
 * @param  tempcode		UI fields.
 * @param  tempcode		Advanced UI fields.
 * @param  tempcode		Hidden fields.
 * @param  string			Default embed contents.
 * @param  string			Javascript to deploy.
 * @param  boolean		Whether previewing will be allowed.
 * @return boolean		Whether we did render specialisation code (if not, standard code will be deployed by the calling function).
*/
function _try_for_special_comcode_tag_specific_contents_ui($tag,$actual_tag,&$fields,&$fields_advanced,$hidden,$default_embed,&$javascript,&$preview)
{
	global $TEXTUAL_TAGS;

	if (($tag=='media') && (addon_installed('filedump')))
	{
		$set_name='file';
		$required=true;
		$set_title=do_lang_tempcode('FILE');
		$field_set=alternate_fields_set__start($set_name);

		$field_set->attach(form_input_line(do_lang_tempcode('URL'),'','tag_contents__a',$default_embed,false));

		$filedump_url=build_url(array('page'=>'filedump'),get_module_zone('filedump'));
		$field_set->attach(form_input_tree_list(do_lang_tempcode('filedump:FILE_DUMP'),do_lang_tempcode('COMCODE_TAG_media_EMBED_FILE',escape_html($filedump_url->evaluate())),'tag_contents__b','','choose_filedump_file',array(),false,'',false));

		$fields->attach(alternate_fields_set__end($set_name,$set_title,'',$field_set,$required,$default_embed));
	}

	elseif ($tag=='attachment')
	{
		if (get_option('eager_wysiwyg')=='0')
		{
			if ((!isset($_COOKIE)) || ($_COOKIE['use_wysiwyg']!='0'))
			{
				$javascript.="document.getElementById('framed').onchange=function() { document.getElementById('_safe').checked=!this.checked; };";
			}
		}

		$hidden->attach(form_input_hidden('tag_contents',$default_embed));
		$tag_description=new ocp_tempcode();

		if (substr($default_embed,0,4)=='new_') $preview=false;
	}

	elseif (($tag=='sections') || ($tag=='big_tabs') || ($tag=='tabs') || ($tag=='list'))
	{
		$fields->attach(form_input_text_multi(do_lang_tempcode('TAG_CONTENTS'),protect_from_escaping(do_lang('COMCODE_TAG_'.$tag.'_EMBED')),'tag_contents',explode(',',$default_embed),2));
	}

	elseif ((array_key_exists($tag,$TEXTUAL_TAGS)) || ($tag=='menu'))
	{
		if (($tag=='menu') && ($default_embed==''))
		{
			$default_embed='-contracted section
+expanded section
 page=URL
 page=URL
+expanded section
page=URL
page=URL';
		}
		$descriptiont=do_lang('COMCODE_TAG_'.$tag.'_EMBED');
		$descriptiont=trim(str_replace(do_lang('BLOCK_IND_SUPPORTS_COMCODE'),'',$descriptiont));
		$fields->attach(form_input_text_comcode(do_lang_tempcode('TAG_CONTENTS'),protect_from_escaping(do_lang('COMCODE_TAG_'.$tag.'_EMBED')),'tag_contents',$default_embed,true,NULL,true));
	}
	else return false;

	return true;
}

/**
 * Render a step of the Comcode tag helper dialog.
 *
 * @return tempcode			The step UI.
 */
function comcode_helper_script_step3()
{
	require_javascript('javascript_posting');
	require_javascript('javascript_editing');

	$field_name=get_param('field_name');
	$tag=post_param('tag');
	$title=get_screen_title('_COMCODE_HELPER',true,array($tag));

	if (get_option('eager_wysiwyg')=='0')
	{
		if (($tag=='attachment') && (post_param_integer('_safe',0)==1) && ((!isset($_COOKIE)) || ($_COOKIE['use_wysiwyg']!='0')))
			$tag='attachment_safe';
	}

	$comcode=_get_preview_environment_comcode($tag);

	$comcode_semihtml=comcode_to_tempcode($comcode,NULL,false,60,NULL,NULL,true,false,false);

	return do_template('BLOCK_HELPER_DONE',array('_GUID'=>'d5d5888d89b764f81769823ac71d0827','TITLE'=>$title,'FIELD_NAME'=>$field_name,'BLOCK'=>$tag,'COMCODE'=>$comcode,'COMCODE_SEMIHTML'=>$comcode_semihtml));
}

/**
 * Reads a Comcode tag from the POST environment.
 *
 * @param  ID_TEXT		Tag being read.
 * @return string			The full Comcode for that tag.
*/
function _get_preview_environment_comcode($tag)
{
	$actual_tag=$tag;
	if ($tag=='attachment_safe') $tag='attachment';

	$comcode='';
	list($tag_list,$custom_tag_list)=_get_details_comcode_tags();

	if (array_key_exists($tag,$tag_list))
	{
		$parameters=$tag_list[$tag];
	} else
	{
		$_params=$custom_tag_list[$tag];
		$parameters=explode(',',preg_replace('#=[^,]*#','',$_params['tag_parameters']));
	}
	if (in_array('param',$parameters))
	{
		$_parameters=array('param');
		unset($parameters[array_search('param',$parameters)]);
		$parameters=array_merge($_parameters,$parameters);
	}
	$bparameters='';

	$tag_contents=post_param('tag_contents',post_param('tag_contents__a',post_param('tag_contents__b','')));

	if ($tag=='include')
	{
		$tag_contents=preg_replace('# .*$#','',$tag_contents);
		$_tag_contents=explode(':',$tag_contents,2);
		$bparameters=' param="'.str_replace('"','\"',$_tag_contents[0]).'"';
		$tag_contents=$_tag_contents[1];
	}

	elseif ($tag=='concepts')
	{
		$i=0;
		while (post_param('x_key_'.strval($i),'')!='')
		{
			$value=str_replace('"','\"',post_param('x_key_'.strval($i)));
			$bparameters.=' '.strval($i+1).'_key="'.$value.'"';
			$bparameters.=' '.strval($i+1).'_value="'.$value.'"';

			$i++;
		}
	}

	elseif ($tag=='jumping')
	{
		$i=0;
		while (post_param('string_'.strval($i),'')!='')
		{
			$value=str_replace('"','\"',post_param('string_'.strval($i)));
			$bparameters.=' '.strval($i).'="'.$value.'"';
			$i++;
		}
	}

	elseif ($tag=='shocker')
	{
		$i=0;
		while(post_param('left_'.strval($i),'') != '')
		{
			$left=str_replace('"','\"',post_param('left_'.strval($i)));
			$right=str_replace('"','\"',post_param('right_'.strval($i),''));
			$bparameters.=' left_'.strval($i+1).'="'.$left.'"';
			$bparameters.=' right_'.strval($i+1).'="'.$right.'"';
			$i++;
		}
		if (post_param('min','') != '')
			$bparameters.=' min="'.str_replace('"','\"',post_param('min')).'"';
		if (post_param('max','') != '')
			$bparameters.=' max="'.str_replace('"','\"',post_param('max')).'"';
	}

	elseif ($tag=='random')
	{
		$i=0;
		$last=0;
		while (post_param('string_'.strval($i),'')!='')
		{
			$name=str_replace('"','\"',post_param('X_'.strval($i),''));
			if ($name=='') $name=strval($last+1);
			$value=str_replace('"','\"',post_param('string_'.strval($i)));
			$bparameters.=' '.$name.'="'.$value.'"';
			$i++;
			$last=intval($name);
		}
	}

	elseif ($tag=='sections')
	{
		$i=0;
		$default=post_param_integer('default',0);
		$comcode='';
		$controller=array();
		while (post_param('tag_contents_'.strval($i),'')!='' && post_param('name_'.strval($i),'')!='')
		{
			$def='';
			$content=post_param('tag_contents_'.strval($i));
			$name=post_param('name_'.strval($i));
			if ($default==($i+1))
			{
				$def=' default="1"';
			}
			$comcode.="[section=\"$name\"$def]".$content."[/section]";
			$controller[]=$name;
			$i++;
		}
		$comcode.='[section_controller]'.implode(',',$controller).'[/section_controller]';
	}

	elseif ($tag=='big_tabs')
	{
		$i=0;
		$default=post_param_integer('default',0);
		$time=post_param_integer('switch_time', 6000);
		$comcode='';
		$controller=array();
		while (post_param('tag_contents_'.strval($i),'')!='' && post_param('name_'.strval($i),'')!='')
		{
			$def='';
			$content=post_param('tag_contents_'.strval($i));
			$name=post_param('name_'.strval($i));
			if ($default==($i+1))
			{
				$def=' default="1"';
			}
			$comcode.="[big_tab=\"$name\"$def]".$content."[/big_tab]";
			$controller[]=$name;
			$i++;
		}
		$comcode='[surround][big_tab_controller switch_time="'.strval($time).'"]'.implode(',',$controller).'[/big_tab_controller]'.$comcode.'[/surround]';
	}

	elseif ($tag=='tabs')
	{
		$i=0;
		$default=post_param_integer('default',0);
		$comcode='';
		$controller=array();
		while (post_param('tag_contents_'.strval($i),'')!='' && post_param('name_'.strval($i),'')!='')
		{
			$def='';
			$content=post_param('tag_contents_'.strval($i));
			$name=post_param('name_'.strval($i));
			if ($default==($i+1))
			{
				$def=' default="1"';
			}
			$comcode.="[tab=\"$name\"$def]".$content."[/tab]";
			$controller[]=$name;
			$i++;
		}
		$comcode='[tabs="'.implode(',',$controller).'"]'.$comcode.'[/tabs]';
	}

	elseif ($tag=='list')
	{
		$i=0;
		$defaults=post_param('default','normal');
		$comcode_arr=array();
		while (post_param('tag_contents_'.strval($i),'')!='')
		{
			$def='';
			$contents=post_param('tag_contents_'.strval($i));
			$comcode_arr[]=$contents;
			$i++;
		}
		$comcode="[list default=\"$defaults\"]".implode("[*]", $comcode_arr)."[/list]";
	}

	else
	{
		foreach ($parameters as $parameter)
		{
			$value=post_param($parameter,post_param($parameter.'__a',post_param($parameter.'__b','')));

			if ($value=='')
			{
				$explicit_false=(($tag=='attachment') || ($tag=='media')) && (($parameter=='thumb') || ($parameter=='framed'));
				if ($explicit_false)
				{
					$value='0';
				}
			}

			if ($value!='')
			{
				if ($parameter=='param')
				{
					$bparameters.='="'.str_replace('"','\"',$value).'"';
				} else
				{
					$bparameters.=' '.$parameter.'="'.str_replace('"','\"',$value).'"';
				}
			}
		}
	}

	if ($comcode=='')
		$comcode='['.$actual_tag.$bparameters.']'.$tag_contents.'[/'.$actual_tag.']';

	return $comcode;
}
