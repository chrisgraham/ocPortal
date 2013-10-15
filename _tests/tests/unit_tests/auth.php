<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

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
class auth_test_set extends ocp_test_case
{
	function setUp()
	{
		require_code('users');

		parent::setUp();
	}

	function testNoBackdoor()
	{
		$this->assertTrue(!isset($GLOBALS['SITE_INFO']['backdoor_ip']),'Backdoor to IP address present, may break other tests');
	}

	function testBadPasswordDoesFail()
	{
		$username='admin';
		$password='wrongpassword';
		$login_array=$GLOBALS['FORUM_DRIVER']->forum_authorise_login($username,NULL,apply_forum_driver_md5_variant($password,$username),$password);
		$member=$login_array['id'];
		$this->assertTrue(is_null($member));
		$this->assertTrue(static_evaluate_tempcode($login_array['error'])==do_lang('MEMBER_BAD_PASSWORD'));
	}

	function testUnknownUsernameDoesFail()
	{
		$username='nosuchuser';
		$password='';
		$login_array=$GLOBALS['FORUM_DRIVER']->forum_authorise_login($username,NULL,apply_forum_driver_md5_variant($password,$username),$password);
		$member=$login_array['id'];
		$this->assertTrue(is_null($member));
	}

	function testAccessDoesFail()
	{
		$this->assertTrue(!has_zone_access($GLOBALS['FORUM_DRIVER']->get_guest_id(),'adminzone'));
	}

	function testPrivilegeDoesFail()
	{
		$this->assertTrue(!has_privilege($GLOBALS['FORUM_DRIVER']->get_guest_id(),'bypass_validation_highrange_content'));
	}

	function testAdminZoneDoesFail()
	{
		require_code('files');
		http_download_file(static_evaluate_tempcode(build_url(array('page'=>''),'adminzone',NULL,false,false,true)),NULL,false);
		global $HTTP_MESSAGE;
		$this->assertTrue($HTTP_MESSAGE=='401');
	}

	function testCannotStealSession()
	{
		$fake_session_id=1234543;

		$ips=array();
		$ips[preg_replace('#\.\d+$#','.*',ocp_srv('SERVER_ADDR'))]=true;
		$ips['1.2.3.4']=false;

		foreach ($ips as $ip=>$pass_expected) // We actually test both pass and fail, to help ensure our test is actually not somehow getting a failure from something else
		{
			// Clean up
			$GLOBALS['SITE_DB']->query_delete('sessions',array('the_session'=>$fake_session_id));

			$new_session_row=array(
				'the_session'=>$fake_session_id,
				'last_activity'=>time(),
				'member_id'=>2,
				'ip'=>$ip,
				'session_confirmed'=>1,
				'session_invisible'=>1,
				'cache_username'=>'admin',
				'the_title'=>'',
				'the_zone'=>'',
				'the_page'=>'',
				'the_type'=>'',
				'the_id'=>'',
			);
			$GLOBALS['SITE_DB']->query_insert('sessions',$new_session_row);
			persistent_cache_delete('SESSION_CACHE');

			require_code('files');
			$result=http_download_file(static_evaluate_tempcode(build_url(array('page'=>'','keep_session'=>$fake_session_id),'adminzone',NULL,false,false,true)),NULL,false);

			global $HTTP_MESSAGE;
			if ($pass_expected)
			{
				$this->assertTrue($HTTP_MESSAGE!='401');
			} else
			{
				$this->assertTrue($HTTP_MESSAGE=='401');
			}
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
