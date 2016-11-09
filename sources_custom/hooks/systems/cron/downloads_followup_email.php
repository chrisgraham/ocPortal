<?php /*

ocPortal/ocProducts is free to use or incorporate this into ocPortal and assert any copyright.
This notification hook was created using the classifieds notification hook as a template.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	None asserted
 * @package		downloads_followup_email
 */


 class Hook_cron_downloads_followup_email
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		if (!addon_installed('downloads')) return;
		require_lang('downloads_followup_email');

		$last=get_value('last_downloads_followup_email_send');
		$debug=FALSE;
		
		// Value can be set in OcCLE: 
		//    2=debug output with short interval (.01 hour instead of default 24 hours) for manually running cron_bridge.php  
		//    1=debug output with normal interval (default 24 hours) 
		//    0=no debug output
		// In OcCLE :set_value('downloads_followup_email_debug','1');
		$debug_mode=get_value('downloads_followup_email_debug');
		if ($debug_mode!='0' && $debug_mode!='1' && $debug_mode!='2') $debug_mode='0';
		if ($debug_mode=='2') 
		{
			$cron_interval=.01; // Sets interval to 36 seconds
			$debug=TRUE;
		}
		else 
		{
			$cron_interval=24; // This default value will be replaced with a config option in the future
			if ($debug_mode=='1') $debug=TRUE;
		}
		
		$time=time();
		
		if ($debug) echo "downloads_followup_email: current-timestamp / last-timestamp / difference = $time / $last / " . round((($time-$last)/60/60),2) . " hours \n";
		if ($debug) echo "downloads_followup_email: debug_mode = $debug_mode \n";
		if ($debug) echo "downloads_followup_email: cron_interval = $cron_interval hours \n";
		
		/*
		If we just installed, reinstalled after uninstalling more than 2 days ago, or if cron stopped 
		working for more than 2 days we will not generate emails for downloads prior to the previous 
		48 hours to prevent sending stale notifications for download actions that are not recent.
		*/
		if ((is_null($last)) || (intval($last)<$time-60*60*48))  $last=$time-60*60*48;
		
		if (intval($last)>$time-60*60*$cron_interval) return; // Don't do more than once per $cron_interval (default is 24 hours)

		if (function_exists('set_time_limit')) @set_time_limit(0);

		// Set the templates names to use. Use CUSTOM template if it exists, else use the default template.
		$theme=isset($CACHED_THEME)?$CACHED_THEME:(((isset($FORUM_DRIVER)) && (is_object($FORUM_DRIVER)) && (method_exists($FORUM_DRIVER,'get_theme')))?filter_naughty($FORUM_DRIVER->get_theme()):'default');
		if (find_template_place('DOWNLOADS_FOLLOWUP_EMAIL_CUSTOM',NULL,$theme,'.tpl','templates') == NULL)
			$mail_template='DOWNLOADS_FOLLOWUP_EMAIL';
		else
			$mail_template='DOWNLOADS_FOLLOWUP_EMAIL_CUSTOM';
		if (find_template_place('DOWNLOADS_FOLLOWUP_EMAIL_CUSTOM',NULL,$theme,'.tpl','templates') == NULL)
			$download_list_template='DOWNLOADS_FOLLOWUP_EMAIL_DOWNLOAD_LIST';
		else
			$download_list_template='DOWNLOADS_FOLLOWUP_EMAIL_DOWNLOAD_LIST_CUSTOM';

		// Get all distinct member id's (except for guest) from download_logging table where the date_and_time is newer than the last runtime of this hook (or last 48 hours if hook hasn't been run recently)
		$query="SELECT DISTINCT the_user FROM ".$GLOBALS['SITE_DB']->get_table_prefix()."download_logging WHERE the_user>1 AND date_and_time>".$last;
		if ($debug) echo "downloads_followup_email: distinct user query = $query \n";
		$member_ids=$GLOBALS['SITE_DB']->query($query);

		// For each distinct member id, send a download follow-up notification
		foreach ($member_ids as $id) 
		{
			// Create template object to hold download list
			$download_list=new ocp_tempcode();
			$member_id='1';
			$member_name='Guest';
			$member_id=strval($id['the_user']);
			$member_name=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
			$lang=get_lang($member_id);
			$zone=get_module_zone('downloads');
			$count=0;
			
			if ($debug) echo "downloads_followup_email: preparing notification to id #$member_id ($member_name) language=$lang \n";
			
			// Do a query to get list of download ids the current member id has downloaded since last run and place them in a content variable
			$query="SELECT * FROM ".$GLOBALS['SITE_DB']->get_table_prefix()."download_logging WHERE the_user=".$member_id." AND date_and_time>".$last;
			if ($debug) echo "downloads_followup_email: download ids query = $query \n";
			$downloads=$GLOBALS['SITE_DB']->query($query);
			foreach ($downloads as $download)
			{
				// Do a query to get download names and generate links
				$query='SELECT p.*,text_original FROM '.get_table_prefix().'download_downloads p LEFT JOIN '.get_table_prefix().'translate t ON t.id=p.name AND '.db_string_equal_to('language',$lang).' WHERE p.id='.$download['id'];
				$the_download=$GLOBALS['SITE_DB']->query($query);
				$root=get_param_integer('root',db_get_first_id(),true);
				$map=array('page'=>'downloads','type'=>'entry','id'=>$download['id'],'root'=>($root==db_get_first_id())?NULL:$root);
				$the_download_url=static_evaluate_tempcode(build_url($map,$zone));

				if ($debug) echo "downloads_followup_email: download query = $query \n";
				if ($debug) echo "downloads_followup_email: download name / download filename / download url = ".$the_download[0]['text_original']." / ".$the_download[0]['original_filename']." / $the_download_url \n";

				$download_list->attach(do_template($download_list_template,array('DOWNLOAD_NAME'=>$the_download[0]['text_original'],'DOWNLOAD_FILENAME'=>$the_download[0]['original_filename'],'DOWNLOAD_URL'=>$the_download_url )));
				$count++;
			}
			$s=''; // Can be used to pluralise the word download in the subject line in the language .ini file if we have more than one download (better than using download(s))
			if ($count>1) $s='s';
			$subject_line=do_lang('SUBJECT_DOWNLOADS_FOLLOWUP_EMAIL',get_site_name(),$member_name,$s,$lang,false);
			// Pass download count, download list, and member id to template.
			$message=static_evaluate_tempcode(do_template("$mail_template",array('MEMBER_ID'=>$member_id,'DOWNLOAD_LIST'=>$download_list,'DOWNLOAD_COUNT'=>strval($count))));

			if ($debug) echo "downloads_followup_email: sending notification (if user allows download followup notifications) to id #$member_id ($member_name) \n";
			if ($debug) echo "downloads_followup_email: notifications enabled = " . strval(notifications_enabled('downloads_followup_email',NULL,$member_id)) . " \n";
			
			// Send actual notification
			require_code('notifications');
			dispatch_notification('downloads_followup_email','',$subject_line,$message,array($member_id),A_FROM_SYSTEM_PRIVILEGED);
		}
		
		set_value('last_downloads_followup_email_send',strval($time));
	}

}
