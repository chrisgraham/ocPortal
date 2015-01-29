<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Hook_stats_external
{

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		$bits=new ocp_tempcode();
		$map=array();
		$url=get_base_url();
		list($rank,$links,$speed)=getAlexaRank($url);
		$page_rank=getPageRank($url);
		if ($page_rank!='') $map['Google PageRank']=$page_rank;
		if ($rank!='') $map['Alexa rank']=$rank;
		$map['Back links']=protect_from_escaping('<a title="Show back links" href="http://www.google.co.uk/search?as_lq='.urlencode($url).'">'.$links.'</a>');
		if ($speed!='') $map['Speed']=$speed;
		foreach ($map as $key=>$val)
		{
			$bits->attach(do_template('BLOCK_SIDE_STATS_SUBLINE',array('_GUID'=>'fa391b1b773cd8a4b283cb6617af898b','KEY'=>$key,'VALUE'=>is_null($val)?'':$val)));
		}
		$section=do_template('BLOCK_SIDE_STATS_SECTION',array('_GUID'=>'0d26b94a7903aab57d76d72da53eca98','SECTION'=>'Meta stats','CONTENT'=>$bits));

		return $section;
	}

}

function getAlexaRank($url)
{
	require_code('files');
	$p=array();
	$result=http_download_file('http://data.alexa.com/data?cli=10&dat=s&url='.urlencode($url),NULL,false);
	if (preg_match('#<POPULARITY [^<>]*TEXT="([0-9]+){1,}"#si',$result,$p)!=0)
		$rank=integer_format(intval($p[1]));
	else $rank=do_lang('NA');
	if (preg_match('#<LINKSIN [^<>]*NUM="([0-9]+){1,}"#si',$result,$p)!=0)
		$links=integer_format(intval($p[1]));
	else $links='0';
	if (preg_match( '#<SPEED [^<>]*PCT="([0-9]+){1,}"#si',$result,$p)!=0)
		$speed='Top '.integer_format(100-intval($p[1])).'%';
	else $speed='?';

	// we would like, but cannot get (without an API key)...
	/*
		time on site
		reach (as a percentage)
		page views
		audience (i.e. what country views the site most)
	 */

	return array($rank,$links,$speed);
}


//convert a string to a 32-bit integer
function StrToNum($Str, $Check, $Magic)
{
	// This is external code which doesn't live up to ocPortal's strictness level
	require_code('developer_tools');
	destrictify();

	$Int32Unit=4294967296;  // 2^32

	$length=strlen($Str);
	for ($i=0;$i<$length;$i++)
	{
		$Check*=$Magic;
		//If the float is beyond the boundaries of integer (usually +/- 2.15e+9=2^31),
		//  the result of converting to integer is undefined
		//  refer to http://www.php.net/manual/en/language.types.integer.php
		if ($Check>=$Int32Unit)
		{
			$Check=($Check - $Int32Unit*intval($Check/$Int32Unit));
			//if the check less than -2^31
			$Check=($Check<-2147483648)?($Check+$Int32Unit):$Check;
		}
		$Check += ord($Str[$i]);
	}
	return $Check;
}

//genearate a hash for a url
function HashURL($String)
{
	$Check1=StrToNum($String,0x1505,0x21);
	$Check2=StrToNum($String,0,0x1003F);

	$Check1=$Check1>>2;
	$Check1=(($Check1>>4) & 0x3FFFFC0) | ($Check1&0x3F);
	$Check1=(($Check1>>4) & 0x3FFC00) | ($Check1&0x3FF);
	$Check1=(($Check1>>4) & 0x3C000) | ($Check1&0x3FFF);	

	$T1=(((($Check1&0x3C0)<<4) | ($Check1&0x3C)) <<2) | ($Check2&0xF0F);
	$T2=@(((($Check1&0xFFFFC000)<<4) | ($Check1 & 0x3C00))<<0xA) | ($Check2&0xF0F0000);

	return ($T1 | $T2);
}

//genearate a checksum for the hash string
function CheckHash($Hashnum)
{
	$CheckByte=0;
	$Flag=0;

	$HashStr=sprintf('%u',$Hashnum);
	$length=strlen($HashStr);

	for ($i=$length-1;$i>=0;$i--)
	{
		$Re=intval($HashStr[$i]);
		if (1===($Flag%2))
		{
			$Re+=$Re;
			$Re=intval($Re/10)+($Re%10);
		}
		$CheckByte+=$Re;
		$Flag++;	
	}

	$CheckByte=$CheckByte%10;
	if (0!==$CheckByte)
	{
		$CheckByte=10-$CheckByte;
		if (1===($Flag%2))
		{
			if (1===($CheckByte%2))
			{
				$CheckByte+=9;
			}

			$CheckByte=$CheckByte>>1;
		}
	}

	return '7'.strval($CheckByte).$HashStr;
}

//return the pagerank checksum hash
function getch($url)
{
	return CheckHash(HashURL($url));
}

//return the pagerank figure
function getpr($url)
{
	$ch=getch($url);
	$errno='0';
	$errstr='';
	require_code('files');
	$data=http_download_file('http://toolbarqueries.google.com/search?client=navclient-auto&ch='.$ch.'&features=Rank&q=info:'.$url,NULL,false);
	if (is_null($data)) return '';

	$pos=strpos($data,"Rank_");
	if($pos!==false)
	{
		$pr=substr($data,$pos+9);
		$pr=trim($pr);
		$pr=str_replace("\n",'',$pr);
		return $pr;
	}

	return '';
}

//return the pagerank figure
function getPageRank($url)
{
	if (preg_match('/^(http:\/\/)?([^\/]+)/i',$url)==0)
	{
		$url='http://'.$url;
	}
	$pr=getpr($url);
	return $pr;
}
