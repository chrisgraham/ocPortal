<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unit_testing
 */

/**
 * ocPortal test case class (unit testing).
 */
class galleries_test_set extends ocp_test_case
{
	var $category_id;
	var $access_mapping;	
	var $cms_gal;
	var $cms_gal_alt;
	var $cms_gal_category;

	function setUp()
	{
		parent::setUp();

		$this->establish_admin_session();

		require_code('feedback');
		require_code('files2');
		require_code('autosave');
		require_code('permissions2');

		$this->access_mapping=array(db_get_first_id()=>4);
		// Creating cms catalogues object
		if (file_exists(get_file_base().'/cms/pages/modules_custom/cms_galleries.php'))
		{
			require_code('cms/pages/modules_custom/cms_galleries.php');
		} else
		{
			require_code('cms/pages/modules/cms_galleries.php');
		}

		$this->cms_gal=new Module_cms_galleries();
		$this->cms_gal->run_start('misc');
		$this->cms_gal_alt=new Module_cms_galleries_alt();
		$this->cms_gal_category=new Module_cms_galleries_cat();
	}

	function testAddgalleryUI()
	{
		return $this->cms_gal_category->ad();
	}

	function testAddgalleryActualiser()
	{
		//Setting sample data to POST
		$_POST=array(
			'saleable'=>1,
			'fullname'=>'A test gallery for UT',
			'require__fullname'=>1,
			'name'=>'a_test_gallery_for_ut',
			'require__name'=>1,
			'comcode__description'=>1,
			'description'=>'A test gallery for UT',

			'description_parsed'=>'',
			'require__rep_image'=>0,
			'hidFileID_rep_image'=>-1,
			'parent_id'=>'root',
			'require__parent_id'=>1,
			'secondary_parents'=>array(
						'0'=>'a_test_image',
				),

			'require__secondary_parents'=>0,
			'accept_images'=>1,
			'tick_on_form__accept_images'=>0,
			'require__accept_images'=>0,
			'accept_videos'=>1,
			'tick_on_form__accept_videos'=>0,
			'require__accept_videos'=>0,
			'tick_on_form__is_member_synched'=>0,
			'require__is_member_synched'=>0,
			'price'=>4,
			'require__price'=>1,
			'hours'=>240,
			'require__hours'=>0,
			'g_owner'=>'admin',
			'require__g_owner'=>0,
			'require__watermark_top_left'=>0,
			'hidFileID_watermark_top_left'=>-1,
			'require__watermark_top_right'=>0,
			'hidFileID_watermark_top_right'=>-1,
			'require__watermark_bottom_left'=>0,
			'hidFileID_watermark_bottom_left'=>-1,
			'require__watermark_bottom_right'=>0,
			'hidFileID_watermark_bottom_right'=>-1,
			'allow_rating'=>1,
			'tick_on_form__allow_rating'=>0,
			'require__allow_rating'=>0,
			'allow_comments'=>0,
			'require__allow_comments'=>1,
			'notes'=>'Test note',
			'teaser'=>'',
			'pre_f_notes'=>1,
			'require__notes'=>0,
			'access_1_presets'=>-1,
			'access_1'=>1,
			'access_9_presets'=>-1,
			'access_9'=>1,
			'access_12_presets'=>-1,
			'access_12'=>1,
			'access_11_presets'=>-1,
			'access_11'=>1,
			'access_13_presets'=>-1,
			'access_13'=>1,
			'access_14_presets'=>-1,
			'access_14'=>1,
			'access_15_presets'=>-1,
			'access_15'=>1,
			'access_10_presets'=>-1,
			'access_10'=>1,
			'meta_keywords'=>'',
			'require__meta_keywords'=>0,
			'meta_description'=>'',
			'require__meta_description'=>0,
			'tick_on_form__award_3'=>0,
			'require__award_3'=>0,
			'http_referer'=>'http://localhost/~manu/nomosa/cms/cms_galleries/ac.htm',
			'description__is_wysiwyg'=>1,
		);

		return $this->cms_gal_category->_ad();
	}

