<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 */
class Hook_fields_list
{
    // ==============
    // Module: search
    // ==============

    /**
     * Get special Tempcode for inputting this field.
     *
     * @param  array                    $row The row for the field to input
     * @return ?array                   List of specially encoded input detail rows (null: nothing special)
     */
    public function get_search_inputter($row)
    {
        $fields = array();
        $type = '_LIST';
        $special = new Tempcode();
        $special->attach(form_input_list_entry('', get_param('option_' . strval($row['id']), '') == '', '---'));
        $list = ($row['cf_default'] == '') ? array() : explode('|', $row['cf_default']);
        $display = array_key_exists('trans_name', $row) ? $row['trans_name'] : get_translated_text($row['cf_name']); // 'trans_name' may have been set in CPF retrieval API, might not correspond to DB lookup if is an internal field
        foreach ($list as $l) {
            $special->attach(form_input_list_entry($l, get_param('option_' . strval($row['id']), '') == $l));
        }
        $fields[] = array('NAME' => strval($row['id']), 'DISPLAY' => $display, 'TYPE' => $type, 'SPECIAL' => $special);
        return $fields;
    }

    /**
     * Get special SQL from POSTed parameters for this field.
     *
     * @param  array                    $row The row for the field to input
     * @param  integer                  $i We're processing for the ith row
     * @return ?array                   Tuple of SQL details (array: extra trans fields to search, array: extra plain fields to search, string: an extra table segment for a join, string: the name of the field to use as a title, if this is the title, extra WHERE clause stuff) (null: nothing special)
     */
    public function inputted_to_sql_for_search($row, $i)
    {
        return exact_match_sql($row, $i, 'long');
    }

    // ===================
    // Backend: fields API
    // ===================

    /**
     * Get some info bits relating to our field type, that helps us look it up / set defaults.
     *
     * @param  ?array                   $field The field details (null: new field)
     * @param  ?boolean                 $required Whether a default value cannot be blank (null: don't "lock in" a new default value)
     * @param  ?string                  $default The given default value as a string (null: don't "lock in" a new default value)
     * @return array                    Tuple of details (row-type,default-value-to-use,db row-type)
     */
    public function get_field_value_row_bits($field, $required = null, $default = null)
    {
        unset($field);
        if (!is_null($required)) {
            if (($required) && ($default == '')) {
                $default = preg_replace('#\|.*#', '', $default);
            }
        }
        return array('long_unescaped', $default, 'long');
    }

    /**
     * Convert a field value to something renderable.
     *
     * @param  array                    $field The field details
     * @param  mixed                    $ev The raw value
     * @return mixed                    Rendered field (tempcode or string)
     */
    public function render_field_value($field, $ev)
    {
        if (is_object($ev)) {
            return $ev;
        }
        return escape_html($ev);
    }

    // ======================
    // Frontend: fields input
    // ======================

    /**
     * Get form inputter.
     *
     * @param  string                   $_cf_name The field name
     * @param  string                   $_cf_description The field description
     * @param  array                    $field The field details
     * @param  ?string                  $actual_value The actual current value of the field (null: none)
     * @return ?tempcode                The Tempcode for the input field (null: skip the field - it's not input)
     */
    public function get_field_inputter($_cf_name, $_cf_description, $field, $actual_value)
    {
        $default = $field['cf_default'];

        $_value = explode('|', $default); // $_value will come up as file|heading(optional)|order(optional)
        $csv_filename = $_value[0];

        if (substr(strtolower($csv_filename), -4) == '.csv') {
            if (!isset($_value[1])) {
                $_value[1] = null;
            }
            if (!isset($_value[2])) {
                $_value[2] = null;
            }
            if (!isset($_value[3])) {
                $_value[3] = null;
            }
            $csv_heading = $_value[1];
            $csv_parent_filename = $_value[2];
            $csv_parent_heading = $_value[3];

            require_code('nested_csv');
            $csv_structure = get_nested_csv_structure();

            $list = array();
            foreach ($csv_structure['csv_files'][$csv_filename]['data'] as $row) {
                $list[$row[$csv_heading]] = 1;
            }
            $list = array_keys($list);
            natsort($list);
        } else {
            $list = explode('|', $default);
        }
        $_list = new Tempcode();
        if (($field['cf_required'] == 0) || ($actual_value == $default) || ($actual_value == '') || (is_null($actual_value))) {
            if ((array_key_exists(0, $list)) && ($list[0] == do_lang('NOT_DISCLOSED'))) {
                $actual_value = $list[0]; // "Not Disclosed" will become the default if it is there
            } else {
                $_list->attach(form_input_list_entry('', true, do_lang_tempcode('NA_EM')));
            }
        }
        $is_locations = ((addon_installed('shopping')) && ($_cf_name == do_lang('shopping:SHIPPING_ADDRESS_COUNTRY')) && (is_file(get_file_base() . '/sources_custom/locations.php')));
        if ($is_locations) {
            require_code('locations');
        }
        foreach ($list as $l) {
            $l_nice = $l;
            if (($is_locations) && (strlen($l) == 2)) {
                $l_nice = find_country_name_from_iso($l);
            }
            $_list->attach(form_input_list_entry($l, $l == $actual_value, $l_nice));
        }
        return form_input_list($_cf_name, $_cf_description, 'field_' . strval($field['id']), $_list, null, false, $field['cf_required'] == 1);
    }

    /**
     * Find the posted value from the get_field_inputter field
     *
     * @param  boolean                  $editing Whether we were editing (because on edit, it could be a fractional edit)
     * @param  array                    $field The field details
     * @param  ?string                  $upload_dir Where the files will be uploaded to (null: do not store an upload, return NULL if we would need to do so)
     * @param  ?array                   $old_value Former value of field (null: none)
     * @return ?string                  The value (null: could not process)
     */
    public function inputted_to_field_value($editing, $field, $upload_dir = 'uploads/catalogues', $old_value = null)
    {
        $id = $field['id'];
        $tmp_name = 'field_' . strval($id);
        return post_param($tmp_name, STRING_MAGIC_NULL);
    }
}
