<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2015

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('_do_lang')) {
    /**
     * Get the human-readable form of a language ID, or a language entry from a language INI file.
     *
     * @param  ID_TEXT                  $codename The language ID
     * @param  ?mixed                   $token1 The first token [string or tempcode] (replaces {1}) (null: none)
     * @param  ?mixed                   $token2 The second token [string or tempcode] (replaces {2}) (null: none)
     * @param  ?mixed                   $token3 The third token (replaces {3}). May be an array of [of string], to allow any number of additional args (null: none)
     * @param  ?LANGUAGE_NAME           $lang The language to use (null: users language)
     * @param  boolean                  $require_result Whether to cause ocPortal to exit if the lookup does not succeed
     * @return ?mixed                   The human-readable content (null: not found). String normally. Tempcode if tempcode parameters.
     */
    function _do_lang($codename, $token1 = null, $token2 = null, $token3 = null, $lang = null, $require_result = true)
    {
        global $LANGUAGE_STRINGS_CACHE, $USER_LANG_CACHED, $RECORD_LANG_STRINGS, $XSS_DETECT, $PAGE_CACHE_LANG_LOADED;, $PAGE_CACHE_LAZY_LOAD, $SMART_CACHE, $PAGE_CACHE_LANGS_REQUESTED, $LANG_REQUESTED_LANG;

        if ($lang === null) {
            $lang = ($USER_LANG_CACHED === null) ? user_lang() : $USER_LANG_CACHED;
        }// else // This else assumes we initially load all language files in the users language. Reasonable. EDIT: Actually, no it is not - the user_lang() initially is not accurate until ocPortal gets past a certain startup position
        //{
            if ($GLOBALS['SEMI_DEV_MODE']) { // Special syntax for easily inlining language strings
                $pos = strpos($codename, '=');
                if ($pos !== false) {
                    require_code('lang2');
                    inline_language_editing($codename, $lang);
                }
            }

            $there = isset($LANGUAGE_STRINGS_CACHE[$lang][$codename]);

            if (!$there) {
                $pos = strpos($codename, ':');
                if ($pos !== false) {
                    require_lang(substr($codename, 0, $pos), null, null, !$require_result);
                    $codename = substr($codename, $pos + 1);
                }

                $there = isset($LANGUAGE_STRINGS_CACHE[$lang][$codename]);
            }

            if ($RECORD_LANG_STRINGS) {
                global $RECORDED_LANG_STRINGS;
                $RECORDED_LANG_STRINGS[$codename] = 1;
            }

            if ((!$there) && ((!isset($LANGUAGE_STRINGS_CACHE[$lang])) || (!array_key_exists($codename, $LANGUAGE_STRINGS_CACHE[$lang])))) {
                global $PAGE_CACHE_LAZY_LOAD, $PAGE_CACHE_LANGS_REQUESTED, $LANG_REQUESTED_LANG;

                if ($PAGE_CACHE_LAZY_LOAD) {
                    $PAGE_CACHE_LAZY_LOAD = false; // We can't be lazy any more, but we will keep growing our pool so hopefully CAN be lazy the next time
                    foreach ($PAGE_CACHE_LANGS_REQUESTED as $request) {
                        list($that_codename, $that_lang) = $request;
                        unset($LANG_REQUESTED_LANG[$that_lang][$that_codename]);
                        require_lang($that_codename, $that_lang, null, true);
                    }
                    $ret = _do_lang($codename, $token1, $token2, $token3, $lang, $require_result);
                    if ($ret === null) {
                        $PAGE_CACHE_LANG_LOADED[$lang][$codename] = null;
                        $SMART_CACHE->append('lang_strings', $codename, null);
                    }
                    return $ret;
                }

                require_all_open_lang_files($lang);
            }
        //}

        if ($lang == 'xxx') {
            return 'xxx'; // Helpful for testing language compliancy. We don't expect to see non x's if we're running this language
        }

        if ((!isset($LANGUAGE_STRINGS_CACHE[$lang][$codename])) && (($require_result) || (!isset($LANGUAGE_STRINGS_CACHE[$lang])) || (!array_key_exists($codename, $LANGUAGE_STRINGS_CACHE[$lang])))) {
            if ($lang != fallback_lang()) {
                $ret = do_lang($codename, $token1, $token2, $token3, fallback_lang(), $require_result);
                if ($codename == 'charset') {
                    switch (strtolower($lang)) {
                        case 'ar':
                        case 'bg':
                        case 'zh-CN':
                        case 'zh-TW':
                        case 'hr':
                        case 'cs':
                        case 'da':
                        case 'nl':
                        case 'fi':
                        case 'fr':
                        case 'de':
                        case 'el':
                        case 'hi':
                        case 'it':
                        case 'ja':
                        case 'ko':
                        case 'pl':
                        case 'pt':
                        case 'ro':
                        case 'ru':
                        case 'es':
                        case 'sv':
                            $ret = 'utf-8';
                            break;
                    }
                } elseif (substr($codename, 0, 3) == 'FC_') {
                    $ret = ocp_mb_substr(trim(do_lang(substr($codename, 3), $token1, $token2, $token3, $lang)), 0, 1);
                } elseif ($codename == 'locale') {
                    $ret = strtolower($lang) . '_' . strtoupper($lang);
                } else {
                    $ret2 = (strtolower($codename) != $codename) ? google_translate($ret, $lang) : $ret;
                    if ($ret2 != $ret) {
                        $ret = $ret2;
                    }
                }

                if ((!isset($PAGE_CACHE_LANG_LOADED[$lang][$codename])) && (isset($PAGE_CACHE_LANG_LOADED[fallback_lang()][$codename]))) {
                    $PAGE_CACHE_LANG_LOADED[$lang][$codename] = $ret; // Will have been cached into fallback_lang() from the nested do_lang call, we need to copy it into our cache bucket for this language
                    $SMART_CACHE->append('lang_strings', $ret, null);
                }

                return $ret;
            } else {
                if ($require_result) {
                    global $USER_LANG_LOOP, $REQUIRE_LANG_LOOP;
                    //print_r(debug_backtrace());
                    if ($USER_LANG_LOOP == 1) {
                        critical_error('RELAY', 'Missing language code: ' . escape_html($codename) . '. This language code is required to produce error messages, and thus a critical error was prompted by the non-ability to show less-critical error messages. It is likely the source language files (lang/' . fallback_lang() . '/*.ini) for ocPortal on this website have been corrupted.');
                    }
                    if ($REQUIRE_LANG_LOOP >= 2) {
                        return ''; // Probably failing to load global.ini, so just output with some text missing
                    }
                    require_code('caches3');
                    erase_cached_language();
                    fatal_exit(do_lang_tempcode('MISSING_LANG_ENTRY', escape_html($codename)));
                } else {
                    return null;
                }
            }
        }

        if ((!isset($PAGE_CACHE_LANG_LOADED[$lang][$codename])) && ((!isset($PAGE_CACHE_LANG_LOADED[$lang])) || (!array_key_exists($codename, $PAGE_CACHE_LANG_LOADED[$lang])))) {
            $PAGE_CACHE_LANG_LOADED[$lang][$codename] = $LANGUAGE_STRINGS_CACHE[$lang][$codename];
            $SMART_CACHE->append('lang_strings', $LANGUAGE_STRINGS_CACHE[$lang][$codename], null);
        }

        // Put in parameters
        static $non_plural_non_vowel = array('1', 'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z');
        $looked_up = $LANGUAGE_STRINGS_CACHE[$lang][$codename];
        if ($looked_up === null) {
            return null; // Learning cache pool has told us this string definitely does not exist
        }
        $out = str_replace('\n', "\n", $looked_up);
        $plural_or_vowel_check = strpos($out, '|') !== false;
        if ($XSS_DETECT) {
            ocp_mark_as_escaped($out);
        }
        if ($token1 !== null) {
            if (((is_object($token1)) && ($token2 === null)) || (($token2 !== null) && (is_object($token2)))) { // Tempcode only supported in first two
                $bits = preg_split('#\{\d[^\}]*\}#', $out, 2, PREG_SPLIT_OFFSET_CAPTURE);

                $ret = new Tempcode();
                foreach ($bits as $bit) {
                    if ($XSS_DETECT) {
                        ocp_mark_as_escaped($bit[0]);
                    }

                    $at = $bit[1];

                    if ($at != 0) {
                        if ($out[$at - 2] == '1') {
                            $ret->attach($token1);
                        } elseif ($out[$at - 2] == '2') {
                            $ret->attach($token2);
                        } elseif (($plural_or_vowel_check) && (substr($out[$at - 2], 0, 2) == '1|')) {
                            $exploded = explode('|', $out[$at - 2]);
                            $_token = $token1->evaluate();
                            $_token_denum = str_replace(',', '', $_token);
                            $ret->attach((in_array(is_numeric($_token_denum) ? $_token_denum : ocp_mb_strtolower(ocp_mb_substr($_token, 0, 1)), $non_plural_non_vowel)) ? $exploded[1] : $exploded[2]);
                        } elseif (($plural_or_vowel_check) && (substr($out[$at - 2], 0, 2) == '2|')) {
                            $exploded = explode('|', $out[$at - 2]);
                            $_token = $token2->evaluate();
                            $_token_denum = str_replace(',', '', $_token);
                            $ret->attach((in_array(is_numeric($_token_denum) ? $_token_denum : ocp_mb_strtolower(ocp_mb_substr($_token, 0, 1)), $non_plural_non_vowel)) ? $exploded[1] : $exploded[2]);
                        }
                    }
                    $ret->attach($bit[0]);
                }

                return $ret;
            } elseif ($token1 !== null) {
                $kg = !has_solemnly_declared(I_UNDERSTAND_XSS);
                if ($kg) {
                    kid_gloves_html_escaping_singular($token1);
                }

                $out = str_replace('{1}', $token1, $out);
                if ($plural_or_vowel_check) {
                    $_token_denum = str_replace(',', '', $token1);
                    $out = preg_replace('#\{1\|(.*)\|(.*)\}#U', (in_array(is_numeric($_token_denum) ? $_token_denum : ocp_mb_strtolower(ocp_mb_substr($token1, 0, 1)), $non_plural_non_vowel)) ? '\\1' : '\\2', $out);
                }
                if (($XSS_DETECT) && (ocp_is_escaped($token1))) {
                    ocp_mark_as_escaped($out);
                }
            }

            if ($token2 !== null) {
                if ($kg) {
                    kid_gloves_html_escaping_singular($token2);
                }

                if ($XSS_DETECT) {
                    $escaped = ocp_is_escaped($out);
                }
                $out = str_replace('{2}', $token2, $out);
                if ($plural_or_vowel_check) {
                    $_token_denum = str_replace(',', '', $token2);
                    $out = preg_replace('#\{2\|(.*)\|(.*)\}#U', (in_array(is_numeric($_token_denum) ? $_token_denum : ocp_mb_strtolower(ocp_mb_substr($token2, 0, 1)), $non_plural_non_vowel)) ? '\\1' : '\\2', $out);
                }
                if (($XSS_DETECT) && (ocp_is_escaped($token2)) && ($escaped)) {
                    ocp_mark_as_escaped($out);
                }

                if ($token3 !== null) {
                    $i = 3;
                    if (!is_array($token3)) {
                        $token3 = array($token3);
                    }
                    foreach ($token3 as $token) {
                        if ($kg) {
                            kid_gloves_html_escaping_singular($token);
                        }

                        if ($XSS_DETECT) {
                            $escaped = ocp_is_escaped($out);
                        }
                        $out = str_replace('{' . strval($i) . '}', $token, $out);
                        if ($plural_or_vowel_check) {
                            $_token_denum = str_replace(',', '', $token);
                            $out = preg_replace('#\{' . strval($i) . '\|(.*)\|(.*)\}#U', (in_array(is_numeric($_token_denum) ? $_token_denum : strtolower(substr($token, 0, 1)), $non_plural_non_vowel)) ? '\\1' : '\\2', $out);
                        }
                        if (($XSS_DETECT) && (ocp_is_escaped($token)) && ($escaped)) {
                            ocp_mark_as_escaped($out);
                        }
                        $i++;
                    }
                }
            }
        }
        return $out;
    }
}

