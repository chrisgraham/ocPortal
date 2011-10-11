<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2009

 See text/en/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_validation
 */

/**
 * Standard code module initialisation function.
 */
function init__js_lex()
{
	global $JS_ERRORS;
	$JS_ERRORS=array();

	// These are standalone lexer tokens: finding them doesn't affect the lexing state
	// ===============================================================================
	
	global $TOKENS;
	
	// Logical combinators
	$TOKENS['BOOLEAN_AND']='&&';
	$TOKENS['BOOLEAN_OR']='||';
	// Logical comparators
	$TOKENS['IS_EQUAL']='==';
	$TOKENS['IS_GREATER']='>';
	$TOKENS['IS_SMALLER']='<';
	$TOKENS['IS_GREATER_OR_EQUAL']='>=';
	$TOKENS['IS_SMALLER_OR_EQUAL']='<=';
	$TOKENS['IS_IDENTICAL']='===';
	$TOKENS['IS_NOT_EQUAL']='!=';
	$TOKENS['IS_NOT_IDENTICAL']='!==';
	// Unary logical operators
	$TOKENS['BOOLEAN_NOT']='!';
	// Logical commands
	$TOKENS['IF']='if';
	$TOKENS['ELSE']='else';
	$TOKENS['SWITCH']='switch';
	$TOKENS['CASE']='case';
	$TOKENS['DEFAULT']='default';
	// Assignment
	$TOKENS['DIV_EQUAL']='/=';
	$TOKENS['MINUS_EQUAL']='-=';
	$TOKENS['MUL_EQUAL']='*=';
	$TOKENS['PLUS_EQUAL']='+=';
	$TOKENS['SL_EQUAL']='<<=';
	$TOKENS['SR_EQUAL']='>>=';
	$TOKENS['ZSR_EQUAL']='>>=';
	$TOKENS['BW_AND_EQUAL']='&=';
	$TOKENS['BW_OR_EQUAL']='|=';
	$TOKENS['EQUAL']='=';
	// General structural
	$TOKENS['COLON']=':';
	$TOKENS['QUESTION']='?';
	$TOKENS['COMMA']=',';
	$TOKENS['CURLY_CLOSE']='}';
	$TOKENS['CURLY_OPEN']='{';
	$TOKENS['BRACKET_OPEN']='(';
	$TOKENS['BRACKET_CLOSE']=')';
	$TOKENS['COMMAND_TERMINATE']=';';
	$TOKENS['EXTRACT_OPEN']='[';
	$TOKENS['EXTRACT_CLOSE']=']';
	$TOKENS['WITH']='with';
	// Loops
	$TOKENS['BREAK']='break';
	$TOKENS['CONTINUE']='continue';
	$TOKENS['FOR']='for';
	$TOKENS['IN']='in';
	$TOKENS['OF']='of';
	$TOKENS['WHILE']='while';
	$TOKENS['DO']='do';
	// Unary operators
	$TOKENS['DEC']='--';
	$TOKENS['INC']='++';
	// Binary operators
	$TOKENS['BW_AND']='&';
	$TOKENS['BW_XOR']='^';
	$TOKENS['BW_OR']='|';
	$TOKENS['BW_NOT']='~';
	$TOKENS['SL']='<<';
	$TOKENS['SR']='>>';
	$TOKENS['ZSR']='>>>';
	$TOKENS['ADD']='+';
	$TOKENS['SUBTRACT']='-';
	$TOKENS['MULTIPLY']='*';
	$TOKENS['DIVIDE']='/';
	$TOKENS['REMAINDER']='%';
	// Classes/objects/variables/functions
	$TOKENS['VAR']='var';
	$TOKENS['OBJECT_OPERATOR']='.';
	$TOKENS['NEW']='new';
	$TOKENS['DELETE']='delete';
	$TOKENS['INSTANCEOF']='instanceof';
	$TOKENS['TYPEOF']='typeof';
	$TOKENS['FUNCTION']='function';
	$TOKENS['RETURN']='return';
	// Exceptions
	$TOKENS['THROW']='throw';
	$TOKENS['TRY']='try';
	$TOKENS['CATCH']='catch';
	$TOKENS['FINALLY']='finally';
	// Simple types
	$TOKENS['true']='true';
	$TOKENS['false']='false';
	$TOKENS['null']='null';
	$TOKENS['undefined']='undefined';
	$TOKENS['infinity']='infinity';
	$TOKENS['NaN']='NaN';
	// Reserved
	$TOKENS['abstract']='abstract';
	$TOKENS['boolean']='boolean';
	$TOKENS['byte']='byte';
	$TOKENS['char']='char';
	$TOKENS['class']='class';
	$TOKENS['const']='const';
	$TOKENS['debugger']='debugger';
	$TOKENS['double']='double';
	$TOKENS['enum']='enum';
	$TOKENS['export']='export';
	$TOKENS['final']='final';
	$TOKENS['float']='float';
	$TOKENS['goto']='goto';
	$TOKENS['implements']='implements';
	$TOKENS['import']='import';
	$TOKENS['int']='int';
	$TOKENS['interface']='interface';
	$TOKENS['long']='long';
	$TOKENS['native']='native';
	$TOKENS['package']='package';
	$TOKENS['private']='private';
	$TOKENS['protected']='protected';
	$TOKENS['public']='public';
	$TOKENS['short']='short';
	$TOKENS['static']='static';
	$TOKENS['super']='super';
	$TOKENS['synchronized']='synchronized';
	$TOKENS['throws']='throws';
	$TOKENS['transient']='transient';
	$TOKENS['volatile']='volatile';
	$TOKENS['void']='void'; // actually exists, but we don't want to allow it

	// None matches go to be 'IDENTIFIER'
	// Also detected are: integer_literal, float_literal, string_literal, variable, comment
	
	// Loaded lexer tokens that change the lexing state
	// ================================================
//	$TOKENS['REGEXP']='/'; // Ending it with "/" is implicit in the LEXER_REGEXP state
	$TOKENS['START_ML_COMMENT']='/*'; // Ending it with "* /" is implicit in the LEXER_ML_COMMENT state
	$TOKENS['COMMENT']='//'; // Ending it with a new-line is implicit in the LEXER_COMMENT state
	$TOKENS['DOUBLE_QUOTE']='"'; // Ending it with non-escaped " is implicit in LEXER_DOUBLE_QUOTE_STRING_LITERAL state (as well as extended escaping)
	$TOKENS['SINGLE_QUOTE']='\''; // Ending it with non-escaped ' is implicit in LEXER_SINGLE_QUOTE_STRING_LITERAL state

	// Lexer states
	define('LEXER_FREE',1); // (grabs implicitly)
	define('LEXER_REGEXP',2); // grabs and converts to token equiv of new RegExp("...")
	define('LEXER_ML_COMMENT',4); // grab comment
	define('LEXER_COMMENT',5); // grab comment
	define('LEXER_DOUBLE_QUOTE_STRING_LITERAL',6); // grab string_literal
	define('LEXER_SINGLE_QUOTE_STRING_LITERAL',7); // grab string_literal
	define('LEXER_NUMERIC_LITERAL',8); // grab float_literal/integer_literal (supports decimal, octal, hexadecimal)

	// These are characters that can be used to continue an identifier lexer token (any other character starts a new token).
	global $CONTINUATIONS;
	$CONTINUATIONS=array(
								'a'=>'1','b'=>'1','c'=>'1','d'=>'1','e'=>'1','f'=>'1','g'=>'1','h'=>'1','i'=>'1','j'=>'1','k'=>'1','l'=>'1','m'=>'1','n'=>'1','o'=>'1','p'=>'1','q'=>'1','r'=>'1','s'=>'1','t'=>'1','u'=>'1','v'=>'1','w'=>'1','x'=>'1','y'=>'1','z'=>'1',
								'A'=>'1','B'=>'1','C'=>'1','D'=>'1','E'=>'1','F'=>'1','G'=>'1','H'=>'1','I'=>'1','J'=>'1','K'=>'1','L'=>'1','M'=>'1','N'=>'1','O'=>'1','P'=>'1','Q'=>'1','R'=>'1','S'=>'1','T'=>'1','U'=>'1','V'=>'1','W'=>'1','X'=>'1','Y'=>'1','Z'=>'1',
								'1'=>'1','2'=>'1','3'=>'1','4'=>'1','5'=>'1','6'=>'1','7'=>'1','8'=>'1','9'=>'1','0'=>'1','_'=>'1','$'=>'1');
	// For non-identifier tokens, tokenisation is driven purely upon "best match".
}

