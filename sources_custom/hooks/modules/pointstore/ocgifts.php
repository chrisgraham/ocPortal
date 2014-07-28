<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_gifts
 */

class Hook_pointstore_ocgifts
{
	/**
	 * Standard pointstore item initialisation function.
	 */
	function init()
	{
		require_lang('ocgifts');
	}

	/**
	 * Standard pointstore item initialisation function.
	 *
	 * @return array			The "shop fronts"
	 */
	function info()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$next_url=build_url(array('page'=>'_SELF','type'=>'action','id'=>$class),'_SELF');
		return array(do_template('POINTSTORE_'.strtoupper($class),array('NEXT_URL'=>$next_url)));
	}

	/**
	 * Standard interface stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action()
	{
		require_code('database_action');
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$title=get_screen_title('OCGIFTS_TITLE');

		require_code('form_templates');

		$map=array('enabled'=>1);
		$category=either_param('category','');
		if ($category!='')
		{
			$map['category']=$category;
		}

		$max_rows=$GLOBALS['SITE_DB']->query_select_value('ocgifts','COUNT(*)',$map);

		$max=get_param_integer('gifts_max',20);
		$start=get_param_integer('gifts_start',0);
		require_code('templates_pagination');
		$pagination=pagination(do_lang_tempcode('OCGIFTS_TITLE'),$start,'gifts_start',$max,'gifts_max',$max_rows,true);

		$rows=$GLOBALS['SITE_DB']->query_select('ocgifts g',array('*','(SELECT COUNT(*) FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'members_gifts m WHERE m.gift_id=g.id) AS popularity'),$map,'ORDER BY popularity DESC',$max,$start);
		$username=get_param('username','');
		$gifts=array();
		foreach ($rows as $gift)
		{
			$gift_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocgifts','gift'=>$gift['id'],'username'=>$username),'_SEARCH');

			$image_url='';
			if (is_file(get_file_base().'/'.rawurldecode($gift['image'])))
			{
				$image_url=get_base_url().'/'.$gift['image'];
			}

			$gifts[]=array(
				'NAME'=>$gift['name'],
				'PRICE'=>integer_format($gift['price']),
				'POPULARITY'=>integer_format($gift['popularity']),
				'GIFT_URL'=>$gift_url,
				'IMAGE_URL'=>$image_url,
			);
		}

		$categories=collapse_1d_complexity('category',$GLOBALS['SITE_DB']->query_select('ocgifts',array('DISTINCT category'),NULL,'ORDER BY category'));

		$tpl=do_template('POINTSTORE_OCGIFTS_GIFTS',array('_GUID'=>'5ff1ea34d0a71d50532e9b906879b72f','TITLE'=>$title,'GIFTS'=>$gifts,'PAGINATION'=>$pagination,'CATEGORY'=>$category,'CATEGORIES'=>$categories));

		require_code('templates_internalise_screen');
		return internalise_own_screen($tpl);
	}

	/**
	 * Standard actualisation stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action_done()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$title=get_screen_title('OCGIFTS_TITLE');

		require_code('form_templates');
		$fields=new ocp_tempcode();

		$fields->attach(form_input_username(do_lang_tempcode('TO_USERNAME'),do_lang_tempcode('MEMBER_TO_GIVE'),'username',get_param('username',''),true));

		$fields->attach(form_input_text(do_lang_tempcode('GIFT_MESSAGE'),do_lang_tempcode('DESCRIPTION_GIFT_MESSAGE'),'gift_message','',true));

		$fields->attach(form_input_tick(do_lang_tempcode('ANONYMOUS'),do_lang_tempcode('DESCRIPTION_ANONYMOUS'),'anonymous',false));

		$submit_name=do_lang_tempcode('SEND_GIFT');
		$text=paragraph(do_lang_tempcode('CHOOSE_MEMBER'));

		$post_url=build_url(array('page'=>'pointstore','type'=>'action_done2','id'=>'ocgifts','gift'=>get_param('gift',0)),'_SEARCH');

		return do_template('FORM_SCREEN',array('_GUID'=>'0d2878fbba63b22f7225a05ec2672537','SKIP_VALIDATION'=>true,'STAFF_HELP_URL'=>'','HIDDEN'=>'','TITLE'=>$title,'FIELDS'=>$fields,'TEXT'=>$text,'SUBMIT_ICON'=>'buttons__proceed','SUBMIT_NAME'=>$submit_name,'URL'=>$post_url));
	}

	/**
	 * Standard actualisation stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action_done2()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$title=get_screen_title('OCGIFTS_TITLE');

		$member_id=get_member();

		$from_member=get_member();

		$gift_id=get_param_integer('gift');
		$to_member=post_param('username','');
		$gift_message=post_param('gift_message','');
		$anonymous=post_param_integer('anonymous',0);

		$member_rows=$GLOBALS['FORUM_DB']->query_select('f_members',array('*'),array('m_username'=>$to_member),'',1);
		if (array_key_exists(0,$member_rows))
		{
			$member_row=$member_rows[0];
			$to_member_id=$member_row['id'];		

			$gift_rows=$GLOBALS['SITE_DB']->query_select('ocgifts',array('*'),array('id'=>$gift_id) );
			if (array_key_exists(0,$gift_rows))
			{
				$gift_row=$gift_rows[0];
				$gift_name=$gift_row['name'];
				$gift_image_url=get_base_url().'/'.$gift_row['image'];

				// Check available points and charge
				$available_points=available_points($from_member);
				if ($gift_row['price']>$available_points) warn_exit(do_lang_tempcode('CANT_AFFORD'));
				require_code('points2');
				charge_member($from_member,$gift_row['price'],do_lang('GIFT_PURCHASING'));

				// Add row
				$gift_row_id=$GLOBALS['SITE_DB']->query_insert('members_gifts',array('to_member_id'=>$to_member_id,'from_member_id'=>$member_id,'gift_id'=>$gift_id,'add_time'=>time(),'is_anonymous'=>$anonymous,'gift_message'=>$gift_message),true);

				// Send notification
				require_code('notifications');
				$subject=do_lang('GOT_GIFT',NULL,NULL,NULL,get_lang($to_member_id));
				if ($anonymous==0)
				{
					$sender_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($from_member);
					$sender_displayname=$GLOBALS['FORUM_DRIVER']->get_username($from_member,true);
					$sender_username=$GLOBALS['FORUM_DRIVER']->get_username($from_member);
					$private_topic_url=$GLOBALS['FORUM_DRIVER']->member_pm_url($from_member);

					$message=do_lang('GIFT_EXPLANATION_MAIL',comcode_escape($sender_displayname),comcode_escape($gift_name),array($sender_url,$gift_image_url,$gift_message,$private_topic_url,comcode_escape($sender_username)),get_lang($to_member_id));

					dispatch_notification('gift',NULL,$subject,$message,array($to_member_id),$member_id,3,false,false,NULL,NULL,'','','','',NULL,true);
				} else
				{
					$message=do_lang('GIFT_EXPLANATION_ANONYMOUS_MAIL',comcode_escape($gift_name),$gift_image_url,$gift_message,get_lang($to_member_id));

					dispatch_notification('gift',NULL,$subject,$message,array($to_member_id),A_FROM_SYSTEM_UNPRIVILEGED);
				}
			} else
			{
				warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
			}
		} else
		{
			warn_exit(do_lang_tempcode('NO_MEMBER_SELECTED'));
		}

		// Show message / done
		$result=do_lang_tempcode('GIFT_CONGRATULATIONS');
		$url=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');
		return redirect_screen($title,$url,$result);
	}
}
