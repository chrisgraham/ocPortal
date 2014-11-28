<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}

@chdir($FILE_BASE);

if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>');

require($FILE_BASE.'/sources/global.php');

set_time_limit(0);
safe_ini_set('ocproducts.xss_detect','0');
@header('Content-type: text/plain; charset='.get_charset());
disable_php_memory_limit();
if (function_exists('gc_enable')) gc_enable();

$GLOBALS['NO_QUERY_LIMIT']=true;

do_work();

function do_work()
{
	$num_wanted=100000;


	require_code('config2');
	set_option('post_history_days','0'); // Needed for a little sanity in recent post retrieval
	set_value('disable_sunk','1');

	set_mass_import_mode();


	// members (remember to test the username autocompleter, and birthdays)
	// authors (remember to check author autocompleter and popup author list)
	// lots of people getting notifications on a forum
	// lots of people getting notifications on a topic
	require_code('authors');
	require_code('ocf_members_action');
	require_code('notifications');
	for ($i=$GLOBALS['FORUM_DB']->query_value('f_members','COUNT(*)');$i<$num_wanted;$i++)
	{
		$member_id=ocf_make_member(uniqid('',true),uniqid('',true),uniqid('',true).'@example.com',array(),intval(date('d')),intval(date('m')),intval(date('Y')),array(),NULL,NULL,1,NULL,NULL,'',NULL,'',0,0,1,'','','',1,1,NULL,1,1,'',NULL,'',false);
		add_author(random_line(),'',$member_id,random_text(),random_text());

		enable_notifications('ocf_topic','forum:'.strval(db_get_first_id()),$member_id);

		enable_notifications('ocf_topic',strval(db_get_first_id()),$member_id);

		// number of friends to a single member
		$GLOBALS['SITE_DB']->query_insert('chat_buddies',array(
			'member_likes'=>$member_id,
			'member_liked'=>db_get_first_id()+1,
			'date_and_time'=>time()
		),false,true);
	}
	$member_id=db_get_first_id()+2;
	// point earn list / gift points to a single member
	require_code('points2');
	for ($j=$GLOBALS['SITE_DB']->query_value('gifts','COUNT(*)');$j<$num_wanted;$j++)
	{
		give_points(10,$member_id,mt_rand(db_get_first_id(),/*don't want wide distribution as points cacheing then eats RAM*/min(100,$num_wanted-1)),random_line(),false,false);
	}
	// number of friends of a single member
	for ($j=intval(floatval($GLOBALS['SITE_DB']->query_value('chat_buddies','COUNT(*)'))/2.0);$j<$num_wanted;$j++)
	{
		$GLOBALS['SITE_DB']->query_insert('chat_buddies',array(
			'member_likes'=>$member_id,
			'member_liked'=>$j+db_get_first_id(),
			'date_and_time'=>time()
		),false,true);
	}
	echo 'done member/authors/points/notifications/friends stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// banners
	require_code('banners2');
	for ($i=$GLOBALS['SITE_DB']->query_value('banners','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_banner(uniqid('',true),get_logo_url(),random_line(),random_text(),'',100,get_base_url(),3,'',db_get_first_id(),NULL,db_get_first_id()+1,1);
	}
	echo 'done banner stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// comcode pages
	require_code('files');
	require_code('files2');
	for ($i=$GLOBALS['SITE_DB']->query_value('comcode_pages','COUNT(*)');$i<$num_wanted;$i++)
	{
		$file=uniqid('',true);
		/*$path=get_custom_file_base().'/site/pages/comcode_custom/'.fallback_lang().'/'.$file.'.txt';
		$myfile=fopen($path,'wt');
		fwrite($myfile,random_text());
		fclose($myfile);
		sync_file($path);
		fix_permissions($path);*/
		$GLOBALS['SITE_DB']->query_insert('comcode_pages',array(
			'the_zone'=>'site',
			'the_page'=>$file,
			'p_parent_page'=>'',
			'p_validated'=>1,
			'p_edit_date'=>NULL,
			'p_add_date'=>time(),
			'p_submitter'=>db_get_first_id(),
			'p_show_as_edit'=>0
		));
	}
	echo 'done comcode stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// zones
	require_code('zones2');
	require_code('abstract_file_manager');
	for ($i=$GLOBALS['SITE_DB']->query_value('zones','COUNT(*)');$i<min($num_wanted,1000/* lets be somewhat reasonable! */);$i++)
	{
		actual_add_zone(uniqid('',true),random_line(),'start',random_line(),'default',0,0,0);
	}
	echo 'done zone stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// calendar events
	require_code('calendar2');
	for ($i=$GLOBALS['SITE_DB']->query_value('calendar_events','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_calendar_event(db_get_first_id(),'',NULL,0,random_line(),random_text(),1,1,intval(date('Y')),intval(date('m')),intval(date('d')),'day_of_month',0,0);
	}
	echo 'done event stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// chat rooms
	require_code('chat2');
	require_code('chat');
	for ($i=$GLOBALS['SITE_DB']->query_value('chat_rooms','COUNT(*)');$i<$num_wanted;$i++)
	{
		$room_id=add_chatroom(random_text(),random_line(),mt_rand(db_get_first_id()+1,$num_wanted-1),strval(db_get_first_id()+1),'','','',fallback_lang());
	}
	$room_id=db_get_first_id()+1;
	// messages in chat room
	for ($j=$GLOBALS['SITE_DB']->query_value('chat_messages','COUNT(*)');$j<$num_wanted;$j++)
	{
		$_message_parsed=insert_lang_comcode(random_text(),4);
		$GLOBALS['SITE_DB']->query_insert('chat_messages',array('system_message'=>0,'ip_address'=>'','room_id'=>$room_id,'user_id'=>db_get_first_id(),'date_and_time'=>time(),'the_message'=>$_message_parsed,'text_colour'=>get_option('chat_default_post_colour'),'font_name'=>get_option('chat_default_post_font')));
	}
	echo 'done chat stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// download categories under a subcategory
	require_code('downloads2');
	$subcat_id=add_download_category(random_line(),db_get_first_id(),random_text(),'');
	for ($i=$GLOBALS['SITE_DB']->query_value('download_categories','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_download_category(random_line(),$subcat_id,random_text(),'');
	}
	// downloads (remember to test content by the single author)
	require_code('downloads2');
	require_code('awards');
	$time=time();
	for ($i=$GLOBALS['SITE_DB']->query_value('download_downloads','COUNT(*)');$i<$num_wanted;$i++)
	{
		$content_id=add_download(db_get_first_id(),random_line(),get_logo_url(),random_text(),'admin',random_text(),NULL,1,1,1,1,'',uniqid('',true).'.jpg',100,110,1);
		give_award(db_get_first_id(),strval($content_id),$time-$i);
	}
	$content_id=db_get_first_id();
	$content_url=build_url(array('page'=>'downloads','type'=>'entry','id'=>$content_id),'site');
	for ($j=$GLOBALS['SITE_DB']->query_value('trackbacks','COUNT(*)');$j<$num_wanted;$j++)
	{
		// trackbacks
		$GLOBALS['SITE_DB']->query_insert('trackbacks',array('trackback_for_type'=>'downloads','trackback_for_id'=>$content_id,'trackback_ip'=>'','trackback_time'=>time(),'trackback_url'=>'','trackback_title'=>random_line(),'trackback_excerpt'=>random_text(),'trackback_name'=>random_line()));

		// ratings
		$GLOBALS['SITE_DB']->query_insert('rating',array('rating_for_type'=>'downloads','rating_for_id'=>$content_id,'rating_member'=>$j+1,'rating_ip'=>'','rating_time'=>time(),'rating'=>3));

		// posts in a comment topic
		$GLOBALS['FORUM_DRIVER']->make_post_forum_topic(
			get_option('comments_forum_name'),
			'downloads_'.strval($content_id),
			get_member(),
			random_text(),
			random_line(),
			'',
			do_lang('COMMENT'),
			$content_url->evaluate(),
			NULL,
			NULL,
			1,
			1
		);
	}
	echo 'done download stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// forums under a forum (don't test it can display, just make sure the main index still works)
	require_code('ocf_forums_action');
	for ($i=$GLOBALS['FORUM_DB']->query_value('f_forums','COUNT(*)');$i<$num_wanted;$i++)
	{
		ocf_make_forum(random_line(),random_text(),db_get_first_id(),array(),db_get_first_id()+3);
	}
	// forum topics
	require_code('ocf_topics_action');
	require_code('ocf_posts_action');
	require_code('ocf_forums');
	require_code('ocf_topics');
	for ($i=intval(floatval($GLOBALS['FORUM_DB']->query_value('f_topics','COUNT(*)'))/2.0);$i<$num_wanted;$i++)
	{
		$topic_id=ocf_make_topic(db_get_first_id(),'','',NULL,1,0,0,0,NULL,NULL,false);
		ocf_make_post($topic_id,random_line(),random_text(),0,true,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false,false);
	}
	// forum posts in a topic
	require_code('ocf_topics_action');
	require_code('ocf_posts_action');
	$topic_id=ocf_make_topic(db_get_first_id()+1,'','',NULL,1,0,0,0,NULL,NULL,false);
	for ($i=intval(floatval($GLOBALS['FORUM_DB']->query_value('f_posts','COUNT(*)'))/3.0);$i<$num_wanted;$i++)
	{
		ocf_make_post($topic_id,random_line(),random_text(),0,true,0,0,NULL,NULL,NULL,mt_rand(db_get_first_id(),$num_wanted-1),NULL,NULL,NULL,false,false);
	}
	echo 'done forum stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// clubs
	require_code('ocf_groups_action');
	require_code('ocf_groups');
	for ($i=$GLOBALS['FORUM_DB']->query_value('f_groups','COUNT(*)');$i<$num_wanted;$i++)
	{
		ocf_make_group(random_line(),0,0,0,random_line(),'',NULL,NULL,NULL,5,0,70,50,100,100,30000,700,25,1,0,0,0,$i,1,0,1);
	}
	echo 'done club stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// galleries under a subcategory
	require_code('galleries2');
	$xsubcat_id=uniqid('',true);
	add_gallery($xsubcat_id,random_line(),random_text(),'','','root');
	for ($i=$GLOBALS['SITE_DB']->query_value('galleries','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_gallery(uniqid('',true),random_line(),random_text(),'','',$xsubcat_id);
	}
	// images
	require_code('galleries2');
	for ($i=$GLOBALS['SITE_DB']->query_value('images','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_image('','root',random_text(),get_logo_url(),get_logo_url(),1,1,1,1,'');
	}
	// videos / validation queue
	require_code('galleries2');
	for ($i=$GLOBALS['SITE_DB']->query_value('videos','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_video('','root',random_text(),get_logo_url(),get_logo_url(),0,1,1,1,'',0,0,0);
	}
	echo 'done galleries stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// newsletter subscribers
	require_code('newsletter');
	for ($i=$GLOBALS['SITE_DB']->query_value('newsletter','COUNT(*)');$i<$num_wanted;$i++)
	{
		basic_newsletter_join(uniqid('',true).'@example.com');
	}
	echo 'done newsletter stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// polls (remember to test poll archive)
	require_code('polls');
	for ($i=$GLOBALS['SITE_DB']->query_value('poll','COUNT(*)');$i<$num_wanted;$i++)
	{
		$poll_id=add_poll(random_line(),random_line(),random_line(),random_line(),random_line(),random_line(),random_line(),random_line(),random_line(),random_line(),random_line(),10,0,0,0,0,'');
	}
	// votes on a poll
	$poll_id=db_get_first_id();
	for ($j=$GLOBALS['SITE_DB']->query_value('poll_votes','COUNT(*)');$j<$num_wanted;$j++)
	{
		$cast=mt_rand(1,6);
		$ip=uniqid('',true);

		$GLOBALS['SITE_DB']->query_insert('poll_votes',array(
			'v_poll_id'=>$poll_id,
			'v_voter_id'=>2,
			'v_voter_ip'=>$ip,
			'v_vote_for'=>$cast,
		));
	}
	echo 'done polls stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// quizzes
	require_code('quiz');
	for ($i=$GLOBALS['SITE_DB']->query_value('quizzes','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_quiz(random_line(),0,random_text(),random_text(),random_text(),'',0,time(),NULL,3,300,'SURVEY',1,'1) Some question');
	}
	echo 'done quizzes stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// successful searches (to test the search recommender)
	// ACTUALLY: I have manually verified the code, it is an isolated portion

	// Wiki+ pages (do a long descendant tree for some, and orphans for others)
	// Wiki+ posts (remember to test Wiki+ changes screen)
	require_code('cedi');
	for ($i=$GLOBALS['SITE_DB']->query_value('seedy_pages','COUNT(*)');$i<$num_wanted;$i++)
	{
		$page_id=cedi_add_page(random_line(),random_text(),'',1);
		cedi_add_post($page_id,random_text(),1,NULL,false);
	}
	echo 'done Wiki+ stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// iotds
	require_code('iotds');
	for ($i=$GLOBALS['SITE_DB']->query_value('iotd','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_iotd(get_logo_url(),random_line(),random_text(),get_logo_url(),1,0,0,0,'');
	}
	echo 'done iotd stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// logged hack attempts
	for ($i=$GLOBALS['SITE_DB']->query_value('hackattack','COUNT(*)');$i<$num_wanted;$i++)
	{
		$GLOBALS['SITE_DB']->query_insert('hackattack',array(
			'url'=>get_base_url(),
			'data_post'=>'',
			'user_agent'=>'',
			'referer'=>'',
			'user_os'=>'',
			'the_user'=>db_get_first_id(),
			'date_and_time'=>time(),
			'ip'=>uniqid('',true),
			'reason'=>'ASCII_ENTITY_URL_HACK',
			'reason_param_a'=>'',
			'reason_param_b'=>''
		));
	}
	// logged hits in one day
	require_code('site');
	for ($i=$GLOBALS['SITE_DB']->query_value('stats','COUNT(*)');$i<$num_wanted;$i++)
	{
		log_stats('/testing'.uniqid('',true),mt_rand(100,2000));
	}
	echo 'done logs stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// blogs and news entries (remember to test both blogs [categories] list, and a list of all news entries)
	require_code('news');
	for ($i=$GLOBALS['SITE_DB']->query_value('news','COUNT(*)');$i<$num_wanted;$i++)
	{
		add_news(random_line(),random_text(),'admin',1,1,1,1,'',random_text(),NULL,NULL,NULL,db_get_first_id()+$i);
	}
	echo 'done news stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// support tickets
	require_code('tickets');
	require_code('tickets2');
	for ($i=intval(floatval($GLOBALS['FORUM_DB']->query_value('f_topics','COUNT(*)'))/2.0);$i<$num_wanted;$i++)
	{
		ticket_add_post(mt_rand(db_get_first_id(),$num_wanted-1),uniqid('',true),db_get_first_id(),random_line(),random_text(),'','');
	}
	echo 'done tickets stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// catalogues
	require_code('catalogues2');
	$root_id=db_get_first_id();
	for ($i=$GLOBALS['SITE_DB']->query_value('catalogues','COUNT(*)');$i<$num_wanted;$i++)
	{
		$catalogue_name=uniqid('',true);
		$root_id=actual_add_catalogue($catalogue_name,random_line(),random_text(),mt_rand(0,3),1,'',30);
	}
	// catalogue categories under a subcategory (remember to test all catalogue views: atoz, index, and root cat)
	$catalogue_name='products';
	$subcat_id=actual_add_catalogue_category($catalogue_name,random_line(),random_text(),'',$root_id);
	for ($j=$GLOBALS['SITE_DB']->query_value('catalogue_categories','COUNT(*)');$j<$num_wanted;$j++)
	{
		actual_add_catalogue_category($catalogue_name,random_line(),random_text(),'',$subcat_id);
	}
	echo 'done catalogue stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	// items in ecommerce store
	require_code('catalogues2');
	$cat_id=$GLOBALS['SITE_DB']->query_value('catalogue_categories','MIN(id)',array('c_name'=>'products'));
	$fields=collapse_1d_complexity('id',$GLOBALS['SITE_DB']->query_select('catalogue_fields',array('id'),array('c_name'=>'products')));
	for ($i=$GLOBALS['SITE_DB']->query_value('catalogue_entries','COUNT(*)');$i<$num_wanted;$i++)
	{
		$map=array(
			$fields[0]=>random_line(),
			$fields[1]=>uniqid('',true),
			$fields[2]=>'1.0',
			$fields[3]=>'1',
			$fields[4]=>'0',
			$fields[5]=>'1',
			$fields[6]=>'0%',
			$fields[7]=>get_logo_url(),
			$fields[8]=>'2.0',
			$fields[9]=>random_text(),
		);
		$pid=actual_add_catalogue_entry($cat_id,1,'',1,1,1,$map);
		unset($map);
	}
	// outstanding ecommerce orders
	$pid=$GLOBALS['SITE_DB']->query_value('catalogue_entries','MIN(id)',array('c_name'=>'products'));
	require_code('shopping');
	for ($j=$GLOBALS['SITE_DB']->query_value('shopping_cart','COUNT(*)');$j<$num_wanted;$j++)
	{
		$product_det=array(
						'product_id'	=>	$pid,
						'product_name'	=>	$fields[0],
						'product_code'	=>	$fields[1],
						'price'			=>	$fields[2],
						'tax'				=>	preg_replace('#[^\d\.]#','',$fields[6]),
						'description'	=>	$fields[9],
						'quantity'		=>	mt_rand(1,20),
						'product_type'	=>	'catalogue_items',
						'product_weight'=>	$fields[8]
					);
		$GLOBALS['SITE_DB']->query_insert('shopping_cart',
				array(
					'session_id'		=>	mt_rand(0,1000000),
					'ordered_by'		=>	mt_rand(db_get_first_id()+1,$num_wanted-1),
					'product_id'		=>	$product_det['product_id'],
					'product_name'		=>	$product_det['product_name'],
					'product_code'		=>	$product_det['product_code'],
					'quantity'			=>	$product_det['quantity'],
					'price'				=>	round(floatval($product_det['price']),2),
					'price_pre_tax'	=>	$product_det['tax'],
					'product_description'	=>	$product_det['description'],
					'product_type'		=>	$product_det['product_type'],
					'product_weight'	=>	$product_det['product_weight'],
					'is_deleted'=>0,
				)
		);
	}
	for ($j=$GLOBALS['SITE_DB']->query_value('shopping_order','COUNT(*)');$j<$num_wanted;$j++)
	{
		$order_id=$GLOBALS['SITE_DB']->query_insert('shopping_order',array(
					'c_member'		=>	mt_rand(db_get_first_id()+1,$num_wanted-1),
					'session_id'	=>	mt_rand(0,1000000),
					'add_date'		=>	time(),
					'tot_price'		=>	'123.00',
					'order_status'	=>	'ORDER_STATUS_awaiting_payment',
					'notes'			=>	'',
					'purchase_through'	=>	'purchase_module',
					'transaction_id'=> '',
					'tax_opted_out'=>	0,
				),true);

		$GLOBALS['SITE_DB']->query_insert('shopping_order_details',array(
			'p_id'		=>	123,
			'p_name'	=>	random_line(),
			'p_code'	=>	123,
			'p_type'	=>	'catalogue_items',
			'p_quantity'	=>	1,
			'p_price'	=>	'12.00',
			'order_id'	=>	$order_id,
			'dispatch_status'=>'',
			'included_tax'=>	'1.00',
		));
	}
	echo 'done store stuff'.chr(10);

	if (function_exists('gc_collect_cycles')) gc_enable();

	echo '{{DONE}}'.chr(10);
}


/* General things to test after we have this data:
 *  Searching
 *  Browsing
 *  Choosing-to-edit
 *  RSS
 *  Using blocks
 *  Cleanup tools
 *  Content translate queue
 *  load_all_category_permissions
 *  Anywhere else the data is queried (grep the code)
 *
 *  Generally click around and try and use the site
 */


function random_text()
{
	static $words=array('fish','cheese','soup','tomato','alphabet','whatever','cannot','be','bothered','to','type','many','more','will','be','here','all','day');
	static $word_count=NULL;
	if (is_null($word_count)) $word_count=count($words);

	$out='';
	for ($i=0;$i<30;$i++)
	{
		if ($i!=0) $out.=' ';
		$out.=$words[mt_rand(0,$word_count-1)];
	}
	return $out;
}

function random_line()
{
	static $words=array('fish','cheese','soup','tomato','alphabet','whatever','cannot','be','bothered','to','type','many','more','will','be','here','all','day');
	static $word_count=NULL;
	if (is_null($word_count)) $word_count=count($words);

	$word=$words[mt_rand(0,$word_count-1)];
	return md5(uniqid('',true)).' '.$word.' '.md5(uniqid('',true));
}
