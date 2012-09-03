<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		classifieds
 */

class Module_classifieds
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array		Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham'; 
		$info['organisation']='ocProducts'; 
		$info['hacked_by']=NULL; 
		$info['hack_version']=NULL;
		$info['version']=1;
		$info['locked']=true;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('classifieds_prices');
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
			$GLOBALS['SITE_DB']->create_table('classifieds_prices',array(
				'id'=>'*AUTO',
				'c_catalogue_name'=>'ID_TEXT',
				//'c_category_id'=>'?AUTO_LINK',
				'c_days'=>'INTEGER',
				'c_label'=>'SHORT_TRANS',
				'c_price'=>'REAL',
			));
			$GLOBALS['SITE_DB']->create_index('classifieds_prices','c_catalogue_name',array('c_catalogue_name'));

			require_lang('classifieds');

			$prices=array(
				'ONE_WEEK'=>array(0.0,7),
				'ONE_MONTH'=>array(5.0,30),
				'THREE_MONTHS'=>array(12.0,90),
				'SIX_MONTHS'=>array(20.0,180),
				'ONE_YEAR'=>array(32.0,365),
			);
			foreach ($prices as $level=>$bits)
			{
				list($price,$days)=$bits;
				$GLOBALS['SITE_DB']->query_insert('classifieds_prices',array(
					'c_catalogue_name'=>'classifieds',
					'c_days'=>$days,
					'c_label'=>insert_lang(do_lang('CLASSIFIEDS_DEFAULT_PRICE_LEVEL_'.$level),2),
					'c_price'=>$price,
				));
			}
		}
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array		A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		require_lang('classifieds');

		$ret=array();
		if (!is_guest()) $ret['adverts']='CLASSIFIED_ADVERTS';
		return $ret;
	}

	/**
	 * Standard module run function.
	 *
	 * @return tempcode		The output of the run
	 */
	function run()
	{
		$type=get_param('type','adverts');

		if ($type=='adverts') return $this->adverts();

		return new ocp_tempcode();
	}

	/**
	 * View an overview of the members adverts on the system.
	 *
	 * @return tempcode		The UI
	 */
	function adverts()
	{
		require_lang('classifieds');
		require_code('catalogues');
		require_code('ecommerce');

		$member_id=get_param_integer('member_id',get_member());

		$title=get_screen_title(($member_id==get_member())?'CLASSIFIED_ADVERTS':'_CLASSIFIED_ADVERTS',true,array($GLOBALS['FORUM_DRIVER']->get_username($member_id)));

		if (is_guest()) access_denied('NOT_AS_GUEST');

		enforce_personal_access($member_id);

		$start=get_param_integer('classifieds_start',0);
		$max=get_param_integer('classifieds_max',30);

		require_code('templates_pagination');

		$max_rows=$GLOBALS['SITE_DB']->query_select_value('catalogue_entries e JOIN '.get_table_prefix().'classifieds_prices c ON c.c_catalogue_name=e.c_name','COUNT(*)',array('ce_submitter'=>$member_id));

		$rows=$GLOBALS['SITE_DB']->query_select('catalogue_entries e JOIN '.get_table_prefix().'classifieds_prices c ON c.c_catalogue_name=e.c_name',array('e.*'),array('ce_submitter'=>$member_id),'GROUP BY e.id ORDER BY ce_add_date DESC');
		if (count($rows)==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));

		$ads=array();
		foreach ($rows as $row)
		{
			$data_map=get_catalogue_entry_map($row,NULL,'CATEGORY','DEFAULT',get_param_integer('keep_catalogue_'.$row['c_name'].'_root',NULL),NULL,array(0));
			$ad_title=$data_map['FIELD_0'];

			$purchase_url=build_url(array('page'=>'purchase','type'=>'misc','filter'=>'CLASSIFIEDS_ADVERT','id'=>$row['id']),get_module_zone('purchase'));

			// We'll show all transactions against this ad
			$transaction_details=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'transactions WHERE purchase_id='.strval($row['id']).' AND item LIKE \''.db_encode_like('CLASSIFIEDS\_ADVERT\_%').'\'');
			$_transaction_details=array();
			foreach ($transaction_details as $t)
			{
				list($found,)=find_product_row($t['item']);
				if (!is_null($found))
				{
					$item_title=$found[4];
				} else $item_title=$t['item'];

				$_transaction_details[]=array(
					'T_ID'=>strval($t['id']),
					'PURCHASE_ID'=>strval($t['purchase_id']),
					'STATUS'=>$t['status'],
					'REASON'=>$t['reason'],
					'AMOUNT'=>float_format($t['amount']),
					'T_CURRENCY'=>$t['t_currency'],
					'LINKED'=>$t['linked'],
					'T_TIME'=>strval($t['t_time']),
					'ITEM'=>$t['item'],
					'ITEM_TITLE'=>$item_title,
					'PENDING_REASON'=>$t['pending_reason'],
					'T_MEMO'=>$t['t_memo'],
					'T_VIA'=>$t['t_via']
				);
			}
			$url_map=array('page'=>'catalogues','type'=>'entry','id'=>$row['id']);
			$url=build_url($url_map,'_SELF');

			// No known expiry status: put on free, or let expire
			if ($row['ce_last_moved']==$row['ce_add_date'])
			{
				require_code('classifieds');
				initialise_classified_listing($row);
			}

			$ads[]=array(
				'AD_TITLE'=>$ad_title,
				'TRANSACTION_DETAILS'=>$_transaction_details,
				'DATE'=>get_timezoned_date($row['ce_add_date']),
				'DATE_RAW'=>strval($row['ce_add_date']),
				'EXPIRES_DATE'=>get_timezoned_date($row['ce_last_moved']),
				'EXPIRES_DATE_RAW'=>strval($row['ce_last_moved']),
				'ACTIVE'=>$row['ce_validated']==1,
				'PURCHASE_URL'=>$purchase_url,
				'ID'=>strval($row['id']),
				'URL'=>$url,
				'NUM_VIEWS'=>integer_format($row['ce_views']),
			);
		}

		$pagination=pagination(do_lang('_CLASSIFIED_ADVERTS'),$start,'classifieds_start',$max,'classifieds_max',$max_rows);

		return do_template('CLASSIFIED_ADVERTS_SCREEN',array('_GUID'=>'b25659c245a738b4f161dc87869d9edc','TITLE'=>$title,'RESULTS_BROWSER'=>$results_browser,'ADS'=>$ads));
	}

}
