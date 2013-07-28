<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		password_censor
 */

function password_censor($auto=false,$display=true,$days_ago=60)
{
	if ($display)
	{
		if (!$GLOBALS['FORUM_DRIVER']->is_super_admin(get_member())) exit('Permission denied');
	}

	$_forum=get_option('ticket_forum_name');
	if (is_numeric($_forum))
	{
		$forum_id=intval($_forum);
	} else
	{
		$forum_id=$GLOBALS['FORUM_DRIVER']->forum_id_from_name($_forum);
	}

	$sql='SELECT t.id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts p JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON p.p_post=t.id';
	$sql.=' WHERE text_original LIKE \'%password%\'';
	$sql.=' AND (p_cache_forum_id='.strval($forum_id).' OR p_cache_forum_id IS NULL OR p_intended_solely_for IS NOT NULL)';
	$sql.=' AND p_time<'.strval(time()-60*60*24*$days_ago);
	$rows=$GLOBALS['FORUM_DB']->query($sql);

	header('Content-type: text/plain');

	foreach ($rows as $row)
	{
		$text=get_translated_text($row['id']);
		$text_start=$text;
		$matches=array();
		$num_matches=preg_match_all('#([^\s]{5,30})#',$text,$matches);
		for ($i=0;$i<$num_matches;$i++)
		{
			$m=$matches[1][$i];

			if (strtolower($m)=='password') continue;
			if (strtolower($m)=='username') continue;
			if (strtolower($m)=='reminder') continue;

			$c=0;
			if (preg_match('#\d#',$m)!=0) $c++;
			if (preg_match('#,+[A-Z]#',$m)!=0) $c++;
			if (preg_match('#[a-z]#',$m)!=0) $c++;
			if (preg_match('#[^\w]#',$m)!=0) $c++;
			if ((is_numeric($m)) && (strlen($m)>6)) $c++;
			if (preg_match('#(password|pass|pword|pw) ?:?=?\s+'.preg_quote($m,'#').'#i',$text)!=0) $c+=2;
			if ($c>=3)
			{
				$text=str_replace($m,'(censored)',$text);
			}
		}
		if ($text!=$text_start)
		{
			$update_query='UPDATE '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate SET text_original=\''.addslashes($text).'\',text_parsed=\'\' WHERE id='.strval($row['id']);

			if ($auto)
				$GLOBALS['FORUM_DB']->query($update_query);

			if ($display)
				echo $text_start."\n\n-------->\n\n".$text."\n\n-------------\n\n".$update_query."\n\n<-----------\n\n\n\n\n";
		}
	}
}