	function testEditgalleryActualiser()
	{
		//Setting sample data to POST
		$_POST=array(
			'saleable'=>1,
			'fullname'=>'A test gallery for UT- Edited',
			'require__fullname'=>1,
			'name'=>'a_test_gallery_for_ut',
			'require__name'=>1,
			'comcode__description'=>1,
			'description'=>'A test gallery for UT',	
			'description_parsed'=>'',
			'require__rep_image'=>0,
			'hidFileID_rep_image'=>-1,
			'parent_id'=>'root',
			'require__parent_id'=>1,
			'secondary_parents'=>array(
						'0'=>'a_test_image',
				),	
			'require__secondary_parents'=>0,
			'accept_images'=>1,
			'tick_on_form__accept_images'=>0,
			'require__accept_images'=>0,
			'accept_videos'=>1,
			'tick_on_form__accept_videos'=>0,
			'require__accept_videos'=>0,
			'tick_on_form__is_member_synched'=>0,
			'require__is_member_synched'=>0,
			'price'=>4,
			'require__price'=>1,
			'hours'=>240,
			'require__hours'=>0,
			'g_owner'=>'admin',
			'require__g_owner'=>0,
			'require__watermark_top_left'=>0,
			'hidFileID_watermark_top_left'=>-1,
			'require__watermark_top_right'=>0,
			'hidFileID_watermark_top_right'=>-1,
			'require__watermark_bottom_left'=>0,
			'hidFileID_watermark_bottom_left'=>-1,
			'require__watermark_bottom_right'=>0,
			'hidFileID_watermark_bottom_right'=>-1,
			'allow_rating'=>1,
			'tick_on_form__allow_rating'=>0,
			'require__allow_rating'=>0,
			'allow_comments'=>0,
			'require__allow_comments'=>1,
			'notes'=>'Test note',
			'pre_f_notes'=>1,
			'require__notes'=>0,
			'access_1_presets'=>-1,
			'access_1'=>1,
			'access_9_presets'=>-1,
			'access_9'=>1,
			'access_12_presets'=>-1,
			'access_12'=>1,
			'access_11_presets'=>-1,
			'access_11'=>1,
			'access_13_presets'=>-1,
			'access_13'=>1,
			'access_14_presets'=>-1,
			'access_14'=>1,
			'access_15_presets'=>-1,
			'access_15'=>1,
			'access_10_presets'=>-1,
			'access_10'=>1,
			'meta_keywords'=>'',
			'require__meta_keywords'=>0,
			'meta_description'=>'',
			'require__meta_description'=>0,
			'tick_on_form__award_3'=>0,
			'require__award_3'=>0,
			'http_referer'=>'http://localhost/~manu/nomosa/cms/cms_galleries/ac.htm',
			'description__is_wysiwyg'=>1,
		);

		//return $this->cms_gal_category->_ed();
	}

	function testAddimageUI()
	{
		//Checking gallery image adding UI
		return $this->cms_gal->ad();
	}

	function testAddImageActualiser()
	{
		//Test data add to POST
		$_POST=array(
			'title'=>'A test image',
			'require__title'=>0,
			'cat'=>'a_test_gallery_for_ut',
			'require__cat'=>1,
			'require__file'=>0,
			'hidFileID_file'=>-1,			
			'url'=>find_theme_image('loading'),
			'require__url'=>1,
			'require__file2'=>1,
			'hidFileID_file2'=>-1,
			'file2'=>'',
			'comcode__comments'=>1,
			'comments'=>'test description',		
			'comments_parsed'=>'',
			'validated'=>1,
			'tick_on_form__validated'=>0,
			'require__validated'=>0,
			'tick_on_form__rep_image'=>0,
			'require__rep_image'=>0,
			'allow_rating'=>1,
			'tick_on_form__allow_rating'=>0,
			'require__allow_rating'=>0,
			'allow_comments'=>1,
			'require__allow_comments'=>1,
			'allow_trackbacks'=>1,
			'tick_on_form__allow_trackbacks'=>0,
			'require__allow_trackbacks'=>0,
			'notes'=>'',
			'pre_f_notes'=>1,
			'require__notes'=>0,
			'meta_keywords'=>'',
			'require__meta_keywords'=>0,
			'meta_description'=>'',
			'require__meta_description'=>0,
			'comments__is_wysiwyg'=>1,
		);

		return $this->cms_gal->_ad();
	}

	function testAddVideoUI()
	{
		return $this->cms_gal_alt->ad();
	}

	function testAddVideoActuliser()
	{
		$_POST=array(
			'title'=>'A test video',
			'require__title'=>0,
			'cat'=>'a_test_gallery_for_ut',
			'require__cat'=>1,
			'require__file'=>0,
			'hidFileID_file'=>-1,			
			'url'=>'http://www.lcpvideo.com/MPEG/ACT60.MPG',
			'require__url'=>1,
			'require__file2'=>1,
			'hidFileID_file2'=>-1,
			'file2'=>'',
			'comcode__comments'=>1,
			'comments'=>'test description',		
			'comments_parsed'=>'',
			'validated'=>1,
			'tick_on_form__validated'=>0,
			'require__validated'=>0,
			'tick_on_form__rep_image'=>0,
			'require__rep_image'=>0,
			'allow_rating'=>1,
			'tick_on_form__allow_rating'=>0,
			'require__allow_rating'=>0,
			'allow_comments'=>1,
			'require__allow_comments'=>1,
			'allow_trackbacks'=>1,
			'tick_on_form__allow_trackbacks'=>0,
			'require__allow_trackbacks'=>0,
			'notes'=>'',
			'pre_f_notes'=>1,
			'require__notes'=>0,
			'meta_keywords'=>'',
			'require__meta_keywords'=>0,
			'meta_description'=>'',
			'require__meta_description'=>0,
			'comments__is_wysiwyg'=>1,
		);

		//return $this->cms_gal_alt->_ad();
	}

	function testDeleteGallery()
	{
		return $this->cms_gal_category->delete_actualisation('a_test_gallery_for_ut');
	}

}
