<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

function init__forum__pages__modules_custom__topicview($in=NULL)
{
	if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.

	$in=str_replace('$_postdetails[\'post\']','ocjester_filtering_wrap($_postdetails[\'post\']->evaluate())',$in);

	return $in;
}

function ocjester_filtering_wrap($in)
{
	$orig=$in;

	$in='<div>'.$in.'</div>';
	$matches=array();
	$num_matches=preg_match_all('#(>)([^<>]+)(<)#Us',$in,$matches,PREG_SET_ORDER);
	global $M_SORT_KEY;
	$M_SORT_KEY=2;
	usort($matches,'strlen_sort');
	$matches=array_reverse($matches);
	for ($i=0;$i<$num_matches;$i++)
	{
		$before=$matches[$i][1];
		$x1=$matches[$i][2];
		$after=$matches[$i][3];
		$x2=ocjester_filtering_wrap_2($x1);
		$in=str_replace($before.$x1.$after,$before.$x2.$after,$in);
	}

	if ($GLOBALS['XSS_DETECT'] && ocp_is_escaped($orig))
	{
		ocp_mark_as_escaped($in);
	}

	return $in;
}

function ocjester_filtering_wrap_2($in)
{
	$bits=preg_split('#(&[^;]+;)#',$in,-1,PREG_SPLIT_DELIM_CAPTURE);

	$new='';
	for ($i=0;$i<count($bits);$i++)
	{
		if ($i%2==1)
		{
			$new.=$bits[$i];
		} else
		{
			$new.=ocjester_filtering($bits[$i]);
		}
	}

	return $new;
}

function ocjester_filtering($in)
{
	require_code('ocfiltering');
	$passes=(count(array_intersect(@ocfilter_to_idlist_using_memory(get_option('ocjester_piglatin_shown_for',true),$GLOBALS['FORUM_DRIVER']->get_usergroup_list()),$GLOBALS['FORUM_DRIVER']->get_members_groups(get_member())))!=0);
	if ($passes)
		$in=ocjester_piglatin_filter($in);

	$passes=(count(array_intersect(@ocfilter_to_idlist_using_memory(get_option('ocjester_leet_shown_for',true),$GLOBALS['FORUM_DRIVER']->get_usergroup_list()),$GLOBALS['FORUM_DRIVER']->get_members_groups(get_member())))!=0);
	if ($passes)
		$in=ocjester_leet_filter($in);

	$passes=(count(array_intersect(@ocfilter_to_idlist_using_memory(get_option('ocjester_string_changes_shown_for',true),$GLOBALS['FORUM_DRIVER']->get_usergroup_list()),$GLOBALS['FORUM_DRIVER']->get_members_groups(get_member())))!=0);
	if ($passes)
		$in=ocjester_string_changes_filter($in);

	return $in;
}

function ocjester_leet_filter($in)
{
	$in=str_replace(
		array(
			'a',			'b',			'c',			'd',			'e',			'f',			'g',			'h',
			'i',			'j',			'k',			'l',			'm',			'n',			'o',			'p',
			'q',			'r',			's',			't',			'u',			'v',			'w',			'x',
			'y',			'z',			'A',			'B',			'C',			'D',			'E',			'F',
			'G',			'H',			'I',			'J',			'K',			'L',			'M',			'N',
			'O',			'P',			'Q',			'R',			'S',			'T',			'U',			'V',
			'W',			'X',			'Y',			'Z',
		),
		array(
			'4',			'b',			'c',			'd',			'3',			'f',			'9',			'h',
			'1',			'j',			'k',			'l',			'm',			'n',			'0',			'',
			'q',			'r',			'5',			'7',			'u',			'v',			'w',			'x',
			'y',			'2',			'4',			'B',			'C',			'D',			'3',			'F',
			'9',			'H',			'1',			'J',			'K',			'L',			'M',			'N',
			'0',			'P',			'Q',			'R',			'5',			'7',			'U',			'V',
			'W',			'X',			'Y',			'2',
		),
		$in);

	return $in;
}

function ocjester_piglatin_filter($in)
{
	$matches=array();
	$num_matches=preg_match_all('#([^\w]|^)(\w\w\w\w+)([^\w]|$)#',$in,$matches);

	for ($i=0;$i<$num_matches;$i++)
	{
		$piglatin_version=pigLatin($matches[2][$i]);
		$in=str_replace($matches[0][$i],$matches[1][$i].$piglatin_version.$matches[3][$i],$in);
	}

	return $in;
}

/* PigLatin by Martyr2 */

// Controller function for determining if word starts with vowel, then add "way"
// Otherwise, pass it on for rotation and add "ay"
// Piglatin has variations in rules, this is a common form but not only form.

function pigLatin($word) {
	if (isVowel(substr($word,0,1))) {
		return "$word" . "way ";
	}
	else {
		return moveLetter($word) . "ay ";
	}
}

// Recursive function to take off a non vowel letter and put it on the end
// Recall the function until a vowel is encountered and then return the word.
function moveLetter(&$word) {
	if (!containsVowel($word)) return $word;

	if (!isVowel(substr($word,0,1))) {
		$chLetter=strtolower(substr($word,0,1));
		$word=substr($word,1) . $chLetter;
		return moveLetter($word);
	}
	else { return $word; }
}

function containsVowel($word)
{
	$len=strlen($word);
	for ($i=0;$i<$len;$i++)
	{
		if (isVowel($word[$i])) return true;
	}
	return false;
}

// Simply checks if letter is a vowel.
// For most pig latin variations, Y is considered a vowel.
function isVowel($chLetter) {
	$letters=array("a","e","i","o","u","y");

	for ($i=0; $i < 6; $i++) {
		if (strtolower($chLetter)==$letters[$i]) { return true; }
	}

	return false;
}

function ocjester_string_changes_filter($in)
{
	$changes=@explode("\n",get_option('ocjester_string_changes',true));
	$remap=array();
	foreach ($changes as $change)
	{
		$bits=explode('=',$change,2);
		if (count($bits)==2)
		{
			$from=trim($bits[0]);
			$to=trim($bits[1]);
			$remap[$from]=$to;
		}
	}

	$len=strlen($in);
	for ($i=0;$i<$len;$i++)
	{
		foreach ($remap as $from=>$to)
		{
			if (substr($in,$i,strlen($from))==$from)
			{
				$in=substr($in,0,$i).$to.substr($in,$i+strlen($from));
				$len=strlen($in);
				$i+=strlen($from)-1;
			}
		}
	}

	return $in;
}
