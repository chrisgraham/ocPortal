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
 * @package		staff_messaging
 */

/**
 * Module page class.
 */
class Module_admin_messaging
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
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((get_forum_type()=='ocf') && (!running_script('upgrader')))
		{
			$moderator_groups=$GLOBALS['FORUM_DRIVER']->get_moderator_groups();
			$staff_access=array();
			foreach ($moderator_groups as $id)
			{
				$staff_access[$id]=5;
			}
			ocf_require_all_forum_stuff();
			require_code('ocf_forums_action');
			require_code('ocf_forums_action2');
			$GLOBALS['OCF_DRIVER']=$GLOBALS['FORUM_DRIVER'];
			ocf_make_forum(do_lang('MESSAGING_FORUM_NAME'),'',db_get_first_id()+1,$staff_access,db_get_first_id());
		}
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('misc'=>'CONTACT_US_MESSAGING');
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

		require_lang('messaging');

		set_helper_panel_pic('pagepics/messaging');
		set_helper_panel_tutorial('tut_support_desk');

		if ($type=='view')
		{
			breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('CONTACT_US_MESSAGING'))));
			breadcrumb_set_self(do_lang_tempcode('MESSAGE'));
		}

		if ($type=='take')
		{
			$id=get_param('id');
			$message_type=get_param('message_type');
			breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('CONTACT_US_MESSAGING')),array('_SELF:_SELF:view:'.$id.':message_type='.$message_type,do_lang_tempcode('MESSAGE'))));
			breadcrumb_set_self(do_lang_tempcode('_TAKE_RESPONSIBILITY'));
		}

		$this->title=get_screen_title('CONTACT_US_MESSAGING');

		return NULL;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		if (get_forum_type()=='none') warn_exit(do_lang_tempcode('NO_FORUM_INSTALLED'));

		$type=get_param('type','misc');

		if ($type=='misc') return $this->choose_message();
		if ($type=='view') return $this->view_message();
		if ($type=='take') return $this->take_responsibility();

		return new ocp_tempcode();
	}

	/**
	 * Choose a message.
	 *
	 * @return tempcode	The message choose screen.
	 */
	function choose_message()
	{
		$fields=new ocp_tempcode();

		$start=get_param_integer('start',0);
		$max=get_param_integer('max',30);

		require_code('templates_results_table');

		$max_rows=0;
		$rows=$GLOBALS['FORUM_DRIVER']->show_forum_topics(get_option('messaging_forum_name'),$max,$start,$max_rows);
		if (!is_null($rows))
		{
			foreach ($rows as $i=>$row)
			{
				$name=$row['firsttitle'];
				if (trim($name)=='') $name=do_lang('UNKNOWN');
				$looking_at=$row['title'];
				if ($row['description']!='') $looking_at=$row['description'];
				$id=substr($looking_at,strrpos($looking_at,'_')+1);
				$message_type=substr($looking_at,strpos($looking_at,'#')+1,strrpos($looking_at,'_')-strpos($looking_at,'#')-1);
				if ($message_type=='') continue;
				$url=build_url(array('page'=>'_SELF','type'=>'view','id'=>$id,'message_type'=>$message_type),'_SELF');

				$fields->attach(results_entry(array(hyperlink($url,$name,false,true),get_timezoned_date($row['firsttime']),$message_type),true));
			}
		}

		$fields_title=results_field_title(array(do_lang_tempcode('TITLE'),do_lang_tempcode('DATE'),do_lang_tempcode('TYPE')));
		$results_table=results_table('messages',$start,'start',$max,'max',$max_rows,$fields_title,$fields,NULL,NULL,NULL,NULL,paragraph(do_lang_tempcode('SELECT_A_MESSAGE')));

		$tpl=do_template('RESULTS_TABLE_SCREEN',array('_GUID'=>'6ced89e25a12a45deb6cf10bd42869ee','TITLE'=>$this->title,'RESULTS_TABLE'=>$results_table));

		require_code('templates_internalise_screen');
		return internalise_own_screen($tpl);
	}

	/**
	 * View a message.
	 *
	 * @return tempcode	The message view screen.
	 */
	function view_message()
	{
		$id=get_param('id');
		$message_type=get_param('message_type');

		require_css('messaging');
		require_javascript('javascript_validation');

		$take_responsibility_url=build_url(array('page'=>'_SELF','type'=>'take','id'=>$id,'message_type'=>$message_type),'_SELF');
		$responsible=NULL;

		$forum=get_option('messaging_forum_name');

		// Filter/read comments
		require_code('feedback');
		actualise_post_comment(true,$message_type,$id,build_url(array('page'=>'_SELF','type'=>'view','id'=>$id),'_SELF',NULL,false,false,true),NULL,$forum);
		$count=0;
		$_comments=$GLOBALS['FORUM_DRIVER']->get_forum_topic_posts($GLOBALS['FORUM_DRIVER']->find_topic_id_for_topic_identifier($forum,$message_type.'_'.$id),$count);
		if ((is_array($_comments)) && (array_key_exists(0,$_comments)))
		{
			$message_title=$_comments[0]['title'];
			$message=$_comments[0]['message'];
			if (isset($_comments[0]['message_comcode']))
			{
				$message=comcode_to_tempcode(str_replace('[/staff_note]','',str_replace('[staff_note]','',$_comments[0]['message_comcode'])),$GLOBALS['FORUM_DRIVER']->get_guest_id());
			}
			$by=$_comments[0]['username'];

			foreach ($_comments as $i=>$comment)
			{
				if (is_object($comment['message'])) $comment['message']=$comment['message']->evaluate();
				if (substr($comment['message'],0,strlen(do_lang('AUTO_SPACER_STUB')))==do_lang('AUTO_SPACER_STUB'))
				{
					$matches=array();
					if (preg_match('#'.str_replace('\\{1\\}','(.+)',preg_quote(do_lang('AUTO_SPACER_TAKE_RESPONSIBILITY'))).'#',$comment['message'],$matches)!=0)
					{
						$responsible=$matches[1];
					}
					$_comments[$i]=NULL;
				}
			}
			$_comments[0]=NULL;
		} else warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		$comment_details=get_comments($message_type,true,$id,false,$forum,NULL,$_comments,true);

		// Find who's read this
		$whos_read=array();
		if (get_forum_type()=='ocf')
		{
			// Read - who has, and when
			$topic_id=$GLOBALS['FORUM_DRIVER']->find_topic_id_for_topic_identifier($forum,$message_type.'_'.$id);
			$rows=$GLOBALS['FORUM_DB']->query_select('f_read_logs',array('l_member_id','l_time'),array('l_topic_id'=>$topic_id));
			foreach ($rows as $row)
			{
				$username=$GLOBALS['FORUM_DRIVER']->get_username($row['l_member_id']);
				$member_link=$GLOBALS['FORUM_DRIVER']->member_profile_url($row['l_member_id'],false,true);
				$date=get_timezoned_date($row['l_time']);
				$whos_read[]=array('USERNAME'=>$username,'MEMBER_URL'=>$member_link,'DATE'=>$date);
			}
		}

		return do_template('MESSAGING_MESSAGE_SCREEN',array(
			'_GUID'=>'61561f1a333b88370ceb66dbbcc0ea4c',
			'TITLE'=>$this->title,
			'MESSAGE_TITLE'=>$message_title,
			'MESSAGE'=>$message,
			'BY'=>$by,
			'WHOS_READ'=>$whos_read,
			'COMMENT_DETAILS'=>$comment_details,
			'TAKE_RESPONSIBILITY_URL'=>$take_responsibility_url,
			'RESPONSIBLE'=>$responsible,
		));
	}

	/**
	 * Take responsibility for handling a message.
	 *
	 * @return tempcode	Success message.
	 */
	function take_responsibility()
	{
		$id=get_param('id');
		$message_type=get_param('message_type');

		// Save as responsibility taken
		$forum=get_option('messaging_forum_name');
		$username=$GLOBALS['FORUM_DRIVER']->get_username(get_member());
		$displayname=$GLOBALS['FORUM_DRIVER']->get_username(get_member(),true);
		$GLOBALS['FORUM_DRIVER']->make_post_forum_topic(
			$forum,
			$message_type.'_'.$id,
			get_member(),
			'',
			do_lang('AUTO_SPACER_TAKE_RESPONSIBILITY',$username,$displayname),
			'',
			do_lang('COMMENT')
		);

		// Redirect them back to view screen
		$url=build_url(array('page'=>'_SELF','type'=>'view','id'=>$id,'message_type'=>$message_type),'_SELF');
		return redirect_screen($this->title,$url,do_lang_tempcode('SUCCESS'));
	}

}

