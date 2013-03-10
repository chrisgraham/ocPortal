<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		content_reviews
 */

/**
 * Get a form to control how some content should be reviewed.
 *
 * @param  ID_TEXT		The content type
 * @param  ?ID_TEXT		The content ID (NULL: not added yet)
 * @param  ?ID_TEXT		The catalogue name where to grab default settings from (NULL: content type has no bound catalogue / try and auto-detect)
 * @return tempcode		The fields
 */
function content_review_get_fields($content_type,$content_id=NULL,$catalogue_name=NULL)
{
	$fields=new ocp_tempcode();

	if (!has_privilege(get_member(),'set_content_review_settings')) return $fields;

	if (is_null($catalogue_name)) $catalogue_name='_'.$content_type;

	if (cron_installed())
	{
		require_lang('content_reviews');

		$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array(
			'SECTION_HIDDEN'=>true,
			'TITLE'=>do_lang_tempcode('CONTENT_REVIEWS'),
		)));

		$content_review_rows=is_null($content_id)?array():$GLOBALS['SITE_DB']->query_select('content_reviews',array('review_freq','next_review_time','auto_action','display_review_status'),array('content_type'=>$content_type,'content_id'=>$content_id),'',1);
		if (array_key_exists(0,$content_review_rows))
		{
			$review_freq=$content_review_rows[0]['review_freq'];
			$next_review_time=$content_review_rows[0]['next_review_time'];
			$auto_action=$content_review_rows[0]['auto_action'];
			$display_review_status=$content_review_rows[0]['display_review_status'];
		} else
		{
			if ($content_type=='catalogue')
			{
				$review_freq=$GLOBALS['SITE_DB']->query_select_value_if_there('catalogues','c_default_review_freq',array('c_name'=>$cataloge_name));
				if (!is_null($review_freq))
				{
					if ($review_freq<=0) $review_freq=mixed();
				}
				if (is_integer($review_freq)) $review_freq=$review_freq*60*60*24;
			}
			elseif ($content_type=='comcode_page')
			{
				$review_freq=intval(get_option('comcode_page_default_review_freq'));
				if ($review_freq<=0) $review_freq=mixed();
				if (is_integer($review_freq)) $review_freq=$review_freq*60*60*24;
			} else
			{
				$review_freq=mixed();
			}
			$next_review_time=mixed();
			$auto_action='leave';
			$display_review_status=0;
		}

		require_code('hooks/systems/content_meta_aware/'.filter_naughty($content_type));
		$content_ob=object_factory('Hook_content_meta_aware_'.$content_type);
		$content_info=$content_ob->info();

		// Allow specification of time in days OR months OR years OR not at all

		$set_name='review_freq';
		$required=true;
		$set_title=do_lang_tempcode('REVIEW_FREQ');
		$field_set=alternate_fields_set__start($set_name);

		$review_freq_days=mixed();
		$review_freq_months=mixed();
		$review_freq_years=mixed();
		if (!is_null($review_freq))
		{
			if ($review_freq%(60*60*24*365)==0)
			{
				$review_freq_years=$review_freq/(60*60*24*365);
			}
			elseif ($review_freq%(60*60*24*31)==0)
			{
				$review_freq_months=$review_freq/(60*60*24*31);
			}
			elseif ($review_freq%(60*60*24)==0)
			{
				$review_freq_days=$review_freq/(60*60*24);
			} else
			{
				// :S
				$review_freq_days=intval(round(floatval($review_freq)/(60.0*60.0*24.0)));
				if ($review_freq_days==0) $review_freq_days=mixed();
			}
		}

		require_lang('dates');
		$field_set->attach(form_input_na(do_lang_tempcode('NA_EM')));
		$field_set->attach(form_input_integer(do_lang_tempcode('DPLU_DAYS'),'','review_freq_days',$review_freq_days,false));
		$field_set->attach(form_input_integer(do_lang_tempcode('DPLU_MONTHS'),'','review_freq_months',$review_freq_months,false));
		$field_set->attach(form_input_integer(do_lang_tempcode('DPLU_YEARS'),'','review_freq_years',$review_freq_years,false));

		$fields->attach(alternate_fields_set__end($set_name,$set_title,'',$field_set,$required));

		// Specification of a specific date

		$fields->attach(form_input_date(do_lang_tempcode('NEXT_REVIEW_DATE'),do_lang_tempcode('DESCRIPTION_NEXT_REVIEW_DATE'),'next_review_time',true,is_null($next_review_time),false,$next_review_time));

		// Specification of auto-action to perform

		$auto_action_list=new ocp_tempcode();
		$auto_actions=array();
		$auto_actions[]='leave';
		if (!is_null($content_info['validated_field'])) $auto_actions[]='unvalidate';
		if (($auto_action=='delete') || (has_privilege(get_member(),'delete_'.$content_info['permissions_type_code'].'range_content',$content_info['module']))) $auto_actions[]='delete';
		foreach ($auto_actions as $type)
		{
			$auto_action_list->attach(form_input_list_entry($type,$auto_action==$type,do_lang_tempcode('CONTENT_REVIEW_AUTO_ACTION_'.$type)));
		}
		$fields->attach(form_input_list(do_lang_tempcode('CONTENT_REVIEW_AUTO_ACTION'),'','auto_action',$auto_action_list,NULL,false,true));

		// Say whether to make review status public

		$fields->attach(form_input_tick(do_lang_tempcode('DISPLAY_REVIEW_STATUS'),do_lang_tempcode('DESCRIPTION_DISPLAY_REVIEW_STATUS'),'display_review_status',$display_review_status==1));
	}

	return $fields;
}

