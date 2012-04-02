<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// FIX PATH
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=str_replace('\\\\','\\',$FILE_BASE);
if (substr($FILE_BASE,-4)=='.php')
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
}
if (!is_file($FILE_BASE.'/sources/global.php'))
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$RELATIVE_PATH=substr($FILE_BASE,(($a>$b)?$a:$b)+1);
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.chr(10).'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	echo getpr('http://www.slashdot.org/');
	$x=new GooglePageRankChecker();
	echo $x->check('http://www.slashdot.org/');
}

//convert a string to a 32-bit integer
function StrToNum($str, $check, $magic)
{
	$int_32_unit = 4294967296.0;  // 2^32

	$length = strlen($str);
	for ($i = 0; $i < $length; $i++)
	{
		$check *= $magic;
		//If the float is beyond the boundaries of integer (usually +/- 2.15e+9 = 2^31),
		//  the result of converting to integer is undefined
		//  refer to http://www.php.net/manual/en/language.types.integer.php
		if ((is_integer($check) && floatval($check) >= $int_32_unit) ||
			(is_float($check) && $check >= $int_32_unit))
		{
			$check = ($check - $int_32_unit * intval($check / $int_32_unit));
			//if the check less than -2^31
			$check = ($check < -2147483648.0) ? ($check + $int_32_unit) : $check;
			if (is_float($check)) $check = intval($check);
		}
		$check += ord($str[$i]);
	}
	return is_integer($check)? $check : intval($check);
}

//genearate a hash for a url
function HashURL($string)
{
	$check1 = StrToNum($string, 0x1505, 0x21);
	$check2 = StrToNum($string, 0, 0x1003F);

	$check1 = $check1 >> 2;
	$check1 = (($check1 >> 4) & 0x3FFFFC0 ) | ($check1 & 0x3F);
	$check1 = (($check1 >> 4) & 0x3FFC00 ) | ($check1 & 0x3FF);
	$check1 = (($check1 >> 4) & 0x3C000 ) | ($check1 & 0x3FFF);

	$t1 = (((($check1 & 0x3C0) << 4) | ($check1 & 0x3C)) <<2 ) | ($check2 & 0xF0F );
	$t2 = @(((($check1 & 0xFFFFC000) << 4) | ($check1 & 0x3C00)) << 0xA) | ($check2 & 0xF0F0000 );

	return ($t1 | $t2);
}

//genearate a checksum for the hash string
function CheckHash($hashnum)
{
	$check_byte = 0;
	$flag = 0;

	$hashstr = sprintf('%u', $hashnum) ;
	$length = strlen($hashstr);

	for ($i = $length - 1;  $i >= 0;  $i --)
	{
		$re = intval($hashstr[$i]);
		if (1 === ($flag % 2))
		{
			$re += $re;
			$re = intval($re / 10) + ($re % 10);
		}
		$check_byte += $re;
		$flag ++;
	}

	$check_byte = $check_byte % 10;
	if (0 !== $check_byte)
	{
		$check_byte = 10 - $check_byte;
		if (1 === ($flag % 2) )
		{
			if (1 === ($check_byte % 2))
			{
				$check_byte += 9;
			}

			$check_byte = $check_byte >> 1;
		}
	}

	return '7'.strval($check_byte).$hashstr;
}

//return the pagerank checksum hash
function getch($url)
{
	return CheckHash(HashURL($url));
}
//return the pagerank figure
function getpr($url)
{
	$ch = getch($url);
	$errno = '0';
	$errstr = '';
	require_code('files');
	$data=http_download_file('http://toolbarqueries.google.com/tbr?client=navclient-auto&ch='.$ch.'&features=Rank&q=info:'.$url,NULL,false,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.0);
	if (is_null($data)) return '';
	$pos = strpos($data, "Rank_");
	if($pos === false)
	{
		header('Content-type: text/html');
exit('!'.$data);
	} else
	{
		$pr=substr($data, $pos + 9);
		$pr=trim($pr);
		$pr=str_replace("\n",'',$pr);
		return $pr;
	}
}


