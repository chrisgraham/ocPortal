<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

require_css('crossword');
require_code('php-crossword/php_crossword.class');

$id=$map['param'];
$cols=array_key_exists('cols',$map)?intval($map['cols']):15;
$rows=array_key_exists('rows',$map)?intval($map['rows']):15;
$max_words=array_key_exists('max_words',$map)?intval($map['max_words']):15;

$cache_id=$id.'_'.strval($cols).'_'.strval($rows).'_'.strval($max_words);
$cached=get_cache_entry('main_crossword',$cache_id);
if (is_null($cached))
{
	$pc=new PHP_Crossword($rows, $cols);

	$pc->setMaxWords($max_words);

	$charset=get_charset();

	$success=$pc->generate();

	if (!$success) warn_exit('Sorry, unable to generate demo crossword - try with more area or less words.');

	$params=array(
		'colors'	=> 0,
		'fillflag'	=> 0,
		'cellflag'	=> ''
		);

	$html=$pc->getHTML($params);
	$words=$pc->getWords();

	require_code('caches2');
	put_into_cache('main_crossword',60*60*24*5000,$cache_id,array($html,$words));
} else
{
	list($html,$words)=$cached;
}

echo '<div class="float_surrounder crossword">';

echo <<<END
<table class="questionTable results_table" border="0" cellpadding="4">
<tr>
	<th>Num.</th>
	<th>Question</th>
</tr>
END;

$word_hints='';
foreach ($words as $key=>$word)
{
	$_key=escape_html(strval($key+1));
	$_question=escape_html($word['question']);
	$_word=$word['word'];
	if ($word_hints!='') $word_hints.=', ';
	$word_hints.=strval($key+1).'='.$_word;
echo <<<END
<tr>
	<td>{$_key}.</td>
	<td>{$_question}</td>
</tr>
END;
}

echo <<<END
</table>
END;

echo $html;

echo '</div>';

if ($GLOBALS['FORUM_DRIVER']->is_staff(get_member()))
{
	attach_message('As you are staff you can see that the answers are as follows: '.$word_hints,'inform');
}
