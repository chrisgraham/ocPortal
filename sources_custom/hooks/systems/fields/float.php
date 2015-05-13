<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_fields
 */

class Hook_fields_float
{

	// ==============
	// Module: search
	// ==============

	/**
	 * Get special Tempcode for inputting this field.
	 *
	 * @param  array			The row for the field to input
	 * @return ?array			List of specially encoded input detail rows (NULL: nothing special)
	 */
	function get_search_inputter($row)
	{
		return NULL;
	}

	/**
	 * Get special SQL from POSTed parameters for this field.
	 *
	 * @param  array			The row for the field to input
	 * @param  integer		We're processing for the ith row
	 * @return ?array			Tuple of SQL details (array: extra trans fields to search, array: extra plain fields to search, string: an extra table segment for a join, string: the name of the field to use as a title, if this is the title, extra WHERE clause stuff) (NULL: nothing special)
	 */
	function inputted_to_sql_for_search($row,$i)
	{
		return exact_match_sql($row,$i,'float');
	}

	// ===================
	// Backend: fields API
	// ===================

	/**
	 * Get some info bits relating to our field type, that helps us look it up / set defaults.
	 *
	 * @param  ?array			The field details (NULL: new field)
	 * @param  ?boolean		Whether a default value cannot be blank (NULL: don't "lock in" a new default value)
	 * @param  ?string		The given default value as a string (NULL: don't "lock in" a new default value)
	 * @return array			Tuple of details (row-type,default-value-to-use,db row-type)
	 */
	function get_field_value_row_bits($field,$required=NULL,$default=NULL)
	{
		unset($field);
		if (!is_null($required))
		{
			if (($required) && ($default=='')) $default='0';
		}
		return array('float_unescaped',$default,'float');
	}

	/**
	 * Convert a field value to something renderable.
	 *
	 * @param  array			The field details
	 * @param  mixed			The raw value
	 * @return mixed			Rendered field (tempcode or string)
	 */
	function render_field_value($field,$ev)
	{
		if (is_object($ev)) return $ev;
		return escape_html($ev);
	}

	// ======================
	// Frontend: fields input
	// ======================

	/**
	 * Get form inputter.
	 *
	 * @param  string			The field name
	 * @param  string			The field description
	 * @param  array			The field details
	 * @param  ?string		The actual current value of the field (NULL: none)
	 * @param  boolean		Whether this is for a new entry
	 * @return ?tempcode		The Tempcode for the input field (NULL: skip the field - it's not input)
	 */
	function get_field_inputter($_cf_name,$_cf_description,$field,$actual_value,$new)
	{
		if ($_cf_name=='Longitude') // Assumes there is a Latitude field too, although not critical
		{
			$pretty_name=$_cf_name;
			$description=$_cf_description;
			$name='field_'.strval($field['id']);
			$required=$field['cf_required']==1;

			if ((isset($actual_value)) && ($actual_value!='') && ($actual_value!=do_lang('NA'))) $longitude=float_to_raw_string(floatval($actual_value),10);
			global $LATITUDE;
			if ((isset($LATITUDE)) && ($LATITUDE!='') && ($LATITUDE!=do_lang('NA'))) $latitude=float_to_raw_string(floatval($LATITUDE),10);

			if ($latitude=='0.0000000000') $latitude='0';
			if ($longitude=='0.0000000000') $longitude='0';

			$input=do_template('FORM_SCREEN_INPUT_MAP_POSITION',array('_GUID'=>'86d69d152d7bfd125e6216c9ac936cfd','REQUIRED'=>$required,'NAME'=>$name,'LATITUDE'=>$latitude,'LONGITUDE'=>$longitude));
			return _form_input($name,'Position','',$input,$required,false);
		}

		if ($_cf_name=='Latitude') // Assumes there is a Longitude field too
		{
			global $LATITUDE;
			$LATITUDE=$actual_value; // Store for when Longitude field is rendered - critical, else won't be entered
			return new ocp_tempcode();
		}

		return form_input_float($_cf_name,$_cf_description,'field_'.strval($field['id']),(is_null($actual_value) || ($actual_value===''))?NULL:floatval($actual_value),$field['cf_required']==1);
	}

	/**
	 * Find the posted value from the get_field_inputter field
	 *
	 * @param  boolean		Whether we were editing (because on edit, it could be a fractional edit)
	 * @param  array			The field details
	 * @param  ?string		Where the files will be uploaded to (NULL: do not store an upload, return NULL if we would need to do so)
	 * @param  ?string		Former value of field (NULL: none)
	 * @return ?string		The value (NULL: could not process)
	 */
	function inputted_to_field_value($editing,$field,$upload_dir='uploads/catalogues',$old_value=NULL)
	{
		$id=$field['id'];
		$tmp_name='field_'.strval($id);
		$default=STRING_MAGIC_NULL;
		if (get_translated_text($field['cf_name'])=='Latitude')
		{
			$default=post_param('latitude',STRING_MAGIC_NULL);
		}
		if (get_translated_text($field['cf_name'])=='Longitude')
		{
			$default=post_param('longitude',STRING_MAGIC_NULL);
		}
		return post_param($tmp_name,$default);
	}

}


