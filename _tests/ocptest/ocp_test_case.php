<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class ocp_test_case extends WebTestCase
{
	var $site_closed;

	function setUp()
	{
		// Make sure the site is open
		$this->site_closed=get_option('site_closed');
		require_code('config2');
		set_option('site_closed','0');

		if (function_exists('set_time_limit')) @set_time_limit(0);
	}

	function tearDown()
	{
		if ($this->site_closed!==NULL)
			set_option('site_closed',$this->site_closed);
	}

	function get($url,$parameters=NULL)
	{
		$parts=array();
		if ((preg_match('#([\w-]*):([\w-]+|[^/]|$)((:(.*))*)#',$url,$parts)!=0) && ($parts[1]!='mailto')) // Specially encoded page-link. Complex regexp to make sure URLs do not match
		{
			list($zone_name,$vars,$hash)=page_link_decode($url);
			$real_url=static_evaluate_tempcode(build_url($vars,$zone_name,NULL,false,false,false,$hash));

			$ret=parent::get($real_url,$parameters);
		} else
		{
			$ret=parent::get($url,$parameters);
		}

		// Save, so we can run validation on it later
		$path=get_file_base().'/_tests/html_dump/'.get_class($this);
		if (!file_exists($path)) mkdir($path,0777);
		$content=$this->_browser->getContent();
		$outfile=fopen($path.'/'.url_to_filename($url).'.htm.tmp','wb');
		fwrite($outfile,$content);
		fclose($outfile);
		fix_permissions($path.'/'.url_to_filename($url).'.htm.tmp');

		// Save the text so we can run through Word's grammar checker
		$text_content=$content;
		$text_content=preg_replace('#<[^>]* title="([^"]+)"<[^>]*>#U','\\1',$text_content);
		$text_content=preg_replace('#<[^>]* alt="([^"]+)"<[^>]*>#U','\\1',$text_content);
		$text_content=preg_replace('#<style[^>]*>.*</style>#Us','',$text_content);
		$text_content=preg_replace('#<script[^>]*>.*</script>#Us','',$text_content);
		$text_content=preg_replace('#<[^>]*>#U','',$text_content);
		$text_content=preg_replace('#\s\s+#','. ',$text_content);
		$text_content=str_replace('&ndash;','-',$text_content);
		$text_content=str_replace('&mdash;','-',$text_content);
		$text_content=str_replace('&hellip;','...',$text_content);
		$text_content=@html_entity_decode($text_content,ENT_QUOTES);
		$outfile=fopen($path.'/'.url_to_filename($url).'.txt.tmp','wb');
		fwrite($outfile,$text_content);
		fclose($outfile);
		fix_permissions($path.'/'.url_to_filename($url).'.txt.tmp');

		return $ret;
	}

	function establish_admin_session()
	{
		global $MEMBER_CACHED;
		require_code('users_active_actions');
		$MEMBER_CACHED=restricted_manually_enabled_backdoor();

		$this->dump($this->_browser->getContent());
	}
}
