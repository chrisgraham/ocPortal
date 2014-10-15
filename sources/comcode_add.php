<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_rich_media
 */

/**
 * Get some metadata of what Comcode tags we have.
 *
 * @return array			A pair: core tags (map to tag parameters), custom tags (map to custom Comcode row).
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
		'php'=>array('scroll','numbers'),
		'codebox'=>array('param','numbers'),
		'sql'=>array('scroll','numbers'),
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
		/*'section_controller'=>array(),*/
		'big_tabs'=>array('default','switch_time','name'),
		/*'big_tab_controller'=>array(),*/
		/*'tab'=>array('param'),*/
		'tabs'=>array('default','name'),
		'carousel'=>array('param'),
		'hide'=>array('param'),
		'tooltip'=>array('param'),
		'currency'=>array('param','bracket'),
		/*'block'=>array(),*/
		'if_in_group'=>array('param','type'),
		'flash'=>array('param'),
		'img'=>array('align','float','param','title','rollover','refresh_time'),
		'upload'=>array('type','param'),
		'exp_thumb'=>array('float'),
		'exp_ref'=>array('param'),
		'thumb'=>array('align','param','caption','float'),
		'url'=>array('param','title','target','rel'),
		'email'=>array('param','title','subject','body'),
		'reference'=>array('type','param'),
		'page'=>array('param'),
		'snapback'=>array('param','forum'),
		'post'=>array('param','forum'),
		'topic'=>array('param','forum'),
		'attachment'=>array('description','filename','type','thumb','float','align','width','height','thumb_url'),
	);
	//'attachment_safe'=>array('description','filename','type','width','height','align','float','thumb_url'),	Merged into attachment in UI
	ksort($tag_list);
	/* // Helps find missing tags
	unset($VALID_COMCODE_TAGS['section']);
	unset($VALID_COMCODE_TAGS['section_controller']);
	unset($VALID_COMCODE_TAGS['tab']);
	unset($VALID_COMCODE_TAGS['big_tab']);
	unset($VALID_COMCODE_TAGS['big_tab_cntroller']);
	unset($VALID_COMCODE_TAGS['acronym']);
	unset($VALID_COMCODE_TAGS['internal_table']);
	unset($VALID_COMCODE_TAGS['external_table']);
	unset($VALID_COMCODE_TAGS['acronym']);
	unset($VALID_COMCODE_TAGS['block']);
	unset($VALID_COMCODE_TAGS['attachment']);
	unset($VALID_COMCODE_TAGS['attachment_safe']);
	unset($VALID_COMCODE_TAGS['thread']);
	foreach (array_keys($tag_list) as $tag)
	{
		global $VALID_COMCODE_TAGS;
		unset($VALID_COMCODE_TAGS[$tag]);
	}
	@var_dump($VALID_COMCODE_TAGS);exit();*/
	$custom_tag_list=array();

	global $DANGEROUS_TAGS,$TEXTUAL_TAGS;

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

	// From Comcode hooks
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
 * Get the comcode tags in groups
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
		'display_code'=>array('php','codebox','sql','code','tt','no_parse'),
		'execute_code'=>array('semihtml','html'),
		'media'=>array('flash','img'/*Over complex,'upload','exp_thumb','exp_ref'*/,'thumb'),
		'linking'=>array('url','email','reference','page','snapback','post','topic')
	);

	if (addon_installed('filedump')) $group_tags['media'][]='attachment';

	// Non-categorised ones
	$all_tags=_get_details_comcode_tags();
	$not_found=array();
	foreach (array_keys($all_tags[0]+$all_tags[1]) as $tag)
	{
		if (in_array($tag,array('exp_thumb','exp_ref','upload','attachment'))) continue; // Explicitly don't want to allow these (attachment will already be listed if allowed)
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
 * Get the non-WYSIWYG tags (ones the WYSWIWYG cannot do itself, so are needed even if it is on)
 *
 * @return array			List of non-WYSIWYG tags
 */
function _get_non_wysiwyg_tags()
{
	$ret=array('indent','del','ins','u','highlight','abbr','cite','samp','q','var','dfn','address','contents','include','concepts','concept','staff_note','menu','surround','tt','no_parse','overlay','random','pulse','ticker','shocker','jumping','sections','big_tabs','tabs','carousel','hide','tooltip','currency','if_in_group','flash','upload','exp_thumb','exp_ref','thumb','reference','snapback','post','topic','attachment');
	return $ret;
}

/**
 * Outputs a Comcode tag helper dialog.
 */
function comcode_helper_script()
{
	require_lang('comcode');
	$type=get_param('type','step1');

	list($tag_list,$custom_tag_list)=_get_details_comcode_tags();

	require_code('comcode_text');

	global $DANGEROUS_TAGS,$TEXTUAL_TAGS;

	if ($type=='step1')
	{
		$title=get_screen_title('COMCODE_TAG');
		$keep=symbol_tempcode('KEEP');
		$comcode_groups='';
		$groups=_get_group_tags();

		$non_wysiwyg_tags=_get_non_wysiwyg_tags();
		$in_wysiwyg=get_param_integer('in_wysiwyg',0)==1;

		foreach($groups as $groupname=>$grouptags)
		{
			sort($grouptags);

			$comcode_types='';
			foreach ($grouptags as $tag)
			{
				$custom=array_key_exists($tag,$custom_tag_list);
				if (($in_wysiwyg) && (!$custom) && (!in_array($tag,$non_wysiwyg_tags))) continue;

				if ((array_key_exists($tag,$DANGEROUS_TAGS)) && (!has_specific_permission(get_member(),'comcode_dangerous'))) continue;

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
				$comcode_groups.=static_evaluate_tempcode(do_template('BLOCK_HELPER_BLOCK_GROUP',array('IMG'=>NULL,'TITLE'=>do_lang_tempcode('COMCODE_GROUP_'.$groupname),'LINKS'=>$comcode_types)));
		}
		$content=do_template('BLOCK_HELPER_START',array('_GUID'=>'d2d6837cdd8b19d80ea95ab9f5d09c9a','GET'=>true,'TITLE'=>$title,'LINKS'=>$comcode_groups));
	}
	elseif ($type=='step2')
	{
		require_code('form_templates');

		$actual_tag=get_param('tag');
		if ((!isset($tag_list[$actual_tag])) && (!isset($custom_tag_list[$actual_tag])) && ($actual_tag!='attachment_safe'))
			warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
		$tag=$actual_tag;
		if ($tag=='attachment_safe') $tag='attachment';

		$title=get_screen_title('_COMCODE_HELPER',true,array($tag));

		$fields=new ocp_tempcode();
		$fields_advanced=new ocp_tempcode();
		$done_tag_contents=false;
		$hidden=new ocp_tempcode();

		$javascript='';

		$preview=true;

		require_code('comcode_text');
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

		$embed_required=true;
		if ($tag=='contents') $embed_required=false;

		if (isset($custom_tag_list[$tag]['tag_description']))
		{
			$tag_description=protect_from_escaping($custom_tag_list[$tag]['tag_description']);
		} else
		{
			$tag_description=protect_from_escaping(do_lang('COMCODE_TAG_'.$tag));
		}

		if (array_key_exists($tag,$tag_list))
		{
			$params=$tag_list[$tag];
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
					$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),1));
				}
			}
			elseif ($tag=='jumping')
			{
				foreach ($params as $param)
				{
					$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
					$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),2));
				}
			}
			elseif ($tag=='shocker')
			{
				foreach ($params as $param)
				{
					$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
					if ($param=='left' || $param=='right')
					{
						$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),2));
					} else
					{
						$default=array_key_exists($param,$defaults)?$defaults[$param]:get_param('default_'.$param,'');
						$fields->attach(form_input_line(titleify($param),protect_from_escaping($description),$param,$default,false));
					}
				}
			}
			elseif ($tag=='random')
			{
				foreach ($params as $param)
				{
					$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
					$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),($param!='X')?2:0));
				}
			}
			elseif ($tag=='sections')
			{
				foreach ($params as $param)
				{
					if($param=='default')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$default=array_key_exists($param,$defaults)?$defaults[$param]:get_param('default_'.$param,'1');
						$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,intval($default),false));
					}
					elseif($param=='name')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),2));
					}
				}
			}
			elseif ($tag=='big_tabs')
			{
				foreach ($params as $param)
				{
					if($param=='default')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$default=array_key_exists($param,$defaults)?$defaults[$param]:get_param('default_'.$param,'1');
						$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,intval($default),false));
					}
					elseif($param=='name')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),2));
					}
					elseif($param=='switch_time')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$default=array_key_exists($param,$defaults)?$defaults[$param]:get_param('default_'.$param,'6000');
						$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,intval($default),false));
					}
				}
			}
			elseif ($tag=='tabs')
			{
				foreach ($params as $param)
				{
					if($param=='default')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$default=array_key_exists($param,$defaults)?$defaults[$param]:get_param('default_'.$param,'1');
						$fields->attach(form_input_integer(titleify($param),protect_from_escaping($description),$param,intval($default),false));
					}
					elseif($param=='name')
					{
						$description=do_lang('COMCODE_TAG_'.$tag.'_PARAM_'.$param);
						$fields->attach(form_input_line_multi(titleify($param),protect_from_escaping($description),$param,get_defaults_multi($defaults,$param),2));
					}
				}
			}
			else
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

						if (($tag=='page') && ($param=='param') && (substr_count($default,':')==1))
						{
							$fields->attach(form_input_page_link($parameter_name,protect_from_escaping($descriptiont),$param,$default,true,NULL));
						}
						elseif (($tag=='attachment') && ($param=='thumb_url') && (addon_installed('filedump')))
						{
							$field=form_input_tree_list(do_lang_tempcode('THUMBNAIL'),do_lang_tempcode('COMCODE_TAG_attachment_PARAM_thumb_url'),'thumb_url','','choose_filedump_file',array('only_images'=>true),false,$default,false);
							$fields_advanced->attach($field);
						} else
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

										// Simplify the choices
										if ($tag=='attachment')
										{
											if (($item=='inline_extract') && (get_param_integer('is_archive',NULL)===0)) continue;
											if (($item=='island_extract') && (get_param_integer('is_archive',NULL)===0)) continue;

											if (($item=='inline') && (get_param_integer('is_image',NULL)===0)) continue;
											if (($item=='island') && (get_param_integer('is_image',NULL)===0)) continue;

											if (($item=='code') && ((get_param_integer('is_image',NULL)===1) || (get_param_integer('is_archive',NULL)===1))) continue;

											if (($item=='mail') && (get_param('default_type',NULL)!==NULL)) continue;
										}

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

					if ($tag=='attachment')
					{
						if (get_option('eager_wysiwyg')=='0')
						{
							$field=form_input_tick(do_lang_tempcode('COMCODE_TAG_attachment_safe'),do_lang_tempcode('COMCODE_TAG_attachment_safe_DESCRIPTION'),'_safe',$actual_tag=='attachment_safe');
							$fields_advanced->attach($field);
						}
					}
				}
			}
		} else
		{
			$_params=$custom_tag_list[$tag];
			$params=explode(',',$_params['tag_parameters']);
			foreach ($params as $param)
			{
				$description=new ocp_tempcode();
				$fields->attach(form_input_line(preg_replace('#=.*$#','',ucwords(str_replace('_',' ',$param))),protect_from_escaping($description),preg_replace('#=.*$#','',$param),preg_replace('#^.*=#U','',$param),false));
			}
			$tag_description=new ocp_tempcode();
			$tag_description->attach(is_integer($_params['tag_description'])?get_translated_text($_params['tag_description']):$_params['tag_description']);
			$tag_description->attach(paragraph(is_integer($_params['tag_example'])?get_translated_text($_params['tag_example']):$_params['tag_example']));
		}

		if ($tag=='attachment')
		{
			if (get_option('eager_wysiwyg')=='0')
			{
				$javascript.="document.getElementById('type').onchange=function() { document.getElementById('_safe').checked=(this.options[this.selectedIndex].value=='inline'); };";
			}

			if (($default_embed!='') || (!addon_installed('filedump')))
			{
				$hidden->attach(form_input_hidden('tag_contents',$default_embed));
				$tag_description=new ocp_tempcode();

				if (substr($default_embed,0,4)=='new_') $preview=NULL;
			} else
			{
				$filedump_url=build_url(array('page'=>'filedump'),get_module_zone('filedump'));
				$fields->attach(form_input_tree_list(do_lang_tempcode('FILE'),do_lang_tempcode('COMCODE_TAG_attachment_EMBED_FILE',escape_html($filedump_url->evaluate())),'tag_contents','','choose_filedump_file',array('attachment_ready'=>true),true,'',false));
			}
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
			$fields->attach(form_input_text_comcode(do_lang_tempcode('TAG_CONTENTS'),protect_from_escaping(do_lang('COMCODE_TAG_'.$tag.'_EMBED')),'tag_contents',$default_embed,$embed_required,NULL,true));
		}
		else
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
			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('SECTION_HIDDEN'=>true,'TITLE'=>do_lang_tempcode('ADVANCED'))));
			$fields->attach($fields_advanced);
		}

		$keep=symbol_tempcode('KEEP');
		$post_url=find_script('comcode_helper').'?type=step3&field_name='.get_param('field_name').$keep->evaluate();
		if (get_param('utheme','')!='') $post_url.='&utheme='.get_param('utheme');

		if (get_param('save_to_id','')!='')
		{
			$post_url.='&save_to_id='.urlencode(get_param('save_to_id'));
			$submit_name=do_lang_tempcode('SAVE');

			// Allow remove option
			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('SECTION_HIDDEN'=>false,'TITLE'=>do_lang_tempcode('ACTIONS'),'HELP'=>'')));
			$fields->attach(form_input_tick(do_lang_tempcode('REMOVE'),'','_delete',false));
		} else
		{
			$submit_name=do_lang_tempcode('USE');
		}

		$text=$tag_description->is_empty()?new ocp_tempcode():do_lang_tempcode('COMCODE_HELPER_2',escape_html($tag),$tag_description);
		$hidden->attach(form_input_hidden('tag',$tag));
		$content=do_template('FORM_SCREEN',array('_GUID'=>'270058349d048a8be6570bba97c81fa2','TITLE'=>$title,'JAVASCRIPT'=>$javascript,'TARGET'=>'_self','SKIP_VALIDATION'=>true,'FIELDS'=>$fields,'URL'=>$post_url,'TEXT'=>$text,'SUBMIT_NAME'=>$submit_name,'HIDDEN'=>$hidden,'PREVIEW'=>$preview,'THEME'=>$GLOBALS['FORUM_DRIVER']->get_theme()));
	}
	elseif ($type=='step3')
	{
		require_javascript('javascript_posting');
		require_javascript('javascript_editing');

		$field_name=get_param('field_name');
		$tag=post_param('tag');
		$title=get_screen_title('_COMCODE_HELPER',true,array($tag));

		if (get_option('eager_wysiwyg')=='0')
		{
			if (($tag=='attachment') && (post_param_integer('_safe',0)==1)) $tag='attachment_safe';
		}

		list($comcode,$bparameters)=_get_preview_environment_comcode($tag);
		if ($tag=='sections' || $tag=='big_tabs' || $tag=='tabs' || $tag=='list')
			$comcode_xml=$bparameters;
		else
			$comcode_xml='<'.$tag.$bparameters.'>'.post_param('tag_contents','').'</'.$tag.'>';

		$comcode_semihtml=comcode_to_tempcode($comcode,NULL,false,60,NULL,NULL,true,false,false);

		$content=do_template('BLOCK_HELPER_DONE',array('_GUID'=>'d5d5888d89b764f81769823ac71d0827','TITLE'=>$title,'FIELD_NAME'=>$field_name,'BLOCK'=>$tag,'COMCODE_XML'=>$comcode_xml,'COMCODE'=>$comcode,'COMCODE_SEMIHTML'=>$comcode_semihtml));
	} else warn_exit(do_lang_tempcode('INTERNAL_ERROR'));

	$content->handle_symbol_preprocessing();
	$echo=do_template('STANDALONE_HTML_WRAP',array('TITLE'=>do_lang_tempcode('COMCODE_HELPER'),'POPUP'=>true,'CONTENT'=>$content));
	exit($echo->evaluate());
	$echo->handle_symbol_preprocessing();
	$echo->evaluate_echo();
}