// Declare the class
class GooglePageRankChecker {
  
  // Track the instance
  private static $instance;
  
  // Constructor
  function getRank($page) {
    // Create the instance, if one isn't created yet
    if(!isset(self::$instance)) {
      self::$instance = new self();
    }
    // Return the result
    return self::$instance->check($page);
  }
  
  
  // Convert string to a number
  function stringToNumber($string,$check,$magic) {
    $int32 = 4294967296;  // 2^32
      $length = strlen($string);
      for ($i = 0; $i < $length; $i++) {
          $check *= $magic;   
          //If the float is beyond the boundaries of integer (usually +/- 2.15e+9 = 2^31), 
          //  the result of converting to integer is undefined
          //  refer to http://www.php.net/manual/en/language.types.integer.php
          if($check >= $int32) {
              $check = ($check - $int32 * (int) ($check / $int32));
              //if the check less than -2^31
              $check = ($check < -($int32 / 2)) ? ($check + $int32) : $check;
          }
          $check += ord($string{$i}); 
      }
      return $check;
  }
  
  // Create a url hash
  function createHash($string) {
    $check1 = $this->stringToNumber($string, 0x1505, 0x21);
      $check2 = $this->stringToNumber($string, 0, 0x1003F);
  
    $factor = 4;
    $halfFactor = $factor/2;

      $check1 >>= $halfFactor;
      $check1 = (($check1 >> $factor) & 0x3FFFFC0 ) | ($check1 & 0x3F);
      $check1 = (($check1 >> $factor) & 0x3FFC00 ) | ($check1 & 0x3FF);
      $check1 = (($check1 >> $factor) & 0x3C000 ) | ($check1 & 0x3FFF);  

      $calc1 = (((($check1 & 0x3C0) << $factor) | ($check1 & 0x3C)) << $halfFactor ) | ($check2 & 0xF0F );
      $calc2 = (((($check1 & 0xFFFFC000) << $factor) | ($check1 & 0x3C00)) << 0xA) | ($check2 & 0xF0F0000 );

      return ($calc1 | $calc2);
  }
  
  // Create checksum for hash
  function checkHash($hashNumber)
  {
      $check = 0;
    $flag = 0;

    $hashString = sprintf('%u', $hashNumber) ;
    $length = strlen($hashString);

    for ($i = $length - 1;  $i >= 0;  $i --) {
      $r = $hashString{$i};
      if(1 === ($flag % 2)) {        
        $r += $r;   
        $r = (int)($r / 10) + ($r % 10);
      }
      $check += $r;
      $flag ++;  
    }

    $check %= 10;
    if(0 !== $check) {
      $check = 10 - $check;
      if(1 === ($flag % 2) ) {
        if(1 === ($check % 2)) {
          $check += 9;
        }
        $check >>= 1;
      }
    }

    return '7'.$check.$hashString;
  }
  
  function check($page) {

    // Open a socket to the toolbarqueries address, used by Google Toolbar
    $socket = fsockopen("toolbarqueries.google.com", 80, $errno, $errstr, 30);

    // If a connection can be established
    if($socket) {
      // Prep socket headers
      $out = "GET /tbr?client=navclient-auto&ch=".$this->checkHash($this->createHash($page))."&features=Rank&q=info:".$page."&num=100&filter=0 HTTP/1.1\r\n";
      $out .= "Host: toolbarqueries.google.com\r\n";
      $out .= "User-Agent: Mozilla/4.0 (compatible; GoogleToolbar 2.0.114-big; Windows XP 5.1)\r\n";
      $out .= "Connection: Close\r\n\r\n";

      // Write settings to the socket
      fwrite($socket, $out);

      // When a response is received...
      $result = "";
      while(!feof($socket)) {
        $data = fgets($socket, 128);
echo $data;
        $pos = strpos($data, "Rank_");
        if($pos !== false){
          $pagerank = substr($data, $pos + 9);
          $result += $pagerank;
        }
      }
      // Close the connection
      fclose($socket);

      // Return the rank!
      return $result;
    }
  }
}