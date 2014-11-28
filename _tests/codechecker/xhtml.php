<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		code_quality
 */

if (!function_exists('html_entity_decode'))
{
	/**
	 * Decode the HTML entitity encoded input string. Can give warning if unrecognised character set.
	 *
	 * @param  string		The text to decode
	 * @param  integer	The quote style code
	 * @param  ?string		Character set to decode to (NULL: default)
	 * @return string		The decoded text
	 */
	function html_entity_decode($input,$quote_style,$charset=NULL)
	{
		unset($quote_style);
		unset($charset);

		$trans_tbl=get_html_translation_table(HTML_ENTITIES);
		$trans_tbl=array_flip($trans_tbl);
		return strtr($input,$trans_tbl);
	}
}
if (!function_exists('str_word_count'))
{
	/**
	 * Isolate the words in the input string.
	 *
	 * @param  string			String to count words in
	 * @param  integer		The format
	 * @set    0 1
	 * @return mixed			Typically a list - the words of the input string
	 */
	function str_word_count($input,$format=0)
	{
		//count words
		$pattern="/[^(\w|\d|\'|\"|\.|\!|\?|;|,|\\|\/|\-\-|:|\&|@)]+/";
		$all_words=trim(preg_replace($pattern,' ',$input));
		$a=explode(' ',$all_words);
		return ($format==0)?count($a):$a;
	}
}

if (!function_exists('qualify_url'))
{
	/**
	 * Take a URL and base-URL, and fully qualify the URL according to it.
	 *
	 * @param  URLPATH		The URL to fully qualified
	 * @param  URLPATH		The base-URL
	 * @return URLPATH		Fully qualified URL
	 */
	function qualify_url($url,$url_base)
	{
		if (($url!='') && ($url[0]!='#') && (substr($url,0,7)!='mailto:'))
		{
			if (strpos($url,'://')===false)
			{
				if ($url[0]=='/')
				{
					$parsed=parse_url($url_base);
					if (!array_key_exists('scheme',$parsed)) $parsed['scheme']='http';
					if (!array_key_exists('host',$parsed)) $parsed['host']='localhost';
					if (substr($url,0,2)=='//')
					{
						$url=$parsed['scheme'].':'.$url;
					} else
					{
						$url=$parsed['scheme'].'://'.$parsed['host'].(array_key_exists('port',$parsed)?(':'.$parsed['port']):'').$url;
					}
				} else $url=$url_base.'/'.$url;
			}
		} else return '';
		return $url;
	}
}

if (!function_exists('http_download_file'))
{
	/**
	 * Return the file in the URL by downloading it over HTTP. If a byte limit is given, it will only download that many bytes. It outputs warnings, returning NULL, on error.
	 *
	 * @param  URLPATH		The URL to download
	 * @param  ?integer		The number of bytes to download. This is not a guarantee, it is a minimum (NULL: all bytes)
	 * @range  1 max
	 * @param  boolean		Whether to throw an ocPortal error, on error
	 * @param  boolean		Whether to block redirects (returns NULL when found)
	 * @param  string			The user-agent to identify as
	 * @param  ?array			An optional array of POST parameters to send; if this is NULL, a GET request is used (NULL: none)
	 * @param  ?array			An optional array of cookies to send (NULL: none)
	 * @param  ?string		'accept' header value (NULL: don't pass one)
	 * @param  ?string		'accept-charset' header value (NULL: don't pass one)
	 * @param  ?string		'accept-language' header value (NULL: don't pass one)
	 * @param  ?resource		File handle to write to (NULL: do not do that)
	 * @param  ?string		The HTTP referer (NULL: none)
	 * @param  ?array			A pair: authentication username and password (NULL: none)
	 * @param  float			The timeout
	 * @param  boolean		Whether to treat the POST parameters as a raw POST (rather than using MIME)
	 * @param  ?array			Files to send. Map between field to file path (NULL: none)
	 * @return ?string		The data downloaded (NULL: error)
	 */
	function http_download_file($url,$byte_limit=NULL,$trigger_error=true,$no_redirect=false,$ua='ocPortal',$post_params=NULL,$cookies=NULL,$accept=NULL,$accept_charset=NULL,$accept_language=NULL,$write_to_file=NULL,$referer=NULL,$auth=NULL,$timeout=6.0,$is_xml=false,$files=NULL)
	{
		safe_ini_set('allow_url_fopen','1');
		return @file_get_contents($url); // Assumes URL-wrappers is on, whilst ocPortal's is much more sophisticated
	}
}

