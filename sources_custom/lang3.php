<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('parse_translated_text')) {
    /**
     * get_translated_tempcode was asked for a lang entry that had not been parsed into Tempcode yet.
     *
     * @param  ID_TEXT                  $table The table name
     * @param  array                    $row The database row
     * @param  ID_TEXT                  $field_name The field name
     * @param  ?object                  $connection The database connection to use (null: standard site connection)
     * @param  ?LANGUAGE_NAME           $lang The language (null: uses the current language)
     * @param  boolean                  $force Whether to force it to the specified language
     * @param  boolean                  $as_admin Whether to force as_admin, even if the lang string isn't stored against an admin (designed for Comcode page cacheing)
     * @return ?tempcode                The parsed Comcode (null: the text couldn't be looked up)
     */
    function parse_translated_text($table, &$row, $field_name, $connection, $lang, $force, $as_admin)
    {
        global $SEARCH__CONTENT_BITS;
        global $LAX_COMCODE;

        $nql_backup = $GLOBALS['NO_QUERY_LIMIT'];
        $GLOBALS['NO_QUERY_LIMIT'] = true;

        $entry = $row[$field_name];

        $result = mixed();
        if (multi_lang_content()) {
            $_result = $connection->query_select('translate', array('text_original', 'source_user'), array('id' => $entry, 'language' => $lang), '', 1);
            if (array_key_exists(0, $_result)) {
                $result = $_result[0];
            }
        }

        if (($result === null) && (multi_lang_content())) { // A missing translation
            if ($force) {
                $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
                return null;
            }

            $result = $connection->query_select_value_if_there('translate', 'text_parsed', array('id' => $entry, 'language' => get_site_default_lang()));
            if ($result === null) {
                $result = $connection->query_select_value_if_there('translate', 'text_parsed', array('id' => $entry));
            }

            if (($result === null) || ($result == '')) {
                require_code('comcode'); // might not have been loaded for a quick-boot
                require_code('permissions');

                $result = $connection->query_select('translate', array('text_original', 'source_user'), array('id' => $entry, 'language' => get_site_default_lang()), '', 1);
                if (!array_key_exists(0, $result)) {
                    $result = $connection->query_select('translate', array('text_original', 'source_user'), array('id' => $entry), '', 1);
                }
                $result = array_key_exists(0, $result) ? $result[0] : null;
                if ($result !== null) {
                    $result['text_original'] = google_translate($result['text_original'], $lang);
                    $result['text_parsed'] = '';
                }

                $temp = $LAX_COMCODE;
                $LAX_COMCODE = true;
                _lang_remap($field_name, $entry, ($result === null) ? '' : $result['text_original'], $connection, true, null, $result['source_user'], $as_admin, false, true);
                if ($SEARCH__CONTENT_BITS !== null) {
                    $ret = comcode_to_tempcode($result['text_original'], $result['source_user'], $as_admin, null, null, $connection, false, false, false, false, false, $SEARCH__CONTENT_BITS);
                    $LAX_COMCODE = $temp;
                    $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
                    return $ret;
                }
                $LAX_COMCODE = $temp;
                $ret = get_translated_tempcode($table, $row, $field_name, $connection, $lang);
                $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
                return $ret;
            }

            $connection->text_lookup_cache[$entry] = new Tempcode();
            $connection->text_lookup_cache[$entry]->from_assembly($result);

            $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
            return $connection->text_lookup_cache[$entry];
        } else {
            require_code('comcode'); // might not have been loaded for a quick-boot
            require_code('permissions');

            $temp = $LAX_COMCODE;
            $LAX_COMCODE = true;

            if (multi_lang_content()) {
                _lang_remap($field_name, $entry, $result['text_original'], $connection, true, null, $result['source_user'], $as_admin, false, true);

                if ($SEARCH__CONTENT_BITS !== null) {
                    $ret = comcode_to_tempcode($result['text_original'], $result['source_user'], $as_admin, null, null, $connection, false, false, false, false, false, $SEARCH__CONTENT_BITS);
                    $LAX_COMCODE = $temp;
                    $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
                    return $ret;
                }
            } else {
                $map = _lang_remap($field_name, $entry, $row[$field_name], $connection, true, null, $row[$field_name . '__source_user'], $as_admin, false, true);

                $connection->query_update($table, $map, $row, '', 1);
                $row = $map + $row;

                if ($SEARCH__CONTENT_BITS !== null) {
                    $ret = comcode_to_tempcode($row[$field_name], $row[$field_name . '__source_user'], $as_admin, null, null, $connection, false, false, false, false, false, $SEARCH__CONTENT_BITS);
                    $LAX_COMCODE = $temp;
                    $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
                    return $ret;
                }
            }

            $LAX_COMCODE = $temp;
            $ret = get_translated_tempcode($table, $row, $field_name, $connection, $lang);
            $GLOBALS['NO_QUERY_LIMIT'] = $nql_backup;
            return $ret;
        }
    }
}
