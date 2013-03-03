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
class lang_test_set extends ocp_test_case
{
	function setUp()
	{
		require_code('lang_compile');

		parent::setUp();
	}

	function str_ipos($haystack,$needle,$offset=0)
	{
		return strpos(strtoupper($haystack),strtoupper($needle),$offset);
	}

	function testLangMistakes()
	{
		$verbose=false;

		$dh=opendir(get_file_base().'/lang/EN/');

		while (($file=readdir($dh))!==false)
		{
			if ($file[0]=='.') continue;

			$input=array();
			_get_lang_file_map(get_file_base().'/lang/EN/'.$file,$input,NULL,false);

			foreach($input as $key=>$string)
			{
				$output2='';

				if ($this->str_ipos($string,'thankyou')!==false) $this->assertTrue(false,'The word \'thankyou\' was used in '.$file.'. This should be changed to \'thank you\'.');
				if ($this->str_ipos($string,'unvalidated')!==false) $this->assertTrue(false,'The word \'unvalidated\' was used in '.$file.'. This should be changed to \'non-validated\'.');
				if ($this->str_ipos($string,'add-on')!==false) $this->assertTrue(false,'The word \'add-on\' was used in '.$file.'. This should be changed to \'addon\'.');
				if ($this->str_ipos($string,'preceeding')!==false) $this->assertTrue(false,'The word \'preceeding\' was used in '.$file.'. This should be changed to \'proceeding\'.');
				if ($this->str_ipos($string,'publically')!==false) $this->assertTrue(false,'The word \'publically\' was used in '.$file.'. This should be changed to \'publicly\'.');
				if ($this->str_ipos($string,'seperate')!==false) $this->assertTrue(false,'The word \'seperate\' was used in '.$file.'. This should be changed to \'separate\'.');
				if ($this->str_ipos($string,'chat room')!==false) $this->assertTrue(false,'The phrase \'chat room\' was used in '.$file.'. This should be changed to \'chatroom\'.');
				if ($this->str_ipos($string,'URL\'s')!==false) $this->assertTrue(false,'The acronym \'URLs\' was used in '.$file.'. This should be changed to \'URLs\'.');
				if ($this->str_ipos($string,'user-group')!==false) $this->assertTrue(false,'The term \'user-group\' was used in '.$file.'. This should be changed to \'usergroup\'.');
				if ($this->str_ipos($string,'supermember')!==false) $this->assertTrue(false,'The term \'supermember\' was used in '.$file.'. This should be changed to \'super-member\'.');
				if ($this->str_ipos($string,'user name')!==false) $this->assertTrue(false,'The term \'user name\' was used in '.$file.'. This should be changed to \'username\'.');
				if ($this->str_ipos($string,'built in')!==false) $this->assertTrue(false,'The phrase \'built in\' was used in '.$file.'. This should be changed to \'built-in\'.');
				if (($this->str_ipos($string,'email')!==false) && ($this->str_ipos($string,'/')===false) && ($this->str_ipos($string,'codename')===false)) $this->assertTrue(false,'The term \'email\' was used in '.$file.'. This should be changed to \'e-mail\'.');
				if ($this->str_ipos($string,'web site')!==false) $this->assertTrue(false,'The phrase \'web site\' was used in '.$file.'. This should be changed to \'website\'.');
				if ($this->str_ipos($string,'ID\'s')!==false) $this->assertTrue(false,'The term \'ID\'s\' was used in '.$file.'. This should be changed to \'IDs\'.');
				if ($this->str_ipos($string,'comma separated')!==false) $this->assertTrue(false,'The phrase \'comma separated\' was used in '.$file.'. This should be changed to \'comma-separated\'.');
				//if ($this->str_ipos($string,'center')!==false) $this->assertTrue(false,'The word \'center\' was used in '.$file.'. This should be changed to \'centre\'.');
				if ($file!='upgrade.ini' && $key!='NO_PHP_IN_TEMPLATES' && $key!='WHAT_TO_EXPECT' && $key!='DESCRIPTION_INCLUDE_OCP_ADVERT' && $key!='INCLUDE_OCP_ADVERT' && $key!='UNINSTALL_WARNING' && $key!='OCP_CHAT_EXTRA' && (strpos($key,'SETUP_WIZARD')===false) && $key!='CANNOT_CONNECT_HOME' && $file!='lang.ini' && $file!='version.ini' && $file!='debrand.ini' && $file!='import.ini' && $file!='installer.ini' && $file!='occle.ini' && $file!='addons.ini' && strpos($string,'ocPortal')!==false)
					$this->assertTrue(false,'The word \'ocPortal\' was used in '.$file.'. This should probably be changed to \'the software\'.');

				if (preg_match('#([^A-Za-z"\_]+)comcode([^A-Za-z"]+)#',$string)!=0) $this->assertTrue(false,'The term \'comcode\' was used in '.$file.'. This should be changed to \'Comcode\'.');

				if (($verbose) && ($this->str_ipos($string,'user')!==false)) $this->assertTrue(false,'The term \'user\' was used in '.$file.'. This might need to be changed to \'member\', depending on the circumstances.');
				if ($this->str_ipos($string,'set-up')!==false) $this->assertTrue(false,'The phrase \'set-up\' was used in '.$file.'. This might need to be changed to \'setup\', depending on the usage.');
				if (($verbose) && (strpos($string,'\n')!==false)) $this->assertTrue(false,'The \'\n\' linebreak character was used in '.$file.' in the language string. This should be checked, to make sure it is really necessary.');

				if (preg_match('#([^A-Za-z]+)tar([^A-Za-z]+)#',$string)!=0) $this->assertTrue(false,'The filetype \'tar\' was used in '.$file.'. This should be changed to \'TAR\'.');
				if (preg_match('#([^A-Za-z]>+)id([^A-Za-z=<]+)#',$string)!=0) $this->assertTrue(false,'The acronym \'id\' was used in '.$file.'. This should be changed to \'ID\'.');
				if (preg_match('#([^A-Za-z\[\]></\']+)url([^\}A-Za-z=\']+)#',$string)!=0) $this->assertTrue(false,'The acronym \'url\' was used in '.$file.'. This should be changed to \'URL\'.');
				if (preg_match('#([^A-Za-z]+)zip([^A-Za-z]+)#',$string)!=0) $this->assertTrue(false,'The filetype \'zip\' was used in '.$file.'. This should be changed to \'ZIP\'.');

				if (($verbose) && (preg_match('#([A-Za-z]+)s( |-)#',$string)!=0)) $this->assertTrue(false,'A word ended with an \'s\', but did not contain an apostrophe. This might be a case of mistaken plurality.');
				if (($verbose) && (preg_match('#([a-z]+)( |-)([A-Z]{1})([a-z]+)#',$string)!=0)) $this->assertTrue(false,'A word that was in the middle of the string started with a capital letter. This might be a badly capitalised string.');
				if (($verbose) && (preg_match('#<([A-Za-z]+)>#',$string)!=0)) $this->assertTrue(false,'An HTML tag was used in '.$file.' in the language string. This should be checked, to make sure it is really necessary; HTML should be confined to the templates.');
			}
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
