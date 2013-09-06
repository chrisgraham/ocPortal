<?php
/*

ocPortal
Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		news
 */

class Hook_addon_registry_news
{
	/**
	 * Get a list of file permissions to set
	 *
	 * @return array			File permissions to set
	 */
	function get_chmod_array()
	{
		return array();
	}

	/**
	 * Get the version of ocPortal this addon is for
	 *
	 * @return float			Version number
	 */
	function get_version()
	{
		return ocp_version_number();
	}

	/**
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
	function get_description()
	{
		return 'News and blogging.';
	}

	/**
	 * Get a mapping of dependency types
	 *
	 * @return array			File permissions to set
	 */
	function get_dependencies()
	{
		return array(
			'requires'=>array(
				'news_shared'
			),
			'recommends'=>array(),
			'conflicts_with'=>array()
		);
	}

	/**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(
			'sources/hooks/systems/notifications/news_entry.php',
			'sources/hooks/modules/admin_setupwizard_installprofiles/blog.php',
			'sources/hooks/systems/realtime_rain/news.php',
			'sources/hooks/systems/content_meta_aware/news.php',
			'sources/hooks/systems/content_meta_aware/news_category.php',
			'sources/hooks/systems/meta/news.php',
			'sources/hooks/blocks/side_stats/stats_news.php',
			'sources/hooks/systems/addon_registry/news.php',
			'sources/hooks/modules/admin_import_types/news.php',
			'sources/hooks/systems/config_default/blog_update_time.php',
			'sources/hooks/systems/config_default/news_show_stats_count_blogs.php',
			'sources/hooks/systems/config_default/news_show_stats_count_total_posts.php',
			'sources/hooks/systems/config_default/news_update_time.php',
			'sources/hooks/systems/config_default/ping_url.php',
			'sources/hooks/systems/config_default/points_ADD_NEWS.php',
			'sources/hooks/systems/profiles_tabs/blog.php',
			'NEWS_ARCHIVE_SCREEN.tpl',
			'NEWS_ENTRY_SCREEN.tpl',
			'BLOCK_BOTTOM_NEWS.tpl',
			'BLOCK_MAIN_NEWS.tpl',
			'BLOCK_SIDE_NEWS_ARCHIVE.tpl',
			'BLOCK_SIDE_NEWS.tpl',
			'BLOCK_SIDE_NEWS_SUMMARY.tpl',
			'BLOCK_SIDE_NEWS_CATEGORIES.tpl',
			'BLOCK_SIDE_NEWS_CATEGORIES_CATEGORY.tpl',
			'NEWS_CHICKLETS.tpl',
			'NEWS_WORDPRESS_IMPORT_SCREEN.tpl',
			'themes/default/images/newscats/index.html',
			'themes/default/images/bigicons/news.png',
			'themes/default/images/newscats/art.jpg',
			'themes/default/images/newscats/business.jpg',
			'themes/default/images/newscats/community.jpg',
			'themes/default/images/newscats/difficulties.jpg',
			'themes/default/images/newscats/entertainment.jpg',
			'themes/default/images/newscats/general.jpg',
			'themes/default/images/newscats/technology.jpg',
			'themes/default/images/pagepics/news.png',
			'cms/pages/modules/cms_news.php',
			'cms/pages/modules/cms_blogs.php',
			'site/pages/modules/news.php',
			'sources/blocks/bottom_news.php',
			'sources/blocks/main_news.php',
			'sources/blocks/side_news.php',
			'sources/blocks/side_news_archive.php',
			'sources/blocks/side_news_categories.php',
			'sources/hooks/blocks/main_staff_checklist/news.php',
			'sources/hooks/modules/admin_setupwizard/news.php',
			'sources/hooks/modules/admin_unvalidated/news.php',
			'sources/hooks/modules/members/news.php',
			'sources/hooks/modules/search/news.php',
			'sources/hooks/systems/attachments/news.php',
			'sources/hooks/systems/awards/news.php',
			'sources/hooks/systems/do_next_menus/news.php',
			'sources/hooks/systems/module_permissions/news.php',
			'sources/hooks/systems/preview/news.php',
			'sources/hooks/systems/rss/news.php',
			'sources/hooks/systems/trackback/news.php',
			'sources/news.php',
			'sources/news2.php',
			'sources/hooks/modules/admin_import/rss.php',
			'sources/hooks/modules/admin_newsletter/news.php',
			'sources/hooks/blocks/main_staff_checklist/blog.php',
			'OCF_MEMBER_PROFILE_BLOG.tpl',
			'sources/news_sitemap.php',
			'ocp_news_sitemap.xml',
		);
	}


	/**
	 * Get mapping between template names and the method of this class that can render a preview of them
	 *
	 * @return array			The mapping
	 */
	function tpl_previews()
	{
		return array(
			'BLOCK_SIDE_NEWS_ARCHIVE.tpl'=>'block_side_news_archive',
			'BLOCK_MAIN_NEWS.tpl'=>'block_main_news',
			'BLOCK_SIDE_NEWS.tpl'=>'block_side_news',
			'BLOCK_SIDE_NEWS_CATEGORIES.tpl'=>'block_side_news_categories',
			'BLOCK_SIDE_NEWS_CATEGORIES_CATEGORY.tpl'=>'block_side_news_categories',
			'BLOCK_SIDE_NEWS_SUMMARY.tpl'=>'block_side_news',
			'BLOCK_BOTTOM_NEWS.tpl'=>'block_bottom_news',
			'NEWS_ENTRY_SCREEN.tpl'=>'news_full_screen',
			'NEWS_CHICKLETS.tpl'=>'news_chicklets',
			'NEWS_ARCHIVE_SCREEN.tpl'=>'news_archive_screen',
			'NEWS_WORDPRESS_IMPORT_SCREEN.tpl'=>'administrative__news_wordpress_import_screen',
			'NEWS_BRIEF.tpl'=>'news_archive_screen',
			'NEWS_BOX.tpl'=>'block_main_news',
			'OCF_MEMBER_PROFILE_BLOG.tpl'=>'ocf_member_profile_blog'
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__ocf_member_profile_blog()
	{
		require_lang('news');

		$tab_content=do_lorem_template('OCF_MEMBER_PROFILE_BLOG', array(
			'MEMBER_ID'=>placeholder_id(),
			'RECENT_BLOG_POSTS'=>lorem_paragraph_html(),
			'RSS_URL'=>placeholder_url(),
			'ADD_BLOG_POST_URL'=>placeholder_url(),
			'PAGINATION'=>placeholder_pagination()
		));
		return array(
			lorem_globalise($tab_content, NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_side_news_archive()
	{
		require_lang('news');
		require_lang('dates');

		return array(
			lorem_globalise(do_lorem_template('BLOCK_SIDE_NEWS_ARCHIVE', array(
				'TITLE'=>lorem_phrase(),
				'YEARS'=>array(
					array(
						'YEAR'=>'2010',
						'TIMES'=>array(
							array(
								'MONTH'=>'2',
								'MONTH_STRING'=>do_lang('FEBRUARY'),
								'URL'=>placeholder_url()
							),
							array(
								'MONTH'=>'1',
								'MONTH_STRING'=>do_lang('JANUARY'),
								'URL'=>placeholder_url()
							)
						)
					),
					array(
						'YEAR'=>'2009',
						'TIMES'=>array(
							array(
								'MONTH'=>'12',
								'MONTH_STRING'=>do_lang('DECEMBER'),
								'URL'=>placeholder_url()
							),
							array(
								'MONTH'=>'11',
								'MONTH_STRING'=>do_lang('NOVEMBER'),
								'URL'=>placeholder_url()
							)
						)
					)
				)
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_main_news()
	{
		require_lang('news');
		require_lang('ocf');
		require_css('news');
		$contents=new ocp_tempcode();
		foreach (placeholder_array() as $k=>$v)
		{
			$contents->attach(do_lorem_template('NEWS_BOX', array(
				'BLOG'=>lorem_phrase(),
				'AUTHOR_URL'=>placeholder_url(),
				'CATEGORY'=>lorem_phrase(),
				'IMG'=>placeholder_image_url(),
				'AUTHOR'=>lorem_phrase(),
				'_AUTHOR'=>lorem_phrase(),
				'SUBMITTER'=>placeholder_id(),
				'AVATAR'=>lorem_phrase(),
				'NEWS_TITLE'=>lorem_phrase(),
				'DATE'=>lorem_phrase(),
				'NEWS'=>lorem_phrase(),
				'COMMENTS'=>lorem_phrase(),
				'VIEW'=>lorem_phrase(),
				'ID'=>placeholder_id(),
				'FULL_URL'=>placeholder_url(),
				'COMMENT_COUNT'=>lorem_phrase(),
				'READ_MORE'=>lorem_sentence(),
				'TRUNCATE'=>false,
				'FIRSTTIME'=>lorem_word(),
				'LASTTIME'=>lorem_word_2(),
				'CLOSED'=>lorem_word(),
				'FIRSTUSERNAME'=>lorem_word(),
				'LASTUSERNAME'=>lorem_word(),
				'FIRSTMEMBERID'=>lorem_word(),
				'LASTMEMBERID'=>lorem_word(),
				'DATE_RAW'=>lorem_word(),
				'TAGS'=>''
			)));
		}

		return array(
			lorem_globalise(do_lorem_template('BLOCK_MAIN_NEWS', array(
				'BLOG'=>TRUE,
				'TITLE'=>lorem_phrase(),
				'CONTENT'=>$contents,
				'RSS_URL'=>placeholder_url(),
				'ATOM_URL'=>placeholder_url(),
				'SUBMIT_URL'=>placeholder_url(),
				'ARCHIVE_URL'=>placeholder_url(),
				'BRIEF'=>lorem_phrase()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__administrative__news_wordpress_import_screen()
	{
		require_lang('news');
		return array(
			lorem_globalise(do_lorem_template('NEWS_WORDPRESS_IMPORT_SCREEN', array(
				'TITLE'=>lorem_title(),
				'XML_UPLOAD_FORM'=>placeholder_form(),
				'DB_IMPORT_FORM'=>placeholder_form()
			)), NULL, '', true)
		);
	}


	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__news_archive_screen()
	{
		$content=do_lorem_template('NEWS_BRIEF', array(
			'DATE'=>placeholder_time(),
			'URL'=>placeholder_url(),
			'TITLE_PLAIN'=>lorem_word(),
			'ID'=>placeholder_id(),
			'TITLE'=>lorem_word()
		));

		return array(
			lorem_globalise(do_lorem_template('NEWS_ARCHIVE_SCREEN', array(
				'TITLE'=>lorem_title(),
				'CONTENT'=>$content,
				'SUBMIT_URL'=>placeholder_url(),
				'BLOG'=>false,
				'BROWSE'=>do_lorem_template('NEXT_BROWSER_BROWSE_NEXT', array(
					'PREVIOUS_URL'=>placeholder_url(),
					'NEXT_URL'=>placeholder_url(),
					'PAGE_NUM'=>placeholder_number(),
					'NUM_PAGES'=>placeholder_number()
				))
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__news_chicklets()
	{
		require_css('news');

		return array(
			lorem_globalise(do_lorem_template('NEWS_CHICKLETS', array(
				'RSS_URL'=>placeholder_url()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_side_news()
	{
		$contents=new ocp_tempcode();
		foreach (placeholder_array() as $k=>$v)
		{
			$contents->attach(do_lorem_template('BLOCK_SIDE_NEWS_SUMMARY', array(
				'ID'=>placeholder_id(),
				'SUBMITTER'=>placeholder_id(),
				'AUTHOR'=>lorem_phrase(),
				'IMG_URL'=>placeholder_image_url(),
				'CATEGORY'=>lorem_phrase(),
				'BLOG'=>TRUE,
				'FULL_URL'=>placeholder_url(),
				'NEWS'=>lorem_paragraph(),
				'NEWS_TITLE'=>lorem_phrase(),
				'_DATE'=>placeholder_date_raw(),
				'DATE'=>placeholder_time()
			)));
		}

		return array(
			lorem_globalise(do_lorem_template('BLOCK_SIDE_NEWS', array(
				'BLOG'=>TRUE,
				'TITLE'=>lorem_phrase(),
				'CONTENT'=>$contents,
				'SUBMIT_URL'=>placeholder_url(),
				'ARCHIVE_URL'=>placeholder_url()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_side_news_categories()
	{
		require_lang('news');
		$contents=new ocp_tempcode();
		foreach (placeholder_array() as $k=>$v)
		{
			$contents->attach(do_lorem_template('BLOCK_SIDE_NEWS_CATEGORIES_CATEGORY', array(
				'URL'=>placeholder_url(),
				'NAME'=>lorem_phrase(),
				'COUNT'=>placeholder_random()
			)));
		}
		return array(
			lorem_globalise(do_lorem_template('BLOCK_SIDE_NEWS_CATEGORIES', array(
				'CONTENT'=>$contents,
				'PRE'=>'',
				'POST'=>''
			)), NULL, '', true)
		);
	}
	function tpl_preview__block_bottom_news()
	{
		$contents_arr=array();
		foreach (placeholder_array() as $k=>$v)
		{
			$contents_arr[]=array(
				'DATE'=>placeholder_time(),
				'FULL_URL'=>placeholder_url(),
				'NEWS_TITLE'=>lorem_word()
			);
		}
		return array(
			lorem_globalise(do_lorem_template('BLOCK_BOTTOM_NEWS', array(
				'BLOG'=>TRUE,
				'POSTS'=>$contents_arr
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__news_full_screen()
	{
		require_lang('news');

		$tags=array();
		foreach (placeholder_array() as $k=>$v)
		{
			$tags[]=array(
				'TAG'=>lorem_word(),
				'LINK_LIMITEDSCOPE'=>placeholder_url(),
				'LINK_FULLSCOPE'=>placeholder_url()
			);
		}

		$comment_details=do_lorem_template('COMMENTS_POSTING_FORM', array(
			'JOIN_BITS'=>lorem_phrase_html(),
			'USE_CAPTCHA'=>false,
			'EMAIL_OPTIONAL'=>lorem_word(),
			'POST_WARNING'=>'',
			'COMMENT_TEXT'=>'',
			'GET_EMAIL'=>true,
			'GET_TITLE'=>true,
			'EM'=>placeholder_emoticon_chooser(),
			'DISPLAY'=>'block',
			'COMMENT_URL'=>placeholder_url(),
			'TITLE'=>lorem_phrase(),
			'MAKE_POST'=>true,
			'CREATE_TICKET_MAKE_POST'=>true,
			'FIRST_POST_URL'=>'',
			'FIRST_POST'=>''
		));

		return array(
			lorem_globalise(do_lorem_template('NEWS_ENTRY_SCREEN', array(
				'ID'=>placeholder_id(),
				'CATEGORY_ID'=>placeholder_id(),
				'BLOG'=>TRUE,
				'_TITLE'=>lorem_phrase(),
				'TAGS'=>do_lorem_template('TAGS', array(
					'TAGS'=>$tags,
					'TYPE'=>''
				)),
				'CATEGORIES'=>placeholder_array(),
				'NEWSLETTER_URL'=>addon_installed('newsletter') ? placeholder_url() : '',
				'ADD_DATE_RAW'=>placeholder_date_raw(),
				'EDIT_DATE_RAW'=>'',
				'SUBMITTER'=>placeholder_id(),
				'CATEGORY'=>lorem_word(),
				'IMG'=>placeholder_image(),
				'TITLE'=>lorem_title(),
				'VIEWS'=>"3",
				'COMMENT_DETAILS'=>$comment_details,
				'RATING_DETAILS'=>lorem_sentence(),
				'TRACKBACK_DETAILS'=>lorem_sentence(),
				'DATE'=>placeholder_time(),
				'AUTHOR'=>lorem_word(),
				'AUTHOR_URL'=>placeholder_url(),
				'NEWS_FULL'=>lorem_paragraph(),
				'NEWS_FULL_PLAIN'=>lorem_sentence(),
				'EDIT_URL'=>placeholder_url(),
				'ARCHIVE_URL'=>placeholder_url(),
				'SUBMIT_URL'=>placeholder_url(),
				'WARNING_DETAILS'=>''
			)), NULL, '', true)
		);
	}
}
