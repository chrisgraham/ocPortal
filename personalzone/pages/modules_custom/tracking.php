<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2008

 See text/en/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		catalogues
 */

class Module_tracking
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']="Sujith";
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=4;
		$info['update_require_upgrade']=1;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	*/
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('tracking_info');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if (is_null($upgrade_from))
		{
			$GLOBALS['SITE_DB']->create_table('tracking_info',array(
				'id'=>'*AUTO',
				't_type'=>'ID_TEXT',
				't_category_id'=>'ID_TEXT',
				't_member_id'=>'USER',
				't_tracked_at'=>'TIME',
				't_use_email'=>'BINARY',
				't_use_sms'=>'BINARY'
			));
		}
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_code('submit');
		require_lang('tracking');
		require_code('tracking');
		require_css('tracking');
		require_javascript('javascript_tracking');

		$type=get_param('type','misc');

		// If coming from the track this button then showing the tracking selection screen
		if ($type=='misc') return $this->do_tracking_screen();

		if($type=='save') return $this->do_save_screen();

		if($type=='untrack') return $this->do_untracking_screen();

		return new ocp_tempcode();
	}

	/**
	 * The function to show the tracking page for a specific category
	 *
	 * @return tempcode	The result of execution.
	 */
	function do_tracking_screen()
	{
		$title=get_page_title('TRACKING');
		
		$id=get_param('id');
		
		$t_type=get_param('track_type');
		
		// Creating the form URL for the tracking
		$map=array('page'=>'_SELF','type'=>'save');
		$redirect=get_param('redirect',NULL);
		if (!is_null($redirect))
		{
			$map['redirect']=$redirect;
			require_code('site2');
			attach_message(do_lang_tempcode('TRACKING_SAVE_TO_SAVE'),'inform');
			$select_root=true;
		} else
		{
			$select_root=false;
		}
		$screen_from_url=build_url($map,'_SELF');

		// Getting the child nodes of catalogues using the site tree
		require_code('hooks/modules/tracking/'.$t_type);
		$object=object_factory('Hook_tracking_'.$t_type);
		$child=$object->get_children($id);

		// Calling the tree creation function
		$tree_string=$object->create_tree($id,$select_root);

		$sms_enabled=$GLOBALS['SITE_DB']->query_value_null_ok('tracking_info','id',array('t_type'=>$t_type,'t_member_id'=>get_member(),'t_use_sms'=>1));

		$email_enabled=$GLOBALS['SITE_DB']->query_value_null_ok('tracking_info','id',array('t_type'=>$t_type,'t_member_id'=>get_member(),'t_use_email'=>1));

		$sms	=	(!is_null($sms_enabled))? "checked='checked'":false;	
		$email=	(!is_null($email_enabled))? "checked='checked'":false;	

		return do_template('TRACKING_SCREEN',array('TITLE'=>$title,'TYPE'=>$t_type,'ID'=>$id,'T_CHILD'=>strval($child),'ACTION'=>$screen_from_url,'TREE'=>$tree_string,'SMS_ENABLED'=>$sms,'EMAIL_ENABLED'=>$email));
	}

	/**
	 * Function to save (delete/insert, as required) the tracking values to tracking_info
	 *
	 * @return tempcode	The result of execution.
	 */
	function do_save_screen()
	{
		$title=get_page_title('TRACKING');
		
		// Reading the posted values
		$t_cat_id=post_param('t_cat_id');
		$t_cat_type=post_param('t_cat_type');
		$tracking_tree=post_param('nodes');
		$sms=post_param_integer('sms',0);
		$email=post_param_integer('email',0);
		$child_flag=post_param_integer('track_child',0);

		// Getting the child nodes of catalogues using the site tree
		require_code('hooks/modules/tracking/'.$t_cat_type);
		$object=object_factory('Hook_tracking_'.$t_cat_type);

		$object->mark_tracking($t_cat_id,$child_flag,$tracking_tree,$email,$sms);

		$url=get_param('redirect',NULL);
		if (is_null($url))
		{
			$_url=build_url(array('page'=>'tracking','track_type'=>$t_cat_type,'id'=>$t_cat_id),get_module_zone('tracking'));
			$url=$_url->evaluate();
		}

		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}

	/**
	 * Function to remove the tracking values from tracking_info
	 *
	 * @return tempcode	The result of execution.
	 */
	function do_untracking_screen()
	{
		$title=get_page_title('TRACKING');
		
		// Reading the values given to this page for untracking the topic
		$id=get_param('id');
		$t_type=get_param('track_type');
		$user_id=get_member();
		$child=1;

		// Getting the child nodes of catalogues using the site tree
		require_code('hooks/modules/tracking/'.$t_type);
		$object=object_factory('Hook_tracking_'.$t_type);
		$object->unmark_tracking($id);

		$url=build_url(array('page'=>$t_type,'id'=>$id),'site');
		
		require_code('templates_redirect_screen');
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}

}