/**
 * Lex some Javascript code.
 *
 * @param  string			The code
 * @return list			List of lexed tokens
 */
function js_lex($text)
{
	global $CONTINUATIONS,$TOKENS,$JS_TAG_RANGES,$JS_VALUE_RANGES,$JS_TEXT,$JS_LEX_TOKENS;

	// So that we don't have to consider end-of-file states as much.
	$JS_TEXT=$text."\n";

	$JS_LEX_TOKENS=array(); // We will be lexing into this list of tokens

	$special_token_value=''; // This will be used during special lexing modes to build up the special token value being lexed

	$lex_state=LEXER_FREE;
	$escape_flag=false; // Used for string_literal escaping

	// Lex the code. Hard coded state changes occur. Understanding of tokenisation implicit. Trying to match tokens to $TOKENS, otherwise an identifier.
	$char='';
	$i=0;
	while (true)
	{
		switch ($lex_state)
		{
			case LEXER_FREE:
				// Jump over any white space in our way
				do
				{
					list($reached_end,$i,$char)=lex__get_next_char($i);
					if ($reached_end) break 3;
				}
				while (trim($char)=='');

				// We need to know where our token is starting
				$i--;
				$i_current=$i;

				// Try and work out what token we're looking at next
				$maybe_applicable_tokens=$TOKENS;
				$applicable_tokens=array();
				$token_so_far='';
				while (count($maybe_applicable_tokens)!=0)
				{
					list($reached_end,$i,$char)=lex__get_next_char($i);
					if ($reached_end) break 3;

					$token_so_far.=$char;

					$_=$token_so_far[0]; // To strict stupid optimiser

					// Filter out any tokens that no longer match
					$cnt=count($JS_LEX_TOKENS);
					foreach ($maybe_applicable_tokens as $token_name=>$token_value)
					{
						// Hasn't matched (or otherwise, may still match)
						if (substr($token_value,0,strlen($token_so_far))!==$token_so_far)
						{
							unset($maybe_applicable_tokens[$token_name]);
						} else
						{
							// Is it a perfect match?
							if ((strlen($token_so_far)==strlen($token_value)) && ((!array_key_exists($token_so_far[0],$CONTINUATIONS)) || (!array_key_exists($JS_TEXT[$i],$CONTINUATIONS))))
							{
								if (($token_name!='FUNCTION') || (!isset($JS_LEX_TOKENS[$cnt-1])) || ($JS_LEX_TOKENS[$cnt-1][0]!='NEW'))
								{
									$applicable_tokens[]=$token_name;
								}
								unset($maybe_applicable_tokens[$token_name]);
							}
						}
					}
				}

				if (in_array('DIV_EQUAL',$applicable_tokens))
				{
					$previous=isset($JS_LEX_TOKENS[count($JS_LEX_TOKENS)-1])?($JS_LEX_TOKENS[count($JS_LEX_TOKENS)-1][0]):'BRACKET_OPEN';
					if (($previous=='BRACKET_OPEN') || ($previous=='COMMA'))
					{
						$applicable_tokens=array('DIVIDE'); // Actually, a regular expression
					}
				}

				// If we have any applicable tokens, find the longest and move $i so it's as we just read it
				$i=$i_current;
				if (count($applicable_tokens)!=0)
				{
					usort($applicable_tokens,'_strlen_sort');
					$token_found=$applicable_tokens[count($applicable_tokens)-1];

					$i+=strlen($TOKENS[$token_found]);

					// Is it a special state jumping token?
					if ($token_found=='START_ML_COMMENT')
					{
						$lex_state=LEXER_ML_COMMENT;
						break;
					}
					elseif ($token_found=='COMMENT')
					{
						$lex_state=LEXER_COMMENT;
						break;
					}
					elseif (($token_found=='DIVIDE') && (!in_array(@$JS_LEX_TOKENS[count($JS_LEX_TOKENS)-1][0],array('number_literal','IDENTIFIER','EXTRACT_CLOSE','BRACKET_CLOSE'))))
					{
						$lex_state=LEXER_REGEXP;
						break;
					}
					elseif ($token_found=='DOUBLE_QUOTE')
					{
						$lex_state=LEXER_DOUBLE_QUOTE_STRING_LITERAL;
						break;
					}
					elseif ($token_found=='SINGLE_QUOTE')
					{
						$lex_state=LEXER_SINGLE_QUOTE_STRING_LITERAL;
						break;
					}

					$JS_LEX_TOKENS[]=array($token_found,$i);
				} else
				{
					// Otherwise, we've found an identifier or numerical literal token, so extract it
					$token_found='';
					$numeric=NULL;
					do
					{
						list($reached_end,$i,$char)=lex__get_next_char($i);
						if ($reached_end) break 3;
						if (is_null($numeric))
						{
							$numeric=array_key_exists($char,array('0'=>1,'1'=>1,'2'=>1,'3'=>1,'4'=>1,'5'=>1,'6'=>1,'7'=>1,'8'=>1,'9'=>1));
						}
						if ((!array_key_exists($char,$CONTINUATIONS)) && (($numeric===false) || ($char!='.') || (!is_numeric($JS_TEXT[$i])))) break;

						$token_found.=$char;
					}
					while (true);
					$i--;

					if ($numeric)
					{
						if (strpos($token_found,'.')!==false) $JS_LEX_TOKENS[]=array('number_literal',floatval($token_found),$i);
						elseif (strpos($token_found,'x')!==false) $JS_LEX_TOKENS[]=array('number_literal',intval(base_convert($token_found,16,10)),$i);
						elseif ($token_found[0]=='0') $JS_LEX_TOKENS[]=array('number_literal',intval(base_convert($token_found,8,10)),$i);
						else $JS_LEX_TOKENS[]=array('number_literal',intval($token_found),$i);

						$JS_VALUE_RANGES[]=array($i-strlen($token_found),$i);
					} else
					{
						if ($token_found=='')
						{
							js_log_warning('LEXER','Bad token found',$i,true);
							return array();
						}
						$JS_LEX_TOKENS[]=array('IDENTIFIER',$token_found,$i);
						$JS_TAG_RANGES[]=array($i-strlen($token_found),$i);
					}
				}

				break;

			case LEXER_COMMENT:
				list($reached_end,$i,$char)=lex__get_next_char($i);
				if ($reached_end) break 2;

				// Exit case
				if ($char==chr(10))
				{
					$lex_state=LEXER_FREE;
					$JS_LEX_TOKENS[]=array('comment',$special_token_value,$i);
					$special_token_value='';
					$i--;
					break;
				}

				// Normal case
				$special_token_value.=$char;

				break;

			case LEXER_ML_COMMENT:
				list($reached_end,$i,$char)=lex__get_next_chars($i,2);
				if ($reached_end) break 2;

				// Exit case
				if ($char=='*/')
				{
					$lex_state=LEXER_FREE;
					$JS_LEX_TOKENS[]=array('comment',$special_token_value,$i);
					$special_token_value='';
					break;
				}

				$i-=1;
				if (!isset($char[0])) break 2;
				$char=$char[0];

				// Normal case
				$special_token_value.=$char;

				break;

			case LEXER_REGEXP:
				list($reached_end,$i,$char)=lex__get_next_chars($i,1);
				if ($reached_end) break 2;

				// Exit case
				if (($char=='/') && (($i<2) || ($JS_TEXT[$i-2]!='\\') || ($JS_TEXT[$i-3]=='\\')))
				{
					do
					{
						list($reached_end,$i,$char)=lex__get_next_chars($i,1);
					}
					while (($char=='g') || ($char=='i') || ($char=='m'));
					$i--;

					$lex_state=LEXER_FREE;
					$JS_LEX_TOKENS[]=array('NEW',$i);
					$JS_LEX_TOKENS[]=array('IDENTIFIER','RegExp',$i);
					$JS_LEX_TOKENS[]=array('BRACKET_OPEN',$i);
					$JS_LEX_TOKENS[]=array('string_literal',$special_token_value,$i);
					$JS_LEX_TOKENS[]=array('BRACKET_CLOSE',$i);
					$JS_VALUE_RANGES[]=array($i-strlen($special_token_value),$i);
					$special_token_value='';
					break;
				}

				// Normal case
				$special_token_value.=$char;

				break;

			case LEXER_DOUBLE_QUOTE_STRING_LITERAL:
				list($reached_end,$i,$char)=lex__get_next_char($i);
				if ($reached_end) break 2;

				if (($char=="\n") && ((strlen($special_token_value)==0) || ($special_token_value[strlen($special_token_value)-1]=='\\'))) js_log_warning('LEXER','String literals may not contain explicit new lines without special escaping',$i,true);

				// Exit case
				if (($char=='"') && (!$escape_flag))
				{
					$lex_state=LEXER_FREE;
					$JS_LEX_TOKENS[]=array('string_literal',$special_token_value,$i);
					$JS_VALUE_RANGES[]=array($i-strlen($special_token_value)-1,$i-1);
					$special_token_value='';
					break;
				}

				// Escape flag based filtering
				$actual_char=$char;
				if ($escape_flag)
				{
					if ($char=='n') $actual_char="\n";
					elseif ($char=='r') $actual_char="\r";
					elseif ($char=='t') $actual_char="\t";
				} else
				{
					if ($char=='\\') $actual_char='';
				}

				// Normal case
				$special_token_value.=$actual_char;

				$escape_flag=((!$escape_flag) && ($char=='\\'));

				break;

			case LEXER_SINGLE_QUOTE_STRING_LITERAL:
				list($reached_end,$i,$char)=lex__get_next_char($i);
				if ($reached_end) break 2;

				if ($char=="\n") js_log_warning('LEXER','String literals may not contain explicit new lines',$i,true);

				// Exit case
				if (($char=="'") && (!$escape_flag))
				{
					$lex_state=LEXER_FREE;
					$JS_LEX_TOKENS[]=array('string_literal',$special_token_value,$i);
					$JS_VALUE_RANGES[]=array($i-strlen($special_token_value)-1,$i-1);
					$special_token_value='';
					break;
				}

				// Escape flag based filtering
				$actual_char=$char;
				if ($escape_flag)
				{
					if ($char=="'") $actual_char="'";
					elseif ($char=='\\') $actual_char='\\';
					else $actual_char='\\'.$char;
				} elseif ($char=='\\') $actual_char='';

				// Normal case
				$special_token_value.=$actual_char;

				$escape_flag=((!$escape_flag) && ($char=='\\'));

				break;
		}
	}

	return $JS_LEX_TOKENS;
}