if (!function_exists('do_lang'))
{
	/**
	 * Get the human-readable form of a language id, or a language entry from a language INI file. (STUB)
	 *
	 * @param  ID_TEXT		The language id
	 * @param  ?mixed			The first token [string or tempcode] (replaces {1}) (NULL: none)
	 * @param  ?mixed			The second token [string or tempcode] (replaces {2}) (NULL: none)
	 * @param  ?mixed			The third token (replaces {3}). May be an array of [of string], to allow any number of additional args (NULL: none)
	 * @param  ?LANGUAGE_NAME The language to use (NULL: users language)
	 * @param  boolean		Whether to cause ocPortal to exit if the lookup does not succeed
	 * @return ?mixed			The human-readable content (NULL: not found). String normally. Tempcode if tempcode parameters.
	 */
	function do_lang($a,$param_a=NULL,$param_b=NULL,$param_c=NULL,$lang=NULL,$require_result=true)
	{
		if (function_exists('_do_lang')) return _do_lang($a,$param_a,$param_b,$param_c,$lang,$require_result);

		unset($lang);

		switch ($a)
		{
			case 'LINK_NEW_WINDOW':
				return 'new window';
			case 'SPREAD_TABLE':
				return 'Spread table';
			case 'MAP_TABLE':
				return 'Item to value mapper table';
		}

		return array($a,$param_a,$param_b,$param_c);
	}
}

if (!function_exists('get_forum_type'))
{
	/**
	 * Get the type of forums installed.
	 *
	 * @return string			The type of forum installed
	 */
	function get_forum_type()
	{
		return 'none';
	}
}

if (!function_exists('ocp_srv'))
{
	/**
	 * Get server environment variables. (STUB)
	 *
	 * @param  string			The variable name
	 * @return string			The variable value ('' means unknown)
	 */
	function ocp_srv($value)
	{
		return '';
	}
}

if (!function_exists('mailto_obfuscated'))
{
	/**
	 * Get obfuscate version of 'mailto:' (which'll hopefully fool e-mail scavengers to not pick up these e-mail addresses).
	 *
	 * @return string		The obfuscated 'mailto:' string
	 */
	function mailto_obfuscated()
	{
		return 'mailto:';
	}
}

if (!function_exists('mixed'))
{
	/**
	 * Assign this to explicitly declare that a variable may be of mixed type, and initialise to NULL.
	 *
	 * @return ?mixed	Of mixed type (NULL: default)
	 */
	function mixed()
	{
		return NULL;
	}
}

if (!function_exists('do_lang_local'))
{
	function do_lang_local($x,$a='',$b='',$c='')
	{
		global $PARSED;
		if (!isset($PARSED))
		{
			$temp=file_get_contents($GLOBALS['OCPORTAL_PATH'].'/lang/EN/validation.ini');
			$temp_2=explode(chr(10),$temp);
			$PARSED=array();
			foreach ($temp_2 as $p)
			{
				$pos=strpos($p,'=');
				if ($pos!==false)
				{
					$PARSED[substr($p,0,$pos)]=rtrim(substr($p,$pos+1));
				}
			}
		}
		$out=strip_tags(str_replace('{1}',$a,str_replace('{2}',$b,$PARSED[$x])));
		if (is_string($c))
		{
			$out=str_replace('{3}',$c,$out);
		} else
		{
			$out=@str_replace('{3}',$c[0],$out);
			$out=@str_replace('{4}',$c[1],$out);
			$out=@str_replace('{5}',$c[2],$out);
			$out=@str_replace('{6}',$c[3],$out);
		}
		return $out;
	}
}

if (!function_exists('error_capture'))
{
	function error_capture($errno,$errmsg)
	{
		$GLOBALS['ERROR']=$errmsg;
	}
}

global $WITHIN_PHP;
if (!isset($WITHIN_PHP)) $WITHIN_PHP=false;

