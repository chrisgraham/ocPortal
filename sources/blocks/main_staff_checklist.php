<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_adminzone_frontpage
 */

class Block_main_staff_checklist
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=4;
		$info['locked']=false;
		$info['parameters']=array();
		$info['update_require_upgrade']=1;

		return $info;
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='(count($_POST)>0)?NULL:array()'; // No cache on POST as this is when we save text data
		$info['ttl']=60*5;
		return $info;
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((is_null($upgrade_from)) || ($upgrade_from < 4))
		{
			$GLOBALS['SITE_DB']->create_table('customtasks',array(
				'id'=>'*AUTO',
				'tasktitle'=>'SHORT_TEXT',
				'datetimeadded'=>'TIME',
				'recurinterval'=>'INTEGER',
				'recurevery' =>'ID_TEXT',
				'taskisdone' =>'?TIME'
			));

			require_lang('staff_checklist');
			$tasks=array(
				do_lang('CHECKLIST_INITIAL_TASK_STRUCTURE'),
				do_lang('CHECKLIST_INITIAL_TASK_FAVICON'),
				do_lang('CHECKLIST_INITIAL_TASK_WEBCLIP'),
				do_lang('CHECKLIST_INITIAL_TASK_THEME'),
				do_lang('CHECKLIST_INITIAL_TASK_CONTENT'),
				'[page="adminzone:admin_themes:edit_image:logo/trimmed_logo:theme=default"]'.do_lang('CHECKLIST_INITIAL_TASK_MAIL_LOGO').'[/page]',
				'[page="adminzone:admin_themes:_edit_templates:theme=default:f0file=MAIL.tpl"]'.do_lang('CHECKLIST_INITIAL_TASK_MAIL').'[/page]',
				'[url="'.do_lang('CHECKLIST_INITIAL_TASK_P3P').'"]http://www.p3pwiz.com/[/url]',
				'[url="'.do_lang('CHECKLIST_INITIAL_TASK_GOOGLE').'"]http://www.google.com/addurl/[/url]',
				'[url="'.do_lang('CHECKLIST_INITIAL_TASK_BING').'"]http://www.bing.com/webmaster/SubmitSitePage.aspx[/url]',
//				'[url="'.do_lang('CHECKLIST_INITIAL_TASK_YAHOO').'"]http://publisher.yahoo.com/rss_guide/submit.php[/url]',
				'Facebook user? Like ocPortal on Facebook:[html]<iframe src="http://www.ocportal.com/facebook.html" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:430px; height:30px;" allowTransparency="true"></iframe>[/html]',
				'[url="Consider helping out with the ocPortal project"]http://ocportal.com/site/helping_out.htm[/url]',
			);
			foreach ($tasks as $task)
			{
				$GLOBALS['SITE_DB']->query_insert('customtasks',array(
					'tasktitle'=>$task,
					'datetimeadded'=>time(),
					'recurinterval'=>0,
					'recurevery' =>'',
					'taskisdone' =>NULL,
				));
			}
		}
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('customtasks');
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		unset($map);

		require_javascript('javascript_ajax');
		require_lang('staff_checklist');
		require_css('adminzone_frontpage');
		require_lang('dates');

		// Handle custom tasks
		$newtask=post_param('newtask',NULL);
		$recurint=post_param_integer('recur',0);
		$recurevery=post_param('recurevery',NULL);
		if ((!is_null($newtask)) && (!is_null($recurint)) && (!is_null($recurevery)))
		{
			$GLOBALS['SITE_DB']->query_insert('customtasks',array('tasktitle'=>$newtask,'datetimeadded'=>time(),'recurinterval'=>$recurint,'recurevery'=>$recurevery,'taskisdone'=>NULL));
			decache('main_staff_checklist');
		}
		$custasks=new ocp_tempcode();
		$rows=$GLOBALS['SITE_DB']->query_select('customtasks',array('*'));
		foreach($rows as $r)
		{
			$recurevery='';
			switch ($r['recurevery'])
			{
				case 'mins':
					$recurevery=do_lang('_MINUTES');
					break;
				case 'hours':
					$recurevery=do_lang('_HOURS');
					break;
				case 'days':
					$recurevery=do_lang('_DAYS');
					break;
				case 'months':
					$recurevery=do_lang('_MONTHS');
					break;
			}
			$custasks->attach(do_template('BLOCK_MAIN_STAFF_CHECKLIST_CUSTOM_TASK',array(
				'TASK_TITLE'=>comcode_to_tempcode($r['tasktitle']),
				'ADD_DATE'=>display_time_period($r['datetimeadded']),
				'RECUR_INTERVAL'=>($r['recurinterval']==0)?'':integer_format($r['recurinterval']),
				'RECUR_EVERY'=>$recurevery,
				'TASK_DONE'=>((!is_null($r['taskisdone'])) && (($r['recurinterval']==0) || (($r['recurevery']!='mins') || (time()<$r['taskisdone']+60*$r['recurinterval'])) && (($r['recurevery']!='hours') || (time()<$r['taskisdone']+60*60*$r['recurinterval'])) && (($r['recurevery']!='days') || (time()<$r['taskisdone']+24*60*60*$r['recurinterval'])) && (($r['recurevery']!='months') || (time()<$r['taskisdone']+31*24*60*60*$r['recurinterval']))))?'checklist1':'not_completed',
				'ID'=>strval($r['id']),
				'ADD_TIME'=>do_lang_tempcode('DAYS_AGO',escape_html(integer_format(intval(round(floatval(time()-$r['datetimeadded'])/60.0/60.0/24.0))))),
			)));
		}

		// Handle notes
		$file='admin_notes';
		$new=post_param('new',NULL);
		if (!is_null($new))
		{
			set_long_value('note_text_'.$file,$new);
			log_it('NOTES',$file);
			decache('main_staff_checklist');
		}
		$notes=get_long_value('note_text_'.$file);
		if (is_null($notes)) $notes='';

		// Handle built in items

		$rets_no_times=array();
		$rets_todo_counts=array();
		$rets_dates=array();

		$_hooks=find_all_hooks('blocks','main_staff_checklist');
		ksort($_hooks);
		foreach (array_keys($_hooks) as $hook)
		{
			require_code('hooks/blocks/main_staff_checklist/'.filter_naughty_harsh($hook));
			$object=object_factory('Hook_checklist_'.filter_naughty_harsh($hook),true);
			if (is_null($object)) continue;
			$ret=$object->run();
			if ((!is_null($ret)) && (count($ret)!=0))
			{
				foreach ($ret as $r)
				{
					if ((is_null($r[1])) && (is_null($r[2])))
					{
						$rets_no_times[]=$r;
					}
					elseif (!is_null($r[2]))
					{
						$rets_todo_counts[]=$r;
					} else
					{
						$rets_dates[]=$r;
					}
				}
			}
		}

		global $M_SORT_KEY;
		$M_SORT_KEY='!2';
		usort($rets_todo_counts,'multi_sort');
		$M_SORT_KEY='1';
		usort($rets_dates,'multi_sort');

		$out_no_times=new ocp_tempcode();
		foreach ($rets_no_times as $item)
		{
			$out_no_times->attach($item[0]);
		}
		$out_todo_counts=new ocp_tempcode();
		foreach ($rets_todo_counts as $item)
		{
			$out_todo_counts->attach($item[0]);
		}
		$out_dates=new ocp_tempcode();
		foreach ($rets_dates as $item)
		{
			$out_dates->attach($item[0]);
		}

		return do_template('BLOCK_MAIN_STAFF_CHECKLIST',array('_GUID'=>'aefbca8252dc1d6edc44fc6d1e78b3ec','URL'=>get_self_url(),'DATES'=>$out_dates,'NO_TIMES'=>$out_no_times,'TODO_COUNTS'=>$out_todo_counts,'CUSTOM_TASKS'=>$custasks));
	}

}