/**
 * Get the next character whilst lexing
 *
 * @param  integer		Get character at this position
 * @return list			Get triplet about the next character (whether end reached, new position, character)
 */
function lex__get_next_char($i)
{
	global $JS_TEXT;
	if ($i>=strlen($JS_TEXT)) return array(true,$i+1,'');
	$char=$JS_TEXT[$i];
	return array(false,$i+1,$char);
}

/**
 * Get the next characters whilst lexing
 *
 * @param  integer		Get character at this position
 * @param  integer		How many to get
 * @return list			Get triplet about the next character (whether end reached, new position, characters)
 */
function lex__get_next_chars($i,$num)
{
	global $JS_TEXT;
	$str=substr($JS_TEXT,$i,$num);
	return array(strlen($str)<$num,$i+$num,$str);
}

/**
 * Convert a position to a triplet of details about the line it is on.
 *
 * @param  integer		The position
 * @param  boolean		Whether the position is a string offset (as opposed to a token position)
 * @return list			The quartet of details (line offset, line number, the line, the absolute position)
 */
function js_pos_to_line_details($i,$absolute=false)
{
	global $JS_TEXT,$JS_LEX_TOKENS;
	if ((!$absolute) && (!isset($JS_LEX_TOKENS[$i]))) $i=-1;
	if ($i==-1) return array(0,0,'',0);
	$j=$absolute?$i:$JS_LEX_TOKENS[$i][count($JS_LEX_TOKENS[$i])-1];
	$line=substr_count(substr($JS_TEXT,0,$j),chr(10))+1;
	$pos=$j-strrpos(substr($JS_TEXT,0,$j),chr(10));
	$l_s=strrpos(substr($JS_TEXT,0,$j+1),chr(10))+1;
	if ($l_s==1) $l_s=0;

	$full_line=substr($JS_TEXT,$l_s,strpos($JS_TEXT,chr(10),$j)-1-$l_s);

	return array($pos,$line,$full_line,$j);
}