if (!function_exists('get_translated_text')) {
    /**
     * Try to return the human-readable version of the language ID, passed in as $entry.
     *
     * @param  mixed                    $entry The ID (if multi-lang-content on), or the string itself
     * @param  ?object                  $connection The database connection to use (null: standard site connection)
     * @param  ?LANGUAGE_NAME           $lang The language (null: uses the current language)
     * @return string                   The human-readable version
     */
    function get_translated_text($entry, $connection = null, $lang = null)
    {
        if (!multi_lang_content()) {
            return $entry;
        }

        if ($entry === 0) {
            return do_lang('FAILED_ENTRY');
        }

        if ($entry === null) {
            fatal_exit(do_lang_tempcode('NULL_LANG_STRING'));
        }

        if ($connection === null) {
            $connection = $GLOBALS['SITE_DB'];
        }

        global $RECORD_LANG_STRINGS_CONTENT;
        if ($RECORD_LANG_STRINGS_CONTENT) {
            global $RECORDED_LANG_STRINGS_CONTENT;
            $RECORDED_LANG_STRINGS_CONTENT[$entry] = ($connection->connection_write != $GLOBALS['SITE_DB']->connection_write);
        }

        if ($lang === null) {
            $lang = user_lang();
        }

        if ((array_key_exists($entry, $connection->text_lookup_original_cache)) && ($lang == user_lang())) {
            return $connection->text_lookup_original_cache[$entry];
        }

        if ($lang == 'xxx') {
            return '!!!'; // Helpful for testing language compliancy. We don't expect to see non x's/!'s if we're running this language
        }
        $result = $connection->query_select('translate', array('text_original', 'text_parsed'), array('id' => $entry, 'language' => $lang), '', 1);
        if (!array_key_exists(0, $result)) {
            $result = $connection->query_select('translate', array('*'), array('id' => $entry, 'language' => get_site_default_lang()), '', 1);
            if (!array_key_exists(0, $result)) {
                $result = $connection->query_select('translate', array('*'), array('id' => $entry), '', 1);
            }
            if (array_key_exists(0, $result)) {
                $result[0]['text_original'] = google_translate($result[0]['text_original'], $lang);
                $result[0]['text_parsed'] = '';
                $connection->query_insert('translate', array('broken' => 1, 'language' => $lang) + $result[0]);
            }
        }
        if (!array_key_exists(0, $result)) {
            $member_id = function_exists('get_member') ? get_member() : $GLOBALS['FORUM_DRIVER']->get_guest_id();
            $connection->query_insert('translate', array('id' => $entry, 'source_user' => $member_id, 'broken' => 0, 'importance_level' => 3, 'text_original' => '', 'text_parsed' => '', 'language' => $lang));
            $msg = do_lang('LANGUAGE_CORRUPTION', strval($entry));
            if ($GLOBALS['DEV_MODE']) {
                fatal_exit($msg);
            }
            require_code('site');
            attach_message(make_string_tempcode($msg), 'warn');
            return '';
        }
        if ($lang == user_lang()) {
            $connection->text_lookup_original_cache[$entry] = $result[0]['text_original'];
            $connection->text_lookup_cache[$entry] = $result[0]['text_parsed'];
        }

        return $result[0]['text_original'];
    }
}

