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

/*

This file is designed to be usable from outside ocPortal, as a library.

*/

/**
 * Standard code module initialisation function.
 */
function init__validation()
{
	if (!function_exists('html_entity_decode'))
	{
		/**
		 * Decode the HTML entitity encoded input string. Can give warning if unrecognised character set.
		 *
		 * @param  string		The text to decode
		 * @param  integer	The quote style code
		 * @return string		The decoded text
		 */
		function html_entity_decode($input,$quote_style)
		{
			unset($quote_style);
			/*			// NB: &nbsp does not go to <space>. It's not something you use with html escaping, it's for hard-space-formatting. URL's don't contain spaces, but that's due to URL escaping (%20)
			$replace_array=array(
				'&amp;'=>'&',
				'&gt;'=>'>',
				'&lt;'=>'<',
				'&#039;'=>'\'',
				'&quot;'=>'"',
			);

			foreach ($replace_array as $from=>$to)
			{
				$input=str_replace($from,$to,$input);
			}

			return $input;
*/

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
		 * @set	 0 1
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
			ini_set('allow_url_fopen','1');
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
			unset($allow_fail);

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

	define('DOCTYPE_HTML','<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">');
	define('DOCTYPE_HTML_STRICT','<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">');
	define('DOCTYPE_XHTML','<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
	define('DOCTYPE_XHTML_STRICT','<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">');
	define('DOCTYPE_XHTML_NEW','<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">');

	global $XHTML_VALIDATOR_OFF,$WELL_FORMED_ONLY,$VALIDATION_JAVASCRIPT,$VALIDATION_CSS,$VALIDATION_WCAG,$VALIDATION_COMPAT,$VALIDATION_EXT_FILES,$VALIDATION_MANUAL;
	$VALIDATION_JAVASCRIPT=true;
	$VALIDATION_CSS=true;
	$VALIDATION_WCAG=true;
	$VALIDATION_COMPAT=true;
	$VALIDATION_EXT_FILES=true;
	$VALIDATION_MANUAL=false;

	global $EXTRA_CHECK;
	$EXTRA_CHECK=array();

	global $VALIDATED_ALREADY;
	$VALIDATED_ALREADY=array();

	global $NO_XHTML_LINK_FOLLOW;
	$NO_XHTML_LINK_FOLLOW=0;

	global $CSS_TAG_RANGES,$CSS_VALUE_RANGES;
	$CSS_TAG_RANGES=array();
	$CSS_VALUE_RANGES=array();

	global $ENTITIES;
	$ENTITIES=array(
	'quot'=>1, 'amp'=>1, 'lt'=>1, 'gt'=>1, 'nbsp'=>1, 'iexcl'=>1, 'cent'=>1,
	'pound'=>1, 'curren'=>1, 'yen'=>1, 'brvbar'=>1, 'sect'=>1, 'uml'=>1,
	'copy'=>1, 'ordf'=>1, 'laquo'=>1, 'not'=>1, 'shy'=>1, 'reg'=>1, 'macr'=>1,
	'deg'=>1, 'plusmn'=>1, 'sup2'=>1, 'sup3'=>1, 'acute'=>1, 'micro'=>1,
	'para'=>1, 'middot'=>1, 'cedil'=>1, 'sup1'=>1, 'ordm'=>1, 'raquo'=>1,
	'frac14'=>1, 'frac12'=>1, 'frac34'=>1, 'iquest'=>1,
	'Agrave'=>1, 'Aacute'=>1, 'Acirc'=>1, 'Atilde'=>1, 'Auml'=>1, 'Aring'=>1, 
	'AElig'=>1, 'Ccedil'=>1, 'Egrave'=>1, 'Eacute'=>1,
	'Ecirc'=>1, 'Euml'=>1, 'Igrave'=>1, 'Iacute'=>1, 'Icirc'=>1, 'Iuml'=>1, 
	'ETH'=>1, 'Ntilde'=>1, 'Ograve'=>1, 'Oacute'=>1, 'Ocirc'=>1,
	'Otilde'=>1, 'Ouml'=>1, 'times'=>1, 'Oslash'=>1, 'Ugrave'=>1, 'Uacute'=>1, 
	'Ucirc'=>1, 'Uuml'=>1, 'Yacute'=>1, 'THORN'=>1,
	'szlig'=>1, 'agrave'=>1, 'aacute'=>1, 'acirc'=>1, 'atilde'=>1, 'auml'=>1, 
	'aring'=>1, 'aelig'=>1, 'ccedil'=>1, 'egrave'=>1,
	'eacute'=>1, 'ecirc'=>1, 'euml'=>1, 'igrave'=>1, 'iacute'=>1, 'icirc'=>1,
	'iuml'=>1, 'eth'=>1, 'ntilde'=>1, 'ograve'=>1, 'oacute'=>1,
	'ocirc'=>1, 'otilde'=>1, 'ouml'=>1, 'divide'=>1, 'oslash'=>1, 'ugrave'=>1,
	'uacute'=>1, 'ucirc'=>1, 'uuml'=>1, 'yacute'=>1,
	'thorn'=>1, 'yuml'=>1, 'fnof'=>1, 'Alpha'=>1, 'Beta'=>1, 'Gamma'=>1,
	'Delta'=>1, 'Epsilon'=>1, 'Zeta'=>1, 'Eta'=>1, 'Theta'=>1, 'Iota'=>1,
	'Kappa'=>1, 'Lambda'=>1, 'Mu'=>1, 'Nu'=>1, 'Xi'=>1, 'Omicron'=>1, 'Pi'=>1, 
	'Rho'=>1, 'Sigma'=>1, 'Tau'=>1, 'Upsilon'=>1, 'Phi'=>1, 'Chi'=>1,
	'Psi'=>1, 'Omega'=>1, 'alpha'=>1, 'beta'=>1, 'gamma'=>1, 'delta'=>1,
	'epsilon'=>1, 'zeta'=>1, 'eta'=>1, 'theta'=>1, 'iota'=>1, 'kappa'=>1,
	'lambda'=>1, 'mu'=>1, 'nu'=>1, 'xi'=>1, 'omicron'=>1, 'pi'=>1, 'rho'=>1,
	'sigmaf'=>1, 'sigma'=>1, 'tau'=>1, 'upsilon'=>1, 'phi'=>1, 'chi'=>1,
	'psi'=>1, 'omega'=>1, 'thetasym'=>1, 'upsih'=>1, 'piv'=>1, 'bull'=>1,
	'hellip'=>1, 'prime'=>1, 'Prime'=>1, 'oline'=>1, 'frasl'=>1,
	'weierp'=>1, 'image'=>1, 'real'=>1, 'trade'=>1, 'alefsym'=>1, 'larr'=>1,
	'uarr'=>1, 'rarr'=>1, 'darr'=>1, 'harr'=>1, 'crarr'=>1,
	'lArr'=>1, 'uArr'=>1, 'rArr'=>1, 'dArr'=>1, 'hArr'=>1, 'forall'=>1, 
	'part'=>1, 'exist'=>1, 'empty'=>1, 'nabla'=>1, 'isin'=>1, 'notin'=>1,
	'ni'=>1, 'prod'=>1, 'sum'=>1, 'minus'=>1, 'lowast'=>1, 'radic'=>1, 'prop'=>1,
	'infin'=>1, 'ang'=>1, 'and'=>1, 'or'=>1, 'cap'=>1, 'cup'=>1, 'int'=>1,
	'there4'=>1, 'sim'=>1, 'cong'=>1, 'asymp'=>1, 'ne'=>1, 'equiv'=>1, 'le'=>1,
	'ge'=>1, 'sub'=>1, 'sup'=>1, 'nsub'=>1, 'sube'=>1, 'supe'=>1,
	'oplus'=>1, 'otimes'=>1, 'perp'=>1, 'sdot'=>1, 'lceil'=>1, 'rceil'=>1,
	'lfloor'=>1, 'rfloor'=>1, 'lang'=>1, 'rang'=>1, 'loz'=>1,
	'spades'=>1, 'clubs'=>1, 'hearts'=>1, 'diams'=>1, 'OElig'=>1, 'oelig'=>1,
	'Scaron'=>1, 'scaron'=>1, 'Yuml'=>1, 'circ'=>1, 'tidle'=>1,
	'ensp'=>1, 'emsp'=>1, 'thinsp'=>1, 'zwnj'=>1, 'zwj'=>1, 'lrm'=>1, 'rlm'=>1,
	'ndash'=>1, 'mdash'=>1, 'lsquo'=>1, 'rsquo'=>1, 'sbquo'=>1,
	'ldquo'=>1, 'rdquo'=>1, 'bdquo'=>1, 'dagger'=>1, 'Dagger'=>1, 'permil'=>1,
	'lsaquo'=>1, 'rsaquo'=>1, 'euro'=>1);

	$strict_form_accessibility=false; // Form fields may not be empty with this strict rule

	global $POSSIBLY_EMPTY_TAGS;
	$POSSIBLY_EMPTY_TAGS=array(
		'a'=>1, // When it's an anchor only - we will detect this with custom code
		'div'=>1,
//		'p'=>1, // Sometimes we need to do an empty-p to workaround browser bugs
		'td'=>1,
		'th'=>1, // Only use for 'corner' ones
		'textarea'=>1,
		'button'=>1,
		'script'=>1, // If we have one of these as self-closing in IE... it kills it!
	);
	if ($strict_form_accessibility) unset($POSSIBLY_EMPTY_TAGS['textarea']);
	
	global $MUST_SELFCLOSE_TAGS;
	$MUST_SELFCLOSE_TAGS=array(
		'img'=>1,
		'hr'=>1,
		'br'=>1,
		'param'=>1,
		'input'=>1,
		'base'=>1,
		'link'=>1,
		'meta'=>1,
		'area'=>1,
		'col'=>1,
		
		'nobr'=>1,
	);

	global $TAGS_BLOCK;
	$TAGS_BLOCK=array(
		'div'=>1,
		'h1'=>1,
		'h2'=>1,
		'h3'=>1,
		'h4'=>1,
		'h5'=>1,
		'h6'=>1,
		'p'=>1,
		'blockquote'=>1,
		'pre'=>1,
		'br'=>1,
		'hr'=>1,
		'fieldset'=>1,

		// Best classified as block
		'address'=>1,
		'iframe'=>1, // From iframe module
		'noscript'=>1,
		'table'=>1,
		'tbody'=>1,
		'td'=>1,
		'tfoot'=>1,
		'th'=>1,
		'thead'=>1,
		'tr'=>1,
		'dd'=>1,
		'dt'=>1,
		'dl'=>1,
		'li'=>1,
		'ol'=>1,
		'ul'=>1,

		// XHTML 1.1
		'rbc'=>1,
		'rtc'=>1,
		'rb'=>1,
		'rt'=>1,
		'rp'=>1,
	);

	global $TAGS_INLINE;
	$TAGS_INLINE=array(
		'span'=>1,
		'abbr'=>1,
		'acronym'=>1,
		'cite'=>1,
		'code'=>1,
		'dfn'=>1,
		'em'=>1,
		'strong'=>1,
		'kbd'=>1,
		'q'=>1,
		'samp'=>1,
		'var'=>1,
		'sub'=>1,
		'sup'=>1,
		'tt'=>1,
		'del'=>1,

		// XHTML 1.1
		'ruby'=>1,

		// Best classified as inline
		'a'=>1,
		'bdo'=>1,
		'img'=>1,
		'ins'=>1,
		'param'=>1,
		'textarea'=>1,
		'button'=>1,
		'input'=>1,
		'select'=>1,
		//'embed'=>1, 'noembed'=>1, // This IS NOT in XHTML, but has to be put in to get IE and non-IE compatibility
		'object'=>1,
		'caption'=>1,
		'label'=>1,

	/* In XHTML strict -- but we're better off without them if we use XHTML-strict */
		'b'=>1,
		'i'=>1,
		'small'=>1,
		'big'=>1,
	);
	
	global $TAGS_NORMAL;
	$TAGS_NORMAL=array(
		'base'=>1,
		'body'=>1,
		'col'=>1,
		'colgroup'=>1,
		'head'=>1,
		'html'=>1,
		'link'=>1,
		'map'=>1,
		'meta'=>1,
		'optgroup'=>1,
		'option'=>1,
		'style'=>1,
		'title'=>1,
		'legend'=>1,
		'script'=>1,
		'area'=>1,

		// I'd call this 'block', but XHTML-strict other validators would disagree - probably xhtml-strict doesn't consider 'progmattic' elements to be inline/block
		'form'=>1,
	);

	global $TAGS_BLOCK_DEPRECATED;
	$TAGS_BLOCK_DEPRECATED=array(
		'dir'=>1,
		'menu'=>1,
	);

	global $TAGS_INLINE_DEPRECATED;
	$TAGS_INLINE_DEPRECATED=array(
	// Would be removed in XHTML strict and deprecated in transitional
		'center'=>1,
		'applet'=>1,
		'font'=>1,
		's'=>1,
		'strike'=>1,
		'u'=>1,
	);

	global $TAGS_NORMAL_DEPRECATED;
	$TAGS_NORMAL_DEPRECATED=array(
		'basefont'=>1,
	);

	$browser=strtolower(ocp_srv('HTTP_USER_AGENT'));
	$is_ie=(strpos($browser,'msie')!==false) && (strpos($browser,'opera')===false);

	$enforce_javascript='([^\n]+)';
	$enforce_lang='[a-zA-Z][a-zA-Z](-[a-zA-Z]+)?';
	$enforce_direction='(ltr|rtl)';
	$enforce_align='(left|center|right|justify|char)';
	$enforce_align2='(top|middle|bottom|left|right)';
	$enforce_align3='(left|center|right|justify)';
	$enforce_align4='(top|bottom|left|right)';
	$enforce_valign='(top|middle|bottom|baseline)';
	$enforce_number='(-?[0-9]+)';
	$enforce_inumber='[0-9]+';
	//$enforce_plain_or_html='(plaintext|html)';
	$enforce_character='.';
	$enforce_color='(black|silver|gray|white|maroon|purple|fuchsia|green|lime|olive|yellow|navy|blue|teal|aqua|orange|red|(\#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])|(\#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]))'; // orange and red aren't 'official' -- but kind of handy ;). In reality, the colour codes were never properly defined, and these two are obvious names for obviously needed ones-- they'll be supported
	$enforce_length='((0)|('.$enforce_number.'(|in|cm|mm|ex|pt|pc|px|em|%))|(('.$enforce_number.')?\.'.$enforce_number.'(in|cm|mm|ex|em|%)))'; // |ex|pt|in|cm|mm|pc	We don't want these in our XHTML... preferably we only want em when it comes to font size!
	$enforce_ilength='((0)|('.$enforce_inumber.'(|in|cm|mm|ex|pt|pc|px|em|%))|(('.$enforce_inumber.')?\.'.$enforce_inumber.'(in|cm|mm|ex|em|%)))'; // |ex|pt|in|cm|mm|pc	We don't want these in our XHTML... preferably we only want em when it comes to font size!
	$enforce_pixels='[0-9]+';
	$enforce_auto_or_length='(auto|'.$enforce_length.')';
	$enforce_auto_or_ilength='(auto|'.$enforce_ilength.')';
	$enforce_normal_or_length='(normal|'.$enforce_length.')';
	$enforce_border_width='(thin|medium|thick|'.$enforce_length.')';
	$enforce_potential_4d_border_width=$enforce_border_width.'( '.$enforce_border_width.'( '.$enforce_border_width.'( '.$enforce_border_width.'|)|)|)';
	$enforce_css_color='((rgb\('.$enforce_inumber.'%,'.$enforce_inumber.'%,'.$enforce_inumber.'%\))|(rgb\('.$enforce_inumber.','.$enforce_inumber.','.$enforce_inumber.'\))|(\#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])|'.$enforce_color.'|ActiveBorder|ActiveCaption|AppWorkspace|Background|Buttonface|ButtonHighlight|ButtonShadow|ButtonText|CaptionText|GrayText|Highlight|HighlightText|InactiveBorder|InactiveCaption|InactiveCaptionText|InfoBackground|InfoText|Menu|MenuText|Scrollbar|ThreeDDarkShadow|ThreeDFace|ThreeDHighlight|ThreeDLightShadow|ThreeDShadow|Window|WindowFrame|WindowText)';
	$enforce_transparent_or_color='(transparent|'.$enforce_css_color.')';
	$enforce_fraction='(\d%|\d\d%|100%|0\.\d+|1\.0)';
	$_enforce_font_list="(cursive|fantasy|monospace|serif|sans-serif|Georgia|Times|Trebuchet|Tahoma|Geneva|Verdana|Arial|Helvetica|Courier|Courier New|Impact|'Georgia'|'Times'|'Trebuchet'|'Tahoma'|'Geneva'|'Verdana'|'Arial'|'Helvetica'|'Courier'|'Courier New'|'Impact')";
	$enforce_font_list='((([A-Za-z]+)|("[A-Za-z ]+")|(\'[A-Za-z ]+\')),\s*)*'.$_enforce_font_list;
	$enforce_functional_url='(url\(\'.+\'\)|url\(".+"\)|url\([^\(\);]+\))';
	$enforce_functional_url_or_none='('.$enforce_functional_url.'|none)';
	$enforce_border_style='(none|dotted|dashed|solid|double|groove|ridge|inset|outset)';
	$enforce_background_repeat='(repeat|repeat-x|repeat-y|no-repeat)';
	$enforce_attachment='(scroll|fixed)';
	$_enforce_background_position='(('.$enforce_length.'|top|center|bottom)|('.$enforce_length.'|left|center|right))';
	$enforce_background_position='(('.$_enforce_background_position.')|('.$_enforce_background_position.' '.$_enforce_background_position.'))';
	$enforce_border='(('.$enforce_border_width.'|'.$enforce_border_style.'|'.$enforce_css_color.')( |$))+';
	$enforce_potential_4d_length=$enforce_length.'( '.$enforce_length.'( '.$enforce_length.'( '.$enforce_length.'|)|)|)';
	$enforce_potential_4d_length_auto=$enforce_auto_or_length.'( '.$enforce_auto_or_length.'( '.$enforce_auto_or_length.'( '.$enforce_auto_or_length.'|)|)|)';
	$enforce_potential_4d_ilength=$enforce_ilength.'( '.$enforce_ilength.'( '.$enforce_ilength.'( '.$enforce_ilength.'|)|)|)';
	$enforce_potential_4d_ilength_auto=$enforce_auto_or_ilength.'( '.$enforce_auto_or_ilength.'( '.$enforce_auto_or_ilength.'( '.$enforce_auto_or_ilength.'|)|)|)';
	$enforce_font_style='(normal|italic|oblique)';
	$enforce_font_variant='(normal|small-caps)';
	$enforce_font_weight='(lighter|normal|bold|bolder|((\d)+))';
	$enforce_list_style_position='(inside|outside)';
	$enforce_list_style_type='(none|disc|circle|square|decimal|lower-roman|upper-roman|lower-alpha|upper-alpha'.((!$is_ie)?'|decimal-leading-zero|lower-greek|lower-latin|upper-latin|hebrew|armenian|georgian|cjk-ideographic|hiragana|katakana|hiragana-iroha|katakana-iroha':'').')';
	$enforce_list_style_image='(none|'.$enforce_functional_url.')';
	$enforce_id='[a-zA-Z][\w\-\:\.]*';
	$enforce_name=$enforce_id.'(\[\])?'; // Only used for <select> tag, as it has to allow multi-selection-lists
	$enforce_link=((get_forum_type()=='none')?'(mailto:.*)?':'').'('.str_replace('#','\\#',preg_quote(mailto_obfuscated())).'.*)?[^\s\#]*(\#[^\s\#]*)?';
	$enforce_class='[ \w-]*';
	$enforce_zoom='(normal|'.$enforce_fraction.')';

	global $CSS_PROPERTIES;
	$CSS_PROPERTIES=array(
		'background'=>'(('.$enforce_transparent_or_color.'|'.$enforce_functional_url_or_none.'|'.$enforce_background_repeat.'|'.$enforce_attachment.'|'.$enforce_background_position.')( |$))+',
		'background-attachment'=>$enforce_attachment,
		'background-color'=>$enforce_transparent_or_color,
		'background-image'=>$enforce_functional_url_or_none,
		'background-repeat'=>$enforce_background_repeat,
		'background-position'=>$enforce_background_position,
		'border'=>$enforce_border,
		'border-collapse'=>'(collapse|separate)',
		'border-color'=>$enforce_transparent_or_color.'( '.$enforce_transparent_or_color.'( '.$enforce_transparent_or_color.'( '.$enforce_transparent_or_color.'|)|)|)',
		'border-spacing'=>$enforce_length.' '.$enforce_length,
		'border-style'=>$enforce_border_style,
		'border-width'=>$enforce_potential_4d_border_width,
		'border-bottom'=>$enforce_border,
		'border-bottom-color'=>$enforce_transparent_or_color,
		'border-bottom-style'=>$enforce_border_style,
		'border-bottom-width'=>$enforce_border_width,
		'border-left'=>$enforce_border,
		'border-left-color'=>$enforce_transparent_or_color,
		'border-left-style'=>$enforce_border_style,
		'border-left-width'=>$enforce_border_width,
		'border-right'=>$enforce_border,
		'border-right-color'=>$enforce_transparent_or_color,
		'border-right-style'=>$enforce_border_style,
		'border-right-width'=>$enforce_border_width,
		'border-top'=>$enforce_border,
		'border-top-color'=>$enforce_transparent_or_color,
		'border-top-style'=>$enforce_border_style,
		'border-top-width'=>$enforce_border_width,
		'bottom'=>$enforce_auto_or_length,
		'clear'=>'(both|left|right|none)',
		'clip'=>'auto|(rect\('.$enforce_potential_4d_length.'\))',
		'color'=>$enforce_css_color,
		'cursor'=>'('.$enforce_functional_url.'|default|auto|n-resize|ne-resize|e-resize|se-resize|s-resize|sw-resize|w-resize|nw-resize|crosshair|pointer|move|text|wait|help'.((!$is_ie)?'|progress':'').')', // hand is actually IE specific version of pointer; we'll use tempcode so as to only show that when really needed
		'direction'=>'(ltr|rtl)',
		'display'=>'(none|inline|block|list-item|table|table-header-group|table-footer-group|inline-block|run-in'.((!$is_ie)?'|inline-table|table-row|table-row-group|table-column-group|table-column|table-cell|table-caption':'').')',
		'float'=>'(left|right|none)',
		'font'=>'((caption|icon|menu|message-box|small-caption|status-bar|'.$enforce_font_style.'|'.$enforce_font_variant.'|'.$enforce_font_weight.'|'.$enforce_length.'|'.$enforce_normal_or_length.'|'.$enforce_font_list.')( |$))+',
		'font-family'=>$enforce_font_list,
		'font-size'=>'larger|smaller|xx-small|x-small|small|medium|large|x-large|xx-large|'.$enforce_length,
		'font-style'=>$enforce_font_style,
		'font-variant'=>$enforce_font_variant,
		'font-weight'=>$enforce_font_weight,
		'height'=>$enforce_auto_or_length,
		'left'=>$enforce_auto_or_length,
		'right'=>$enforce_auto_or_length,
		'letter-spacing'=>$enforce_normal_or_length,
		'line-height'=>$enforce_normal_or_length,
		'list-style'=>'(('.$enforce_list_style_type.'|'.$enforce_list_style_position.'|'.$enforce_list_style_image.')( |$))+',
		'list-style-image'=>$enforce_functional_url,
		'list-style-position'=>$enforce_list_style_position,
		'list-style-type'=>$enforce_list_style_type,
		'margin'=>$enforce_potential_4d_length_auto,
		'margin-bottom'=>$enforce_auto_or_length,
		'margin-left'=>$enforce_auto_or_length,
		'margin-right'=>$enforce_auto_or_length,
		'margin-top'=>$enforce_auto_or_length,
		'overflow'=>'(visible|hidden|scroll|auto)',
		'padding'=>$enforce_potential_4d_ilength,
		'padding-bottom'=>$enforce_auto_or_ilength,
		'padding-left'=>$enforce_auto_or_ilength,
		'padding-right'=>$enforce_auto_or_ilength,
		'padding-top'=>$enforce_auto_or_ilength,
		'page-break-after'=>'(auto|left|right|always)',
		'page-break-before'=>'(auto|left|right|always)',
		'position'=>'(static|relative|absolute'.((!$is_ie)?'|fixed':'').')',
		'table-layout'=>'(auto|fixed)',
		'text-align'=>'(left|right|center|justify)',
		'text-decoration'=>'(underline|line-through|none'.((!$is_ie)?'|blink':'').')',
		'text-indent'=>$enforce_length,
		'text-transform'=>'(capitalize|uppercase|lowercase|none)',
		'top'=>$enforce_auto_or_length,
		'unicode-bidi'=>'(bidi-override|normal|embed)',
		'vertical-align'=>'(baseline|sub|super|top|text-top|middle|bottom|text-bottom)',
		'visibility'=>'(hidden|visible|collapse)',
		'white-space'=>'(normal|pre|nowrap'.((!$is_ie)?'|pre-wrap|pre-line':'').')',
		'width'=>$enforce_auto_or_length,
		'word-spacing'=>$enforce_normal_or_length,
		'z-index'=>'(auto|(\d+))',
		'zoom'=>$enforce_zoom,
		'opacity'=>$enforce_fraction, // CSS3
		'overflow-x'=>'(visible|hidden|scroll|auto)', // CSS3
		'overflow-y'=>'(visible|hidden|scroll|auto)', // CSS3

		/* Purposely left out due to very poor browser support (not just IE not having it) */
		/*
		(print module)
		(aural module)
		*/

		/* These are non standard but we want them */
		//'-moz-opacity'=>$enforce_fraction,
		//'filter'=>'.*', // Lots of complex MS scoped-function crap - we won't bother validating it
		//'writing-mode'=>'(tb-rl|lr-tb)',
	);

	$_counter_increment='((\w+( \d+)?)+)';
	$enforce_counter_increment=$_counter_increment.'( '.$_counter_increment.')*';

	global $CSS_NON_IE_PROPERTIES;
	$CSS_NON_IE_PROPERTIES=array(
		'content'=>'.+',
		'quotes'=>'.+ .+',
		'max-width'=>$enforce_auto_or_length,
		'min-width'=>$enforce_auto_or_length,
		'max-height'=>$enforce_auto_or_length,
		'min-height'=>$enforce_auto_or_length,
		'marker-offset'=>$enforce_auto_or_length,
		'caption-side'=>'top|bottom|left|right',
		'empty-cells'=>'show|hide',
		'counter-increment'=>$enforce_counter_increment,
		'counter-reset'=>$enforce_counter_increment,
		'outline'=>$enforce_border,
		'outline-color'=>$enforce_transparent_or_color,
		'outline-style'=>$enforce_border_style,
		'outline-width'=>$enforce_border_width,
	);

	global $TAG_ATTRIBUTES;
	$TAG_ATTRIBUTES=array(
		'a.accesskey'=>$enforce_character,
		'a.charset'=>'.+',
		'a.class'=>$enforce_class,
		'a.coords'=>'.+',
		'a.dir'=>$enforce_direction,
		'a.href'=>$enforce_link,
		'a.hreflang'=>$enforce_lang,
		'a.id'=>$enforce_id,
		'a.lang'=>$enforce_lang,
		'a.name'=>$enforce_id,
		'a.onblur'=>$enforce_javascript,
		'a.onclick'=>$enforce_javascript,
		'a.ondblclick'=>$enforce_javascript,
		'a.onfocus'=>$enforce_javascript,
		'a.onkeydown'=>$enforce_javascript,
		'a.onkeypress'=>$enforce_javascript,
		'a.onkeyup'=>$enforce_javascript,
		'a.onmousedown'=>$enforce_javascript,
		'a.onmousemove'=>$enforce_javascript,
		'a.onmouseout'=>$enforce_javascript,
		'a.onmouseover'=>$enforce_javascript,
		'a.onmouseup'=>$enforce_javascript,
		'a.rel'=>'.*',
		'a.rev'=>'.+',
		'a.shape'=>'(rect|circle|poly|default)',
		'a.style'=>'.*',
		'a.tabindex'=>$enforce_inumber,
		'a.title'=>'.*',
		'a.type'=>'.+',
		'abbr.class'=>$enforce_class,
		'abbr.dir'=>$enforce_direction,
		'abbr.id'=>$enforce_id,
		'abbr.lang'=>$enforce_lang,
		'abbr.onclick'=>$enforce_javascript,
		'abbr.ondblclick'=>$enforce_javascript,
		'abbr.onkeydown'=>$enforce_javascript,
		'abbr.onkeypress'=>$enforce_javascript,
		'abbr.onkeyup'=>$enforce_javascript,
		'abbr.onmousedown'=>$enforce_javascript,
		'abbr.onmousemove'=>$enforce_javascript,
		'abbr.onmouseout'=>$enforce_javascript,
		'abbr.onmouseover'=>$enforce_javascript,
		'abbr.onmouseup'=>$enforce_javascript,
		'abbr.style'=>'.*',
		'abbr.title'=>'.+',
		'acronym.class'=>$enforce_class,
		'acronym.dir'=>$enforce_direction,
		'acronym.id'=>$enforce_id,
		'acronym.lang'=>$enforce_lang,
		'acronym.onclick'=>$enforce_javascript,
		'acronym.ondblclick'=>$enforce_javascript,
		'acronym.onkeydown'=>$enforce_javascript,
		'acronym.onkeypress'=>$enforce_javascript,
		'acronym.onkeyup'=>$enforce_javascript,
		'acronym.onmousedown'=>$enforce_javascript,
		'acronym.onmousemove'=>$enforce_javascript,
		'acronym.onmouseout'=>$enforce_javascript,
		'acronym.onmouseover'=>$enforce_javascript,
		'acronym.onmouseup'=>$enforce_javascript,
		'acronym.style'=>'.*',
		'acronym.title'=>'.+',
		'address.class'=>$enforce_class,
		'address.dir'=>$enforce_direction,
		'address.id'=>$enforce_id,
		'address.lang'=>$enforce_lang,
		'address.onclick'=>$enforce_javascript,
		'address.ondblclick'=>$enforce_javascript,
		'address.onkeydown'=>$enforce_javascript,
		'address.onkeypress'=>$enforce_javascript,
		'address.onkeyup'=>$enforce_javascript,
		'address.onmousedown'=>$enforce_javascript,
		'address.onmousemove'=>$enforce_javascript,
		'address.onmouseout'=>$enforce_javascript,
		'address.onmouseover'=>$enforce_javascript,
		'address.onmouseup'=>$enforce_javascript,
		'address.style'=>'.*',
		'address.title'=>'.+',
		'area.accesskey'=>$enforce_character,
		'area.alt'=>'.*',
		'area.class'=>$enforce_class,
		'area.coords'=>'.+',
		'area.dir'=>$enforce_direction,
		'area.href'=>$enforce_link,
		'area.id'=>$enforce_id,
		'area.lang'=>$enforce_lang,
		'area.nohref'=>'nohref',
		'area.onblur'=>'.+',
		'area.onclick'=>$enforce_javascript,
		'area.ondblclick'=>$enforce_javascript,
		'area.onfocus'=>$enforce_javascript,
		'area.onkeydown'=>$enforce_javascript,
		'area.onkeypress'=>$enforce_javascript,
		'area.onkeyup'=>$enforce_javascript,
		'area.onmousedown'=>$enforce_javascript,
		'area.onmousemove'=>$enforce_javascript,
		'area.onmouseout'=>$enforce_javascript,
		'area.onmouseover'=>$enforce_javascript,
		'area.onmouseup'=>$enforce_javascript,
		'area.shape'=>'(rect|circle|poly|default)',
		'area.style'=>'.*',
		'area.tabindex'=>$enforce_inumber,
		'area.title'=>'.+',
		'b.class'=>$enforce_class,
		'b.dir'=>$enforce_direction,
		'b.id'=>$enforce_id,
		'b.lang'=>$enforce_lang,
		'b.onclick'=>$enforce_javascript,
		'b.ondblclick'=>$enforce_javascript,
		'b.onkeydown'=>$enforce_javascript,
		'b.onkeypress'=>$enforce_javascript,
		'b.onkeyup'=>$enforce_javascript,
		'b.onmousedown'=>$enforce_javascript,
		'b.onmousemove'=>$enforce_javascript,
		'b.onmouseout'=>$enforce_javascript,
		'b.onmouseover'=>$enforce_javascript,
		'b.onmouseup'=>$enforce_javascript,
		'b.style'=>'.*',
		'b.title'=>'.+',
		'base.href'=>$enforce_link,
		'bdo.class'=>$enforce_class,
		'bdo.dir'=>$enforce_direction,
		'bdo.id'=>$enforce_id,
		'bdo.lang'=>$enforce_lang,
		'bdo.style'=>'.*',
		'bdo.title'=>'.+',
		'big.class'=>$enforce_class,
		'big.dir'=>$enforce_direction,
		'big.id'=>$enforce_id,
		'big.lang'=>$enforce_lang,
		'big.onclick'=>$enforce_javascript,
		'big.ondblclick'=>$enforce_javascript,
		'big.onkeydown'=>$enforce_javascript,
		'big.onkeypress'=>$enforce_javascript,
		'big.onkeyup'=>$enforce_javascript,
		'big.onmousedown'=>$enforce_javascript,
		'big.onmousemove'=>$enforce_javascript,
		'big.onmouseout'=>$enforce_javascript,
		'big.onmouseover'=>$enforce_javascript,
		'big.onmouseup'=>$enforce_javascript,
		'big.style'=>'.*',
		'big.title'=>'.+',
		'blockquote.cite'=>'.+',
		'blockquote.class'=>$enforce_class,
		'blockquote.dir'=>$enforce_direction,
		'blockquote.id'=>$enforce_id,
		'blockquote.lang'=>$enforce_lang,
		'blockquote.onclick'=>$enforce_javascript,
		'blockquote.ondblclick'=>$enforce_javascript,
		'blockquote.onkeydown'=>$enforce_javascript,
		'blockquote.onkeypress'=>$enforce_javascript,
		'blockquote.onkeyup'=>$enforce_javascript,
		'blockquote.onmousedown'=>$enforce_javascript,
		'blockquote.onmousemove'=>$enforce_javascript,
		'blockquote.onmouseout'=>$enforce_javascript,
		'blockquote.onmouseover'=>$enforce_javascript,
		'blockquote.onmouseup'=>$enforce_javascript,
		'blockquote.style'=>'.*',
		'blockquote.title'=>'.+',
		'body.background'=>'.+',
		'body.class'=>$enforce_class,
		'body.dir'=>$enforce_direction,
		'body.id'=>$enforce_id,
		'body.lang'=>$enforce_lang,
		'body.onclick'=>$enforce_javascript,
		'body.ondblclick'=>$enforce_javascript,
		'body.onkeydown'=>$enforce_javascript,
		'body.onkeypress'=>$enforce_javascript,
		'body.onkeyup'=>$enforce_javascript,
		'body.onload'=>$enforce_javascript,
		'body.onmousedown'=>$enforce_javascript,
		'body.onmousemove'=>$enforce_javascript,
		'body.onmouseout'=>$enforce_javascript,
		'body.onmouseover'=>$enforce_javascript,
		'body.onmouseup'=>$enforce_javascript,
		'body.onunload'=>$enforce_javascript,
		'body.style'=>'.*',
		'body.title'=>'.+',
		'br.class'=>$enforce_class,
		'br.id'=>$enforce_id,
		'br.style'=>'.*',
		'br.title'=>'.+',
		'button.accesskey'=>$enforce_character,
		'button.class'=>$enforce_class,
		'button.dir'=>$enforce_direction,
		'button.disabled'=>'disabled',
		'button.id'=>$enforce_id,
		'button.lang'=>$enforce_lang,
		'button.name'=>$enforce_id,
		'button.onblur'=>$enforce_javascript,
		'button.onclick'=>$enforce_javascript,
		'button.ondblclick'=>$enforce_javascript,
		'button.onfocus'=>$enforce_javascript,
		'button.onkeydown'=>$enforce_javascript,
		'button.onkeypress'=>$enforce_javascript,
		'button.onkeyup'=>$enforce_javascript,
		'button.onmousedown'=>$enforce_javascript,
		'button.onmousemove'=>$enforce_javascript,
		'button.onmouseout'=>$enforce_javascript,
		'button.onmouseover'=>$enforce_javascript,
		'button.onmouseup'=>$enforce_javascript,
		'button.style'=>'.*',
		'button.tabindex'=>$enforce_inumber,
		'button.title'=>'.+',
		'button.type'=>'(button|submit|reset)',
		'button.value'=>'.+',
		'caption.class'=>$enforce_class,
		'caption.dir'=>$enforce_direction,
		'caption.id'=>$enforce_id,
		'caption.lang'=>$enforce_lang,
		'caption.onclick'=>$enforce_javascript,
		'caption.ondblclick'=>$enforce_javascript,
		'caption.onkeydown'=>$enforce_javascript,
		'caption.onkeypress'=>$enforce_javascript,
		'caption.onkeyup'=>$enforce_javascript,
		'caption.onmousedown'=>$enforce_javascript,
		'caption.onmousemove'=>$enforce_javascript,
		'caption.onmouseout'=>$enforce_javascript,
		'caption.onmouseover'=>$enforce_javascript,
		'caption.onmouseup'=>$enforce_javascript,
		'caption.style'=>'.*',
		'caption.title'=>'.+',
		'cite.class'=>$enforce_class,
		'cite.dir'=>$enforce_direction,
		'cite.id'=>$enforce_id,
		'cite.lang'=>$enforce_lang,
		'cite.onclick'=>$enforce_javascript,
		'cite.ondblclick'=>$enforce_javascript,
		'cite.onkeydown'=>$enforce_javascript,
		'cite.onkeypress'=>$enforce_javascript,
		'cite.onkeyup'=>$enforce_javascript,
		'cite.onmousedown'=>$enforce_javascript,
		'cite.onmousemove'=>$enforce_javascript,
		'cite.onmouseout'=>$enforce_javascript,
		'cite.onmouseover'=>$enforce_javascript,
		'cite.onmouseup'=>$enforce_javascript,
		'cite.style'=>'.*',
		'cite.title'=>'.+',
		'code.class'=>$enforce_class,
		'code.dir'=>$enforce_direction,
		'code.id'=>$enforce_id,
		'code.lang'=>$enforce_lang,
		'code.onclick'=>$enforce_javascript,
		'code.ondblclick'=>$enforce_javascript,
		'code.onkeydown'=>$enforce_javascript,
		'code.onkeypress'=>$enforce_javascript,
		'code.onkeyup'=>$enforce_javascript,
		'code.onmousedown'=>$enforce_javascript,
		'code.onmousemove'=>$enforce_javascript,
		'code.onmouseout'=>$enforce_javascript,
		'code.onmouseover'=>$enforce_javascript,
		'code.onmouseup'=>$enforce_javascript,
		'code.style'=>'.*',
		'code.title'=>'.+',
		'col.align'=>$enforce_align,
		'col.char'=>$enforce_character,
		'col.charoff'=>$enforce_length,
		'col.class'=>$enforce_class,
		'col.dir'=>$enforce_direction,
		'col.id'=>$enforce_id,
		'col.lang'=>$enforce_lang,
		'col.onclick'=>$enforce_javascript,
		'col.ondblclick'=>$enforce_javascript,
		'col.onkeydown'=>$enforce_javascript,
		'col.onkeypress'=>$enforce_javascript,
		'col.onkeyup'=>$enforce_javascript,
		'col.onmousedown'=>$enforce_javascript,
		'col.onmousemove'=>$enforce_javascript,
		'col.onmouseout'=>$enforce_javascript,
		'col.onmouseover'=>$enforce_javascript,
		'col.onmouseup'=>$enforce_javascript,
		'col.span'=>$enforce_inumber,
		'col.style'=>'.*',
		'col.title'=>'.+',
		//'col.valign'=>$enforce_valign,
		'col.width'=>$enforce_length,
		'colgroup.align'=>$enforce_align,
		'colgroup.char'=>$enforce_character,
		'colgroup.charoff'=>$enforce_length,
		'colgroup.class'=>$enforce_class,
		'colgroup.dir'=>$enforce_direction,
		'colgroup.id'=>$enforce_id,
		'colgroup.lang'=>$enforce_lang,
		'colgroup.onclick'=>$enforce_javascript,
		'colgroup.ondblclick'=>$enforce_javascript,
		'colgroup.onkeydown'=>$enforce_javascript,
		'colgroup.onkeypress'=>$enforce_javascript,
		'colgroup.onkeyup'=>$enforce_javascript,
		'colgroup.onmousedown'=>$enforce_javascript,
		'colgroup.onmousemove'=>$enforce_javascript,
		'colgroup.onmouseout'=>$enforce_javascript,
		'colgroup.onmouseover'=>$enforce_javascript,
		'colgroup.onmouseup'=>$enforce_javascript,
		'colgroup.span'=>$enforce_inumber,
		'colgroup.style'=>'.*',
		'colgroup.title'=>'.+',
		//'colgroup.valign'=>$enforce_valign,
		'colgroup.width'=>$enforce_length,
		'dd.class'=>$enforce_class,
		'dd.dir'=>$enforce_direction,
		'dd.id'=>$enforce_id,
		'dd.lang'=>$enforce_lang,
		'dd.onclick'=>$enforce_javascript,
		'dd.ondblclick'=>$enforce_javascript,
		'dd.onkeydown'=>$enforce_javascript,
		'dd.onkeypress'=>$enforce_javascript,
		'dd.onkeyup'=>$enforce_javascript,
		'dd.onmousedown'=>$enforce_javascript,
		'dd.onmousemove'=>$enforce_javascript,
		'dd.onmouseout'=>$enforce_javascript,
		'dd.onmouseover'=>$enforce_javascript,
		'dd.onmouseup'=>$enforce_javascript,
		'dd.style'=>'.*',
		'dd.title'=>'.+',
		'del.cite'=>'.+',
		'del.class'=>$enforce_class,
		'del.datetime'=>'.+',
		'del.dir'=>$enforce_direction,
		'del.id'=>$enforce_id,
		'del.lang'=>$enforce_lang,
		'del.onclick'=>$enforce_javascript,
		'del.ondblclick'=>$enforce_javascript,
		'del.onkeydown'=>$enforce_javascript,
		'del.onkeypress'=>$enforce_javascript,
		'del.onkeyup'=>$enforce_javascript,
		'del.onmousedown'=>$enforce_javascript,
		'del.onmousemove'=>$enforce_javascript,
		'del.onmouseout'=>$enforce_javascript,
		'del.onmouseover'=>$enforce_javascript,
		'del.onmouseup'=>$enforce_javascript,
		'del.style'=>'.*',
		'del.title'=>'.+',
		'dfn.class'=>$enforce_class,
		'dfn.dir'=>$enforce_direction,
		'dfn.id'=>$enforce_id,
		'dfn.lang'=>$enforce_lang,
		'dfn.onclick'=>$enforce_javascript,
		'dfn.ondblclick'=>$enforce_javascript,
		'dfn.onkeydown'=>$enforce_javascript,
		'dfn.onkeypress'=>$enforce_javascript,
		'dfn.onkeyup'=>$enforce_javascript,
		'dfn.onmousedown'=>$enforce_javascript,
		'dfn.onmousemove'=>$enforce_javascript,
		'dfn.onmouseout'=>$enforce_javascript,
		'dfn.onmouseover'=>$enforce_javascript,
		'dfn.onmouseup'=>$enforce_javascript,
		'dfn.style'=>'.*',
		'dfn.title'=>'.+',
		'div.class'=>$enforce_class,
		'div.dir'=>$enforce_direction,
		'div.id'=>$enforce_id,
		'div.xml:lang'=>$enforce_lang,
		'div.lang'=>$enforce_lang,
		'div.onclick'=>$enforce_javascript,
		'div.ondblclick'=>$enforce_javascript,
		'div.onkeydown'=>$enforce_javascript,
		'div.onkeypress'=>$enforce_javascript,
		'div.onkeyup'=>$enforce_javascript,
		'div.onmousedown'=>$enforce_javascript,
		'div.onmousemove'=>$enforce_javascript,
		'div.onmouseout'=>$enforce_javascript,
		'div.onmouseover'=>$enforce_javascript,
		'div.onmouseup'=>$enforce_javascript,
		'div.style'=>'.*',
		'div.title'=>'.+',
		'dl.class'=>$enforce_class,
		'dl.dir'=>$enforce_direction,
		'dl.id'=>$enforce_id,
		'dl.lang'=>$enforce_lang,
		'dl.onclick'=>$enforce_javascript,
		'dl.ondblclick'=>$enforce_javascript,
		'dl.onkeydown'=>$enforce_javascript,
		'dl.onkeypress'=>$enforce_javascript,
		'dl.onkeyup'=>$enforce_javascript,
		'dl.onmousedown'=>$enforce_javascript,
		'dl.onmousemove'=>$enforce_javascript,
		'dl.onmouseout'=>$enforce_javascript,
		'dl.onmouseover'=>$enforce_javascript,
		'dl.onmouseup'=>$enforce_javascript,
		'dl.style'=>'.*',
		'dl.title'=>'.+',
		'dt.class'=>$enforce_class,
		'dt.dir'=>$enforce_direction,
		'dt.id'=>$enforce_id,
		'dt.lang'=>$enforce_lang,
		'dt.onclick'=>$enforce_javascript,
		'dt.ondblclick'=>$enforce_javascript,
		'dt.onkeydown'=>$enforce_javascript,
		'dt.onkeypress'=>$enforce_javascript,
		'dt.onkeyup'=>$enforce_javascript,
		'dt.onmousedown'=>$enforce_javascript,
		'dt.onmousemove'=>$enforce_javascript,
		'dt.onmouseout'=>$enforce_javascript,
		'dt.onmouseover'=>$enforce_javascript,
		'dt.onmouseup'=>$enforce_javascript,
		'dt.style'=>'.*',
		'dt.title'=>'.+',
		'em.class'=>$enforce_class,
		'em.dir'=>$enforce_direction,
		'em.id'=>$enforce_id,
		'em.lang'=>$enforce_lang,
		'em.onclick'=>$enforce_javascript,
		'em.ondblclick'=>$enforce_javascript,
		'em.onkeydown'=>$enforce_javascript,
		'em.onkeypress'=>$enforce_javascript,
		'em.onkeyup'=>$enforce_javascript,
		'em.onmousedown'=>$enforce_javascript,
		'em.onmousemove'=>$enforce_javascript,
		'em.onmouseout'=>$enforce_javascript,
		'em.onmouseover'=>$enforce_javascript,
		'em.onmouseup'=>$enforce_javascript,
		'em.style'=>'.*',
		'em.title'=>'.+',
		'fieldset.class'=>$enforce_class,
		'fieldset.dir'=>$enforce_direction,
		'fieldset.id'=>$enforce_id,
		'fieldset.lang'=>$enforce_lang,
		'fieldset.onclick'=>$enforce_javascript,
		'fieldset.ondblclick'=>$enforce_javascript,
		'fieldset.onkeydown'=>$enforce_javascript,
		'fieldset.onkeypress'=>$enforce_javascript,
		'fieldset.onkeyup'=>$enforce_javascript,
		'fieldset.onmousedown'=>$enforce_javascript,
		'fieldset.onmousemove'=>$enforce_javascript,
		'fieldset.onmouseout'=>$enforce_javascript,
		'fieldset.onmouseover'=>$enforce_javascript,
		'fieldset.onmouseup'=>$enforce_javascript,
		'fieldset.style'=>'.*',
		'fieldset.title'=>'.+',
		'form.accept-charset'=>'.+',
		'form.action'=>$enforce_link,
		'form.class'=>$enforce_class,
		'form.dir'=>$enforce_direction,
		'form.id'=>$enforce_id,
		'form.enctype'=>'multipart/form-data|application/x-www-form-urlencoded',
		'form.lang'=>$enforce_lang,
		'form.method'=>'(get|post)',
		'form.onclick'=>$enforce_javascript,
		'form.ondblclick'=>$enforce_javascript,
		'form.onkeydown'=>$enforce_javascript,
		'form.onkeypress'=>$enforce_javascript,
		'form.onkeyup'=>$enforce_javascript,
		'form.onmousedown'=>$enforce_javascript,
		'form.onmousemove'=>$enforce_javascript,
		'form.onmouseout'=>$enforce_javascript,
		'form.onmouseover'=>$enforce_javascript,
		'form.onmouseup'=>$enforce_javascript,
		'form.onreset'=>'.+',
		'form.style'=>'.*',
		'form.title'=>'.+',
		'form.onsubmit'=>'.+',
		'h1.class'=>$enforce_class,
		'h1.dir'=>$enforce_direction,
		'h1.id'=>$enforce_id,
		'h1.lang'=>$enforce_lang,
		'h1.onclick'=>$enforce_javascript,
		'h1.ondblclick'=>$enforce_javascript,
		'h1.onkeydown'=>$enforce_javascript,
		'h1.onkeypress'=>$enforce_javascript,
		'h1.onkeyup'=>$enforce_javascript,
		'h1.onmousedown'=>$enforce_javascript,
		'h1.onmousemove'=>$enforce_javascript,
		'h1.onmouseout'=>$enforce_javascript,
		'h1.onmouseover'=>$enforce_javascript,
		'h1.onmouseup'=>$enforce_javascript,
		'h1.style'=>'.*',
		'h1.title'=>'.+',
		'h2.class'=>$enforce_class,
		'h2.dir'=>$enforce_direction,
		'h2.id'=>$enforce_id,
		'h2.lang'=>$enforce_lang,
		'h2.onclick'=>$enforce_javascript,
		'h2.ondblclick'=>$enforce_javascript,
		'h2.onkeydown'=>$enforce_javascript,
		'h2.onkeypress'=>$enforce_javascript,
		'h2.onkeyup'=>$enforce_javascript,
		'h2.onmousedown'=>$enforce_javascript,
		'h2.onmousemove'=>$enforce_javascript,
		'h2.onmouseout'=>$enforce_javascript,
		'h2.onmouseover'=>$enforce_javascript,
		'h2.onmouseup'=>$enforce_javascript,
		'h2.style'=>'.*',
		'h2.title'=>'.+',
		'h3.class'=>$enforce_class,
		'h3.dir'=>$enforce_direction,
		'h3.id'=>$enforce_id,
		'h3.lang'=>$enforce_lang,
		'h3.onclick'=>$enforce_javascript,
		'h3.ondblclick'=>$enforce_javascript,
		'h3.onkeydown'=>$enforce_javascript,
		'h3.onkeypress'=>$enforce_javascript,
		'h3.onkeyup'=>$enforce_javascript,
		'h3.onmousedown'=>$enforce_javascript,
		'h3.onmousemove'=>$enforce_javascript,
		'h3.onmouseout'=>$enforce_javascript,
		'h3.onmouseover'=>$enforce_javascript,
		'h3.onmouseup'=>$enforce_javascript,
		'h3.style'=>'.*',
		'h3.title'=>'.+',
		'h4.class'=>$enforce_class,
		'h4.dir'=>$enforce_direction,
		'h4.id'=>$enforce_id,
		'h4.lang'=>$enforce_lang,
		'h4.onclick'=>$enforce_javascript,
		'h4.ondblclick'=>$enforce_javascript,
		'h4.onkeydown'=>$enforce_javascript,
		'h4.onkeypress'=>$enforce_javascript,
		'h4.onkeyup'=>$enforce_javascript,
		'h4.onmousedown'=>$enforce_javascript,
		'h4.onmousemove'=>$enforce_javascript,
		'h4.onmouseout'=>$enforce_javascript,
		'h4.onmouseover'=>$enforce_javascript,
		'h4.onmouseup'=>$enforce_javascript,
		'h4.style'=>'.*',
		'h4.title'=>'.+',
		'h5.class'=>$enforce_class,
		'h5.dir'=>$enforce_direction,
		'h5.id'=>$enforce_id,
		'h5.lang'=>$enforce_lang,
		'h5.onclick'=>$enforce_javascript,
		'h5.ondblclick'=>$enforce_javascript,
		'h5.onkeydown'=>$enforce_javascript,
		'h5.onkeypress'=>$enforce_javascript,
		'h5.onkeyup'=>$enforce_javascript,
		'h5.onmousedown'=>$enforce_javascript,
		'h5.onmousemove'=>$enforce_javascript,
		'h5.onmouseout'=>$enforce_javascript,
		'h5.onmouseover'=>$enforce_javascript,
		'h5.onmouseup'=>$enforce_javascript,
		'h5.style'=>'.*',
		'h5.title'=>'.+',
		'h6.class'=>$enforce_class,
		'h6.dir'=>$enforce_direction,
		'h6.id'=>$enforce_id,
		'h6.lang'=>$enforce_lang,
		'h6.onclick'=>$enforce_javascript,
		'h6.ondblclick'=>$enforce_javascript,
		'h6.onkeydown'=>$enforce_javascript,
		'h6.onkeypress'=>$enforce_javascript,
		'h6.onkeyup'=>$enforce_javascript,
		'h6.onmousedown'=>$enforce_javascript,
		'h6.onmousemove'=>$enforce_javascript,
		'h6.onmouseout'=>$enforce_javascript,
		'h6.onmouseover'=>$enforce_javascript,
		'h6.onmouseup'=>$enforce_javascript,
		'h6.style'=>'.*',
		'h6.title'=>'.+',
		'head.dir'=>$enforce_direction,
		'head.lang'=>$enforce_lang,
		'head.profile'=>'.+',
		'hr.class'=>$enforce_class,
		'hr.id'=>$enforce_id,
		'hr.onclick'=>$enforce_javascript,
		'hr.ondblclick'=>$enforce_javascript,
		'hr.onkeydown'=>$enforce_javascript,
		'hr.onkeypress'=>$enforce_javascript,
		'hr.onkeyup'=>$enforce_javascript,
		'hr.onmousedown'=>$enforce_javascript,
		'hr.onmousemove'=>$enforce_javascript,
		'hr.onmouseout'=>$enforce_javascript,
		'hr.onmouseover'=>$enforce_javascript,
		'hr.onmouseup'=>$enforce_javascript,
		'hr.style'=>'.*',
		'hr.title'=>'.+',
		'hr.width'=>$enforce_length,
		'html.dir'=>$enforce_direction,
		'html.lang'=>$enforce_lang,
		'html.xml:lang'=>$enforce_lang,
		'html.version'=>'.+',
		'html.xmlns'=>'.+',
		'i.class'=>$enforce_class,
		'i.dir'=>$enforce_direction,
		'i.id'=>$enforce_id,
		'i.lang'=>$enforce_lang,
		'i.onclick'=>$enforce_javascript,
		'i.ondblclick'=>$enforce_javascript,
		'i.onkeydown'=>$enforce_javascript,
		'i.onkeypress'=>$enforce_javascript,
		'i.onkeyup'=>$enforce_javascript,
		'i.onmousedown'=>$enforce_javascript,
		'i.onmousemove'=>$enforce_javascript,
		'i.onmouseout'=>$enforce_javascript,
		'i.onmouseover'=>$enforce_javascript,
		'i.onmouseup'=>$enforce_javascript,
		'i.style'=>'.*',
		'i.title'=>'.+',
		'img.alt'=>'.*', // Have to allow this really, for non-semantic images
		'img.class'=>$enforce_class,
		'img.dir'=>$enforce_direction,
		'img.height'=>$enforce_number,
		'img.id'=>$enforce_id,
		'img.ismap'=>'ismap',
		'img.lang'=>$enforce_lang,
		'img.longdesc'=>'.+',
		'img.onclick'=>$enforce_javascript,
		'img.ondblclick'=>$enforce_javascript,
		'img.onkeydown'=>$enforce_javascript,
		'img.onkeypress'=>$enforce_javascript,
		'img.onkeyup'=>$enforce_javascript,
		'img.onmousedown'=>$enforce_javascript,
		'img.onmousemove'=>$enforce_javascript,
		'img.onmouseout'=>$enforce_javascript,
		'img.onmouseover'=>$enforce_javascript,
		'img.onmouseup'=>$enforce_javascript,
		'img.src'=>$enforce_link,
		'img.style'=>'.*',
		'img.title'=>'.*',
		'img.usemap'=>'.+',
		'img.width'=>$enforce_number,
		//'input.autocomplete'=>'on|off', // Unofficial extension
		'input.accept'=>'.+',
		'input.accesskey'=>$enforce_character,
		'input.alt'=>'.*',
		'input.checked'=>'checked',
		'input.class'=>$enforce_class,
		'input.dir'=>$enforce_direction,
		'input.disabled'=>'disabled',
		'input.id'=>$enforce_id,
		'input.lang'=>$enforce_lang,
		'input.maxlength'=>$enforce_inumber,
		'input.name'=>$enforce_id,
		'input.onblur'=>'.+',
		'input.onchange'=>'.+',
		'input.onclick'=>$enforce_javascript,
		'input.ondblclick'=>$enforce_javascript,
		'input.onfocus'=>$enforce_javascript,
		'input.onkeydown'=>$enforce_javascript,
		'input.onkeypress'=>$enforce_javascript,
		'input.onkeyup'=>$enforce_javascript,
		'input.onmousedown'=>$enforce_javascript,
		'input.onmousemove'=>$enforce_javascript,
		'input.onmouseout'=>$enforce_javascript,
		'input.onmouseover'=>$enforce_javascript,
		'input.onmouseup'=>$enforce_javascript,
		'input.onselect'=>'.+',
		'input.readonly'=>'readonly',
		'input.size'=>'.+',
		'input.src'=>'.+',
		'input.style'=>'.*',
		'input.tabindex'=>$enforce_inumber,
		'input.title'=>'.+',
		'input.type'=>'(text|password|checkbox|radio|submit|reset|file|hidden|image|button)',
		'input.usemap'=>'.+',
		'input.value'=>'.'.($strict_form_accessibility?'+':'*'), // Was (.|\n)  but XHTML-mime-type turns new lines into spaces
		'ins.cite'=>'.+',
		'ins.class'=>$enforce_class,
		'ins.datetime'=>'.+',
		'ins.dir'=>$enforce_direction,
		'ins.id'=>$enforce_id,
		'ins.lang'=>$enforce_lang,
		'ins.onclick'=>$enforce_javascript,
		'ins.ondblclick'=>$enforce_javascript,
		'ins.onkeydown'=>$enforce_javascript,
		'ins.onkeypress'=>$enforce_javascript,
		'ins.onkeyup'=>$enforce_javascript,
		'ins.onmousedown'=>$enforce_javascript,
		'ins.onmousemove'=>$enforce_javascript,
		'ins.onmouseout'=>$enforce_javascript,
		'ins.onmouseover'=>$enforce_javascript,
		'ins.onmouseup'=>$enforce_javascript,
		'ins.style'=>'.*',
		'ins.title'=>'.+',
		'kbd.class'=>$enforce_class,
		'kbd.dir'=>$enforce_direction,
		'kbd.id'=>$enforce_id,
		'kbd.lang'=>$enforce_lang,
		'kbd.onclick'=>$enforce_javascript,
		'kbd.ondblclick'=>$enforce_javascript,
		'kbd.onkeydown'=>$enforce_javascript,
		'kbd.onkeypress'=>$enforce_javascript,
		'kbd.onkeyup'=>$enforce_javascript,
		'kbd.onmousedown'=>$enforce_javascript,
		'kbd.onmousemove'=>$enforce_javascript,
		'kbd.onmouseout'=>$enforce_javascript,
		'kbd.onmouseover'=>$enforce_javascript,
		'kbd.onmouseup'=>$enforce_javascript,
		'kbd.style'=>'.*',
		'kbd.title'=>'.+',
		'label.accesskey'=>$enforce_character,
		'label.class'=>$enforce_class,
		'label.dir'=>$enforce_direction,
		'label.for'=>'.+',
		'label.id'=>$enforce_id,
		'label.lang'=>$enforce_lang,
		'label.onblur'=>'.+',
		'label.onclick'=>$enforce_javascript,
		'label.ondblclick'=>$enforce_javascript,
		'label.onfocus'=>$enforce_javascript,
		'label.onkeydown'=>$enforce_javascript,
		'label.onkeypress'=>$enforce_javascript,
		'label.onkeyup'=>$enforce_javascript,
		'label.onmousedown'=>$enforce_javascript,
		'label.onmousemove'=>$enforce_javascript,
		'label.onmouseout'=>$enforce_javascript,
		'label.onmouseover'=>$enforce_javascript,
		'label.onmouseup'=>$enforce_javascript,
		'label.style'=>'.*',
		'label.title'=>'.+',
		'legend.accesskey'=>$enforce_character,
		'legend.align'=>$enforce_align4,
		'legend.class'=>$enforce_class,
		'legend.dir'=>$enforce_direction,
		'legend.id'=>$enforce_id,
		'legend.lang'=>$enforce_lang,
		'legend.onclick'=>$enforce_javascript,
		'legend.ondblclick'=>$enforce_javascript,
		'legend.onkeydown'=>$enforce_javascript,
		'legend.onkeypress'=>$enforce_javascript,
		'legend.onkeyup'=>$enforce_javascript,
		'legend.onmousedown'=>$enforce_javascript,
		'legend.onmousemove'=>$enforce_javascript,
		'legend.onmouseout'=>$enforce_javascript,
		'legend.onmouseover'=>$enforce_javascript,
		'legend.onmouseup'=>$enforce_javascript,
		'legend.style'=>'.*',
		'legend.title'=>'.+',
		'li.class'=>$enforce_class,
		'li.dir'=>$enforce_direction,
		'li.id'=>$enforce_id,
		'li.lang'=>$enforce_lang,
		'li.onclick'=>$enforce_javascript,
		'li.ondblclick'=>$enforce_javascript,
		'li.onkeydown'=>$enforce_javascript,
		'li.onkeypress'=>$enforce_javascript,
		'li.onkeyup'=>$enforce_javascript,
		'li.onmousedown'=>$enforce_javascript,
		'li.onmousemove'=>$enforce_javascript,
		'li.onmouseout'=>$enforce_javascript,
		'li.onmouseover'=>$enforce_javascript,
		'li.onmouseup'=>$enforce_javascript,
		'li.style'=>'.*',
		'li.title'=>'.+',
		'link.charset'=>'.+',
		'link.class'=>$enforce_class,
		'link.dir'=>$enforce_direction,
		'link.href'=>$enforce_link,
		'link.hreflang'=>$enforce_lang,
		'link.id'=>$enforce_id,
		'link.lang'=>$enforce_lang,
		'link.media'=>'.+',
		'link.onclick'=>$enforce_javascript,
		'link.ondblclick'=>$enforce_javascript,
		'link.onkeydown'=>$enforce_javascript,
		'link.onkeypress'=>$enforce_javascript,
		'link.onkeyup'=>$enforce_javascript,
		'link.onmousedown'=>$enforce_javascript,
		'link.onmousemove'=>$enforce_javascript,
		'link.onmouseout'=>$enforce_javascript,
		'link.onmouseover'=>$enforce_javascript,
		'link.onmouseup'=>$enforce_javascript,
		'link.rel'=>'.+',
		'link.rev'=>'.+',
		'link.style'=>'.*',
		'link.title'=>'.+',
		'link.type'=>'.+',
		'map.class'=>$enforce_class,
		'map.dir'=>$enforce_direction,
		'map.id'=>$enforce_id,
		'map.lang'=>$enforce_lang,
		'map.onclick'=>$enforce_javascript,
		'map.ondblclick'=>$enforce_javascript,
		'map.onkeydown'=>$enforce_javascript,
		'map.onkeypress'=>$enforce_javascript,
		'map.onkeyup'=>$enforce_javascript,
		'map.onmousedown'=>$enforce_javascript,
		'map.onmousemove'=>$enforce_javascript,
		'map.onmouseout'=>$enforce_javascript,
		'map.onmouseover'=>$enforce_javascript,
		'map.onmouseup'=>$enforce_javascript,
		'map.style'=>'.*',
		'map.title'=>'.+',
		'meta.content'=>'.*',
		'meta.dir'=>$enforce_direction,
		'meta.http-equiv'=>'[a-zA-Z].+',
		'meta.lang'=>$enforce_lang,
		'meta.name'=>'[a-zA-Z].+',
		'meta.scheme'=>'.+',
		'noscript.class'=>$enforce_class,
		'noscript.dir'=>$enforce_direction,
		'noscript.id'=>$enforce_id,
		'noscript.lang'=>$enforce_lang,
		'noscript.onclick'=>$enforce_javascript,
		'noscript.ondblclick'=>$enforce_javascript,
		'noscript.onkeydown'=>$enforce_javascript,
		'noscript.onkeypress'=>$enforce_javascript,
		'noscript.onkeyup'=>$enforce_javascript,
		'noscript.onmousedown'=>$enforce_javascript,
		'noscript.onmousemove'=>$enforce_javascript,
		'noscript.onmouseout'=>$enforce_javascript,
		'noscript.onmouseover'=>$enforce_javascript,
		'noscript.onmouseup'=>$enforce_javascript,
		'noscript.style'=>'.*',
		'noscript.title'=>'.+',
		'object.archive'=>'.+',
		'object.class'=>$enforce_class,
		'object.classid'=>'.+',
		'object.codebase'=>$enforce_link,
		'object.codetype'=>'.+',
		'object.data'=>$enforce_link,
		'object.declare'=>'declare',
		'object.dir'=>$enforce_direction,
		'object.height'=>$enforce_length,
		'object.id'=>$enforce_id,
		'object.lang'=>$enforce_lang,
		'object.name'=>$enforce_id,
		'object.onclick'=>$enforce_javascript,
		'object.ondblclick'=>$enforce_javascript,
		'object.onkeydown'=>$enforce_javascript,
		'object.onkeypress'=>$enforce_javascript,
		'object.onkeyup'=>$enforce_javascript,
		'object.onmousedown'=>$enforce_javascript,
		'object.onmousemove'=>$enforce_javascript,
		'object.onmouseout'=>$enforce_javascript,
		'object.onmouseover'=>$enforce_javascript,
		'object.onmouseup'=>$enforce_javascript,
		'object.standby'=>'.+',
		'object.style'=>'.*',
		'object.tabindex'=>$enforce_inumber,
		'object.title'=>'.+',
		'object.type'=>'.+',
		'object.usemap'=>'.+',
		'object.width'=>$enforce_length,
		'ol.class'=>$enforce_class,
		'ol.dir'=>$enforce_direction,
		'ol.id'=>$enforce_id,
		'ol.lang'=>$enforce_lang,
		'ol.onclick'=>$enforce_javascript,
		'ol.ondblclick'=>$enforce_javascript,
		'ol.onkeydown'=>$enforce_javascript,
		'ol.onkeypress'=>$enforce_javascript,
		'ol.onkeyup'=>$enforce_javascript,
		'ol.onmousedown'=>$enforce_javascript,
		'ol.onmousemove'=>$enforce_javascript,
		'ol.onmouseout'=>$enforce_javascript,
		'ol.onmouseover'=>$enforce_javascript,
		'ol.onmouseup'=>$enforce_javascript,
		'ol.style'=>'.*',
		'ol.title'=>'.+',
		'optgroup.class'=>$enforce_class,
		'optgroup.dir'=>$enforce_direction,
		'optgroup.disabled'=>'disabled',
		'optgroup.id'=>$enforce_id,
		'optgroup.label'=>'.+',
		'optgroup.lang'=>$enforce_lang,
		'optgroup.onclick'=>$enforce_javascript,
		'optgroup.ondblclick'=>$enforce_javascript,
		'optgroup.onkeydown'=>$enforce_javascript,
		'optgroup.onkeypress'=>$enforce_javascript,
		'optgroup.onkeyup'=>$enforce_javascript,
		'optgroup.onmousedown'=>$enforce_javascript,
		'optgroup.onmousemove'=>$enforce_javascript,
		'optgroup.onmouseout'=>$enforce_javascript,
		'optgroup.onmouseover'=>$enforce_javascript,
		'optgroup.onmouseup'=>$enforce_javascript,
		'optgroup.style'=>'.*',
		'optgroup.title'=>'.+',
		'option.class'=>$enforce_class,
		'option.dir'=>$enforce_direction,
		'option.disabled'=>'disabled',
		'option.id'=>$enforce_id,
		'option.label'=>'.+',
		'option.lang'=>$enforce_lang,
		'option.onclick'=>$enforce_javascript,
		'option.ondblclick'=>$enforce_javascript,
		'option.onkeydown'=>$enforce_javascript,
		'option.onkeypress'=>$enforce_javascript,
		'option.onkeyup'=>$enforce_javascript,
		'option.onmousedown'=>$enforce_javascript,
		'option.onmousemove'=>$enforce_javascript,
		'option.onmouseout'=>$enforce_javascript,
		'option.onmouseover'=>$enforce_javascript,
		'option.onmouseup'=>$enforce_javascript,
		'option.selected'=>'selected',
		'option.style'=>'.*',
		'option.title'=>'.+',
		'option.value'=>'.*',
		'p.class'=>$enforce_class,
		'p.dir'=>$enforce_direction,
		'p.id'=>$enforce_id,
		'p.lang'=>$enforce_lang,
		'p.onclick'=>$enforce_javascript,
		'p.ondblclick'=>$enforce_javascript,
		'p.onkeydown'=>$enforce_javascript,
		'p.onkeypress'=>$enforce_javascript,
		'p.onkeyup'=>$enforce_javascript,
		'p.onmousedown'=>$enforce_javascript,
		'p.onmousemove'=>$enforce_javascript,
		'p.onmouseout'=>$enforce_javascript,
		'p.onmouseover'=>$enforce_javascript,
		'p.onmouseup'=>$enforce_javascript,
		'p.style'=>'.*',
		'p.title'=>'.+',
		'param.id'=>$enforce_id,
		'param.name'=>$enforce_id,
		'param.type'=>'.+',
		'param.value'=>'.+',
		'param.valuetype'=>'(data|ref|object)',
		'pre.class'=>$enforce_class,
		'pre.dir'=>$enforce_direction,
		'pre.id'=>$enforce_id,
		'pre.lang'=>$enforce_lang,
		'pre.onclick'=>$enforce_javascript,
		'pre.ondblclick'=>$enforce_javascript,
		'pre.onkeydown'=>$enforce_javascript,
		'pre.onkeypress'=>$enforce_javascript,
		'pre.onkeyup'=>$enforce_javascript,
		'pre.onmousedown'=>$enforce_javascript,
		'pre.onmousemove'=>$enforce_javascript,
		'pre.onmouseout'=>$enforce_javascript,
		'pre.onmouseover'=>$enforce_javascript,
		'pre.onmouseup'=>$enforce_javascript,
		'pre.style'=>'.*',
		'pre.title'=>'.+',
		'q.cite'=>'.+',
		'q.class'=>$enforce_class,
		'q.dir'=>$enforce_direction,
		'q.id'=>$enforce_id,
		'q.lang'=>$enforce_lang,
		'q.onclick'=>$enforce_javascript,
		'q.ondblclick'=>$enforce_javascript,
		'q.onkeydown'=>$enforce_javascript,
		'q.onkeypress'=>$enforce_javascript,
		'q.onkeyup'=>$enforce_javascript,
		'q.onmousedown'=>$enforce_javascript,
		'q.onmousemove'=>$enforce_javascript,
		'q.onmouseout'=>$enforce_javascript,
		'q.onmouseover'=>$enforce_javascript,
		'q.onmouseup'=>$enforce_javascript,
		'q.style'=>'.*',
		'q.title'=>'.+',
		'samp.class'=>$enforce_class,
		'samp.dir'=>$enforce_direction,
		'samp.id'=>$enforce_id,
		'samp.lang'=>$enforce_lang,
		'samp.onclick'=>$enforce_javascript,
		'samp.ondblclick'=>$enforce_javascript,
		'samp.onkeydown'=>$enforce_javascript,
		'samp.onkeypress'=>$enforce_javascript,
		'samp.onkeyup'=>$enforce_javascript,
		'samp.onmousedown'=>$enforce_javascript,
		'samp.onmousemove'=>$enforce_javascript,
		'samp.onmouseout'=>$enforce_javascript,
		'samp.onmouseover'=>$enforce_javascript,
		'samp.onmouseup'=>$enforce_javascript,
		'samp.style'=>'.*',
		'samp.title'=>'.+',
		'script.charset'=>'.+',
		'script.defer'=>'defer',
		'script.event'=>'.+',
		'script.for'=>'.+',
		'script.src'=>'.+',
		'script.type'=>'text/javascript',
		'select.class'=>$enforce_class,
		'select.dir'=>$enforce_direction,
		'select.disabled'=>'disabled',
		'select.id'=>$enforce_id,
		'select.lang'=>$enforce_lang,
		'select.multiple'=>'multiple',
		'select.name'=>$enforce_name,
		'select.onblur'=>'.+',
		'select.onchange'=>'.+',
		'select.onclick'=>$enforce_javascript,
		'select.ondblclick'=>$enforce_javascript,
		'select.onfocus'=>$enforce_javascript,
		'select.onkeydown'=>$enforce_javascript,
		'select.onkeypress'=>$enforce_javascript,
		'select.onkeyup'=>$enforce_javascript,
		'select.onmousedown'=>$enforce_javascript,
		'select.onmousemove'=>$enforce_javascript,
		'select.onmouseout'=>$enforce_javascript,
		'select.onmouseover'=>$enforce_javascript,
		'select.onmouseup'=>$enforce_javascript,
		'select.size'=>$enforce_inumber,
		'select.style'=>'.*',
		'select.tabindex'=>$enforce_inumber,
		'select.title'=>'.*',
		'small.class'=>$enforce_class,
		'small.dir'=>$enforce_direction,
		'small.id'=>$enforce_id,
		'small.lang'=>$enforce_lang,
		'small.onclick'=>$enforce_javascript,
		'small.ondblclick'=>$enforce_javascript,
		'small.onkeydown'=>$enforce_javascript,
		'small.onkeypress'=>$enforce_javascript,
		'small.onkeyup'=>$enforce_javascript,
		'small.onmousedown'=>$enforce_javascript,
		'small.onmousemove'=>$enforce_javascript,
		'small.onmouseout'=>$enforce_javascript,
		'small.onmouseover'=>$enforce_javascript,
		'small.onmouseup'=>$enforce_javascript,
		'small.style'=>'.*',
		'small.title'=>'.+',
		'span.class'=>$enforce_class,
		'span.dir'=>$enforce_direction,
		'span.id'=>$enforce_id,
		'span.xml:lang'=>$enforce_lang,
		'span.lang'=>$enforce_lang,
		'span.onclick'=>$enforce_javascript,
		'span.ondblclick'=>$enforce_javascript,
		'span.onkeydown'=>$enforce_javascript,
		'span.onkeypress'=>$enforce_javascript,
		'span.onkeyup'=>$enforce_javascript,
		'span.onmousedown'=>$enforce_javascript,
		'span.onmousemove'=>$enforce_javascript,
		'span.onmouseout'=>$enforce_javascript,
		'span.onmouseover'=>$enforce_javascript,
		'span.onmouseup'=>$enforce_javascript,
		'span.style'=>'.*',
		'span.title'=>'.+',
		'strong.class'=>$enforce_class,
		'strong.dir'=>$enforce_direction,
		'strong.id'=>$enforce_id,
		'strong.lang'=>$enforce_lang,
		'strong.onclick'=>$enforce_javascript,
		'strong.ondblclick'=>$enforce_javascript,
		'strong.onkeydown'=>$enforce_javascript,
		'strong.onkeypress'=>$enforce_javascript,
		'strong.onkeyup'=>$enforce_javascript,
		'strong.onmousedown'=>$enforce_javascript,
		'strong.onmousemove'=>$enforce_javascript,
		'strong.onmouseout'=>$enforce_javascript,
		'strong.onmouseover'=>$enforce_javascript,
		'strong.onmouseup'=>$enforce_javascript,
		'strong.style'=>'.*',
		'strong.title'=>'.+',
		'style.dir'=>$enforce_direction,
		'style.lang'=>$enforce_lang,
		'style.media'=>'.+',
		'style.title'=>'.+',
		'style.type'=>'text/css',
		'sub.class'=>$enforce_class,
		'sub.dir'=>$enforce_direction,
		'sub.id'=>$enforce_id,
		'sub.lang'=>$enforce_lang,
		'sub.onclick'=>$enforce_javascript,
		'sub.ondblclick'=>$enforce_javascript,
		'sub.onkeydown'=>$enforce_javascript,
		'sub.onkeypress'=>$enforce_javascript,
		'sub.onkeyup'=>$enforce_javascript,
		'sub.onmousedown'=>$enforce_javascript,
		'sub.onmousemove'=>$enforce_javascript,
		'sub.onmouseout'=>$enforce_javascript,
		'sub.onmouseover'=>$enforce_javascript,
		'sub.onmouseup'=>$enforce_javascript,
		'sub.style'=>'.*',
		'sub.title'=>'.+',
		'sup.class'=>$enforce_class,
		'sup.dir'=>$enforce_direction,
		'sup.id'=>$enforce_id,
		'sup.lang'=>$enforce_lang,
		'sup.onclick'=>$enforce_javascript,
		'sup.ondblclick'=>$enforce_javascript,
		'sup.onkeydown'=>$enforce_javascript,
		'sup.onkeypress'=>$enforce_javascript,
		'sup.onkeyup'=>$enforce_javascript,
		'sup.onmousedown'=>$enforce_javascript,
		'sup.onmousemove'=>$enforce_javascript,
		'sup.onmouseout'=>$enforce_javascript,
		'sup.onmouseover'=>$enforce_javascript,
		'sup.onmouseup'=>$enforce_javascript,
		'sup.style'=>'.*',
		'sup.title'=>'.+',
		'table.border'=>$enforce_pixels,
		'table.cellpadding'=>$enforce_length,
		'table.cellspacing'=>$enforce_length,
		'table.class'=>$enforce_class,
		'table.dir'=>$enforce_direction,
		'table.frame'=>'(void|above|below|hsides|lhs|rhs|vsides|box|border)',
		'table.id'=>$enforce_id,
		'table.lang'=>$enforce_lang,
		'table.onclick'=>$enforce_javascript,
		'table.ondblclick'=>$enforce_javascript,
		'table.onkeydown'=>$enforce_javascript,
		'table.onkeypress'=>$enforce_javascript,
		'table.onkeyup'=>$enforce_javascript,
		'table.onmousedown'=>$enforce_javascript,
		'table.onmousemove'=>$enforce_javascript,
		'table.onmouseout'=>$enforce_javascript,
		'table.onmouseover'=>$enforce_javascript,
		'table.onmouseup'=>$enforce_javascript,
		'table.rules'=>'(none|groups|rows|cols|all)',
		'table.style'=>'.*',
		'table.summary'=>'.*',
		'table.title'=>'.+',
		'table.width'=>$enforce_length,
		'tbody.align'=>$enforce_align,
		'tbody.char'=>$enforce_character,
		'tbody.charoff'=>$enforce_length,
		'tbody.class'=>$enforce_class,
		'tbody.dir'=>$enforce_direction,
		'tbody.id'=>$enforce_id,
		'tbody.lang'=>$enforce_lang,
		'tbody.onclick'=>$enforce_javascript,
		'tbody.ondblclick'=>$enforce_javascript,
		'tbody.onkeydown'=>$enforce_javascript,
		'tbody.onkeypress'=>$enforce_javascript,
		'tbody.onkeyup'=>$enforce_javascript,
		'tbody.onmousedown'=>$enforce_javascript,
		'tbody.onmousemove'=>$enforce_javascript,
		'tbody.onmouseout'=>$enforce_javascript,
		'tbody.onmouseover'=>$enforce_javascript,
		'tbody.onmouseup'=>$enforce_javascript,
		'tbody.style'=>'.*',
		'tbody.title'=>'.+',
		//'tbody.valign'=>$enforce_valign,
		'td.abbr'=>'.+',
		'td.align'=>$enforce_align,
		'td.axis'=>'.+',
		'td.char'=>$enforce_character,
		'td.charoff'=>$enforce_length,
		'td.class'=>$enforce_class,
		'td.colspan'=>$enforce_inumber,
		'td.dir'=>$enforce_direction,
		'td.headers'=>'.+',
		'td.id'=>$enforce_id,
		'td.lang'=>$enforce_lang,
		'td.onclick'=>$enforce_javascript,
		'td.ondblclick'=>$enforce_javascript,
		'td.onkeydown'=>$enforce_javascript,
		'td.onkeypress'=>$enforce_javascript,
		'td.onkeyup'=>$enforce_javascript,
		'td.onmousedown'=>$enforce_javascript,
		'td.onmousemove'=>$enforce_javascript,
		'td.onmouseout'=>$enforce_javascript,
		'td.onmouseover'=>$enforce_javascript,
		'td.onmouseup'=>$enforce_javascript,
		'td.rowspan'=>$enforce_inumber,
		'td.scope'=>'(row|col|rowgroup|colgroup)',
		'td.style'=>'.*',
		'td.title'=>'.+',
		//'td.valign'=>$enforce_valign,
		'textarea.accesskey'=>$enforce_character,
		'textarea.class'=>$enforce_class,
		'textarea.cols'=>$enforce_inumber,
		'textarea.dir'=>$enforce_direction,
		'textarea.disabled'=>'disabled',
		'textarea.id'=>$enforce_id,
		'textarea.lang'=>$enforce_lang,
		'textarea.name'=>$enforce_id,
		'textarea.onblur'=>'.+',
		'textarea.onchange'=>'.+',
		'textarea.onclick'=>$enforce_javascript,
		'textarea.ondblclick'=>$enforce_javascript,
		'textarea.onfocus'=>$enforce_javascript,
		'textarea.onkeydown'=>$enforce_javascript,
		'textarea.onkeypress'=>$enforce_javascript,
		'textarea.onkeyup'=>$enforce_javascript,
		'textarea.onmousedown'=>$enforce_javascript,
		'textarea.onmousemove'=>$enforce_javascript,
		'textarea.onmouseout'=>$enforce_javascript,
		'textarea.onmouseover'=>$enforce_javascript,
		'textarea.onmouseup'=>$enforce_javascript,
		'textarea.onselect'=>'.+',
		'textarea.readonly'=>'readonly',
		'textarea.rows'=>$enforce_inumber,
		'textarea.style'=>'.*',
		'textarea.tabindex'=>$enforce_inumber,
		'textarea.title'=>'.+',
		'tfoot.align'=>$enforce_align,
		'tfoot.char'=>$enforce_character,
		'tfoot.charoff'=>$enforce_length,
		'tfoot.class'=>$enforce_class,
		'tfoot.dir'=>$enforce_direction,
		'tfoot.id'=>$enforce_id,
		'tfoot.lang'=>$enforce_lang,
		'tfoot.onclick'=>$enforce_javascript,
		'tfoot.ondblclick'=>$enforce_javascript,
		'tfoot.onkeydown'=>$enforce_javascript,
		'tfoot.onkeypress'=>$enforce_javascript,
		'tfoot.onkeyup'=>$enforce_javascript,
		'tfoot.onmousedown'=>$enforce_javascript,
		'tfoot.onmousemove'=>$enforce_javascript,
		'tfoot.onmouseout'=>$enforce_javascript,
		'tfoot.onmouseover'=>$enforce_javascript,
		'tfoot.onmouseup'=>$enforce_javascript,
		'tfoot.style'=>'.*',
		'tfoot.title'=>'.+',
		//'tfoot.valign'=>$enforce_valign,
		'th.abbr'=>'.+',
		'th.align'=>$enforce_align,
		'th.axis'=>'.+',
		'th.char'=>$enforce_character,
		'th.charoff'=>$enforce_length,
		'th.class'=>$enforce_class,
		'th.colspan'=>$enforce_inumber,
		'th.dir'=>$enforce_direction,
		'th.headers'=>'.+',
		'th.height'=>$enforce_length,
		'th.id'=>$enforce_id,
		'th.lang'=>$enforce_lang,
		'th.onclick'=>$enforce_javascript,
		'th.ondblclick'=>$enforce_javascript,
		'th.onkeydown'=>$enforce_javascript,
		'th.onkeypress'=>$enforce_javascript,
		'th.onkeyup'=>$enforce_javascript,
		'th.onmousedown'=>$enforce_javascript,
		'th.onmousemove'=>$enforce_javascript,
		'th.onmouseout'=>$enforce_javascript,
		'th.onmouseover'=>$enforce_javascript,
		'th.onmouseup'=>$enforce_javascript,
		'th.rowspan'=>$enforce_inumber,
		'th.scope'=>'(row|col|rowgroup|colgroup)',
		'th.style'=>'.*',
		'th.title'=>'.+',
		//'th.valign'=>$enforce_valign,
		'th.width'=>$enforce_length,
		'thead.align'=>$enforce_align,
		'thead.char'=>$enforce_character,
		'thead.charoff'=>$enforce_length,
		'thead.class'=>$enforce_class,
		'thead.dir'=>$enforce_direction,
		'thead.id'=>$enforce_id,
		'thead.lang'=>$enforce_lang,
		'thead.onclick'=>$enforce_javascript,
		'thead.ondblclick'=>$enforce_javascript,
		'thead.onkeydown'=>$enforce_javascript,
		'thead.onkeypress'=>$enforce_javascript,
		'thead.onkeyup'=>$enforce_javascript,
		'thead.onmousedown'=>$enforce_javascript,
		'thead.onmousemove'=>$enforce_javascript,
		'thead.onmouseout'=>$enforce_javascript,
		'thead.onmouseover'=>$enforce_javascript,
		'thead.onmouseup'=>$enforce_javascript,
		'thead.style'=>'.*',
		'thead.title'=>'.+',
		//'thead.valign'=>$enforce_valign,
		'title.dir'=>$enforce_direction,
		'title.lang'=>$enforce_lang,
		'tr.align'=>$enforce_align,
		'tr.char'=>$enforce_character,
		'tr.charoff'=>$enforce_length,
		'tr.class'=>$enforce_class,
		'tr.dir'=>$enforce_direction,
		'tr.id'=>$enforce_id,
		'tr.lang'=>$enforce_lang,
		'tr.onclick'=>$enforce_javascript,
		'tr.ondblclick'=>$enforce_javascript,
		'tr.onkeydown'=>$enforce_javascript,
		'tr.onkeypress'=>$enforce_javascript,
		'tr.onkeyup'=>$enforce_javascript,
		'tr.onmousedown'=>$enforce_javascript,
		'tr.onmousemove'=>$enforce_javascript,
		'tr.onmouseout'=>$enforce_javascript,
		'tr.onmouseover'=>$enforce_javascript,
		'tr.onmouseup'=>$enforce_javascript,
		'tr.style'=>'.*',
		'tr.title'=>'.+',
		//'tr.valign'=>$enforce_valign,
		'tt.class'=>$enforce_class,
		'tt.dir'=>$enforce_direction,
		'tt.id'=>$enforce_id,
		'tt.lang'=>$enforce_lang,
		'tt.onclick'=>$enforce_javascript,
		'tt.ondblclick'=>$enforce_javascript,
		'tt.onkeydown'=>$enforce_javascript,
		'tt.onkeypress'=>$enforce_javascript,
		'tt.onkeyup'=>$enforce_javascript,
		'tt.onmousedown'=>$enforce_javascript,
		'tt.onmousemove'=>$enforce_javascript,
		'tt.onmouseout'=>$enforce_javascript,
		'tt.onmouseover'=>$enforce_javascript,
		'tt.onmouseup'=>$enforce_javascript,
		'tt.style'=>'.*',
		'tt.title'=>'.+',
		'ul.class'=>$enforce_class,
		'ul.dir'=>$enforce_direction,
		'ul.id'=>$enforce_id,
		'ul.lang'=>$enforce_lang,
		'ul.onclick'=>$enforce_javascript,
		'ul.ondblclick'=>$enforce_javascript,
		'ul.onkeydown'=>$enforce_javascript,
		'ul.onkeypress'=>$enforce_javascript,
		'ul.onkeyup'=>$enforce_javascript,
		'ul.onmousedown'=>$enforce_javascript,
		'ul.onmousemove'=>$enforce_javascript,
		'ul.onmouseout'=>$enforce_javascript,
		'ul.onmouseover'=>$enforce_javascript,
		'ul.onmouseup'=>$enforce_javascript,
		'ul.style'=>'.*',
		'ul.title'=>'.+',
		'var.class'=>$enforce_class,
		'var.dir'=>$enforce_direction,
		'var.id'=>$enforce_id,
		'var.lang'=>$enforce_lang,
		'var.onclick'=>$enforce_javascript,
		'var.ondblclick'=>$enforce_javascript,
		'var.onkeydown'=>$enforce_javascript,
		'var.onkeypress'=>$enforce_javascript,
		'var.onkeyup'=>$enforce_javascript,
		'var.onmousedown'=>$enforce_javascript,
		'var.onmousemove'=>$enforce_javascript,
		'var.onmouseout'=>$enforce_javascript,
		'var.onmouseover'=>$enforce_javascript,
		'var.onmouseup'=>$enforce_javascript,
		'var.style'=>'.*',
		'var.title'=>'.+',
		'map.name'=>$enforce_id,
//		'form.name'=>$enforce_id,

		// Below brought back in in modules (target, iframe)
		'a.target'=>'.+',
		//'area.target'=>'.+',
		'base.target'=>'.+',
		'form.target'=>'.+',
		'iframe.align'=>$enforce_align2,
		'iframe.class'=>$enforce_class,
		'iframe.height'=>$enforce_length,
		'iframe.id'=>$enforce_id,
		'iframe.longdesc'=>'.+',
		'iframe.name'=>$enforce_id,
		'iframe.scrolling'=>'(yes|no|auto)',
		'iframe.src'=>'.+',
		'iframe.style'=>'.*',
		'iframe.title'=>'.*',
		'iframe.frameborder'=>'(1|0)',
		'iframe.marginheight'=>$enforce_pixels,
		'iframe.marginwidth'=>$enforce_pixels,

		// XHTML 1.1
		'ruby.class'=>$enforce_class,
		'ruby.dir'=>$enforce_direction,
		'ruby.id'=>$enforce_id,
		'ruby.lang'=>$enforce_lang,
		'ruby.onclick'=>$enforce_javascript,
		'ruby.ondblclick'=>$enforce_javascript,
		'ruby.onkeydown'=>$enforce_javascript,
		'ruby.onkeypress'=>$enforce_javascript,
		'ruby.onkeyup'=>$enforce_javascript,
		'ruby.onmousedown'=>$enforce_javascript,
		'ruby.onmousemove'=>$enforce_javascript,
		'ruby.onmouseout'=>$enforce_javascript,
		'ruby.onmouseover'=>$enforce_javascript,
		'ruby.onmouseup'=>$enforce_javascript,
		'ruby.style'=>'.*',
		'ruby.title'=>'.+',
		'rbc.class'=>$enforce_class,
		'rbc.dir'=>$enforce_direction,
		'rbc.id'=>$enforce_id,
		'rbc.lang'=>$enforce_lang,
		'rbc.onclick'=>$enforce_javascript,
		'rbc.ondblclick'=>$enforce_javascript,
		'rbc.onkeydown'=>$enforce_javascript,
		'rbc.onkeypress'=>$enforce_javascript,
		'rbc.onkeyup'=>$enforce_javascript,
		'rbc.onmousedown'=>$enforce_javascript,
		'rbc.onmousemove'=>$enforce_javascript,
		'rbc.onmouseout'=>$enforce_javascript,
		'rbc.onmouseover'=>$enforce_javascript,
		'rbc.onmouseup'=>$enforce_javascript,
		'rbc.style'=>'.*',
		'rbc.title'=>'.+',
		'rtc.class'=>$enforce_class,
		'rtc.dir'=>$enforce_direction,
		'rtc.id'=>$enforce_id,
		'rtc.lang'=>$enforce_lang,
		'rtc.onclick'=>$enforce_javascript,
		'rtc.ondblclick'=>$enforce_javascript,
		'rtc.onkeydown'=>$enforce_javascript,
		'rtc.onkeypress'=>$enforce_javascript,
		'rtc.onkeyup'=>$enforce_javascript,
		'rtc.onmousedown'=>$enforce_javascript,
		'rtc.onmousemove'=>$enforce_javascript,
		'rtc.onmouseout'=>$enforce_javascript,
		'rtc.onmouseover'=>$enforce_javascript,
		'rtc.onmouseup'=>$enforce_javascript,
		'rtc.style'=>'.*',
		'rtc.title'=>'.+',
		'rb.class'=>$enforce_class,
		'rb.dir'=>$enforce_direction,
		'rb.id'=>$enforce_id,
		'rb.lang'=>$enforce_lang,
		'rb.onclick'=>$enforce_javascript,
		'rb.ondblclick'=>$enforce_javascript,
		'rb.onkeydown'=>$enforce_javascript,
		'rb.onkeypress'=>$enforce_javascript,
		'rb.onkeyup'=>$enforce_javascript,
		'rb.onmousedown'=>$enforce_javascript,
		'rb.onmousemove'=>$enforce_javascript,
		'rb.onmouseout'=>$enforce_javascript,
		'rb.onmouseover'=>$enforce_javascript,
		'rb.onmouseup'=>$enforce_javascript,
		'rb.style'=>'.*',
		'rb.title'=>'.+',
		'rt.class'=>$enforce_class,
		'rt.dir'=>$enforce_direction,
		'rt.id'=>$enforce_id,
		'rt.lang'=>$enforce_lang,
		'rt.onclick'=>$enforce_javascript,
		'rt.ondblclick'=>$enforce_javascript,
		'rt.onkeydown'=>$enforce_javascript,
		'rt.onkeypress'=>$enforce_javascript,
		'rt.onkeyup'=>$enforce_javascript,
		'rt.onmousedown'=>$enforce_javascript,
		'rt.onmousemove'=>$enforce_javascript,
		'rt.onmouseout'=>$enforce_javascript,
		'rt.onmouseover'=>$enforce_javascript,
		'rt.onmouseup'=>$enforce_javascript,
		'rt.style'=>'.*',
		'rt.title'=>'.+',
		'rt.rbspan'=>$enforce_inumber,
	);

	global $TAG_ATTRIBUTES_DEPRECATED;
	$TAG_ATTRIBUTES_DEPRECATED=array(
	/*
	From tags removed in XHTML-strict...
	*/
		'img.align'=>$enforce_align2,
		'iframe.width'=>$enforce_length,
		'script.language'=>'Javascript',
		'dir.class'=>$enforce_class,
		'dir.compact'=>'compact',
		'dir.dir'=>$enforce_direction,
		'dir.id'=>$enforce_id,
		'dir.lang'=>$enforce_lang,
		'dir.onclick'=>$enforce_javascript,
		'dir.ondblclick'=>$enforce_javascript,
		'dir.onkeydown'=>$enforce_javascript,
		'dir.onkeypress'=>$enforce_javascript,
		'dir.onkeyup'=>$enforce_javascript,
		'dir.onmousedown'=>$enforce_javascript,
		'dir.onmousemove'=>$enforce_javascript,
		'dir.onmouseout'=>$enforce_javascript,
		'dir.onmouseover'=>$enforce_javascript,
		'dir.onmouseup'=>$enforce_javascript,
		'dir.style'=>'.*',
		'dir.title'=>'.+',
		'menu.class'=>$enforce_class,
		'menu.compact'=>'compact',
		'menu.dir'=>$enforce_direction,
		'menu.id'=>$enforce_id,
		'menu.lang'=>$enforce_lang,
		'menu.onclick'=>$enforce_javascript,
		'menu.ondblclick'=>$enforce_javascript,
		'menu.onkeydown'=>$enforce_javascript,
		'menu.onkeypress'=>$enforce_javascript,
		'menu.onkeyup'=>$enforce_javascript,
		'menu.onmousedown'=>$enforce_javascript,
		'menu.onmousemove'=>$enforce_javascript,
		'menu.onmouseout'=>$enforce_javascript,
		'menu.onmouseover'=>$enforce_javascript,
		'menu.onmouseup'=>$enforce_javascript,
		'menu.style'=>'.*',
		'menu.title'=>'.+',
		'center.class'=>$enforce_class,
		'center.dir'=>$enforce_direction,
		'center.id'=>$enforce_id,
		'center.lang'=>$enforce_lang,
		'center.onclick'=>$enforce_javascript,
		'center.ondblclick'=>$enforce_javascript,
		'center.onkeydown'=>$enforce_javascript,
		'center.onkeypress'=>$enforce_javascript,
		'center.onkeyup'=>$enforce_javascript,
		'center.onmousedown'=>$enforce_javascript,
		'center.onmousemove'=>$enforce_javascript,
		'center.onmouseout'=>$enforce_javascript,
		'center.onmouseover'=>$enforce_javascript,
		'center.onmouseup'=>$enforce_javascript,
		'center.style'=>'.*',
		'center.title'=>'.+',
		'applet.align'=>$enforce_align2,
		'applet.alt'=>'.*',
		'applet.archive'=>'.+',
		'applet.class'=>$enforce_class,
		'applet.code'=>'.+',
		'applet.codebase'=>'.+',
		'applet.height'=>$enforce_length,
		'applet.hspace'=>$enforce_pixels,
		'applet.id'=>$enforce_id,
		'applet.name'=>$enforce_id,
		'applet.object'=>'.+',
		'applet.style'=>'.*',
		'applet.title'=>'.+',
		'applet.vspace'=>$enforce_pixels,
		'applet.width'=>$enforce_length,
		'font.class'=>$enforce_class,
		'font.color'=>$enforce_color,
		'font.dir'=>$enforce_direction,
		'font.face'=>'.+',
		'font.id'=>$enforce_id,
		'font.lang'=>$enforce_lang,
		'font.size'=>'.+',
		'font.style'=>'.*',
		'font.title'=>'.+',
		'basefont.color'=>$enforce_color,
		'basefont.face'=>'.+',
		'basefont.id'=>$enforce_id,
		'basefont.size'=>'.+',
		's.class'=>$enforce_class,
		's.dir'=>$enforce_direction,
		's.id'=>$enforce_id,
		's.lang'=>$enforce_lang,
		's.onclick'=>$enforce_javascript,
		's.ondblclick'=>$enforce_javascript,
		's.onkeydown'=>$enforce_javascript,
		's.onkeypress'=>$enforce_javascript,
		's.onkeyup'=>$enforce_javascript,
		's.onmousedown'=>$enforce_javascript,
		's.onmousemove'=>$enforce_javascript,
		's.onmouseout'=>$enforce_javascript,
		's.onmouseover'=>$enforce_javascript,
		's.onmouseup'=>$enforce_javascript,
		's.style'=>'.*',
		's.title'=>'.+',
		'strike.class'=>$enforce_class,
		'strike.dir'=>$enforce_direction,
		'strike.id'=>$enforce_id,
		'strike.lang'=>$enforce_lang,
		'strike.onclick'=>$enforce_javascript,
		'strike.ondblclick'=>$enforce_javascript,
		'strike.onkeydown'=>$enforce_javascript,
		'strike.onkeypress'=>$enforce_javascript,
		'strike.onkeyup'=>$enforce_javascript,
		'strike.onmousedown'=>$enforce_javascript,
		'strike.onmousemove'=>$enforce_javascript,
		'strike.onmouseout'=>$enforce_javascript,
		'strike.onmouseover'=>$enforce_javascript,
		'strike.onmouseup'=>$enforce_javascript,
		'strike.style'=>'.*',
		'strike.title'=>'.+',
		'u.class'=>$enforce_class,
		'u.dir'=>$enforce_direction,
		'u.id'=>$enforce_id,
		'u.lang'=>$enforce_lang,
		'u.onclick'=>$enforce_javascript,
		'u.ondblclick'=>$enforce_javascript,
		'u.onkeydown'=>$enforce_javascript,
		'u.onkeypress'=>$enforce_javascript,
		'u.onkeyup'=>$enforce_javascript,
		'u.onmousedown'=>$enforce_javascript,
		'u.onmousemove'=>$enforce_javascript,
		'u.onmouseout'=>$enforce_javascript,
		'u.onmouseover'=>$enforce_javascript,
		'u.onmouseup'=>$enforce_javascript,
		'u.style'=>'.*',
		'u.title'=>'.+',

	/*
	Removed in XHTML strict
	*/
		'base.target'=>'.+',
		'link.target'=>'.+',
		'body.bgcolor'=>$enforce_color,
		'body.text'=>$enforce_color,
		'body.vlink'=>$enforce_color,
		'body.link'=>$enforce_color,
		'body.alink'=>$enforce_color,
		'div.align'=>$enforce_align3,
		'p.align'=>$enforce_align3,
		'h1.align'=>$enforce_align3,
		'h2.align'=>$enforce_align3,
		'h3.align'=>$enforce_align3,
		'h4.align'=>$enforce_align3,
		'h5.align'=>$enforce_align3,
		'h6.align'=>$enforce_align3,
		'ul.compact'=>'compact',
		'ul.type'=>'(disc|square|circle)',
		'ol.compact'=>'compact',
		'ol.start'=>$enforce_inumber,
		'ol.type'=>'.+',
		'li.type'=>'.+',
		'li.value'=>$enforce_inumber,
		'dl.compact'=>'compact',
		'hr.align'=>'(left|center|right)',
		'hr.noshade'=>'noshade',
		'hr.size'=>'.+',
		'pre.width'=>$enforce_inumber,
		'br.clear'=>'(left|all|right|none)',
		'object.align'=>$enforce_align2,
		'object.border'=>$enforce_pixels,
		'object.hspace'=>$enforce_pixels,
		'object.vspace'=>$enforce_pixels,
		//'img.border'=>$enforce_pixels, Deprecated
		'img.hspace'=>$enforce_pixels,
		'img.vspace'=>$enforce_pixels,
		'input.align'=>$enforce_align2,
		'table.align'=>'(left|center|right)',
		'table.bgcolor'=>$enforce_color,
		'caption.align'=>$enforce_align4,
		'tr.bgcolor'=>$enforce_color,
		'th.nowrap'=>'nowrap',
		'th.bgcolor'=>$enforce_color,
		'td.bgcolor'=>$enforce_color,
		'td.nowrap'=>'nowrap',
		'td.width'=>$enforce_number,
		'td.height'=>$enforce_number,
		);

	global $TAG_ATTRIBUTES_REQUIRED;
	$TAG_ATTRIBUTES_REQUIRED=array(
		'base'=>array('href'), // XHTML-strict
		'html'=>array('xmlns','xml:lang'),
		'meta'=>array('content'),
		'style'=>array('type'),
		'script'=>array('type'),
		'bdo'=>array('dir'),
		'basefont'=>array('size'),
	//	'param'=>array('name'), Not needed in XHTML strict
	/*	'applet'=>array('width','height'),*/
		'iframe'=>array('src','title'),
		'img'=>array('src','alt'),
		'label'=>array('for'),
		'map'=>array('id'),
		'area'=>array('alt'),
		'form'=>array('action'),
		'textarea'=>array('cols','rows'),
//		'input'=>array('value'), // accessibility, checked somewhere else
		'table'=>array('summary'),
		'optgroup'=>array('label'));

	// B's may not appear under A
	global $PROHIBITIONS;
	$PROHIBITIONS=array(
		'a'=>array('a'),
		'button'=>array('input','select','textarea','label','button','form','fieldset','iframe'),
	//	'label'=>array('label'),  Not sure, but used this for a reason - when we had one label for two things
		'p'=>array('p','table','div','form','h1','h2','h3','h4','h5','h6','blockquote','pre','hr'),
		'form'=>array('form'),
		'em'=>array('em'),
		'abbr'=>array('abbr'),
		'acronym'=>array('acronym'),
		'strong'=>array('strong'),
		'label'=>array('label','div'));

	// Only B's can be under A
	global $ONLY_CHILDREN;
	$ONLY_CHILDREN=array(
		'ruby'=>array('rbc','rtc','rp'),
		'tr'=>array('td','th'),
		'thead'=>array('tr'),
		'tbody'=>array('tr'),
		'tfoot'=>array('tr'),
		'table'=>array('tbody','thead','tfoot','tr','colgroup','col','caption'),
		'colgroup'=>array('col'),
		'select'=>array('option'),
		'legend'=>array('ins','del'),
		//'map'=>array('area'), Apparently no such rule (see w3.org)
		'html'=>array('head','body'),
		'object'=>array('param','object','embed'),
		'embed'=>array('noembed'),
		'applet'=>array('param'),
		'head'=>array('meta','base','basefont','script','link','noscript','map','title','style'),
		'ul'=>array('li'),
		'ol'=>array('li'),
		'menu'=>array('li'),
		'dl'=>array('li','dt','dd'),
		'dir'=>array('li'),
		'hr'=>array(),
		'img'=>array(),
		'input'=>array(),
		'br'=>array(),
		'meta'=>array(),
		'base'=>array(),
		'title'=>array(),
		'textarea'=>array(),
		'style'=>array(),
		'pre'=>array(),
		'script'=>array(),
		'param'=>array(),
		/*'option'=>array(),*/
		'area'=>array(),
		'link'=>array('link'),
		'basefont'=>array(),
		'col'=>array()
	);

	// A can only occur underneath B's
	global $ONLY_PARENT;
	$ONLY_PARENT=array(
		'rb'=>array('rbc'),
		'rt'=>array('rtc'),
		'rbc'=>array('ruby'),
		'rtc'=>array('ruby'),
		'rp'=>array('ruby'),
		'area'=>array('map'),
		'base'=>array('head'),
		'body'=>array('html'),
		'head'=>array('html'),
		'param'=>array('script','object'),
		'meta'=>array('head'),
		'link'=>array('head','link'),
		'li'=>array('ul','ol','dd','menu','dt','dl','dir'),
		'style'=>array('head'),
		'tbody'=>array('table'),
		'tfoot'=>array('table'),
		'thead'=>array('table'),
		'th'=>array('tr'),
		'td'=>array('tr'),
		'tr'=>array('table','thead','tbody','tfoot'),
		'title'=>array('head'),
		'caption'=>array('table'),
		'col'=>array('colgroup','table'),
		'colgroup'=>array('table'),
		'option'=>array('select'),
		'noembed'=>array('embed'),
		);

	global $REQUIRE_ANCESTER;
	$REQUIRE_ANCESTER=array(
		'legend'=>'fieldset',
		'textarea'=>'form',
		'input'=>'form',
//		'button'=>'form',
		'option'=>'form',
		'optgroup'=>'form',
		'select'=>'form',
		);

	global $TEXT_NO_BLOCK;
	$TEXT_NO_BLOCK=array(
		'table'=>1,
		'tr'=>1,
		'tfoot'=>1,
		'thead'=>1,
		'ul'=>1,
		'ol'=>1,
		'dl'=>1,
		'optgroup'=>1,
		'select'=>1,
		'colgroup'=>1,
		'map'=>1,
		'body'=>1,
		'form'=>1,
		);

	define('IN_XML_TAG',-3);
	define('IN_DTD_TAG',-2);
	define('NO_MANS_LAND',-1);
	define('IN_COMMENT',0);
	define('IN_TAG_NAME',1);
	define('STARTING_TAG',2);
	define('IN_TAG_BETWEEN_ATTRIBUTES',3);
	define('IN_TAG_ATTRIBUTE_NAME',4);
	define('IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_LEFT',5);
	define('IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_RIGHT',7);
	define('IN_TAG_ATTRIBUTE_VALUE_BIG_QUOTES',10);
	define('IN_TAG_ATTRIBUTE_VALUE_NO_QUOTES',12);
	define('IN_TAG_EMBEDDED_COMMENT',9);
	define('IN_TAG_ATTRIBUTE_VALUE_LITTLE_QUOTES',8);
	define('IN_CDATA',11);

	define('CSS_AT_RULE_BLOCK',-4);
	define('CSS_AT_RULE',-3);
	define('CSS_NO_MANS_LAND',-2);
	define('CSS_EXPECTING_CLASS_NAME',-1);
	define('CSS_IN_COMMENT',0);
	define('CSS_IN_CLASS',1);
	define('CSS_EXPECTING_SEP_OR_CLASS_NAME_OR_CLASS',2);
	define('CSS_IN_CLASS_NAME',3);
	
	define('_CSS_NO_MANS_LAND',0);
	define('_CSS_IN_PROPERTY_KEY',1);
	define('_CSS_IN_PROPERTY_BETWEEN',2);
	define('_CSS_IN_PROPERTY_VALUE',3);
	define('_CSS_IN_COMMENT',4);
	define('_CSS_EXPECTING_END',5);
}

/**
 * Check the specified XHTML, and return the results.
 *
 * @param  string			The XHTML to validate
 * @param  boolean		Whether to avoid checking for relational errors (false implies just a quick structural check, aka a 'well formed' check)
 * @param  boolean		Whether what is being validated is an HTML fragment, rather than a whole document
 * @param  boolean		Validate javascript
 * @param  boolean		Validate CSS
 * @param  boolean		Validate WCAG
 * @param  boolean		Validate for compatibility
 * @param  boolean		Validate external files
 * @param  boolean		Bring up messages about manual checks
 * @return ?map			Error information (NULL: no error)
 */
function check_xhtml($out,$well_formed_only=false,$is_fragment=false,$validation_javascript=true,$validation_css=true,$validation_wcag=true,$validation_compat=true,$validation_ext_files=true,$validation_manual=false)
{
	global $XHTML_VALIDATOR_OFF,$WELL_FORMED_ONLY,$VALIDATION_JAVASCRIPT,$VALIDATION_CSS,$VALIDATION_WCAG,$VALIDATION_COMPAT,$VALIDATION_EXT_FILES,$VALIDATION_MANUAL;
	$XHTML_VALIDATOR_OFF=mixed();
	$WELL_FORMED_ONLY=$well_formed_only;
	$VALIDATION_JAVASCRIPT=$validation_javascript;
	$VALIDATION_CSS=$validation_css;
	$VALIDATION_WCAG=$validation_wcag;
	$VALIDATION_COMPAT=$validation_compat;
	$VALIDATION_EXT_FILES=$validation_ext_files;
	$VALIDATION_MANUAL=$validation_manual;

	global $IDS_SO_FAR;
	$IDS_SO_FAR=array();

	$content_start_stack=array();

	global $BLOCK_CONSTRAIN,$XML_CONSTRAIN,$LAST_TAG_ATTRIBUTES,$FOUND_DOCTYPE,$FOUND_DESCRIPTION,$FOUND_KEYWORDS,$FOUND_CONTENTTYPE,$THE_DOCTYPE,$TAGS_DEPRECATE_ALLOW,$URL_BASE,$PARENT_TAG,$TABS_SEEN,$KEYS_SEEN,$ANCHORS_SEEN,$ATT_STACK,$TAG_STACK,$POS,$LINENO,$LINESTART,$OUT,$T_POS,$PROHIBITIONS,$ONLY_PARENT,$ONLY_CHILDREN,$REQUIRE_ANCESTER,$LEN,$ANCESTER_BLOCK,$ANCESTER_INLINE,$POSSIBLY_EMPTY_TAGS,$MUST_SELFCLOSE_TAGS,$FOR_LABEL_IDS,$FOR_LABEL_IDS_2,$INPUT_TAG_IDS;
	global $TAG_RANGES,$VALUE_RANGES,$LAST_A_TAG,$A_LINKS,$XHTML_FORM_ENCODING;
	global $AREA_LINKS,$LAST_HEADING,$CRAWLED_URLS,$HYPERLINK_URLS,$EMBED_URLS,$THE_LANGUAGE,$PSPELL_LINK;
	$PSPELL_LINK=NULL;
	$THE_LANGUAGE='en';
	$THE_DOCTYPE=$is_fragment?DOCTYPE_XHTML:DOCTYPE_HTML;
	$TAGS_DEPRECATE_ALLOW=true;
	$XML_CONSTRAIN=$is_fragment;
	$BLOCK_CONSTRAIN=false;
	$LINENO=0;
	$LINESTART=0;
	$HYPERLINK_URLS=array();
	$EMBED_URLS=array();
	$AREA_LINKS=array();
	$LAST_HEADING=0;
	$FOUND_DOCTYPE=false;
	$FOUND_CONTENTTYPE=false;
	$FOUND_KEYWORDS=false;
	$FOUND_DESCRIPTION=false;
	$CRAWLED_URLS=array();
	$PARENT_TAG='';
	$XHTML_FORM_ENCODING='';
	$KEYS_SEEN=array();
	$TABS_SEEN=array();
	$TAG_RANGES=array();
	$VALUE_RANGES=array();
	$LAST_A_TAG=NULL;
	$ANCHORS_SEEN=array();
	$FOR_LABEL_IDS=array();
	$FOR_LABEL_IDS_2=array();
	$INPUT_TAG_IDS=array();
	$TAG_STACK=array();
	$ATT_STACK=array();
	$ANCESTER_BLOCK=0;
	$ANCESTER_INLINE=0;
	$POS=0;
	$OUT=$out;
	unset($out);
	$LEN=strlen($OUT);
	$level_ranges=array();
	$stack_size=0;
	$to_find=array('html'=>1,'head'=>1,'title'=>1/*,'meta'=>1*/);
	$only_one_of_stack=array();
	$only_one_of_template=array('title'=>1,'head'=>1,'body'=>1,'base'=>1,'thead'=>1,'tfoot'=>1);
	$only_one_of=$only_one_of_template;
	$A_LINKS=array();
	$previous='';
	if (!isset($GLOBALS['MAIL_MODE'])) $GLOBALS['MAIL_MODE']=false;

	$errors=array();

	$token=_get_next_tag();
	while (!is_null($token))
	{
//		echo $T_POS.'-'.$POS.' ('.$stack_size.')<br />';

		if ((is_array($token)) && (count($token)!=0)) // Some kind of error in our token
		{
			if (is_null($XHTML_VALIDATOR_OFF))
			{
				foreach ($token[1] as $error)
				{
					$errors[]=_xhtml_error($error[0],array_key_exists(1,$error)?$error[1]:'',array_key_exists(2,$error)?$error[2]:'',array_key_exists(3,$error)?$error[3]:'',array_key_exists('raw',$error)?$error['raw']:false,array_key_exists('pos',$error)?$error['pos']:0);
				}
				if (is_null($token[0])) return array('level_ranges'=>$level_ranges,'tag_ranges'=>$TAG_RANGES,'value_ranges'=>$VALUE_RANGES,'errors'=>$errors);
			}
			$token=$token[0];
		}

		$basis_token=_get_tag_basis($token);

		// Open, close, or monitonic?
		$term=strpos($token,'/');
		if (!is_null($XHTML_VALIDATOR_OFF))
		{
			if ($term===false) $XHTML_VALIDATOR_OFF++;
			elseif ($term==1)
			{
				if ($XHTML_VALIDATOR_OFF==0)
				{
					$XHTML_VALIDATOR_OFF=NULL;
				} else
				{
					$XHTML_VALIDATOR_OFF--;
				}
			}
		}

		if ($term!==1)
		{
			if (isset($only_one_of[$basis_token]))
			{
				if ($only_one_of[$basis_token]==0) $errors[]=_xhtml_error('XHTML_ONLY_ONE_ALLOWED',$basis_token);
				$only_one_of[$basis_token]--;
			}

//			echo 'Push $basis_token<br />';
			$level_ranges[]=array($stack_size,$T_POS,$POS);
			if (isset($to_find[$basis_token])) unset($to_find[$basis_token]);
			if ((!$WELL_FORMED_ONLY) && (is_null($XHTML_VALIDATOR_OFF)))
			{
				if (((!$is_fragment) && ($stack_size==0)) && ($basis_token!='html')) $errors[]=_xhtml_error('XHTML_BAD_ROOT');
				if ($stack_size!=0)
				{
					if (isset($ONLY_CHILDREN[$PARENT_TAG]))
					{
						if (!in_array($basis_token,$ONLY_CHILDREN[$PARENT_TAG]))
							$errors[]=_xhtml_error('XHTML_BAD_CHILD',$basis_token,$PARENT_TAG);
					}

					/*if (isset($PROHIBITIONS[$PARENT_TAG]))
					{
						$prohibitions=$PROHIBITIONS[$PARENT_TAG];
						if (in_array($basis_token,$prohibitions)) $errors[]=_xhtml_error('XHTML_PROHIBITION',$basis_token,$PARENT_TAG);
					}*/
					foreach ($TAG_STACK as $parent_tag)
					{
						if (isset($PROHIBITIONS[$parent_tag]))
						{
							$prohibitions=$PROHIBITIONS[$parent_tag];
							if (in_array($basis_token,$prohibitions)) $errors[]=_xhtml_error('XHTML_PROHIBITION',$basis_token,$parent_tag);
						}
					}
				}

				if ((isset($REQUIRE_ANCESTER[$basis_token])) && (!$is_fragment))
				{
					if (!in_array($REQUIRE_ANCESTER[$basis_token],$TAG_STACK)) $errors[]=_xhtml_error('XHTML_MISSING_ANCESTER',$basis_token,$REQUIRE_ANCESTER[$basis_token]);
				}
				if (isset($ONLY_PARENT[$basis_token]))
				{
					if ($stack_size==0)
					{
						if (!$is_fragment) $errors[]=_xhtml_error('XHTML_BAD_PARENT',$basis_token,'/');
					} else
					{
						if (!in_array($PARENT_TAG,$ONLY_PARENT[$basis_token])) $errors[]=_xhtml_error('XHTML_BAD_PARENT',$basis_token,$PARENT_TAG);
					}
				}
			}

			// In order to ease validation, we tolerate these in the parser (but of course, mark as errors)
			if ((is_null($XHTML_VALIDATOR_OFF)) && (!$WELL_FORMED_ONLY) && ($term===false) && (isset($MUST_SELFCLOSE_TAGS[$basis_token])))
			{
				if ($XML_CONSTRAIN) $errors[]=_xhtml_error('XHTML_NONEMPTY_TAG',$basis_token);
			}
			else
			{
				if ($term===false)
				{
					$PARENT_TAG=$basis_token;
					array_push($TAG_STACK,$basis_token);
					array_push($ATT_STACK,$LAST_TAG_ATTRIBUTES);
					array_push($content_start_stack,$POS);
					array_push($only_one_of_stack,$only_one_of);
					$only_one_of=$only_one_of_template;
					++$stack_size;
				} else
				{
					if ((is_null($XHTML_VALIDATOR_OFF)) && (!$WELL_FORMED_ONLY) && ((!$XML_CONSTRAIN) || (!isset($MUST_SELFCLOSE_TAGS[$basis_token]))) && /*(!in_array($basis_token,array('a'))) && */(is_null($XHTML_VALIDATOR_OFF))) // A tags must not self close even when only an anchor. Makes a weird underlined line effect in firefox
					{
						$errors[]=_xhtml_error('XHTML_CEMPTY_TAG',$basis_token);
					}
				}
			}
		}
		elseif ($term==1) // Check its the closing to the stacks highest
		{
			// HTML allows implicit closing. We will flag errors when we have to do it. See 1-2-3 note
			do
			{
				// For case 3 (see note below)
				if (!in_array($basis_token,$TAG_STACK))
				{
					if ((is_null($XHTML_VALIDATOR_OFF)) && ($XML_CONSTRAIN)) $errors[]=_xhtml_error('XML_NO_CLOSE_MATCH',$basis_token,$previous);
					break;
				}

				$previous=array_pop($TAG_STACK);
				$PARENT_TAG=($TAG_STACK==array())?'':$TAG_STACK[count($TAG_STACK)-1];
				$start_pos=array_pop($content_start_stack);
				array_pop($ATT_STACK);
				$only_one_of=array_pop($only_one_of_stack);
				if (is_null($previous))
				{
					if ((is_null($XHTML_VALIDATOR_OFF)) && ($XML_CONSTRAIN)) $errors[]=_xhtml_error('XML_MORE_CLOSE_THAN_OPEN',$basis_token);
					break;
				}

				if ($basis_token!=$previous)
				{
					// This is really tricky, and totally XHTML-incompliant. There are three situations:
					// 1) Overlapping tags. We really can't survive this, and it's very invalid. We could only detect it if we broke support for cases (1) and (2). e.g. <i><b></i></b>
					// 2) Implicit closing. We close everything implicitly until we find the matching tag. E.g. <i><b></i>
					// 3) Closing something that was never open. This is tricky - we can't survive it if it was opened somewhere as a parent, as we'd end up closing a whole load of tags by rule (2) - but if it's a lone closing, we can skip it. Good e.g. <b></i></b>. Bad e.g. <div><p></div></p></div>
					if ((is_null($XHTML_VALIDATOR_OFF)) && ($XML_CONSTRAIN)) $errors[]=_xhtml_error('XML_NO_CLOSE_MATCH',$basis_token,$previous);
				}

				if ((!$WELL_FORMED_ONLY) && (is_null($XHTML_VALIDATOR_OFF)))
				{
					if ((isset($MUST_SELFCLOSE_TAGS[$previous])) && ($XML_CONSTRAIN))
					{
						$errors[]=_xhtml_error('XHTML_NONEMPTY_TAG',$previous);
					}

					if ((!isset($MUST_SELFCLOSE_TAGS[$previous])) && (!isset($POSSIBLY_EMPTY_TAGS[$previous])) && (trim(substr($OUT,$start_pos,$T_POS-$start_pos))==''))
					{
						$errors[]=_xhtml_error('XHTML_EMPTY_TAG',$previous);
					}
				}
				$stack_size--;
				$level_ranges[]=array($stack_size,$T_POS,$POS);
	//			echo 'Popped $previous<br />';

				if ((is_null($XHTML_VALIDATOR_OFF)) && (!$WELL_FORMED_ONLY) && (is_null($XHTML_VALIDATOR_OFF)))
				{
					if ($previous=='script')
					{
						$tag_contents=substr($OUT,$start_pos,$T_POS-$start_pos);
						$c_section=strpos($tag_contents,']]>');
						if ((trim($tag_contents)!='') && (strpos($tag_contents,'//-->')===false) && (strpos($tag_contents,'// -->')===false) && ($c_section===false))
						{
							$errors[]=_xhtml_error('XHTML_SCRIPT_COMMENTING',$previous);
						} elseif (($c_section===false) && ((strpos($tag_contents,'<!--')!==false)))
						{
							if ($XML_CONSTRAIN) $errors[]=_xhtml_error('XHTML_CDATA');
						}
						if (/*(!$c_section) && */(strpos($tag_contents,'</')!==false)) $errors[]=_xhtml_error('XML_JS_TAG_ESCAPE');
					}
				}
			}
			while ($basis_token!=$previous);
		}
		/*else
		{
			$level_ranges[]=array($stack_size,$T_POS,$POS);
			// it's monitonic, so ignore
		}*/

		$token=_get_next_tag();
	}

	// Check we have everything closed
	if ($stack_size!=0)
	{
		if ($XML_CONSTRAIN) $errors[]=_xhtml_error('XML_NO_CLOSE',array_pop($TAG_STACK));
		return array('level_ranges'=>$level_ranges,'tag_ranges'=>$TAG_RANGES,'value_ranges'=>$VALUE_RANGES,'errors'=>$errors);
	}

	if (!$well_formed_only)
//	if ((is_null($XHTML_VALIDATOR_OFF)) || (!$well_formed_only)) // validator-off check needed because it's possible a non-validateable portion foobars up possibility of interpreting the rest of the document such that checking ends early
	{
		if (!$is_fragment)
		{
			foreach (array_keys($to_find) as $tag)
				$errors[]=_xhtml_error('XHTML_MISSING_TAG',$tag);

			if ((!$FOUND_DOCTYPE) && (!$GLOBALS['MAIL_MODE'])) $errors[]=_xhtml_error('XHTML_DOCTYPE');
			if (($FOUND_DOCTYPE) && ($GLOBALS['MAIL_MODE'])) $errors[]=_xhtml_error('MAIL_DOCTYPE');
			if (!$FOUND_CONTENTTYPE) $errors[]=_xhtml_error('XHTML_CONTENTTYPE');
			if (!$FOUND_KEYWORDS) $errors[]=_xhtml_error('XHTML_KEYWORDS');
			if (!$FOUND_DESCRIPTION) $errors[]=_xhtml_error('XHTML_DESCRIPTION');
		}

		if (!$is_fragment)
		{
			// Check that all area-links have a corresponding hyperlink
			foreach (array_keys($AREA_LINKS) as $id)
			{
				if (!in_array($id,$HYPERLINK_URLS)) $errors[]=_xhtml_error('WCAG_AREA_EQUIV',$id);
			}

			// Check that all labels apply to real input tags
			foreach (array_keys($FOR_LABEL_IDS_2) as $id)
			{
				if (!isset($INPUT_TAG_IDS[$id])) $errors[]=_xhtml_error('XHTML_ID_UNBOUND',$id);
			}
		}
	}

	// Main spelling
	if ((function_exists('pspell_new')) && (isset($GLOBALS['SPELLING'])))
	{
		$stripped=$OUT;
		$matches=array();
		$num_matches=preg_match_all('#\<style.*\</style\>#Umis',$stripped,$matches);
		for ($i=0;$i<$num_matches;$i++)
		{
			$stripped=str_replace($matches[0][$i],str_repeat(' ',strlen($matches[0][$i])),$stripped);
		}
		$num_matches=preg_match_all('#\<script.*\</script\>#Umis',$stripped,$matches);
		for ($i=0;$i<$num_matches;$i++)
		{
			$stripped=str_replace($matches[0][$i],str_repeat(' ',strlen($matches[0][$i])),$stripped);
		}
		$stripped=@html_entity_decode(strip_tags($stripped),ENT_QUOTES,get_charset());
		$new_errors=validate_spelling($stripped);
		$misspellings=array();
		global $POS,$LINENO,$LINESTART;
		foreach ($new_errors as $error)
		{
			if (array_key_exists($error[1],$misspellings)) continue;
			$misspellings[$error[1]]=1;
			$POS=strpos($OUT,$error[1]);
			$LINESTART=strrpos(substr($OUT,0,$POS),chr(10));
			$LINENO=substr_count(substr($OUT,0,$LINESTART),chr(10))+1;
			$errors[]=_xhtml_error($error[0],$error[1]);
		}
	}

	unset($OUT);

	return array('level_ranges'=>$level_ranges,'tag_ranges'=>$TAG_RANGES,'value_ranges'=>$VALUE_RANGES,'errors'=>$errors);
}

/**
 * Get some general debugging information for an identified XHTML error.
 *
 * @param  string			The error that occurred
 * @param  string			The first parameter of the error
 * @param  string			The second parameter of the error
 * @param  string			The third parameter of the error
 * @param  boolean		Whether to not do a lang lookup
 * @param  integer		Offset position
 * @return map				A map of the error information
 */
function _xhtml_error($error,$param_a='',$param_b='',$param_c='',$raw=false,$rel_pos=0)
{
	global $POS,$OUT,$LINENO,$LINESTART;
	$lineno=($rel_pos==0)?0:substr_count(substr($OUT,$POS,$rel_pos),chr(10));
	$out=array();
	$out['line']=$LINENO+1+$lineno;
	if ($rel_pos==0)
	{
		$out['pos']=$POS-$LINESTART;
	} else
	{
		$out['pos']=$POS+$rel_pos-strrpos(substr($OUT,0,$POS+$rel_pos),chr(10));
	}
	$out['global_pos']=$POS+$rel_pos;
	$out['error']=$raw?$error:do_lang($error,htmlentities($param_a),htmlentities($param_b),htmlentities($param_c));

	return $out;
}

/**
 * Checks to see if a string holds a hexadecimal number.
 *
 * @param  string			The string to check
 * @return boolean		Whether the string holds a hexadecimal number
 */
function is_hex($string)
{
	return preg_match('#^(\d*[abcdef]*)*$#',$string)!=0;
}


// Be prepared for some hideous code. I've had to optimise this relatively heavily to keep performance up!

/**
 * Test the next entity in the output stream.
 *
 * @param  integer		Checking offset
 * @return ?mixed			An array of error details (NULL: no errors)
 */
function test_entity($offset=0)
{
	global $OUT,$POS,$ENTITIES;

	$lump=substr($OUT,$POS+$offset,8);

	$errors=array();

	$pos=strpos($lump,';');
	//if ($pos!==0) // "&; sequence" is possible. It's in IPB's posts and to do with emoticon meta tagging
	{
		if ($pos===false)
		{
			$errors[]=array('XHTML_BAD_ENTITY');
		} else
		{
			$lump=substr($lump,0,$pos);
			if (!(($lump[0]=='#') && ((is_numeric(substr($lump,1))) || (($lump[1]=='x') && (is_hex(substr($lump,2))))))) // It's ok if this is a numeric code, so no need to check further
			{
				// Check against list
				if (!isset($ENTITIES[$lump]))
				{
					$errors[]=array('XHTML_BAD_ENTITY');
				}
			}
		}
	}
	
	if (count($errors)==0) return NULL;
	return $errors;
}

/**
 * Fix any invalid entities in the text.
 *
 * @param  string			Text to fix in
 * @return string			Fixed result
 */
function fix_entities($in)
{
	global $ENTITIES;
	
	$out='';

	$len=strlen($in);
	for ($i=0;$i<$len;$i++)
	{
		$out.=$in[$i];

		if ($in[$i]=='&')
		{
			$lump=substr($in,$i+1,8);
			$pos=strpos($lump,';');

			if ($pos===false)
			{
				$out.='amp;';
			} else
			{
				$lump=substr($lump,0,$pos);
				if (!(($lump[0]=='#') && ((is_numeric(substr($lump,1))) || (($lump[1]=='x') && (is_hex(substr($lump,2)))))))
				{
					if (!isset($ENTITIES[$lump]))	$out.='amp;';
				}
			}
		}
	}
	
	return $out;
}

/**
 * Get the next tag in the current XHTML document.
 *
 * @return ?mixed			Either an array of error details, a string of the tag, or NULL for finished (NULL: no next tag)
 */
function _get_next_tag()
{
	//	echo '<p>!</p>';

	global $PARENT_TAG,$POS,$LINENO,$LINESTART,$OUT,$T_POS,$ENTITIES,$LEN,$ANCESTER_BLOCK,$TAG_STACK,$XHTML_VALIDATOR_OFF,$TEXT_NO_BLOCK,$INBETWEEN_TEXT;
	global $TAG_RANGES,$VALUE_RANGES;

	$status=NO_MANS_LAND;

	$current_tag='';
	$current_attribute_name='';
	$current_attribute_value='';
	$close=false;
	$doc_type='';
	$INBETWEEN_TEXT='';

	$attribute_map=array();

	$errors=array();

	$chr_10=chr(10);
	$chr_13=chr(13);
	$special_chars=array('='=>1,'"'=>1,'&'=>1,'/'=>1,'<'=>1,'>'=>1,' '=>1,$chr_10=>1,$chr_13=>1);

	while ($POS<$LEN)
	{
		$next=$OUT[$POS];
		$POS++;

		if ($next==$chr_10)
		{
			$LINENO++;
			$LINESTART=$POS;
		}
//		echo $status.' for '.$next.'<br />';

		// Entity checking
		if (($next=='&') && ($status!=IN_CDATA) && ($status!=IN_COMMENT) && (is_null($XHTML_VALIDATOR_OFF)))
		{
			$test=test_entity();
			if (!is_null($test)) $errors=array_merge($errors,$test);
		}

		// State machine
		switch ($status)
		{
			case NO_MANS_LAND:
				$in_no_mans_land='';
				$continue=($next!='<') && ($next!='&') && ($POS<$LEN-1);
				if ($next!='<') $INBETWEEN_TEXT.=$next;
				while ($continue)
				{
					$next=$OUT[$POS];
					$POS++;
					$continue=($next!='<') && ($next!='&') && ($POS<$LEN-1);
					if ($continue) $in_no_mans_land.=$next;
					if ($next!='<') $INBETWEEN_TEXT.=$next;
					if ($next==$chr_10)
					{
						$LINENO++;
						$LINESTART=$POS;
					}
				}
				if (($next=='&') && (is_null($XHTML_VALIDATOR_OFF)))
				{
					$test=test_entity();
					if (!is_null($test)) $errors=array_merge($errors,$test);
				}

				// Can't have loose text in form/body/etc
				// 'x' is there for when called externally, checking on an x that has replaced, for example, a directive tag (which isn't actual text - so can't trip the error)
				if (($in_no_mans_land!='x') && (trim($in_no_mans_land)!='') && (isset($TEXT_NO_BLOCK[$PARENT_TAG])) && ($GLOBALS['BLOCK_CONSTRAIN'])) $errors[]=array('XHTML_TEXT_NO_BLOCK',$PARENT_TAG);
				
				if (($next=='<') && (isset($OUT[$POS])) && ($OUT[$POS]=='!'))
				{
					if (($OUT[$POS+1]=='-') && ($OUT[$POS+2]=='-')) $status=IN_COMMENT;
					elseif (substr($OUT,$POS-1,9)=='<![CDATA[')
					{
						$status=IN_CDATA;
						$POS+=8;
					}
					else
					{
						$status=IN_DTD_TAG;
					}
				}
				elseif (($next=='<') && (isset($OUT[$POS])) && ($OUT[$POS]=='?') && ($POS<10))
				{
					if ($GLOBALS['MAIL_MODE']) $errors[]=array('MAIL_PROLOG');
					$status=IN_XML_TAG;
				}
				elseif ($next=='<')
				{
					$T_POS=$POS-1;
					$status=STARTING_TAG;
				}
				else
				{
					if ($next=='>')
					{
						$errors[]=array('XML_TAG_CLOSE_ANOMALY');
						return array(NULL,$errors);
					}
				}
				break;
			case IN_TAG_NAME:
				$more_to_come=(!isset($special_chars[$next])) && ($POS<$LEN);
				while ($more_to_come)
				{
					$current_tag.=$next;
					$next=$OUT[$POS];
					$POS++;
					if ($next==$chr_10)
					{
						$LINENO++;
						$LINESTART=$POS;
					}
					$more_to_come=(!isset($special_chars[$next])) && ($POS<$LEN);
				}
				if (($next==' ') || ($next==$chr_10) || ($next==$chr_13))
				{
					$TAG_RANGES[]=array($T_POS+1,$POS-1,$current_tag);
					$status=IN_TAG_BETWEEN_ATTRIBUTES;
				}
				elseif ($next=='<')
				{
					$errors[]=array('XML_TAG_OPEN_ANOMALY','1');
					return array(NULL,$errors);
				}
				elseif ($next=='>')
				{
					if ($OUT[$POS-2]=='/')
					{
						$TAG_RANGES[]=array($T_POS+1,$POS-1,$current_tag);
						return _check_tag($current_tag,array(),true,$close,$errors);
					} else
					{
						$TAG_RANGES[]=array($T_POS+1,$POS-1,$current_tag);
						return _check_tag($current_tag,array(),false,$close,$errors);
					}
				}
				elseif ($next!='/') $current_tag.=$next;
				break;
			case STARTING_TAG:
				if ($next=='/') $close=true;
				elseif ($next=='<')
				{
					$errors[]=array('XML_TAG_OPEN_ANOMALY','2');
//					return array(NULL,$errors);
					// We have to assume the first < was not for a real opening tag
					$POS--;
					$status=NO_MANS_LAND;
				}
				elseif ($next=='>')
				{
					$errors[]=array('XML_TAG_CLOSE_ANOMALY','3');
//					return array(NULL,$errors);
					// We have to assume neither were for a real tag
					$status=NO_MANS_LAND;
				}
				else
				{
					$current_tag.=$next;
					$status=IN_TAG_NAME;
				}
				break;
			case IN_TAG_BETWEEN_ATTRIBUTES:
				if (($next=='/') && (isset($OUT[$POS])) && ($OUT[$POS]=='>'))
				{
					++$POS;
					return _check_tag($current_tag,$attribute_map,true,$close,$errors);
				}
				elseif ($next=='>')
				{
					return _check_tag($current_tag,$attribute_map,false,$close,$errors);
				}
				elseif (($next=='<') && (isset($OUT[$POS])) && ($OUT[$POS]=='!') && ($OUT[$POS+1]=='-') && ($OUT[$POS+2]=='-'))
				{
					$status=IN_TAG_EMBEDDED_COMMENT;
					if ($OUT[$POS+3]=='-') $errors[]=array('XHTML_WRONG_COMMENTING');
				}
				elseif ($next=='<')
				{
					$errors[]=array('XML_TAG_OPEN_ANOMALY','4');
					return array(NULL,$errors);
				}
				elseif (($next!=' ') && ($next!="\t") && ($next!=$chr_10) && ($next!=$chr_13))
				{
					$status=IN_TAG_ATTRIBUTE_NAME;
					$current_attribute_name.=$next;
				}
				break;
			case IN_TAG_ATTRIBUTE_NAME:
				$more_to_come=(!isset($special_chars[$next])) && ($POS<$LEN);
				while ($more_to_come)
				{
					$current_attribute_name.=$next;
					$next=$OUT[$POS];
					$POS++;
					if ($next==$chr_10)
					{
						$LINENO++;
						$LINESTART=$POS;
					}
					$more_to_come=(!isset($special_chars[$next])) && ($POS<$LEN);
				}

				if ($next=='=') $status=IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_RIGHT;
				elseif ($next=='<')
				{
					$errors[]=array('XML_TAG_OPEN_ANOMALY','5');
					//return array(NULL,$errors);
					// We have to assume we shouldn't REALLY have found a tag
					$POS--;
					$current_tag='';
					$status=NO_MANS_LAND;
				}
				elseif ($next=='>')
				{
					if ($GLOBALS['XML_CONSTRAIN']) $errors[]=array('XML_TAG_CLOSE_ANOMALY');
					// Things like nowrap, checked, etc
//					return array(NULL,$errors);

					if (isset($attribute_map[$current_attribute_name])) $errors[]=array('XML_TAG_DUPLICATED_ATTRIBUTES',$current_tag);
					$attribute_map[$current_attribute_name]=$current_attribute_name;
					$current_attribute_name='';
					$VALUE_RANGES[]=array($POS-1,$POS-1);
					return _check_tag($current_tag,$attribute_map,false,$close,$errors);
				}
				elseif (($next!=' ') && ($next!="\t") && ($next!=$chr_10) && ($next!=$chr_13)) $current_attribute_name.=$next;
				else $status=IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_LEFT;
				break;
			case IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_LEFT:
				if ($next=='=') $status=IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_RIGHT;
				elseif (($next!=' ') && ($next!="\t") && ($next!=$chr_10) && ($next!=$chr_13))
				{
					if ($GLOBALS['XML_CONSTRAIN']) $errors[]=array('XML_ATTRIBUTE_ERROR');
					//return array(NULL,$errors);  Actually  <blah nowrap ... />	could cause this

					$status=IN_TAG_BETWEEN_ATTRIBUTES;
					if (isset($attribute_map[$current_attribute_name])) $errors[]=array('XML_TAG_DUPLICATED_ATTRIBUTES',$current_tag);
					$attribute_map[$current_attribute_name]=$current_attribute_name;
					$current_attribute_name='';
					$VALUE_RANGES[]=array($POS-1,$POS-1);
				}
				break;
			case IN_TAG_BETWEEN_ATTRIBUTE_NAME_VALUE_RIGHT:
				if ($next=='"')
				{
					$v_pos=$POS;
					$status=IN_TAG_ATTRIBUTE_VALUE_BIG_QUOTES;
				}
				elseif (($next=='\'') && (true)) // Change to false if we want to turn off these quotes (preferred - but we can't control all input :( )
				{
					$v_pos=$POS;
					$status=IN_TAG_ATTRIBUTE_VALUE_LITTLE_QUOTES;
				}
				elseif (($next!=' ') && ($next!="\t") && ($next!=$chr_10) && ($next!=$chr_13))
				{
					if ($next=='<')
					{
						$errors[]=array('XML_TAG_OPEN_ANOMALY','6');
//						return array(NULL,$errors);
					}
					elseif ($next=='>')
					{
						$errors[]=array('XML_TAG_CLOSE_ANOMALY');
//						return array(NULL,$errors);
					}

					if ($GLOBALS['XML_CONSTRAIN']) $errors[]=array('XML_ATTRIBUTE_ERROR');
					$POS--;
					$v_pos=$POS;
					$status=IN_TAG_ATTRIBUTE_VALUE_NO_QUOTES;
				}
				break;
			case IN_TAG_ATTRIBUTE_VALUE_NO_QUOTES:
				if ($next=='>')
				{
					if (isset($attribute_map[$current_attribute_name])) $errors[]=array('XML_TAG_DUPLICATED_ATTRIBUTES',$current_tag);
					$attribute_map[$current_attribute_name]=$current_attribute_value;
					$current_attribute_value='';
					$current_attribute_name='';
					$VALUE_RANGES[]=array($v_pos,$POS-1);
					return _check_tag($current_tag,$attribute_map,false,$close,$errors);
				}
				elseif (($next==' ') || ($next=="\t") || ($next==$chr_10) || ($next==$chr_13))
				{
					$status=IN_TAG_BETWEEN_ATTRIBUTES;
					if (isset($attribute_map[$current_attribute_name])) $errors[]=array('XML_TAG_DUPLICATED_ATTRIBUTES',$current_tag);
					$attribute_map[$current_attribute_name]=$current_attribute_value;
					$current_attribute_value='';
					$current_attribute_name='';
					$VALUE_RANGES[]=array($v_pos,$POS-1);
				}
				else
				{
					if ($next=='<')
					{
						$errors[]=array('XML_TAG_OPEN_ANOMALY','7');
	//					return array(NULL,$errors);
					}

					$current_attribute_value.=$next;
				}
				break;
			case IN_TAG_ATTRIBUTE_VALUE_BIG_QUOTES:
				$more_to_come=(!isset($special_chars[$next])) && ($POS<$LEN);
				while ($more_to_come)
				{
					$current_attribute_value.=$next;
					$next=$OUT[$POS];
					$POS++;
					if ($next==$chr_10)
					{
						$LINENO++;
						$LINESTART=$POS;
					}
					$more_to_come=(!isset($special_chars[$next])) && ($POS<$LEN);
				}
				if (($next=='&') && (is_null($XHTML_VALIDATOR_OFF)))
				{
					$test=test_entity();
					if (!is_null($test)) $errors=array_merge($errors,$test);
				}

				if ($next=='"')
				{
					$status=IN_TAG_BETWEEN_ATTRIBUTES;
					if (isset($attribute_map[$current_attribute_name])) $errors[]=array('XML_TAG_DUPLICATED_ATTRIBUTES',$current_tag);
					$attribute_map[$current_attribute_name]=$current_attribute_value;
					$current_attribute_value='';
					$current_attribute_name='';
					$VALUE_RANGES[]=array($v_pos,$POS-1);
				}
				else
				{
					if ($next=='<')
					{
						$errors[]=array('XML_TAG_OPEN_ANOMALY','7');
	//					return array(NULL,$errors);
					}
					elseif ($next=='>')
					{
						$errors[]=array('XML_TAG_CLOSE_ANOMALY');
	//					return array(NULL,$errors);
					}

					$current_attribute_value.=$next;
				}
				break;
			case IN_TAG_ATTRIBUTE_VALUE_LITTLE_QUOTES:
				if ($next=='\'')
				{
					$status=IN_TAG_BETWEEN_ATTRIBUTES;
					$attribute_map[$current_attribute_name]=$current_attribute_value;
					$current_attribute_value='';
					$current_attribute_name='';
					$VALUE_RANGES[]=array($v_pos,$POS-1);
				}
				else
				{
					if ($next=='<')
					{
						$errors[]=array('XML_TAG_OPEN_ANOMALY','7');
	//					return array(NULL,$errors);
					}
					elseif ($next=='>')
					{
						$errors[]=array('XML_TAG_CLOSE_ANOMALY');
	//					return array(NULL,$errors);
					}

					$current_attribute_value.=$next;
				}
				break;
			case IN_XML_TAG:
				if (($OUT[$POS-2]=='?') && ($next=='>')) $status=NO_MANS_LAND;
				break;
			case IN_DTD_TAG: // This is a parser-directive, but we only use them for doctypes
				$doc_type.=$next;
				if ($next=='>')
				{
					if (substr($doc_type,0,8)=='!DOCTYPE')
					{
						global $THE_DOCTYPE,$TAGS_DEPRECATE_ALLOW,$FOUND_DOCTYPE,$XML_CONSTRAIN,$BLOCK_CONSTRAIN;

						$FOUND_DOCTYPE=true;
						$valid_doctypes=array(DOCTYPE_HTML,DOCTYPE_HTML_STRICT,DOCTYPE_XHTML,DOCTYPE_XHTML_STRICT,DOCTYPE_XHTML_NEW);
						$doc_type=preg_replace('#//EN"\s+"#','//EN" "',$doc_type);
						if (!in_array('<'.$doc_type,$valid_doctypes))
						{
							$errors[]=array('XHTML_DOCTYPE');
						} else
						{
							$THE_DOCTYPE='<'.$doc_type;
							if (($THE_DOCTYPE==DOCTYPE_HTML_STRICT) || ($THE_DOCTYPE==DOCTYPE_XHTML_STRICT) || ($THE_DOCTYPE==DOCTYPE_XHTML_NEW))
								$TAGS_DEPRECATE_ALLOW=false;

							if (($THE_DOCTYPE==DOCTYPE_XHTML_STRICT) || ($THE_DOCTYPE==DOCTYPE_XHTML_NEW))
								$BLOCK_CONSTRAIN=true;

							if (($THE_DOCTYPE==DOCTYPE_XHTML) || ($THE_DOCTYPE==DOCTYPE_XHTML_STRICT) || ($THE_DOCTYPE==DOCTYPE_XHTML_NEW))
								$XML_CONSTRAIN=true;
						}
					}
					$status=NO_MANS_LAND;
				}
				break;
			case IN_CDATA:
				if (($next=='>') && ($OUT[$POS-2]==']') && ($OUT[$POS-3]==']')) $status=NO_MANS_LAND;
				break;
			case IN_COMMENT:
				if (($next=='>') && ($OUT[$POS-2]=='-') && ($OUT[$POS-3]=='-'))
				{
					if ($OUT[$POS-4]=='-') $errors[]=array('XHTML_WRONG_COMMENTING');
					$status=NO_MANS_LAND;
				}
				break;
			case IN_TAG_EMBEDDED_COMMENT:
				if (($next=='>') && ($OUT[$POS-2]=='-') && ($OUT[$POS-3]=='-')) $status=IN_TAG_BETWEEN_ATTRIBUTES;
				break;
		}
	}
	if ($status!=NO_MANS_LAND)
	{
		$errors[]=array('XML_BROKEN_END');
		return array(NULL,$errors);
	}
	return NULL;
}

/**
 * Checks an XHTML tag for validity, including attributes. Return the results.
 *
 * @param  string			The name of the tag to check
 * @param  map				A map of attributes (name=>value) the tag has
 * @param  boolean		Whether this is a self-closing tag
 * @param  boolean		Whether this is a closing tag
 * @param  list			Errors detected so far. We will add to these and return
 * @return mixed			String for tag basis form, or array of error information
 */
function _check_tag($tag,$attributes,$self_close,$close,$errors)
{
	global $XML_CONSTRAIN,$LAST_TAG_ATTRIBUTES,$WELL_FORMED_ONLY,$XHTML_VALIDATOR_OFF,$MUST_SELFCLOSE_TAGS,$TAG_STACK,$ATT_STACK,$TABS_SEEN,$KEYS_SEEN,$TAG_ATTRIBUTES,$IDS_SO_FAR,$ANCESTER_BLOCK,$ANCESTER_INLINE,$EXPECTING_TAG,$OUT,$POS,$LAST_A_TAG,$TAG_RANGES;

	$ltag=strtolower($tag);
	if ($ltag!=$tag)
	{
		if ($XML_CONSTRAIN) $errors[]=array('XHTML_CASE_TAG',$tag);
		$tag=$ltag;
	}

	$LAST_TAG_ATTRIBUTES=$attributes;

	$actual_self_close=$self_close;
	if ((!$WELL_FORMED_ONLY) && (!$self_close) && (isset($MUST_SELFCLOSE_TAGS[$tag])))
	{
		$self_close=true; // Will be flagged later
	}

	if (((isset($attributes['class'])) && (in_array($attributes['class'],array('comcode_code_content','xhtml_validator_off')))) || ((isset($attributes['xmlns'])) && (strpos($attributes['xmlns'],'xhtml')===false)))
	{
		$XHTML_VALIDATOR_OFF=0;
	}

	if ((!$WELL_FORMED_ONLY) /*&& (is_null($XHTML_VALIDATOR_OFF))*/)
	{
		// Dodgy mouse events.
		if ((isset($attributes['onclick'])) && (!isset($attributes['onkeypress'])) && (!in_array($tag,array('a','input','textarea','select'))))
			$errors[]=array('WCAG_MOUSE_EVENT_UNMATCHED');
		if ((isset($attributes['onmouseover'])) && (!isset($attributes['onfocus'])) && (in_array($tag,array('a','area','button','input','label','select','textarea'))))
			$errors[]=array('WCAG_MOUSE_EVENT_UNMATCHED');
		if ((isset($attributes['onmouseout'])) && (!isset($attributes['onblur'])) && (in_array($tag,array('a','area','button','input','label','select','textarea'))))
			$errors[]=array('WCAG_MOUSE_EVENT_UNMATCHED');

		// Unexpected tags
		if ((!is_null($EXPECTING_TAG)) && ($EXPECTING_TAG!=$tag))
		{
			if ($EXPECTING_TAG=='noscript')
			{
				$errors[]=array('MANUAL_WCAG_SCRIPT');
			} else
			{
				$errors[]=array('XHTML_EXPECTING',$EXPECTING_TAG);
			}
		}
		$EXPECTING_TAG=NULL;

		// Note that we do NOT take into account display:inline, because the W3C one doesn't either - probably because 'display' implies not 'semantic'
		$tmp=_check_blockyness($tag,$attributes,$self_close,$close);
		if (!is_null($tmp)) $errors=array_merge($errors,$tmp);

		// Look for unknown attributes, or bad values
		$tmp=_check_attributes($tag,$attributes,$self_close,$close);
		if (!is_null($tmp)) $errors=array_merge($errors,$tmp);

		if (!$close)
		{
			if ($GLOBALS['MAIL_MODE'])
			{
				if (in_array($tag,array('style','object','applet','embed','form','map')))
					$errors[]=array('MAIL_BAD_TAG',$tag);
				if ($tag=='script')
					$errors[]=array('MAIL_JAVASCRIPT');
				foreach (array_keys($attributes) as $atr)
				{
					if (substr(strtolower($atr),0,2)=='on')
					{
						$errors[]=array('MAIL_JAVASCRIPT');
					}
				}
				if (($tag=='body') && (count($attributes)!=0) && ($attributes!=array('style'=>'margin: 0')))
					$errors[]=array('MAIL_BODY');
			}

			// Check all required attributes are here
			global $TAG_ATTRIBUTES_REQUIRED;
			if ((isset($TAG_ATTRIBUTES_REQUIRED[$tag])) && (($tag!='html') || ($XML_CONSTRAIN)))
			{
				$diff=array_diff($TAG_ATTRIBUTES_REQUIRED[$tag],array_keys($attributes));
				foreach ($diff as $attribute)
				{
					$errors[]=array('XHTML_MISSING_ATTRIBUTE',$tag,$attribute);
				}
			}

			// Iframes and CSS sheets need external checking
			if ($GLOBALS['VALIDATION_EXT_FILES'])
			{
				$tmp=_check_externals($tag,$attributes,$self_close,$close);
				if (!is_null($tmp)) $errors=array_merge($errors,$tmp);
			}

			// Check our links are OK
			if (($tag=='a') && (isset($attributes['href'])))
			{
				if ((substr($attributes['href'],0,5)=='mailto:') && (strpos($attributes['href'],'&')===false) && (strpos($attributes['href'],'unsubscribe')!==false)) $errors[]=array('XHTML_SPAM');
				$tmp=_check_link_accessibility($tag,$attributes,$self_close,$close);
				if (!is_null($tmp)) $errors=array_merge($errors,$tmp);
			}

			// Embed is a special case
//			if (($tag=='embed') && (!$self_close)) $EXPECTING_TAG='noembed';
	
			if (($tag=='fieldset') && (!$self_close)) $EXPECTING_TAG='legend';
		} else
		{
			if ($tag=='a') $LAST_A_TAG=$TAG_RANGES[count($TAG_RANGES)-1][1];
		}

		// Check our form labelling is OK
		$tmp=_check_labelling($tag,$attributes,$self_close,$close);
		if (!is_null($tmp)) $errors=array_merge($errors,$tmp);

		if (!$close) // Intentionally placed after labelling is checked
		{
			if (($tag=='input') || ($tag=='select'))
			{
				if (($GLOBALS['VALIDATION_MANUAL']) && (isset($attributes['name'])) && (strpos(strtolower($GLOBALS['OUT']),'privacy')===false))
				{
					$privacy=array('dob','name','age','address','date_of_birth','dateofbirth','email','e_mail','gender','salutation');
					foreach ($privacy as $priv)
					{
						if (strpos(strtolower($attributes['name']),$priv)!==false)
						{
							$errors[]=array('MANUAL_PRIVACY');
						}
					}
				}
			}

			switch ($tag)
			{
				case 'meta':
					if (($GLOBALS['VALIDATION_MANUAL']) && (isset($attributes['name'])) && ($attributes['name']=='robots'))
					{
						$errors[]=array('MANUAL_META');
					}
					if ((isset($attributes['http-equiv'])) && (isset($attributes['content'])) && (strtolower($attributes['http-equiv'])=='content-type') && ((strpos($attributes['content'],'text/html;')!==false) || (strpos($attributes['content'],'application/xhtml+xml;')!==false)) && (strpos($attributes['content'],'charset=')!==false))
					{
						$GLOBALS['FOUND_CONTENTTYPE']=true;
					}
					if ((isset($attributes['content'])) && ($attributes['content']!=''))
					{
						if ((isset($attributes['name'])) && ($attributes['name']=='keywords'))
						{
							$GLOBALS['FOUND_KEYWORDS']=true;
						}
						if ((isset($attributes['name'])) && ($attributes['name']=='description'))
						{
							$GLOBALS['FOUND_DESCRIPTION']=true;
						}
					}
					break;

				case 'blockquote':
					if ($GLOBALS['VALIDATION_MANUAL'])
					{
						$errors[]=array('MANUAL_WCAG_SEMANTIC_BLOCKQUOTE');
					}
					break;

				case 'ul':
				case 'ol':
				case 'dl':
					if ($GLOBALS['VALIDATION_MANUAL'])
					{
						$errors[]=array('MANUAL_WCAG_SEMANTIC_LIST');
					}
					break;
	
				case 'script':
					if ($GLOBALS['VALIDATION_MANUAL'])
					{
						$errors[]=array('MANUAL_WCAG_ANIMATION');
						$EXPECTING_TAG='noscript';
					}
					if (($GLOBALS['VALIDATION_JAVASCRIPT']) && ((!isset($attributes['type'])) || ((isset($attributes['type'])) && (($attributes['type']=='text/javascript') || (($attributes['type']=='application/x-javascript')))))) // Validate CSS
					{
						if (function_exists('require_code')) require_code('js_validator');
						$content=substr($OUT,$POS,strpos($OUT,'</script>',$POS)-$POS); // Whilst the </table> found may not be the closing tag to our table, we do know a <th> should occur before any such one (unless it's a really weird table layout)
						$content=preg_replace('#((<![CDATA[)|(]]>)|(<!--)|(-->))#','',$content);
						$js_validity=check_js($content,true);
						if (is_array($js_validity)) $errors=array_merge($errors,$js_validity); // Some kind of error
					}
					break;

				case 'style':
					if (($GLOBALS['VALIDATION_CSS']) && ((!isset($attributes['type'])) || ((isset($attributes['type'])) && ($attributes['type']=='text/css')))) // Validate CSS
					{
						$content=substr($OUT,$POS,strpos($OUT,'</style>',$POS)-$POS); // Whilst the </table> found may not be the closing tag to our table, we do know a <th> should occur before any such one (unless it's a really weird table layout)
						$content=preg_replace('#((<![CDATA[)|(]]>)|(<!--)|(-->))#','',$content);
						$css_validity=_validate_css_sheet($content);
						if (is_array($css_validity)) $errors=array_merge($errors,$css_validity); // Some kind of error
					}
					break;
	
				case 'area':
					global $AREA_LINKS;
					if (isset($attributes['href'])) $AREA_LINKS[@html_entity_decode($attributes['href'],ENT_QUOTES,get_charset())]=1;
					break;
	
				case 'base':
					global $URL_BASE;
					if (isset($attributes['href'])) $URL_BASE=@html_entity_decode($attributes['href'],ENT_QUOTES,get_charset());
					break;
	
				case 'form':
					if ((isset($attributes['action'])) && (strpos($attributes['action'],'?')!==false) && (isset($attributes['method'])) && ($attributes['method']=='get'))
						$errors[]=array('XHTML_FORM_TYPE');
					$GLOBALS['XHTML_FORM_ENCODING']=isset($attributes['enctype'])?$attributes['enctype']:'application/x-www-form-urlencoded';
					if ((isset($attributes['target'])) && ($attributes['target']=='_blank') && ((!isset($attributes['title'])) || (strpos($attributes['title'],do_lang('LINK_NEW_WINDOW'))===false)))
						$errors[]=array('WCAG_BLANK');
					if (($GLOBALS['XHTML_FORM_ENCODING']=='multipart/form-data') && (array_key_exists('method',$attributes)) && ($attributes['method']=='get')) $errors[]=array('XHTML_FORM_ENCODING_2');
				case 'map':
				case 'iframe':
				case 'object': // We can't check for the 'a' tag because it is rendered if given both a name and an ID
					if (isset($attributes['name']))
					{
						global $ANCHORS_SEEN;
						if (isset($ANCHORS_SEEN[$attributes['name']]))
						{
							$errors[]=array('XHTML_A_NAME',$tag);
						} else $ANCHORS_SEEN[$attributes['name']]=1;
		
						if ((!isset($attributes['id'])) || ((isset($attributes['id'])) && ($attributes['id']!=$attributes['name'])))
							$errors[]=array('XHTML_NAME_ID_DEPRECATED');
					}// elseif ((isset($attributes['id'])) && (!isset($attributes['href']))) $errors[]=array('XHTML_NAME_ID_DEPRECATED');
					break;

				case 'input':
					if (isset($attributes['type']))
					{
						// Special case for missing 'name' in form elements
						if (($attributes['type']!='image') && ($attributes['type']!='submit') && ($attributes['type']!='button') && ($attributes['type']!='reset'))
						{
							if (!isset($attributes['name'])) $errors[]=array('XHTML_MISSING_ATTRIBUTE',$tag,'name');
						}
	
						if (($attributes['type']=='image') && (!isset($attributes['alt'])))
						{
							$errors[]=array('XHTML_MISSING_ATTRIBUTE','input','alt');
						}

						if ($attributes['type']=='file')
						{
							if (isset($attributes['value'])) $errors[]=array('XHTML_FILE_VALUE');
							if (($GLOBALS['XHTML_FORM_ENCODING']!='multipart/form-data') && ($GLOBALS['XHTML_FORM_ENCODING']!='')) $errors[]=array('XHTML_FORM_ENCODING');
						}
						elseif (($attributes['type']=='text') && (!isset($attributes['value'])))
							$errors[]=array('XHTML_MISSING_ATTRIBUTE',$tag,'value');
					}
					break;
	
				case 'select':
					if ((isset($attributes['onchange'])) && (strpos($attributes['onchange'],'form.submit()')!==false))
						$errors[]=array('WCAG_AUTO_SUBMIT_LIST');
					break;
	
				case 'table':
					if ((isset($attributes['summary'])) && (($attributes['summary']==do_lang('SPREAD_TABLE')) || ($attributes['summary']==do_lang('MAP_TABLE'))))
					{
						$content=strtolower(substr($OUT,$POS,strpos($OUT,'</table>',$POS)-$POS)); // Whilst the </table> found may not be the closing tag to our table, we do know a <th> should occur before any such one (unless it's a really weird table layout)
						$th_count=substr_count($content,'<th');
						if (($th_count==0) && (trim($content)!='x')) $errors[]=array('WCAG_MISSING_TH');
						else
						{
							if (strpos($content,'<thead')===false)
							{
								$tr_count=substr_count($content,'<tr');
								if ($th_count>$tr_count) $errors[]=array('WCAG_HD_SPECIAL');
							}
						}
					}
					break;
	
				case 'thead':
					$array_pos=array_search('table',array_reverse($TAG_STACK));
					if ($array_pos!==false) $array_pos=count($TAG_STACK)-$array_pos-1;
					if (($array_pos!==false) && (isset($ATT_STACK[$array_pos]['summary'])) && ($ATT_STACK[$array_pos]['summary']==''))
						$errors[]=array('WCAG_BAD_LAYOUT_TABLE');
					break;
	
				case 'tfoot':
					$array_pos=array_search('table',array_reverse($TAG_STACK));
					if ($array_pos!==false) $array_pos=count($TAG_STACK)-$array_pos-1;
					if (($array_pos!==false) && (isset($ATT_STACK[$array_pos]['summary'])) && ($ATT_STACK[$array_pos]['summary']==''))
						$errors[]=array('WCAG_BAD_LAYOUT_TABLE');
					break;
	
				case 'th':
					$array_pos=array_search('table',array_reverse($TAG_STACK));
					if ($array_pos!==false) $array_pos=count($TAG_STACK)-$array_pos-1;
					if (($array_pos!==false) && (isset($ATT_STACK[$array_pos]['summary'])) && ($ATT_STACK[$array_pos]['summary']==''))
						$errors[]=array('WCAG_BAD_LAYOUT_TABLE');
	
					if (!isset($attributes['abbr']))
					{
						$content=trim(substr($OUT,$POS,strpos($OUT,'</th>',$POS)-$POS)); // This isn't perfect - In theory a th could contain a table itself: but it's not very semantic if it does
						if (strlen(@html_entity_decode(strip_tags($content),ENT_QUOTES,get_charset()))>40) $errors[]=array('WCAG_TH_TOO_LONG');
					}
					break;

				case 'a':
					// Handle empty tag check for <a> (couldn't handle with normal case due to complexity)
					if ((!isset($attributes['name'])) && (substr($OUT,$POS,4)=='</a>'))
						$errors[]=array('XHTML_EMPTY_TAG',$tag);
					break;

				case 'img':
					if (($GLOBALS['VALIDATION_MANUAL']) && (!isset($attributes['width'])))
					{
						$errors[]=array('XHTML_WIDTH');
					}
					if ((isset($attributes['longdesc'])) && (!isset($attributes['dlink'])))
					{
						$errors[]=array('WCAG_LONGTEXT_DLINK');
					}
					if ((isset($attributes['alt'])) && (isset($attributes['src'])) && ($attributes['alt']==$attributes['src']))
					{
						$errors[]=array('XHTML_MISSING_ATTRIBUTE','img','alt');
					}
					if ((isset($attributes['alt'])) && ($attributes['alt']!='') && ((!isset($attributes['width'])) || ($attributes['width']!='1')) && (!isset($attributes['title'])))
					{
						$errors[]=array('XHTML_IE_COMPAT_TITLE');
					}
					break;
			}
	
			/*if (($tag[0]=='h') && (is_numeric(substr($tag,1))))	 Excessive check
			{
				global $LAST_HEADING;
				if ($LAST_HEADING<intval(substr($tag,1))-1) $errors[]=array('WCAG_HEADING_ORDER');
				$LAST_HEADING=intval(substr($tag,1));
			}*/
	
			if (isset($attributes['accesskey']))
			{
				$this_href=isset($attributes['href'])?$attributes['href']:uniqid('');
				if ((isset($KEYS_SEEN[$attributes['accesskey']])) && ($KEYS_SEEN[$attributes['accesskey']]!=$this_href)) $errors[]=array('WCAG_ACCESSKEY_UNIQUE');
				$KEYS_SEEN[$attributes['accesskey']]=$this_href;
			}
			if (isset($attributes['tabindex']))
			{
				if ((in_array($attributes['tabindex'],$TABS_SEEN)) && ($attributes['tabindex']!='x'))
				{
					$last=array_pop($TABS_SEEN);
					if ($last!=$attributes['tabindex']) // We do allow repeating of tabindexes as long as they are next to each other
					{
						$errors[]=array('WCAG_TABINDEX_UNIQUE');
					} else
					{
						array_push($TABS_SEEN,$last);
					}
				}
				$TABS_SEEN[]=$attributes['tabindex'];
			}
		}
	}

	if ($XHTML_VALIDATOR_OFF>0) $errors=array();
	return array('<'.($close?'/':'').$tag.($actual_self_close?'/':'').'>',$errors);
}

/**
 * Checks a tag's inline/block/normal nesting situations.
 *
 * @param  string			The name of the tag to check
 * @param  map				A map of attributes (name=>value) the tag has
 * @param  boolean		Whether this is a self-closing tag
 * @param  boolean		Whether this is a closing tag
 * @return ?list			Array of errors (NULL: none)
 */
function _check_blockyness($tag,$attributes,$self_close,$close)
{
	unset($attributes);

	global $THE_DOCTYPE,$BLOCK_CONSTRAIN,$XML_CONSTRAIN,$TAGS_DEPRECATE_ALLOW,$PARENT_TAG,$TAGS_INLINE,$TAGS_BLOCK,$TAGS_NORMAL,$TAGS_INLINE_DEPRECATED,$TAGS_BLOCK_DEPRECATED,$TAGS_NORMAL_DEPRECATED,$TAG_ATTRIBUTES,$IDS_SO_FAR,$ANCESTER_BLOCK,$ANCESTER_INLINE,$EXPECTING_TAG,$OUT,$POS,$LAST_A_TAG;

	$errors=array();

	$dif=$close?-1:1;
	if ($self_close) $dif=0;
	if ((isset($TAGS_BLOCK[$tag])) || (isset($TAGS_BLOCK_DEPRECATED[$tag])))
	{
		if (($ANCESTER_INLINE!=0) && ($BLOCK_CONSTRAIN)) $errors[]=array('XHTML_ANCESTER_BLOCK_INLINE',$tag);
		$ANCESTER_BLOCK+=$dif;
		if (isset($TAGS_BLOCK_DEPRECATED[$tag])) $errors[]=array($TAGS_DEPRECATE_ALLOW?'XHTML_DEPRECATED_TAG':'XHTML_UNKNOWN_TAG',$tag);
	}
	elseif ((isset($TAGS_INLINE[$tag])) || (isset($TAGS_INLINE_DEPRECATED[$tag])))
	{
		//if (($BLOCK_CONSTRAIN) && ($PARENT_TAG!='span') && ((isset($TAGS_NORMAL[$PARENT_TAG])) || ((isset($TAGS_NORMAL_DEPRECATED[$PARENT_TAG]))))) $errors[]=array('XHTML_ANCESTER_INLINE_NORMAL',$tag);
		if ($tag!='label') $ANCESTER_INLINE+=$dif;
		if (isset($TAGS_INLINE_DEPRECATED[$tag])) $errors[]=array($TAGS_DEPRECATE_ALLOW?'XHTML_DEPRECATED_TAG':'XHTML_UNKNOWN_TAG',$tag);
	}
	elseif ((isset($TAGS_NORMAL[$tag])) || (isset($TAGS_NORMAL_DEPRECATED[$tag])))
	{
		if ($tag=='title') $ANCESTER_BLOCK+=$dif;
		if (($tag=='iframe') && (($THE_DOCTYPE==DOCTYPE_XHTML_STRICT) || ($THE_DOCTYPE==DOCTYPE_XHTML_NEW))) $errors[]=array('XHTML_UNKNOWN_TAG',$tag);
		if (isset($TAGS_NORMAL_DEPRECATED[$tag])) $errors[]=array($TAGS_DEPRECATE_ALLOW?'XHTML_DEPRECATED_TAG':'XHTML_UNKNOWN_TAG',$tag);
	} elseif (!$close)
	{
		$errors[]=array('XHTML_UNKNOWN_TAG',$tag);
	}

	return ($errors==array())?NULL:$errors;
}

/**
 * Checks a tag's attributes.
 *
 * @param  string			The name of the tag to check
 * @param  map				A map of attributes (name=>value) the tag has
 * @param  boolean		Whether this is a self-closing tag
 * @param  boolean		Whether this is a closing tag
 * @return ?list			Array of errors (NULL: none)
 */
function _check_attributes($tag,$attributes,$self_close,$close)
{
	//unset($self_close);
	//unset($close);

	global $PSPELL_LINK,$THE_LANGUAGE,$XML_CONSTRAIN,$TAGS_DEPRECATE_ALLOW,$THE_DOCTYPE,$HYPERLINK_URLS,$CRAWLED_URLS,$EMBED_URLS,$TAGS_INLINE,$TAGS_BLOCK,$TAGS_NORMAL,$TAGS_INLINE_DEPRECATED,$TAGS_BLOCK_DEPRECATED,$TAGS_NORMAL_DEPRECATED,$TAG_ATTRIBUTES,$TAG_ATTRIBUTES_DEPRECATED,$IDS_SO_FAR,$ANCESTER_BLOCK,$ANCESTER_INLINE,$EXPECTING_TAG,$OUT,$POS,$LAST_A_TAG,$TAG_ATTRIBUTES_REQUIRED;

	$errors=array();

	$stub=$tag.'.';
	foreach ($attributes as $attribute=>$value)
	{
		$lattribute=strtolower($attribute);
		if ($lattribute!=$attribute)
		{
			if ($XML_CONSTRAIN) $errors[]=array('XHTML_CASE_ATTRIBUTE',$tag,$attribute);
			$attribute=$lattribute;
		}

		if (($attribute=='lang') || ($attribute=='xml:lang'))
		{
			$THE_LANGUAGE=$value;
		}

		if (($value=='TODO') || (strpos($value,'Lorum ')!==false)) $errors[]=array('XHTML_PLACEHOLDER');

		if ((!isset($TAG_ATTRIBUTES[$stub.$attribute])) && (!isset($TAG_ATTRIBUTES_REQUIRED[$stub.$attribute])))
		{
			if ((!isset($TAGS_BLOCK[$tag])) && (!isset($TAGS_INLINE[$tag])) && (!isset($TAGS_NORMAL[$tag]))) continue;
			if ((!isset($TAGS_BLOCK_DEPRECATED[$tag])) && (!isset($TAGS_INLINE_DEPRECATED[$tag])) && (!isset($TAGS_NORMAL_DEPRECATED[$tag]))) continue;
			if (strpos($attribute,':')!==false) continue;

			//if ($tag=='embed') continue; // Hack, to allow rich media to work in multiple browsers
			$errors[]=array('XHTML_UNKNOWN_ATTRIBUTE',$tag,$attribute);
			continue;
		} else
		{
			if (isset($TAG_ATTRIBUTES_REQUIRED[$stub.$attribute])) $errors[]=array($TAGS_DEPRECATE_ALLOW?'XHTML_DEPRECATED_ATTRIBUTE':'XHTML_UNKNOWN_ATTRIBUTE',$tag,$attribute);

			if (($attribute=='target') && (($THE_DOCTYPE==DOCTYPE_XHTML_STRICT) || ($THE_DOCTYPE==DOCTYPE_XHTML_NEW)))
				$errors[]=array('XHTML_UNKNOWN_ATTRIBUTE',$tag,$attribute);
		}

		if ((($attribute=='alt') || ($attribute=='title') || (($attribute=='content') && (array_key_exists('http-equiv',$attributes)) && ((strtolower($attributes['http-equiv'])=='description') || (strtolower($attributes['http-equiv'])=='keywords'))) || ($attribute=='summary')) && (function_exists('pspell_new')) && (isset($GLOBALS['SPELLING'])) && ($value!=''))
		{
			$_value=@html_entity_decode($value,ENT_QUOTES,get_charset());
			$errors=array_merge($errors,validate_spelling($_value));
		}

		if (($attribute=='alt') && ($tag!='input') && (strlen(strip_tags($value))>150)) $errors[]=array('WCAG_ATTRIBUTE_TOO_LONG',$attribute);

		if (($attribute=='href') || ($attribute=='src') || (($attribute=='data') && ($tag=='object')))
		{
			$CRAWLED_URLS[]=@html_entity_decode($value,ENT_QUOTES,get_charset());
			if ($tag=='a') $HYPERLINK_URLS[]=@html_entity_decode($value,ENT_QUOTES,get_charset());
		}
		if ((($attribute=='src') && ($tag=='embed')) || (($attribute=='src') && ($tag=='script')) || (($attribute=='src') && ($tag=='iframe')) || (($attribute=='src') && ($tag=='img')) || (($attribute=='href') && ($tag=='link') && (isset($attributes['rel'])) && ($attributes['rel']=='stylesheet')) || (($attribute=='data') && ($tag=='object')) || (($attribute=='code') && ($tag=='applet')))
		{
			$EMBED_URLS[]=@html_entity_decode($value,ENT_QUOTES,get_charset());
		}

		if (($attribute=='href') && (@strtolower(@$value[0])=='j') && (strtolower(substr($value,0,11))=='javascript:'))
			$errors[]=array('XHTML_BAD_ATTRIBUTE_VALUE',$attribute,$value,'no js href');

		$reg_exp=$TAG_ATTRIBUTES[$stub.$attribute];

		if (($reg_exp!='(.|\n)*') && (preg_match('#^'.$reg_exp.'$#',$value)==0) && ($value!='x')) $errors[]=array('XHTML_BAD_ATTRIBUTE_VALUE',$attribute,$value,$reg_exp);

		if (($attribute=='style') && ($GLOBALS['VALIDATION_CSS'])) // Validate CSS
		{
			if ((!function_exists('do_template')) && (strpos($value,'{')===false) && (strpos($value,'float:')===false) && (strpos($value,': none')===false) && (strpos($value,': inline')===false) && (strpos($value,': block')===false))
				$errors[]=array('CSS_INLINE_STYLES');

			$css_validity=_validate_css_class($value,0);
			if (is_array($css_validity)) $errors=array_merge($errors,$css_validity); // Some kind of error
		}

		if ($attribute=='id') // Check we don't have duplicate ID's
		{
			if (isset($IDS_SO_FAR[strtolower($value)])) // strtolower is for IE - in reality, IDs are not meant to be case insensitive
			{
				$errors[]=array('XHTML_DUPLICATED_ID',strval($value));
			}
			$IDS_SO_FAR[strtolower($value)]=1;
		}
	}
	
	return ($errors==array())?NULL:$errors;
}

/**
 * Checks the spelling of some text.
 *
 * @param  string			The text
 * @return list			Array of errors
 */
function validate_spelling($value)
{
	global $THE_LANGUAGE,$PSPELL_LINK;

	$lang=strtolower($THE_LANGUAGE);
	$sub_lang='';
	/*if ($lang=='en')
	{
		$sub_lang='british';
	}*/
	if (is_null($PSPELL_LINK)) $PSPELL_LINK=@pspell_new($lang,$sub_lang,'','',PSPELL_FAST);
	if ($PSPELL_LINK===false) return array();
	$words=array();
	$errors=array();
	$num_matches=preg_match_all("/[A-Z\']{1,16}/i",$value,$words);
	for ($i=0;$i<$num_matches;$i++)
	{
		if (strtoupper($words[0][$i])==$words[0][$i]) continue;
		if (strlen($words[0][$i])==1) continue;
		$words[0][$i]=trim($words[0][$i],"'");
		if (!pspell_check($PSPELL_LINK,$words[0][$i]))
			$errors[]=array('XHTML_SPELLING',$words[0][$i]);
	}
	return $errors;
}

/**
 * Checks the content under a tag's external references.
 *
 * @param  string			The name of the tag to check
 * @param  map				A map of attributes (name=>value) the tag has
 * @param  boolean		Whether this is a self-closing tag
 * @param  boolean		Whether this is a closing tag
 * @return ?list			Array of errors (NULL: none)
 */
function _check_externals($tag,$attributes,$self_close,$close)
{
	if ((function_exists('get_param_integer')) && (get_param_integer('keep_no_ext_check',0)==1)) return NULL;

	unset($self_close);
	unset($close);

	global $VALIDATED_ALREADY,$TAG_ATTRIBUTES,$IDS_SO_FAR,$ANCESTER_BLOCK,$ANCESTER_INLINE,$EXPECTING_TAG,$OUT,$POS,$LAST_A_TAG;

	$errors=array();

	if (($tag=='link') && ($GLOBALS['VALIDATION_CSS']) && ($GLOBALS['NO_XHTML_LINK_FOLLOW']==0) && (isset($attributes['href'])) && (isset($attributes['type'])) && ($attributes['type']=='text/css') && (!isset($VALIDATED_ALREADY[$attributes['href']]))) // Validate CSS
	{
		$VALIDATED_ALREADY[$attributes['href']]=1;
		$url=qualify_url($attributes['href'],$GLOBALS['URL_BASE']);
		if ($url!='')
		{
			$sheet=http_download_file($url,NULL,false);
			if (!is_null($sheet))
			{
				$css_validity=_validate_css_sheet($sheet);
				if (is_array($css_validity)) $errors=array_merge($errors,$css_validity); // Some kind of error
			}
		}
	}

	if (($GLOBALS['VALIDATION_JAVASCRIPT']) && ($tag=='script') && ($GLOBALS['NO_XHTML_LINK_FOLLOW']==0) && (isset($attributes['src'])) && (isset($attributes['type'])) && (($attributes['type']=='text/javascript') || ($attributes['type']=='application/x-javascript')) && (!isset($VALIDATED_ALREADY[$attributes['src']]))) // Validate CSS
	{
		$VALIDATED_ALREADY[$attributes['src']]=1;
		$url=qualify_url($attributes['src'],$GLOBALS['URL_BASE']);
		if ($url!='')
		{
			$js=http_download_file($url,NULL,false);
			if (!is_null($js))
			{
				$js=convert_to_internal_encoding($js);

				$VALIDATED_ALREADY[$attributes['src']]=1;

				if (function_exists('require_code')) require_code('js_validator');
				$js_validity=check_js($js,true);
				if (is_array($js_validity)) $errors=array_merge($errors,$js_validity); // Some kind of error
			}
		}
	}

	if (($tag=='iframe') && (isset($attributes['src'])) && ($attributes['src']!='') && ($GLOBALS['NO_XHTML_LINK_FOLLOW']==0) && (!isset($VALIDATED_ALREADY[$attributes['src']]))) // Validate iframe's
	{
		$VALIDATED_ALREADY[$attributes['src']]=1;
		$url=qualify_url($attributes['src'],$GLOBALS['URL_BASE']);
		if ($url!='')
		{
			$iframe=http_download_file($url,NULL,false);			 //	 Sometimes disabled due to my iframe producing a weird PHP exception, that was stopping me working
			if ((!is_null($iframe)) && ($iframe!=''))
			{
				$iframe=convert_to_internal_encoding($iframe);

				global $HTTP_DOWNLOAD_MIME_TYPE;
				if (($HTTP_DOWNLOAD_MIME_TYPE=='text/html') || ($HTTP_DOWNLOAD_MIME_TYPE=='application/xhtml+xml'))
				{
					global $EXTRA_CHECK;
					$EXTRA_CHECK[]=$iframe;
				}
			}
		}
	}

	return ($errors==array())?NULL:$errors;
}

/**
 * Checks link accessibility.
 *
 * @param  string			The name of the tag to check
 * @param  map				A map of attributes (name=>value) the tag has
 * @param  boolean		Whether this is a self-closing tag
 * @param  boolean		Whether this is a closing tag
 * @return ?list			Array of errors (NULL: none)
 */
function _check_link_accessibility($tag,$attributes,$self_close,$close)
{
	//unset($self_close);

	global $TAG_ATTRIBUTES,$IDS_SO_FAR,$ANCESTER_BLOCK,$ANCESTER_INLINE,$EXPECTING_TAG,$OUT,$POS,$LAST_A_TAG,$TAG_RANGES;

	$errors=array();

	// Check positioning - not anymore "until user agents"
	/*if ((!is_null($LAST_A_TAG)) && (isset($attributes['href'])))
	{
		$between=substr($OUT,$LAST_A_TAG+1,$TAG_RANGES[count($TAG_RANGES)-1][0]-$LAST_A_TAG-2);
		$between=str_replace('&nbsp;',' ',$between);
		$between=strip_tags($between,'<li><td><img><hr><br><p><th>');
		if (trim($between)=='') $errors[]=array('WCAG_ADJACENT_LINKS');
	}*/

	// Check captioning
	global $A_LINKS;
	if (!isset($attributes['title'])) $title=''; else $title=$attributes['title'];
	$content=strtolower(substr($OUT,$POS,strpos($OUT,'</a>',$POS)-$POS));
	if ((isset($attributes['target'])) && ($attributes['target']=='_blank') && (strpos($content,do_lang('LINK_NEW_WINDOW'))===false) && (strpos($title,do_lang('LINK_NEW_WINDOW'))===false))
		$errors[]=array('WCAG_BLANK');
	if (substr($content,0,4)!='<img')
	{
		$filtered_href=str_replace('/index.php','',$attributes['href']);
		$filtered_href=preg_replace('#&keep_session=[^&]*#','',$filtered_href);

		if ((isset($A_LINKS[$title])) && (isset($A_LINKS[$title][$content])) && ($A_LINKS[$title][$content]!=$attributes['href']) && ($A_LINKS[$title][$content]!=$filtered_href))
			$errors[]=array('WCAG_DODGY_LINK',$A_LINKS[$title][$content]);
		$bad_strings=array('click','here');
		$_content=strip_tags($content);
		if (($GLOBALS['VALIDATION_COMPAT']) && (trim($_content)!=$_content)) $errors[]=array('XHTML_A_SPACES');
		if (($_content==$content) && (strlen($content)<12))
		{
			$in_strings=str_word_count($_content,1);
			foreach ($bad_strings as $string)
			{
				if (in_array($string,$in_strings)!==false) $errors[]=array('WCAG_DODGY_LINK_2',$string);
			}
		}
		//if ((strlen(@html_entity_decode($_content,ENT_QUOTES,get_charset()))>40) && (isset($attributes['href'])) && (strpos($attributes['href'],'tut_')===false)) $errors[]=array('WCAG_ATTRIBUTE_TOO_LONG','a');
		if ($title=='')
		{
			if (strtolower($content)=='more') $errors[]=array('WCAG_DODGY_LINK_2',$string);
		}
		$A_LINKS[$title][$content]=$filtered_href;
	}

	return ($errors==array())?NULL:$errors;
}

/**
 * Checks form field labelling.
 *
 * @param  string			The name of the tag to check
 * @param  map				A map of attributes (name=>value) the tag has
 * @param  boolean		Whether this is a self-closing tag
 * @param  boolean		Whether this is a closing tag
 * @return ?list			Array of errors (NULL: none)
 */
function _check_labelling($tag,$attributes,$self_close,$close)
{
	unset($self_close);

	global $TAG_STACK,$TAG_ATTRIBUTES,$IDS_SO_FAR,$ANCESTER_BLOCK,$ANCESTER_INLINE,$EXPECTING_TAG,$OUT,$POS,$LAST_A_TAG;

	$errors=array();

	global $FOR_LABEL_IDS,$FOR_LABEL_IDS_2,$INPUT_TAG_IDS;
	if (($tag=='td')/* || ($tag=='div')*/)
	{
		$FOR_LABEL_IDS=array(); // Can't work across table cells
	}
	if (($tag=='label') && (isset($attributes['for'])))
	{
		$FOR_LABEL_IDS[$attributes['for']]=1;
		$FOR_LABEL_IDS_2[$attributes['for']]=1;
	}
	// Check we that all input tags have labels
	elseif ((!$close) && (($tag=='textarea') || ($tag=='select') || (($tag=='input') && ((!isset($attributes['type'])) || (($attributes['type']!='hidden') && ($attributes['type']!='button') && ($attributes['type']!='image') && ($attributes['type']!='reset') && ($attributes['type']!='submit'))))))
	{
		if (isset($attributes['id'])) $INPUT_TAG_IDS[$attributes['id']]=1;

		if ((!isset($attributes['style'])) || (($attributes['style']!='display:none') && ($attributes['style']!='display: none')))
		{
			if ($tag=='input')
			{
				if (!isset($attributes['type'])) return NULL;
	
				if ((($attributes['type']=='radio') || ($attributes['type']=='checkbox')) && (isset($attributes['onchange'])) && ($GLOBALS['VALIDATION_COMPAT']))
					$errors[]=array('XHTML_IE_ONCHANGE');
			}
	
	//		if ((!in_array('label',$TAG_STACK)) )//&& ((!isset($attributes['value']) || ($attributes['value']=='')))) // Compromise - sometimes we will use a default value as a substitute for a label. Not strictly allowed in accessibility rules, but writers mention as arguably ok (+ we need it so we don't clutter things unless we start hiding labels, which is not nice)
			{
				if (!isset($attributes['id'])) $attributes['id']='unnamed_'.strval(mt_rand(0,10000));
	
				if ((!isset($FOR_LABEL_IDS[$attributes['id']])) && ($attributes['id']!='x'))
				{
					$errors[]=array('WCAG_NO_INPUT_LABEL',$attributes['id']);
				}
			}
		}
	}

	return ($errors==array())?NULL:$errors;
}

/**
 * Get the tag basis for the specified tag. e.g. '<br />' would become 'br'. Note: tags with parameters given are not supported.
 *
 * @param  string			The full tag
 * @return string			The basis of the tag
 */
function _get_tag_basis($full)
{
	$full=preg_replace('#[/ <>]#','',$full);

	return $full;
}

/**
 * Checks a CSS style sheet (high level).
 *
 * @param  string			The data of the style sheet
 * @return ?map			Error information (NULL: no error)
 */
function check_css($data)
{
	if (!isset($GLOBALS['MAIL_MODE'])) $GLOBALS['MAIL_MODE']=false;
	$_errors=_validate_css_sheet($data);
	if (is_null($_errors)) $_errors=array();
	$errors=array();
	global $POS,$OUT;
	global $CSS_TAG_RANGES,$CSS_VALUE_RANGES;
	$OUT=$data;

	foreach ($_errors as $error)
	{
		$POS=0;
		$errors[]=_xhtml_error($error[0],array_key_exists(1,$error)?$error[1]:'',array_key_exists(2,$error)?$error[2]:'',array_key_exists(3,$error)?$error[3]:'',false,$error['pos']);
	}
	return array('level_ranges'=>NULL,'tag_ranges'=>$CSS_TAG_RANGES,'value_ranges'=>$CSS_VALUE_RANGES,'errors'=>$errors);
}

/**
 * Checks a CSS style sheet.
 *
 * @param  string			The data of the style sheet
 * @return ?map			Error information (NULL: no error)
 */
function _validate_css_sheet($data)
{
	global $CSS_TAG_RANGES,$CSS_VALUE_RANGES,$VALIDATED_ALREADY;
	$CSS_TAG_RANGES=array();
	$CSS_VALUE_RANGES=array();

	$errors=array();

	$len=strlen($data);
	$status=CSS_NO_MANS_LAND;
	$line=0;
	$class_before_comment=NULL;
	$class='';
	$at_rule='';
	$at_rule_block='';
	//$left_no_mans_land_once=false;
	$brace_level=0;
	$i=0;
	$class_start_line=NULL;
	$class_start_i=NULL;
	$class_name='';
	$in_comment=false;
	$quoting=false;
	while ($i<$len)
	{
		$next=$data[$i];
		$val=ord($next);
		if (($next=='_') || ($next=='.') || ($next=='-') || (($val>=65) && ($val<=90)) || (($val>=97) && ($val<=122)) || (($val>=48) && ($val<=57)))
		{
			$alpha_numeric=true;
			$whitespace=false;
			$comment_starting=false;
		} else
		{
			$alpha_numeric=false;
			$whitespace=(($next=="\t") || ($val==13) || ($val==10) || ($next==' '));
			$comment_starting=(($next=='/') && ($i<$len-2) && ($data[$i+1]=='*'));
		}

		switch ($status)
		{
			case CSS_AT_RULE:
				if ($next=='{')
				{
					$brace_level=0;
					$status=CSS_AT_RULE_BLOCK;
					$at_rule_block='';
				}
				elseif ($next==';')
				{
					$status=CSS_NO_MANS_LAND;
					if (substr($at_rule,0,6)=='import ')
					{
						$count=substr_count($at_rule,'"');
						$first=strpos($at_rule,'"')+1;
						if ($count<2)
						{
							$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER',1=>$next,2=>number_format($line),'pos'=>$i);
							return $errors;
						}
						$at_file=substr($at_rule,$first,(strpos($at_rule,'"',$first)-1)-$first);
						if (!isset($VALIDATED_ALREADY[$at_file]))
						{
							$at_file=qualify_url($at_file,$GLOBALS['URL_BASE']);
							if ($at_file!='')
							{
								$data2=http_download_file($at_file,NULL,false);
								if (!is_null($data2))
								{
									$css_tag_ranges_backup=$CSS_TAG_RANGES;
									$css_value_ranges_backup=$CSS_VALUE_RANGES;
									$test=_validate_css_sheet($data2);
									$CSS_TAG_RANGES=$css_tag_ranges_backup;
									$CSS_VALUE_RANGES=$css_value_ranges_backup;
									if (is_array($test))
									{
										foreach ($test as $error)
										{
											$error['pos']=$i;
											$errors[]=$error;
										}
									}
								}
							}
						}
					}
				} else $at_rule.=$next;
				break;

			case CSS_AT_RULE_BLOCK:
				if ($next=='{')
				{
					++$brace_level;
					$at_rule_block.=$next;
				}
				elseif (($next=='}') && ($brace_level==0))
				{
					$status=CSS_NO_MANS_LAND;
					if (substr($at_rule,0,6)=='media ')
					{
						$css_tag_ranges_backup=$CSS_TAG_RANGES;
						$css_value_ranges_backup=$CSS_VALUE_RANGES;
						$test=_validate_css_sheet($at_rule_block);
						$CSS_TAG_RANGES=$css_tag_ranges_backup;
						$CSS_VALUE_RANGES=$css_value_ranges_backup;
						if (is_array($test))
						{
							foreach ($test as $error)
							{
								$error['pos']=$i;
								$errors[]=$error;
							}
						}
					}
				}
				elseif ($next=='}')
				{
					$brace_level--;
					$at_rule_block.=$next;
				} else $at_rule_block.=$next;
				break;

			case CSS_NO_MANS_LAND:
				if ($whitespace)
				{
					// Continuing
				}
				elseif (($next=='.') || ($next=='#') || ($alpha_numeric))
				{
					$status=CSS_IN_CLASS_NAME;
					$class_name='';
					//$left_no_mans_land_once=true;
				}
				elseif ($next=='@')
				{
					$status=CSS_AT_RULE;
					$at_rule='';
				}
				elseif ($comment_starting)
				{
					$status=CSS_IN_COMMENT;
					$class_before_comment=CSS_NO_MANS_LAND;
				}
				elseif ($next=='*')
				{
					$status=CSS_IN_CLASS_NAME;
					$class_name='*';
					//$left_no_mans_land_once=true;
				}
				else
				{
					$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER',1=>$next,2=>number_format($line),'pos'=>$i);
//					return $errors;
				}
				break;

			case CSS_EXPECTING_CLASS_NAME:
				if ($comment_starting)
				{
					$status=CSS_IN_COMMENT;
					$class_before_comment=CSS_EXPECTING_CLASS_NAME;
				}
				elseif ($whitespace)
				{
					// Continuing
				}
				elseif ($next=='*')
				{
					$status=CSS_IN_CLASS_NAME;
					$class_name='*';
				}
				elseif (($next=='.') || ($next=='#') || ($alpha_numeric))
				{
					$status=CSS_IN_CLASS_NAME;
					$class_name=$alpha_numeric?$next:'';
				}
				else
				{
					$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER',1=>$next,2=>number_format($line),'pos'=>$i);
//					return $errors;
				}
				break;

			case CSS_IN_COMMENT:
				if (($next=='*') && ($i!=$len-2) && ($data[$i+1]=='/'))
				{
					$status=$class_before_comment;
					++$i;
				}
				break;

			case CSS_IN_CLASS_NAME:
				if (($alpha_numeric) || ($next==':') || ($next=='#'))
				{
					$class_name.=$next;
				} else
				{
					// Test class name
					$cnt=substr_count($class_name,':');
					if ($cnt>0)
					{
						$pseudo=substr($class_name,strpos($class_name,':')+1);
						if (($GLOBALS['VALIDATION_COMPAT']) && (!in_array($pseudo,array('active','hover','link','visited','first-letter','first-line'))))
							$errors[]=array(0=>'CSS_BAD_PSEUDO_CLASS',1=>$pseudo,'pos'=>$i);
					}

					if ($whitespace)
					{
						$status=CSS_EXPECTING_SEP_OR_CLASS_NAME_OR_CLASS;
					}
					elseif ($next=='>')
					{
						$status=CSS_EXPECTING_CLASS_NAME;
						if ($GLOBALS['VALIDATION_COMPAT']) $errors[]=array(0=>'CSS_BAD_SELECTOR',1=>'>','pos'=>$i);
					}
					elseif ($next==',')
					{
						$status=CSS_EXPECTING_CLASS_NAME;
					}
					elseif ($next=='{')
					{
						$status=CSS_IN_CLASS;
						$class_start_line=$line;
						$class_start_i=$i;
						$class='';
					}
					else
					{
						$matches=array();
						if (($next=='[') && (preg_match('#\[(\w+|)?\w+([$*~|^]?="[^;"]*")?\]#',substr($data,$i,50),$matches)))
						{
							if ($GLOBALS['VALIDATION_COMPAT']) $errors[]=array(0=>'CSS_BAD_SELECTOR',1=>'(attribute-selectors)','pos'=>$i);
							$i+=strlen($matches[0])-1;
						} else
						{
							$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER',1=>$next,2=>number_format($line),'pos'=>$i);
		//					return $errors;
						}
					}
				}
				break;

			case CSS_EXPECTING_SEP_OR_CLASS_NAME_OR_CLASS:
				if ($next=='{')
				{
					$status=CSS_IN_CLASS;
					$class_start_line=$line;
					$class_start_i=$i;
					$class='';
				}
				elseif (($whitespace) || ($next=='*'))
				{
					// Continuing
				}
				elseif ($comment_starting)
				{
					$status=CSS_IN_COMMENT;
					$class_before_comment=CSS_EXPECTING_SEP_OR_CLASS_NAME_OR_CLASS;
				}
				elseif (($next==',') || ($next=='>'))
				{
					$status=CSS_EXPECTING_CLASS_NAME;
				}
				elseif (($next=='.') || ($next=='#') || ($alpha_numeric))
				{
					$status=CSS_IN_CLASS_NAME;
					$class_name='';
				}
				else
				{
					$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER',1=>$next,2=>number_format($line),'pos'=>$i);
//					return $errors;
				}
				break;

			case CSS_IN_CLASS:
				if ($quoting)
				{
					if ((($next=='"') || ($next=="'")) && ($data[$i-1]!="\\")) $quoting=!$quoting;
					$class.=$next;
				}
				elseif ($in_comment)
				{
					$comment_ending=(($next=='*') && ($i<$len-2) && ($data[$i+1]=='/'));
					if ($comment_ending)
					{
						$in_comment=false;
					}
					$class.=$next;
				}
				elseif ($next=='}')
				{
					$status=CSS_NO_MANS_LAND;
					$test=_validate_css_class($class,$class_start_i,$class_start_line+1);
					if (is_array($test)) $errors=array_merge($errors,$test);
				}
				elseif ($comment_starting)
				{
					$in_comment=true;
					$class.=$next;
				}
				elseif ((($next=='"') || ($next=="'")) && ($data[$i-1]!="\\"))
				{
					$quoting=true;
					$class.=$next;
				}
				elseif ($next=='{')
				{
					$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER_CLASS',1=>$next,2=>number_format($line),'pos'=>$i);
					return $errors;
				} else $class.=$next;
				break;
		}

		if ($val==10) ++$line;

		++$i;
	}

	if ($status!=CSS_NO_MANS_LAND)
	{
		$errors[]=array(0=>'CSS_UNEXPECTED_TERMINATION','pos'=>$i);
		return $errors;
	}

	return ($errors==array())?NULL:$errors;
}

/**
 * Checks a CSS class.
 *
 * @param  string			The data of the CSS class
 * @param  integer		Current parse position
 * @param  integer		The higher-level line number we are checking for (to give better debug output)
 * @return ?map			Error information (NULL: no error)
 */
function _validate_css_class($data,$_i,$line=0)
{
	$errors=array();

	global $CSS_TAG_RANGES;
	global $CSS_VALUE_RANGES;

	$len=strlen($data);
	$i=0;
	$key='';
	$value='';
	$status=_CSS_NO_MANS_LAND;
	$class_before_comment=NULL;
	$quoting=false;
	while ($i<$len)
	{
		$next=$data[$i];
		$val=ord($next);
		$alpha_numeric=($next=='_') || ($next=='.') || ($next=='-') || (($val>=65) && ($val<=90)) || (($val>=97) && ($val<=122)) || (($val>=48) && ($val<=57));
		$whitespace=(($next=="\t") || ($val==13) || ($val==10) || ($next==' '));
		$comment_starting=(($next=='/') && ($i!=$len-2) && ($i+1<$len) && ($data[$i+1]=='*'));

		switch ($status)
		{
			case _CSS_NO_MANS_LAND:
				if ($alpha_numeric)
				{
					$CSS_TAG_RANGES[]=array($_i+$i+1,$_i+$i+2);
					$status=_CSS_IN_PROPERTY_KEY;
					$key=$next;
				}
				elseif (($whitespace) || ($next==';')) // ; is unusual here, but allowed; It occurs when we substitute nothing into a part of a style attribute
				{
					// Continuing
				}
				elseif ($comment_starting)
				{
					$class_before_comment=$status;
					$status=_CSS_IN_COMMENT;
				} else
				{
					$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER_CLASS',1=>$next,2=>number_format($line),'pos'=>$_i);
//					return $errors;
				}
				break;

			case _CSS_IN_COMMENT:
				if (($next=='*') && ($i!=$len-1) && ($data[$i+1]=='/'))
				{
					$status=$class_before_comment;
					++$i;
				}
				break;

			case _CSS_IN_PROPERTY_KEY:
				if ($next==':')
				{
					$status=_CSS_IN_PROPERTY_BETWEEN;
					$value='';
				}
				elseif ($alpha_numeric)
				{
					$key.=$next;
					$CSS_TAG_RANGES[count($CSS_TAG_RANGES)-1][1]++;
				}
				break;

			case _CSS_IN_PROPERTY_BETWEEN:
				if (!$whitespace)
				{
					$status=_CSS_IN_PROPERTY_VALUE;
					$CSS_VALUE_RANGES[]=array($_i+$i+1,$_i+$i+1);
					$i--;
				}
				break;

			case _CSS_IN_PROPERTY_VALUE:
				if (($next==';') && (!$quoting))
				{
					$test=_check_css_value($key,$value,$_i);
					if (is_array($test)) $errors[]=$test;
					$status=_CSS_NO_MANS_LAND;
				}
				elseif ($comment_starting) // IE 5 can't support :(
				{
					$class_before_comment=$status;
					$status=_CSS_IN_COMMENT;
					$errors[]=array(0=>'CSS_IE_COMPAT_COMMENT',1=>$next,2=>number_format($line),'pos'=>$_i);
				}
				elseif (($val==10) || ($val==13))
				{
					$status=_CSS_EXPECTING_END;
				} else
				{
					if ((($next=='"') || ($next=="'")) && ($data[$i-1]!="\\")) $quoting=!$quoting;
					$value.=$next;
					$CSS_VALUE_RANGES[count($CSS_VALUE_RANGES)-1][1]++;
				}
				break;

			case _CSS_EXPECTING_END:
				if (!$whitespace)
				{
					$errors[]=array(0=>'CSS_UNEXPECTED_CHARACTER_CLASS',1=>$next,2=>number_format($line),'pos'=>$_i);
					return $errors;
				}
				break;
		}

		if ($val==10) ++$line;

		++$i;
	}

	if (($status!=_CSS_NO_MANS_LAND) && ($status!=_CSS_IN_PROPERTY_VALUE) && ($status!=_CSS_EXPECTING_END))
	{
		$errors[]=array(0=>'CSS_UNEXPECTED_TERMINATION_PROPERTY','pos'=>$_i);
		return $errors;
	}

	if ($status==_CSS_IN_PROPERTY_VALUE)
	{
		$test=_check_css_value($key,$value,$_i);
		if (is_array($test)) $errors[]=$test;
	}

	return ($errors==array())?NULL:$errors;
}

/**
 * Checks a CSS attribute/value combination is appropriate.
 *
 * @param  string			The name of the attribute
 * @param  string			The value of the attribute
 * @param  integer		Current parse position
 * @return ?map			Error information (NULL: no error)
 */
function _check_css_value($key,$value,$_i)
{
	$value=str_replace(' !important','',$value);
	$value=trim($value);

	if (substr($value,0,11)=='!important ') $value=substr($value,11); // Strip off the important flag if it's present

	$error=NULL;

	global $CSS_PROPERTIES,$CSS_NON_IE_PROPERTIES;
	if (!isset($CSS_PROPERTIES[$key]))
	{
		if (!isset($CSS_NON_IE_PROPERTIES[$key]))
		{
			return array(0=>'CSS_UNKNOWN_PROPERTY',1=>$key,'pos'=>$_i);
		} else
		{
			$reg_exp=$CSS_NON_IE_PROPERTIES[$key];
			if ($GLOBALS['VALIDATION_COMPAT']) $error=array(0=>'CSS_NON_IE_PROPERTIES',1=>$key,'pos'=>$_i);
		}
	} else
	{
		$reg_exp=$CSS_PROPERTIES[$key];
	}

	if ((preg_match('#^'.$reg_exp.'$#',$value)==0) && ($value!='xpx') && ($value!='x')) return array(0=>'CSS_BAD_PROPERTY_VALUE',1=>$key,2=>$value,3=>$reg_exp,'pos'=>$_i);

	if ($GLOBALS['MAIL_MODE'])
	{
		if ($key=='position') return array(0=>'MAIL_POSITIONING','pos'=>$_i);
		if (($key=='width') && (substr($value,-2)=='px') && (intval(substr($value,0,strlen($value)-2))>530))
		{
			return array(0=>'MAIL_WIDTH','pos'=>$_i);
		}
	} else
	{
		if (($key=='font-size') && (substr($value,-2)=='px')) return array(0=>'CSS_PX_FONT','pos'=>$_i);
	}

	return $error;
}