/**
 * Reads a Comcode tag from the POST environment.
 *
 * @param  ID_TEXT		Tag being read.
 * @return array			A pair: The full Comcode for that tag, just the parameters bit.
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
	$bparameters_xml='';
	$tag_contents=post_param('tag_contents','');
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
			$key=str_replace('"','\"',post_param('x_key_'.strval($i)));
			$value=str_replace('"','\"',post_param('x_value_'.strval($i)));
			$bparameters.=' '.strval($i+1).'_key="'.$key.'"';
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

//				$bparameters_xml.='<blockParam key="'.($i+1).'_value" val="'.$value.'" />';
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
			if($default==($i+1))
			{
				$def=' default="1"';
			}
			$comcode.="[section=\"$name\"$def]".$content."[/section]";
			$controller[]=$name;
			$bparameters.="<section=\"$name\"$def>".$content."</section>";
			$i++;
		}
		$comcode.='[section_controller]'.implode(',',$controller).'[/section_controller]';
		$bparameters.='<section_controller>'.implode(',',$controller).'</section_controller>';
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
			if($default==($i+1))
			{
				$def=' default="1"';
			}
			$comcode.="[big_tab=\"$name\"$def]".$content."[/big_tab]";
			$controller[]=$name;
			$bparameters.="<big_tab=\"$name\"$def>".$content."</big_tab>";
			$i++;
		}
		$comcode='[surround][big_tab_controller switch_time="'.strval($time).'"]'.implode(',',$controller).'[/big_tab_controller]'.$comcode.'[/surround]';
		$bparameters.='[surround]<big_tab_controller switch_time="'.strval($time).'">'.implode(',',$controller).'</big_tab_controller>[/surround]';
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
			if($default==($i+1))
			{
				$def=' default="1"';
			}
			$comcode.="[tab=\"$name\"$def]".$content."[/tab]";
			$controller[]=$name;
			$bparameters.="<tab=\"$name\"$def>".$content."</tab>";
			$i++;
		}
		$comcode='[tabs="'.implode(',',$controller).'"]'.$comcode.'[/tabs]';
		$bparameters='<tabs="'.implode(',',$controller).'">'.$bparameters.'</tabs>';
	}
	elseif ($tag=='list')
	{
		$i=0;
		$defaults=post_param('default','normal');
		$comcode_arr=array();
		$xml='';
		while (post_param('tag_contents_'.strval($i),'')!='')
		{
			$def='';
			$contents=post_param('tag_contents_'.strval($i));
			$comcode_arr[]=$contents;
			$xml.="<listElement>$contents</listElement>";
			$i++;
		}
		$comcode="[list default=\"$defaults\"]".implode("[*]", $comcode_arr)."[/list]";
		$bparameters="<list default=\"$defaults\">$xml</list>";
	}
	else
	{
		foreach ($parameters as $parameter)
		{
			$value=post_param($parameter,'');

			if (($tag=='attachment') && ($parameter=='thumb') && ($value==''))
			{
				$value='0';
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

	return array($comcode,$bparameters);
}

/**
 * Locate a set of consistently named parameters and generate an array of them for a multi-line input.
 *
 * @param  array			All default values for the tag.
 * @param  ID_TEXT		Match name for the parameter set.
 * @return array			List of values.
 */
function get_defaults_multi($defaults,$param)
{
	$values=array();
	foreach ($defaults as $key=>$val)
	{
		if (substr($param,0,2)=='x_')
		{
			if (preg_match('#^'.str_replace('x','\d',preg_quote($param,'#')).'$#',$key)!=0)
			{
				$values[]=$val;
			}
		} else
		{
			if (substr($key,0,strlen($param)+1)==$param.'_')
			{
				$values[]=$val;
			}
		}
	}
	return $values;
}