if (!$WITHIN_PHP)
{
	error_reporting(E_ALL);

	$extra=array();
	if (isset($_SERVER['argv']))
	{
		foreach ($_SERVER['argv'] as $index=>$argv)
		{
			$explode=explode('=',$argv,2);
			if (count($explode)==2)
				$extra[$explode[0]]=$explode[1];
		}
		$_SERVER['argv']=array_merge($_SERVER['argv'],$extra);

		if (array_key_exists('path',$_SERVER['argv'])) $GLOBALS['OCPORTAL_PATH']=$_SERVER['argv']['path'];
	}

	require_once('lib.php');
	global $OCPORTAL_PATH,$START_TIME;
	$START_TIME=time();

	$to_use=isset($_SERVER['argv'][1])?$_SERVER['argv'][1]:$_GET['to_use'];
}

if (!isset($_SERVER['argv']))
	$_SERVER['argv']=array();

if (!function_exists('init__validation'))
{
	require_once('../../sources/validation.php');
	init__validation();
	if (file_exists('../../sources/validation2.php'))
	{
		require_once('../../sources/validation2.php');
		init__validation2();
	}
}
if (!function_exists('init__js_lex'))
{
	require_once('../../sources/js_lex.php');
	init__js_lex();
}
if (!function_exists('init__js_parse'))
{
	require_once('../../sources/js_parse.php');
	init__js_parse();
}
if (!function_exists('init__js_validator'))
{
	require_once('../../sources/js_validator.php');
	init__js_validator();
}

