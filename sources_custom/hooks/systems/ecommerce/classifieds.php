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

class Hook_classifieds
{

	/**
	 * Function for administrators to pick an identifier (only used by admins, usually the identifier would be picked via some other means in the wider ocPortal codebase).
	 *
	 * @param  ID_TEXT		Product type code.
	 * @return ?tempcode		Input field in standard Tempcode format for fields (NULL: no identifier).
	 */
	function get_identifier_manual_field_inputter($type_code)
	{
		require_code('catalogues');
		require_lang('classifieds');

		$list=new ocp_tempcode();
		$rows=$GLOBALS['SITE_DB']->query_select('catalogue_entries e JOIN '.get_table_prefix().'classifieds_prices c ON c.c_catalogue_name=e.c_name',array('e.*'),NULL,'GROUP BY e.id ORDER BY ce_add_date DESC');
		foreach ($rows as $row)
		{
			$data_map=get_catalogue_entry_map($row,NULL,'CATEGORY','DEFAULT',NULL,NULL,array(0));
			$ad_title=$data_map['FIELD_0'];

			$username=$GLOBALS['FORUM_DRIVER']->get_username($row['ce_submitter']);
			if (is_null($username)) $username=do_lang('UNKNOWN');
			$list->attach(form_input_list_entry(strval($row['id']),get_param_integer('id',NULL)===$row['id'],do_lang('CLASSIFIED_OF',strval($row['id']),$username,$ad_title)));
		}
		return form_input_list(do_lang_tempcode('ENTRY'),'','purchase_id',$list);
	}

	/**
	 * Get the products handled by this eCommerce hook.
	 *
	 * @return array		A map of product name to list of product details.
	 */
	function get_products()
	{
		require_lang('classifieds');

		$prices=$GLOBALS['SITE_DB']->query_select('classifieds_prices',array('id','c_label','c_price'),NULL,'ORDER BY c_price');

		$products=array();
		foreach ($prices as $price)
		{
			if ($price['c_price']!=0.0)
			{
				$products['CLASSIFIEDS_ADVERT_'.strval($price['id'])]=array(PRODUCT_PURCHASE_WIZARD,float_to_raw_string($price['c_price']),'handle_classifieds_advert',array(),do_lang('CLASSIFIED_ADVERT_BUY',get_translated_text($price['c_label'])));
			}
		}

		return $products;
	}

	/**
	 * Whether this product is available.
	 *
	 * @return integer	The availability code (a ECOMMERCE_PRODUCT_* constant).
	 */
	function is_available()
	{
		return ECOMMERCE_PRODUCT_AVAILABLE;
	}

	/**
	 * Throw out the ID we're buying.
	 *
	 * @param  ID_TEXT	The product chosen.
	 * @return ID_TEXT	The purchase ID.
	 */
	function set_needed_fields($product)
	{
		$entry_id=get_param_integer('id',NULL);
		if (is_null($entry_id)) return '';

		$matches=array();
		if (preg_match('#^CLASSIFIEDS\_ADVERT\_(\d+)$#',$product,$matches)!=0)
		{
			$entry_catalogue_name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_entries','c_name',array('id'=>$entry_id));
			if (is_null($entry_catalogue_name)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

			// Check this is a valid purchase for the product
			$classified_price_catalogue_name=$GLOBALS['SITE_DB']->query_value_null_ok('classifieds_prices','c_catalogue_name',array('id'=>intval($matches[1])));
			if ($classified_price_catalogue_name!=$entry_catalogue_name)
				warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
		} else
		{ // Bizarre if this happened
			warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
		}

		return strval($entry_id);
	}

}

/**
 * Handling of a purchased classifieds advert.
 *
 * @param  ID_TEXT	The purchase ID.
 * @param  array		Details relating to the product.
 * @param  ID_TEXT	The product.
 */
function handle_classifieds_advert($purchase_id,$details,$product)
{
	$days=$GLOBALS['SITE_DB']->query_value_null_ok('classifieds_prices','c_days',array('id'=>intval(substr($product,19))));

	// Make validated, bump up timer
	$time=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_entries','ce_last_moved',array('id'=>intval($purchase_id)));
	if (!is_null($time))
	{
		$time+=$days*60*60*24;
		$GLOBALS['SITE_DB']->query_update('catalogue_entries',array('ce_validated'=>1,'ce_last_moved'=>$time),array('id'=>intval($purchase_id)),'',1);
		require_code('catalogues2');
		$cc_id=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_entries','cc_id',array('id'=>intval($purchase_id)));
		calculate_category_child_count_cache($cc_id);
	}
}

