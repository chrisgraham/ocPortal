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
 * @package		quizzes
 */

/**
 * Show a quiz box.
 *
 * @param  array			The database row
 * @param  string			The zone to show in
 * @param  boolean		Whether to include context (i.e. say WHAT this is, not just show the actual content)
 * @param  ID_TEXT		Overridden GUID to send to templates (blank: none)
 * @return tempcode		The rendered quiz link
 */
function render_quiz_box($row,$zone='_SEARCH',$give_context=true,$guid='')
{
	require_lang('quiz');

	$date=get_timezoned_date($row['q_add_date']);
	$url=build_url(array('page'=>'quiz','type'=>'do','id'=>$row['id']),$zone);

	$name=get_translated_text($row['q_name']);
	$start_text=get_translated_tempcode($row['q_start_text']);

	$timeout=is_null($row['q_timeout'])?'':display_time_period($row['q_timeout']*60);
	$redo_time=((is_null($row['q_redo_time'])) || ($row['q_redo_time']==0))?'':display_time_period($row['q_redo_time']*60*60);

	return do_template('QUIZ_BOX',array(
		'_GUID'=>($guid!='')?$guid:'3ba4e19d93eb41f6cf2d472af982116e',
		'GIVE_CONTEXT'=>$give_context,
		'_TYPE'=>$row['q_type'],
		'POINTS'=>strval($row['q_points_for_passing']),
		'TIMEOUT'=>$timeout,
		'REDO_TIME'=>$redo_time,
		'TYPE'=>do_lang_tempcode($row['q_type']),
		'DATE'=>$date,
		'URL'=>$url,
		'NAME'=>$name,
		'START_TEXT'=>$start_text,
	));
}

/**
 * Get quiz data for exporting it as a CSV
 *
 * @param	AUTO_LINK	Quiz ID
 * @return	array			Quiz data array	
 */
function get_quiz_data_for_csv($quiz_id)
{
	$questions_rows=$GLOBALS['SITE_DB']->query_select('quiz_questions',array('*'),array('q_quiz'=>$quiz_id),'ORDER BY q_order');

	$csv_data=array();

	// Create header array
	$header=array(do_lang('MEMBER_NAME'),do_lang('MEMBER_EMAIL'));

	// Get all entries and member answers of this quiz in to an array
	$member_answer_rows=$GLOBALS['SITE_DB']->query_select('quiz_entry_answer t1 JOIN '.get_table_prefix().'quiz_entries t2 ON t2.id=t1.q_entry JOIN '.get_table_prefix().'quiz_questions t3 ON t3.id=t1.q_question',array('t2.id AS entry_id','q_question','q_member','q_answer'),array('t2.q_quiz'=>$quiz_id),'ORDER BY q_order');
	$member_answers=array();
	foreach ($member_answer_rows as $id=>$answer_entry)
	{
		$member_entry_key=strval($answer_entry['q_member']).'_'.strval($answer_entry['entry_id']);
		$question_id=$answer_entry['q_question'];
		if (!isset($member_answers[$member_entry_key][$question_id])) $member_answers[$member_entry_key][$question_id]=array();
		$member_answers[$member_entry_key][$question_id]=$answer_entry['q_answer'];
	}

	// Proper answers, for non-free-form questions
	$answer_rows=$GLOBALS['SITE_DB']->query_select('quiz_question_answers a JOIN '.get_table_prefix().'quiz_questions q ON q.id=a.q_question',array('q_answer_text','q_question','a.id'),array('q_quiz'=>$quiz_id),'ORDER BY id');

	// Loop over it all
	foreach ($member_answers as $member_bits=>$member_answers)
	{
		list($member,)=explode('_',$member_bits);
		$username=$GLOBALS['FORUM_DRIVER']->get_username($member);
		$member_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($member);

		$member_answers_csv=array();
		$member_answers_csv[do_lang('IDENTIFIER')]=$member;
		$member_answers_csv[do_lang('USERNAME')]=$username;
		$member_answers_csv[do_lang('EMAIL')]=$member_email;
		foreach ($questions_rows as $i=>$question_row)
		{
			$member_answer=array_key_exists($question_row['id'],$member_answers)?$member_answers[$question_row['id']]:'';

			if (is_numeric($member_answer))
			{
				foreach ($answer_rows as $question_answer_row)
				{
					if (($question_answer_row['id']==intval($member_answer)) && ($question_answer_row['q_question']==$question_row['id']))
					{
						$member_answer=get_translated_text($question_answer_row['q_answer_text']);
					}
				}
			}

			$member_answers_csv[integer_format($i+1).') '.get_translated_text($question_row['q_question_text'])]=$member_answer;
		}

		$csv_data[]=$member_answers_csv;
	}

	return $csv_data;
}

/**
 * Get quiz data for exporting it as csv
 *
 * @param	array			The quiz questions
 * @return	tempcode		The rendered quiz	
 */
function render_quiz($questions)
{
	require_lang('quiz');

	require_code('form_templates');

	// Sort out qa input
	$fields=new ocp_tempcode();
	foreach ($questions as $i=>$question)
	{
		$name='q_'.strval($question['id']);
		$text=protect_from_escaping(is_string($question['q_question_text'])?comcode_to_tempcode($question['q_question_text']):get_translated_tempcode($question['q_question_text']));

		if ($question['q_num_choosable_answers']==0) // Text box ("free question"). May be an actual answer, or may not be: but regardless, the user cannot see it
		{
			if ($question['q_long_input_field']==1) // Big field
			{
				$fields->attach(form_input_text($text,'',$name,'',$question['q_required']==1));
			} else // Small field
			{
				$fields->attach(form_input_line($text,'',$name,'',$question['q_required']==1));
			}
		}
		elseif ($question['q_num_choosable_answers']>1) // Check boxes
		{
			$content=array();
			foreach ($question['answers'] as $a)
			{
				$content[]=array(protect_from_escaping(is_string($a['q_answer_text'])?comcode_to_tempcode($a['q_answer_text']):get_translated_tempcode($a['q_answer_text'])),$name.'_'.strval($a['id']),false,'');
			}
			$fields->attach(form_input_various_ticks($content,'',NULL,$text,true));
		} else // Radio buttons
		{
			$radios=new ocp_tempcode();
			foreach ($question['answers'] as $a)
			{
				$answer_text=is_string($a['q_answer_text'])?comcode_to_tempcode($a['q_answer_text']):get_translated_tempcode($a['q_answer_text']);
				$radios->attach(form_input_radio_entry($name,strval($a['id']),false,protect_from_escaping($answer_text)));
			}
			$fields->attach(form_input_radio($text,'',$name,$radios));
		}
	}

	return $fields;
}

