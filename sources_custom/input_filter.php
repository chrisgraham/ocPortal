<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('init__input_filter'))
{
	function init__input_filter($in=NULL)
	{
		if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.

		$new_code='
			global $OBSCURE_REPLACEMENTS;
			$OBSCURE_REPLACEMENTS=array();
			require_code(\'textfiles\');
			$whitelists=explode(chr(10),read_text_file(\'comcode_whitelist\'));
			foreach ($whitelists as $i=>$w)
			{
				if (trim($w)!=\'\')
				{
					if ($w[0]!=\'/\') $w=preg_quote($w,\'#\'); else $w=substr($w,1,strlen($w)-2);
					$val=preg_replace_callback(\'#\'.$w.\'#\',\'obscure_html_callback\',$val);
				}
			}
		';
		$in=str_replace('// Null vector',$new_code,$in);

		return $in;
	}
}

function obscure_html_callback($matches)
{
	global $OBSCURE_REPLACEMENTS;
	$rep=uniqid('');
	$OBSCURE_REPLACEMENTS[$rep]=$matches[0];
	return $rep;
}

