<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		iotds
 */

/**
 * Module page class.
 */
class Module_iotds
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
		$info['update_require_upgrade']=1;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('iotd');

		delete_privilege('choose_iotd');

		$GLOBALS['SITE_DB']->query_delete('trackbacks',array('trackback_for_type'=>'iotds'));

		require_code('files');
		deldir_contents(get_custom_file_base().'/uploads/iotds',true);
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
			$GLOBALS['SITE_DB']->create_table('iotd',array(
				'id'=>'*AUTO',
				'url'=>'URLPATH',
				'i_title'=>'SHORT_TRANS',
				'caption'=>'LONG_TRANS',	// Comcode
				'thumb_url'=>'URLPATH',
				'is_current'=>'BINARY',
				'allow_rating'=>'BINARY',
				'allow_comments'=>'SHORT_INTEGER',
				'allow_trackbacks'=>'BINARY',
				'notes'=>'LONG_TEXT',
				'used'=>'BINARY',
				'date_and_time'=>'?TIME',
				'iotd_views'=>'INTEGER',
				'submitter'=>'MEMBER',
				'add_date'=>'TIME',
				'edit_date'=>'?TIME'
			));

			$GLOBALS['SITE_DB']->create_index('iotd','iotd_views',array('iotd_views'));
			$GLOBALS['SITE_DB']->create_index('iotd','get_current',array('is_current'));
			$GLOBALS['SITE_DB']->create_index('iotd','ios',array('submitter'));
			$GLOBALS['SITE_DB']->create_index('iotd','iadd_date',array('add_date'));
			$GLOBALS['SITE_DB']->create_index('iotd','date_and_time',array('date_and_time'));

			add_privilege('IOTDS','choose_iotd',false);

			$GLOBALS['SITE_DB']->create_index('iotd','ftjoin_icap',array('caption'));
		}
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @param  boolean	Whether to check permissions.
	 * @param  ?MEMBER	The member to check permissions as (NULL: current user).
	 * @param  boolean	Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
	 * @param  boolean	Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "misc" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
	 * @return ?array		A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (NULL: disabled).
	 */
	function get_entry_points($check_perms=true,$member_id=NULL,$support_crosslinks=true,$be_deferential=false)
	{
		return array(
			'misc'=>array('IOTDS','menu/rich_content/iotds'),
		);
	}

	var $title;
	var $id;
	var $myrow;
	var $url;

	/**
	 * Standard modular pre-run function, so we know meta-data for <head> before we start streaming output.
	 *
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run()
	{
		$type=get_param('type','misc');

		require_lang('iotds');

		if ($type=='misc')
		{
			$this->title=get_screen_title('IOTD_ARCHIVE');
		}

		if ($type=='view')
		{
			set_feed_url('?mode=iotds&filter=');

			$id=get_param_integer('id');

			// Breadcrumbs
			breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('IOTD_ARCHIVE'))));

			// Fetch details
			$rows=$GLOBALS['SITE_DB']->query_select('iotd',array('*'),array('id'=>$id),'',1);
			if (!array_key_exists(0,$rows))
			{
				return warn_screen($this->title,do_lang_tempcode('MISSING_RESOURCE'));
			}
			$myrow=$rows[0];
			$url=$myrow['url'];
			if (url_is_local($url)) $url=get_custom_base_url().'/'.$url;

			// Meta data
			set_extra_request_metadata(array(
				'created'=>date('Y-m-d',$myrow['add_date']),
				'creator'=>$GLOBALS['FORUM_DRIVER']->get_username($myrow['submitter']),
				'publisher'=>'', // blank means same as creator
				'modified'=>is_null($myrow['edit_date'])?'':date('Y-m-d',$myrow['edit_date']),
				'type'=>'Poll',
				'title'=>get_translated_text($myrow['i_title']),
				'identifier'=>'_SEARCH:iotds:view:'.strval($id),
				'description'=>'',
				'image'=>$url,
			));

			$this->title=get_screen_title('IOTD');

			$this->id=$id;
			$this->myrow=$myrow;
			$this->url=$url;
		}

		return NULL;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_code('feedback');
		require_code('iotds');
		require_css('iotds');

		// What action are we going to do?
		$type=get_param('type','misc');

		if ($type=='misc') return $this->iotd_browse();
		if ($type=='view') return $this->view();

		return new ocp_tempcode();
	}

	/**
	 * The UI to browse IOTDs.
	 *
	 * @return tempcode		The UI
	 */
	function iotd_browse()
	{
		$content=do_block('main_multi_content',array('param'=>'iotd','efficient'=>'0','zone'=>'_SELF','sort'=>'recent','max'=>'10','no_links'=>'1','pagination'=>'1','give_context'=>'0','include_breadcrumbs'=>'0','block_id'=>'module'));

		return do_template('PAGINATION_SCREEN',array('_GUID'=>'d8a493c2b007d98074f104ea433c8091','TITLE'=>$this->title,'CONTENT'=>$content));
	}

	/**
	 * The UI to view an IOTD.
	 *
	 * @return tempcode		The UI
	 */
	function view()
	{
		$id=$this->id;
		$myrow=$this->myrow;
		$url=$this->url;

		// Feedback
		list($rating_details,$comment_details,$trackback_details)=embed_feedback_systems(
			get_page_name(),
			strval($id),
			$myrow['allow_rating'],
			$myrow['allow_comments'],
			$myrow['allow_trackbacks'],
			((is_null($myrow['date_and_time'])) && ($myrow['used']==0))?0:1,
			$myrow['submitter'],
			build_url(array('page'=>'_SELF','type'=>'view','id'=>$id),'_SELF',NULL,false,false,true),
			get_translated_text($myrow['i_title']),
			find_overridden_comment_forum('iotds'),
			$myrow['add_date']
		);

		$date=get_timezoned_date($myrow['date_and_time']);
		$date_raw=strval($myrow['date_and_time']);
		$add_date=get_timezoned_date($myrow['add_date']);
		$add_date_raw=strval($myrow['add_date']);
		$edit_date=get_timezoned_date($myrow['edit_date']);
		$edit_date_raw=is_null($myrow['edit_date'])?'':strval($myrow['edit_date']);

		// Views
		if ((get_db_type()!='xml') && (get_value('no_view_counts')!=='1'))
		{
			$myrow['iotd_views']++;
			if (!$GLOBALS['SITE_DB']->table_is_locked('iotd'))
				$GLOBALS['SITE_DB']->query_update('iotd',array('iotd_views'=>$myrow['iotd_views']),array('id'=>$id),'',1,NULL,false,true);
		}

		// Management links
		if ((has_actual_page_access(NULL,'cms_iotds',NULL,NULL)) && (has_edit_permission('high',get_member(),$myrow['submitter'],'cms_iotds')))
		{
			$edit_url=build_url(array('page'=>'cms_iotds','type'=>'_ed','id'=>$id),get_module_zone('cms_iotds'));
		} else $edit_url=new ocp_tempcode();

		return do_template('IOTD_ENTRY_SCREEN',array(
			'_GUID'=>'f508d483459b88fab44cd8b9f4db780b',
			'TITLE'=>$this->title,
			'SUBMITTER'=>strval($myrow['submitter']),
			'I_TITLE'=>get_translated_tempcode($myrow['i_title']),
			'CAPTION'=>get_translated_tempcode($myrow['caption']),
			'DATE'=>$date,
			'DATE_RAW'=>$date_raw,
			'ADD_DATE'=>$add_date,
			'ADD_DATE_RAW'=>$add_date_raw,
			'EDIT_DATE'=>$edit_date,
			'EDIT_DATE_RAW'=>$edit_date_raw,
			'VIEWS'=>integer_format($myrow['iotd_views']),
			'TRACKBACK_DETAILS'=>$trackback_details,
			'RATING_DETAILS'=>$rating_details,
			'COMMENT_DETAILS'=>$comment_details,
			'EDIT_URL'=>$edit_url,
			'URL'=>$url,
		));
	}
}