/**
 * Make a JS error (critically).
 *
 * @param  string			The system causing the error
 * @param  integer		The position
 * @param  string			The line
 * @param  string			The error
 * @param  integer		The global position
 * @return ?boolean		Always NULL (NULL: exit)
 */
function js_die_error($system,$pos,$line,$message,$i)
{
	$error=array('JS ERROR ('.$system.'): '.$message,$pos,$line,$i);
	global $JS_ERRORS;
	$JS_ERRORS[]=$error;
	return NULL;
}

/**
 * Log a warning when lexing/parsing/checking.
 *
 * @param  string			The system causing the error
 * @param  string			The warning
 * @param  integer		The global position
 * @param  boolean		Whether the position is a string offset (as opposed to a token position)
 */
function js_log_warning($system,$warning,$i=-1,$absolute=false)
{
	global $JS_TEXT;

	if (($i==-1) && (isset($GLOBALS['i']))) $i=$GLOBALS['i'];
	list($pos,$line,,$i)=js_pos_to_line_details($i,$absolute);

	$error=array('JS ERROR ('.$system.'): '.$warning,$pos,$line,$i);
	global $JS_ERRORS;
	$JS_ERRORS[]=$error;
}

/**
 * Helper function for usort to sort a list by string length.
 *
 * @param  string			The first string to compare
 * @param  string			The second string to compare
 * @return integer		The comparison result
 */
function _strlen_sort($a,$b)
{
	global $TOKENS;
	$a=$TOKENS[$a];
	$b=$TOKENS[$b];
	if ($a==$b) return 0;
	return (strlen($a)<strlen($b))?-1:1;
}