/**
 * Work out when an action should happen, and last happened.
 *
 * @param  ?integer	The number of seconds ago since it last happened (NULL: never happened) OR If $recur_hours is NULL then the number of seconds until it happens (NULL: won't happen)
 * @param  ?integer	It should be done every this many hours (NULL: never happened)
 * @return array		A pair: Tempcode to display, and the number of seconds to go until the action should happen
 */
function staff_checklist_time_ago_and_due($seconds_ago,$recur_hours=NULL)
{
	if (is_null($recur_hours)) // None recurring
	{
		$seconds_to_go=$seconds_ago; // Actually, if only one parameter given, meaning is different
		$seconds_ago=mixed();
		if (is_null($seconds_to_go))
		{
			return array(do_lang_tempcode('DUE_NOT'),1000000);
		}
	} else // Recurring
	{
		if (is_null($seconds_ago))
		{
			return array(do_lang_tempcode('DUE_NOW'),0); // Due for first time now
		} else
		{
			$seconds_to_go=$recur_hours*60*60-$seconds_ago;
		}
	}

	if ($seconds_to_go==0) return array(do_lang_tempcode('DUE_NOW'),0); // Due for first time now (this is a special encoding for non-recurring tasks that still need doing on some form of schedule and need doing for first time now)
	if ($seconds_to_go>0)
	{
		return array(do_lang_tempcode('DUE_TIME',is_null($seconds_ago)?do_lang_tempcode('NA_EM'):make_string_tempcode(escape_html(display_time_period($seconds_ago))),make_string_tempcode(escape_html(display_time_period($seconds_to_go)))),$seconds_to_go);
	} else
	{
		return array(do_lang_tempcode('DUE_TIME_AGO',is_null($seconds_ago)?do_lang_tempcode('NA_EM'):make_string_tempcode(escape_html(display_time_period($seconds_ago))),make_string_tempcode(escape_html(display_time_period(-$seconds_to_go)))),$seconds_to_go);
	}
}