/**
 * Convert a language string into another language string.
 *
 * @param  mixed                        $str_in The string to convert
 * @param  LONG_TEXT                    $lang The language to convert to
 * @return LONG_TEXT                    The converted string
 */
function google_translate($str_in, $lang)
{
    $tempcode = is_object($str_in);

    $GLOBALS['NO_QUERY_LIMIT'] = true;

    $key = get_option('enable_google_translate', true);
    if (empty($key)) {
        return $str_in;
    }

    if ($tempcode) {
        $str_in = $str_in->evaluate();
    }

    global $DOING_TRANSLATE;
    if (!isset($DOING_TRANSLATE)) {
        $DOING_TRANSLATE = false;
    }

    if ($DOING_TRANSLATE) {
        return $tempcode ? protect_from_escaping($str_in) : $str_in; // Don't want loops
    }

    if ($str_in == '') {
        return $tempcode ? protect_from_escaping(escape_html('')) : escape_html('');
    }

    if (strpos($str_in, 'gtranslate_cache') !== false) {
        return $tempcode ? protect_from_escaping($str_in) : $str_in; // Stop loops about corrupt/missing database tables
    }

    require_code('GTranslate');
    $translate = new GTranslate();

    $language_list = $translate->GetLanguageList();
    $lang = strtolower($lang);
    if (!array_key_exists($lang, $language_list)) {
        return $tempcode ? protect_from_escaping($str_in) : $str_in;
    }

    $DOING_TRANSLATE = true;

    require_lang('lang');
    $cache = check_google_cache($str_in, $lang);
    if (count($cache) == 0) {
        $num_matches = array();
        $matches = array();
        $rep = array();
        $prepped = $str_in;
        $j = 0;
        foreach (array(array('[', ']'), array('{', '}')) as $symbol) {
            $_matches = array();
            $_num_matches = preg_match_all('#[' . preg_quote($symbol[0]) . '][^' . preg_quote($symbol[0]) . preg_quote($symbol[1]) . ']*[' . preg_quote($symbol[1]) . ']#', $str_in, $_matches);
            $matches[$symbol[0]] = $_matches;
            $num_matches[$symbol[0]] = $_num_matches;

            for ($i = 0; $i < $_num_matches; $i++) {
                $from = $_matches[0][$i];
                $to = '<span class="notranslate">' . strval($j) . '</span>';
                $rep['!' . strval($j)] = $from; // The '!' bit is because we can't trust indexing in PHP arrays if it is numeric
                $pos = 0;
                do {
                    $pos = strpos($prepped, $from, $pos);
                    if ($pos !== false) {
                        $pos_open = strrpos(substr($prepped, 0, $pos), '<');
                        $pos_close = strrpos(substr($prepped, 0, $pos), '>');
                        if (($pos_open === false) || (($pos_close !== false) && ($pos_close > $pos_open))) {
                            $prepped = substr($prepped, 0, $pos) . $to . substr($prepped, $pos + strlen($from));
                            $pos += strlen($to);
                        } else {
                            $pos_title = strrpos(substr($prepped, 0, $pos), 'title="');
                            $pos_alt = strrpos(substr($prepped, 0, $pos), 'alt="');
                            $pos_quote = strrpos(substr($prepped, 0, $pos), '"');
                            if ((($pos_alt !== false) && ($pos_alt > $pos_open) && ($pos_quote == $pos_alt + 4)) || (($pos_title !== false) && ($pos_title > $pos_open) && ($pos_quote == $pos_title + 6))) {
                                $to2 = ' conv' . strval($j) . ' ';
                                $prepped = substr($prepped, 0, $pos) . $to2 . substr($prepped, $pos + strlen($from));
                                $pos += strlen($to2);
                            } else {
                                $pos += strlen($from);
                            }
                        }
                    }
                }
                while ($pos !== false);
                $j++;
            }
        }
        if (strpos(preg_replace('#<[^>]*>#', '', $prepped), '{') !== false) {
            $DOING_TRANSLATE = false;
            return $tempcode ? protect_from_escaping($str_in) : $str_in; // Cannot translate as it has very complex Tempcode in it
        }

        $to = $language_list[$lang];
        $from_lang = strtolower(get_site_default_lang());
        try {
            $_from = array_key_exists($from_lang, $language_list) ? $language_list[$from_lang] : 'English';
            $convertedstring = $translate->Key($key)->Text($prepped)->From($_from)->To($to);
        } catch (Exception $e) {
        }
        if ($convertedstring === null) {
            $convertedstring = $str_in;
        }

        do {
            $before = $convertedstring;
            $convertedstring = preg_replace('#(<span class="notranslate">\d+) (.*</span>)#', '${1}</span> <span class="notranslate">${2}', $convertedstring);
        }
        while ($before != $convertedstring);
        foreach (array_reverse($rep) as $_j => $from) {
            $j = intval(substr($_j, 1));
            $convertedstring = preg_replace('#\s*<span class="notranslate">\s*' . preg_quote(strval($j)) . '\s*</span>\s*#', $from, $convertedstring);
            $convertedstring = preg_replace('# conv' . preg_quote(strval($j)) . '\s*#', $from, $convertedstring);
        }
        $convertedstring = str_replace('<html> ', '', $convertedstring);
        $convertedstring = str_replace('&#39;', '', $convertedstring);

        save_google_cache($str_in, $lang, $convertedstring);
        $str = $convertedstring;
    } else {
        $str = $cache['t_result'];
    }
    $DOING_TRANSLATE = false;
    if ((function_exists('ocp_mark_as_escaped')) && (ocp_is_escaped($str_in))) {
        ocp_mark_as_escaped($str);
    }
    return $tempcode ? protect_from_escaping($str) : $str;
}