/**
 * Save the results of a content review form.
 *
 * @param  ID_TEXT		The content type
 * @param  ID_TEXT		The content ID
 * @param  ?ID_TEXT		The old content ID (NULL: not being renamed)
 */
function content_review_set($content_type,$content_id,$old_content_id=NULL)
{
	if (!is_null($old_content_id)) // Do renaming operation
	{
		$GLOBALS['SITE_DB']->query_update('content_reviews',array('content_id'=>$content_id),array(
			'content_type'=>$content_type,
			'content_id'=>$old_content_id,
		),'',1);
	}

	if (!has_privilege(get_member(),'set_content_review_settings')) return;

	if (cron_installed())
	{
		$review_freq=mixed();
		$review_freq_days=post_param_integer('review_freq_days',NULL);
		$review_freq_months=post_param_integer('review_freq_months',NULL);
		$review_freq_years=post_param_integer('review_freq_years',NULL);
		if (!is_null($review_freq_days)) $review_freq=$review_freq_days*60*60*24;
		elseif (!is_null($review_freq_months)) $review_freq=$review_freq_months*60*60*24*31;
		elseif (!is_null($review_freq_years)) $review_freq=$review_freq_years*60*60*24*365;

		$next_review_time=get_input_date('next_review_time');

		$auto_action=post_param('auto_action','leave');

		$display_review_status=post_param_integer('display_review_status',0);

		schedule_content_review($content_type,$content_id,$review_freq,$next_review_time,$auto_action,$display_review_status);
	}
}

/**
 * Schedule that some content should be reviewed.
 *
 * @param  ID_TEXT		The content type
 * @param  ID_TEXT		The content ID
 * @param  ?integer		The review frequency in seconds (NULL: no repeat review pattern)
 * @param  ?TIME			Manual next review time (NULL: work out from review frequency)
 * @param  ID_TEXT		Automatic action to perform upon review time
 * @set leave unvalidate delete
 * @param  BINARY			Whether to display the review status publicly
 */
function schedule_content_review($content_type,$content_id,$review_freq,$next_review_time=NULL,$auto_action='leave',$display_review_status=1)
{
	// Tidy up, if conflicting entry in database
	$GLOBALS['SITE_DB']->query_delete('content_reviews',array(
		'content_type'=>$content_type,
		'content_id'=>$content_id,
	),'',1);

	// Work out review time
	if ((is_null($next_review_time)) && (is_null($review_freq)))
		return; // Nothing to schedule
	$calc_review_time=(time()+$review_freq);
	if ((is_null($next_review_time))/* || ($calc_review_time<$next_review_time)*/)
	{
		$next_review_time=$calc_review_time;
	}

	// Add to database
	$GLOBALS['SITE_DB']->query_insert('content_reviews',array(
		'content_type'=>$content_type,
		'content_id'=>$content_id,
		'review_freq'=>$review_freq,
		'next_review_time'=>$next_review_time,
		'auto_action'=>$auto_action,
		'review_notification_happened'=>0,
		'display_review_status'=>$display_review_status,
		'last_reviewed_time'=>time(),
	));
}
