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
 * @package		polls
 */

class Hook_Preview_poll
{

	/**
	 * Find whether this preview hook applies.
	 *
	 * @return array			Triplet: Whether it applies, the attachment ID type, whether the forum DB is used [optional]
	 */
	function applies()
	{
		$applies=(get_param('page','')=='cms_polls');
		return array($applies,NULL,false);
	}

	/**
	 * Standard modular run function for preview hooks.
	 *
	 * @return array			A pair: The preview, the updated post Comcode
	 */
	function run()
	{
		// Our questions templated
		$tpl=new ocp_tempcode();
		$i=1;
		do
		{
			$answer_plain=post_param('option'.strval($i));
			if ($answer_plain!='')
			{
				$answer=comcode_to_tempcode($answer_plain);
				$votes=0;
				$width=0;
				$tpl->attach(do_template('POLL_ANSWER_RESULT',array('PID'=>'','I'=>strval($i),'VOTE_URL'=>'','ANSWER'=>$answer,'ANSWER_PLAIN'=>$answer_plain,'WIDTH'=>strval($width),'VOTES'=>integer_format($votes))));
				$i++;
			}
		}
		while ($answer_plain!='');

		$submit_url=new ocp_tempcode();

		// Do our final template
		$question_plain=post_param('question');
		$question=comcode_to_tempcode($question_plain);
		$archive_url=build_url(array('page'=>'polls','type'=>'misc'),get_module_zone('polls'));
		$map2=array('VOTE_URL'=>'','SUBMITTER'=>strval(get_member()),'PID'=>'','FULL_URL'=>'','CONTENT'=>$tpl,'QUESTION'=>$question,'QUESTION_PLAIN'=>$question_plain,'SUBMIT_URL'=>$submit_url,'ARCHIVE_URL'=>$archive_url,'RESULT_URL'=>'','ZONE'=>'');
		$output=do_template('POLL_BOX',$map2);

		return array($output,NULL);
	}


}