/**
 * Check google cache.
 *
 * @param  STRING                       $str The string TO CONVERT
 * @param  STRING                       $lang The lANGUAGE STRING
 * @return ARRAY                        array of data
 */
function check_google_cache($str, $lang)
{
    if (!$GLOBALS['SITE_DB']->table_exists('gtranslate_cache')) {
        $GLOBALS['SITE_DB']->create_table('gtranslate_cache',
            array('id' => '*AUTO', 'language' => 'LANGUAGE_NAME', 'stringtoconvert' => 'LONG_TEXT', 't_result' => 'LONG_TEXT', 'create_time' => 'TIME'), true
        );
    }

    $where = array('stringtoconvert' => $str, 'language' => $lang);
    $_result = $GLOBALS['SITE_DB']->query_select('gtranslate_cache', array('*'), $where, '', 1);
    if (count($_result) == 1) {
        $data = $_result[0];
    } else {
        $data = array();
    }
    return $data;
}

/**
 * Save successful google response of gtranslate table.
 *
 * @param  STRING                       $str The string TO CONVERT
 * @param  STRING                       $lang The lANGUAGE STRING
 * @param  STRING                       $result result of request
 * @return BINARY                       If success return true
 */
function save_google_cache($str, $lang, $result)
{
    $time = time();
    $GLOBALS['SITE_DB']->query_insert('gtranslate_cache', array('language' => $lang, 'stringtoconvert' => $str, 't_result' => $result, 'create_time' => $time));
    return true;
}

if (!function_exists('get_site_default_lang')) {
    /**
     * Get the site's default language, with support for URL overrides.
     *
     * @return LANGUAGE_NAME            The site's default language
     */
    function get_site_default_lang()
    {
        // Site default then
        global $SITE_INFO;
        if (!array_key_exists('default_lang', $SITE_INFO)) { // We must be installing
            global $IN_MINIKERNEL_VERSION;
            if ($IN_MINIKERNEL_VERSION) {
                if (array_key_exists('lang', $_POST)) {
                    return $_POST['lang'];
                }
                if (array_key_exists('lang', $_GET)) {
                    return $_GET['lang'];
                }
            }
            return fallback_lang();
        }
        return $SITE_INFO['default_lang'];
    }
}