if (!$WITHIN_PHP)
{
	$full_path=(strpos($to_use,':')===false)?($OCPORTAL_PATH.'/'.$to_use):$to_use;
	$contents=file_get_contents($full_path);
	$contents=str_replace(chr(13),'',$contents);
	if (substr($to_use,-4)=='.tpl')
	{
		$contents=str_replace('{!LINK_NEW_WINDOW}',do_lang('LINK_NEW_WINDOW'),$contents);
		$contents=str_replace('{!SPREAD_TABLE}',do_lang('SPREAD_TABLE'),$contents);
		$contents=str_replace('{!MAP_TABLE}',do_lang('MAP_TABLE'),$contents);
	}

	$javascript=(((strpos($to_use,'/JAVASCRIPT')!==false) || (strpos($to_use,'\\JAVASCRIPT')!==false)) && (strpos($contents,'function ')!==false));

	if ((substr($to_use,-4)!='.css') && (!$javascript))
	{
		do
		{
			$old_contents=$contents;
			$contents=preg_replace('#\{[^\n\{\}]*\}#U','',$contents);
		}
		while ($contents!=$old_contents);
	}
	elseif ($javascript)
	{
		do
		{
			$old_contents=$contents;
			$contents=preg_replace('#\{[\$\!][^\n\{\}]*\}#U','',$contents);
		}
		while ($contents!=$old_contents);
	}
} else
{
	$contents=$between_all;
	$javascript=false;
	$to_use=$GLOBALS['FILENAME'];
}
$line=1;
$pos=1;
for ($i=0;$i<strlen($contents);$i++)
{
	$next=$contents{$i};
	if (ord($next)>128) echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.do_lang_local('XHTML_UNSAFE_CHAR',$next,strval(ord($next)))."\n";
	if ($next==chr(10))
	{
		$line++;
		$pos=1;
	} else $pos++;
}
if ($javascript)
{
	$results=check_js($contents,false);
}
elseif (substr($to_use,-4)=='.css')
{
	$results=check_css($contents);
} else
{
	$is_fragment=(substr($to_use,-5)!='.html') && (substr($to_use,-4)!='.htm') && (substr($to_use,-4)!='.php');
	$manual=(in_array('checks',$_SERVER['argv'])) || ((array_key_exists('checks',$_SERVER['argv']) && ($_SERVER['argv']['checks']=='1')));
	$ext=false;
	if ((strpos($to_use,'/_mail.html')!==false) || (strpos($to_use,'_mail.htm')!==false) || ($to_use=='_mail.html') || ($to_use=='_mail.htm'))
	{
		$GLOBALS['MAIL_MODE']=true;
		$matches=array();
		$num_matches=preg_match_all('#^.*$#m',$contents,$matches);
		$pos=1;
		$line=1;
		for ($i=0;$i<$num_matches;$i++)
		{
			if (strlen($matches[0][$i])>512) echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.do_lang_local('MAIL_LONG_LINE')."\n";
			$line++;
		}
		if (strpos(strtolower($contents),'unsubscribe')===false)
		{
			echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.do_lang_local('MAIL_UNSUBSCRIBE')."\n";
		}
		if ((strpos(strtolower($contents),'web version')===false) && (strpos(strtolower($contents),'if you are')===false))
		{
			echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.do_lang_local('MAIL_WEB_VERSION')."\n";
		}
		$nasty_keywords=explode(chr(10),"
4U
Accept credit cards
Act now! Don't hesitate!
Additional income
Addresses on CD
All natural
Amazing
Apply Online
As seen on
Billing address
Auto email removal
Avoid bankruptcy
Be amazed
Be your own boss
Being a member
Big bucks
Bill 1618
Billion dollars
Brand new pager
Bulk email
Buy direct
Buying judgments
Cable converter
Call free
Call now
Calling creditors
Cannot be combined with any other offer
Cancel at any time
Can't live without
Cash bonus
Cashcashcash
Casino
Cell phone cancer scam
Cents on the dollar
Check or money order
Claims not to be selling anything
Claims to be in accordance with some spam law
Claims to be legal
Claims you are a winner
Claims you registered with some kind of partner
Click below
Click here link
Click to remove
Click to remove mailto
Compare rates
Compete for your business
Confidentially on all orders
Congratulations
Consolidate debt and credit
Stop snoring
get it now
Special promotion
Copy accurately
Copy DVDs
Credit bureaus
Credit card offers
Cures baldness
Dear email
Dear friend
Dear somebody
Different reply to
Dig up dirt on friends
Direct email
Direct marketing
Discusses search engine listings
Do it today
Don't delete
Drastically reduced
Earn per week
Easy terms
Eliminate bad credit
Email harvest
Email marketing
Expect to earn
Fantastic deal
Fast Viagra delivery
Financial freedom
Find out anything
For free
For instant access
For just $ (some amt)
Free access
Free cell phone
Free consultation
Free DVD
Free grant money 	
Free hosting
Free installation
Free investment
Free leads
Free membership
Free money
Free offer
Free preview
Free priority mail
Free quote
Free sample
Free trial
Free website
Full refund
Get paid
Get started now
Gift certificate
Great offer
Guarantee
Have you been turned down?
Hidden assets
Home employment
Human growth hormone
If only it were that easy
In accordance with laws
Increase sales
Increase traffic
Insurance
Investment decision
It's effective
Join millions of Americans
Laser printer
Limited time only
Long distance phone offer
Lose weight spam
Lower interest rates
Lower monthly payment
Lowest price
Luxury car
Mail in order form
Marketing solutions
Mass email
Meet singles
Member stuff
Message contains disclaimer
Money back
Money making
Month trial offer
More Internet traffic
Mortgage rates
Multi level marketing
MLM
Name brand
New customers only
New domain extensions
Nigerian
No age restrictions
No catch
No claim forms
No cost
No credit check
No disappointment
No experience
No fees
No gimmick
No inventory
No investment
No medical exams
No middleman
No obligation
No purchase necessary
No questions asked
No selling
No strings attached
Not intended
Off shore
Offer expires
Offers coupon
Offers extra cash
Offers free (often stolen) passwords
Once in lifetime
One hundred percent free
One hundred percent guaranteed
One time mailing
Online biz opportunity 	
Online pharmacy
Only $
Opportunity
Opt in
Order now
Order status
Orders shipped by priority mail
Outstanding values
Pennies a day
People just leave money laying around
Please read
Potential earnings
Print form signature
Print out and fax
Produced and sent out
Profits
Promise you ...!
Pure profit
Real thing
Refinance home
Removal instructions
Remove in quotes
Remove subject
Removes wrinkles
Reply remove subject
Requires initial investment
Reserves the right
Reverses aging
Risk free
Round the world
S 1618
Safeguard notice
Satisfaction guaranteed
Save $
Save big money
Save up to
Score with babes
Section 301
See for yourself
Sent in compliance
Serious cash
Serious only
Shopping spree
Sign up free today
Social security number
Stainless steel
Stock alert
Stock disclaimer statement
Stock pick
Strong buy
Stuff on sale
Subject to credit
Supplies are limited
Take action now
Talks about hidden charges
Talks about prizes
Tells you it's an ad
Terms and conditions
The best rates
The following form
They keep your money -- no refund!
They're just giving it away
This isn't junk
This isn't spam
University diplomas
Unlimited
Unsecured credit/debt
Urgent
US dollars
Vacation offers
Viagra and other drugs
Wants credit card
We hate spam
We honor all
Weekend getaway
What are you waiting for?
While supplies last
While you sleep
Who really wins?
Why pay more?
Will not believe your eyes
Winner
Winning
Work at home
You have been selected
Your income");
		foreach ($nasty_keywords as $keyword)
		{
			$keyword=trim($keyword);
			if ($keyword=='') continue;
			if (strpos($contents,$keyword)!==false)
			{
				echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.do_lang_local('MAIL_FLASHWORD')."\n";
			}
		}
	} else
	{
		$GLOBALS['MAIL_MODE']=false;
	}
	$results=check_xhtml($contents,false,$is_fragment,true,true,true,true,$ext,$manual); // full check, but no external file checking
}
if (!is_null($results))
{
	$pedantic=(in_array('checks',$_SERVER['argv'])) || ((array_key_exists('pedantic',$_SERVER['argv']) && ($_SERVER['argv']['pedantic']=='1')));
	$skip_over=$pedantic?array():array('XHTML_EMPTY_TAG','CSS_INLINE_STYLES','WCAG_ADJACENT_LINKS','XHTML_SPELLING');
	foreach ($results['errors'] as $result)
	{
		//echo ' '.implode(' ',$result['error'])."\n";
		$error_exp=trim(is_array($result['error'])?implode(' ',$result['error']):$result['error']);
		$sp=strpos($error_exp,' ');
		if (in_array($sp===false?$error_exp:substr($error_exp,0,$sp),$skip_over)) continue;
		$error_exp_2=trim(is_array($result['error'])?do_lang_local($result['error'][0],@$result['error'][1],@$result['error'][2],@$result['error'][3]):$result['error']);
		echo 'ISSUE "'.$to_use.'" '.$result['line'].' '.$result['pos'].' '.html_entity_decode($error_exp_2)."\n";
	}
}
// Check URLs
global $CRAWLED_URLS,$URL_BASE;
$filesize=0;
if ((!isset($URL_BASE)) && (isset($CRAWLED_URLS)))
{
	foreach ($CRAWLED_URLS as $url)
	{
		if ($url=='TODO') continue;

		if (strpos($url,'://')===false)
		{
			if ($GLOBALS['MAIL_MODE'])
				echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.html_entity_decode(do_lang_local('MAIL_LOCAL_REF'))."\n";
		} else
		{
			set_error_handler('error_capture');
			$GLOBALS['ERROR']='';
			file_get_contents($url);
			restore_error_handler();
			if (strpos($GLOBALS['ERROR'],'no such host is known')!==false)
			{
				echo 'ISSUE "'.$to_use.'" 1 1 '.html_entity_decode(do_lang_local('XHTML_BROKEN_URL',$url,'bad host'))."\n";
			}
			if (strpos($GLOBALS['ERROR'],'404 not found')!==false)
			{
				echo 'ISSUE "'.$to_use.'" 1 1 '.html_entity_decode(do_lang_local('XHTML_BROKEN_URL',$url,'404'))."\n";
			}
			if (strpos($GLOBALS['ERROR'],'500 internal server error')!==false)
			{
				echo 'ISSUE "'.$to_use.'" 1 1 '.html_entity_decode(do_lang_local('XHTML_BROKEN_URL',$url,'500'))."\n";
			}
		}
		if (preg_match('#^[A-Za-z0-9\-\_\.][A-Za-z0-9\-\_\./]*$#',$url)!=0)
		{
			if (!file_exists(dirname($to_use).'/'.$url))
			{
				$global_pos=strpos($contents,$url);
				$line=substr_count(substr($contents,0,$global_pos),chr(10))+1;
				$pos=$global_pos-strrpos(substr($contents,0,$global_pos),chr(10));
				echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.html_entity_decode(do_lang_local('XHTML_LOCAL_BROKEN_URL',$url))."\n";
			} else
			{
				$filesize+=filesize(dirname($to_use).'/'.$url);
			}
		}
	}
}
if ($filesize>100*1024)
{
	echo 'ISSUE "'.$to_use.'" '.strval($line).' '.strval($pos).' '.html_entity_decode(do_lang_local('XHTML_BLOAT'))."\n";
}

global $WITHIN_PHP;
if (!isset($WITHIN_PHP)) echo 'DONE "'.$to_use."\"\n";

