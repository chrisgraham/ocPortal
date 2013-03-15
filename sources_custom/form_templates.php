<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_form_interfaces
 */


/**
 * Get the tempcode for a checkbox input.
 *
 * @param  mixed			A human intelligible name for this input field
 * @param  mixed			A description for this input field
 * @param  ID_TEXT		The name which this input field is for
 * @param  boolean		Whether this is ticked by default
 * @param  ?integer		The tab index of the field (NULL: not specified)
 * @param  ID_TEXT		The value the checkbox passes when ticked
 * @param  ?boolean		Whether this box should be disabled (default: false)
 * @return tempcode		The input field
 */
function form_input_tick($pretty_name,$description,$name,$ticked,$tabindex=NULL,$value='1',$disabled=false)
{
	$tabindex=get_form_field_tabindex($tabindex);

	$ticked=(filter_form_field_default($name,$ticked?'1':'0')=='1');

	$input=do_template('FORM_SCREEN_INPUT_TICK',array('_GUID'=>'f765a641c7527c0027b2d5c1da408aca','VALUE'=>$value,'CHECKED'=>$ticked,'TABINDEX'=>strval($tabindex),'NAME'=>$name,'DISABLED'=>$disabled));
	return _form_input($name,$pretty_name,$description,$input,false,false,$tabindex);
}

/**
 * Get the tempcode for a bank of tick boxes.
 *
 * @param  array			A list of tuples: (prettyname, name, value, description)
 * @param  mixed			A description for this input field
 * @param  ?integer		The tab index of the field (NULL: not specified)
 * @param  mixed			A human intelligible name for this input field (blank: use default)
 * @param  boolean		Whether to place each tick on a new line
 * @param  ?ID_TEXT		Name for custom value to be entered to (NULL: no custom value allowed)
 * @param  ?string		Value for custom value (NULL: no custom value known)
 * @return tempcode		The input field
 */
function form_input_various_ticks($options,$description,$_tabindex=NULL,$_pretty_name='',$simple_style=false,$custom_name=NULL,$custom_value=NULL)
{
	if (count($options)==0) return new ocp_tempcode();

	$options=array_values($options);

	if (is_null($_tabindex))
	{
		$tabindex=get_form_field_tabindex(NULL);
	} else
	{
		$_tabindex++;
		$tabindex=$_tabindex;
	}

	if ((is_string($_pretty_name)) && ($_pretty_name=='')) $_pretty_name=do_lang_tempcode('OPTIONS');

	$input=new ocp_tempcode();

	if (count($options[0])!=3)
	{
		$options=array(array($options,NULL,new ocp_tempcode()));
	}
	foreach ($options as $_option)
	{
		$out=array();
		foreach ($_option[0] as $option)
		{
			// $disabled has been added to the API, so we must emulate the
			// previous behaviour if it isn't supplied (ie. $disabled='0')
			if (count($option)==4)
			{
				list($pretty_name,$name,$value,$_description)=$option;
				$disabled='0';
			}
			elseif (count($option)==5)
			{
				list($pretty_name,$name,$value,$_description,$_disabled)=$option;
				$disabled=$_disabled?'1':'0';
			}

			$value=(filter_form_field_default($name,$value?'1':'0')=='1');

			$out[]=array('CHECKED'=>$value,'TABINDEX'=>strval($tabindex),'NAME'=>$name,'PRETTY_NAME'=>$pretty_name,'DESCRIPTION'=>$_description,'DISABLED'=>$disabled);
		}

		$input->attach(do_template('FORM_SCREEN_INPUT_VARIOUS_TICKS',array('_GUID'=>'e6be7f9668020bc2ba5d112300ceba4c','CUSTOM_NAME'=>$custom_name,'CUSTOM_VALUE'=>$custom_value,'SECTION_TITLE'=>$_option[2],'EXPANDED'=>$_option[1],'SIMPLE_STYLE'=>$simple_style,'BRETHREN_COUNT'=>strval(count($out)),'OUT'=>$out)));
	}
	return _form_input('',$_pretty_name,$description,$input,false,false,$tabindex);
}
