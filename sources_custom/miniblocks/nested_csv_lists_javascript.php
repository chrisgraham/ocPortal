<?php

require_code('nested_csv');
$csv_structure=get_nested_csv_structure();

// Sanitisation to protect any data not destined to be available in the form
$csv_headings_used=array();
foreach (array_keys($csv_structure['cpf_fields']) as $csv_heading)
{
	$csv_headings_used[$csv_heading]=1;
}
foreach ($csv_structure['csv_files'] as $csv_filename=>$csv_file)
{
	foreach ($csv_file['data'] as $i=>$row)
	{
		foreach (array_keys($row) as $csv_heading)
		{
			if (!isset($csv_headings_used[$csv_heading])) unset($csv_structure['csv_files'][$csv_filename]['data'][$i][$csv_heading]);
		}
	}
}

// Output Javascript
echo "
	window.nested_csv_structure=".json_encode($csv_structure).";

	add_event_listener_abstract(window,'load',function () {
		var forms=document.getElementsByTagName('form');
		for (var i=0;i<forms.length;i++)
		{
			inject_form_select_chaining__form(forms[i]);
		}
	} );

	function inject_form_select_chaining__form(form)
	{
		var cpf_fields=window.nested_csv_structure.cpf_fields;
		for (var i in cpf_fields)
		{
			var cpf_field=cpf_fields[i];
			if (typeof cpf_field.possible_fields=='undefined') continue; // Is not part of list

			var element=find_cpf_field_element(form,cpf_field);
			if (element) inject_form_select_chaining__element(element,cpf_field,true);
		}
	}

	function find_cpf_field_element(form,cpf_field)
	{
		for (var i=0;i<form.elements.length;i++)
		{
			if (form.elements[i].nodeName.toLowerCase()=='select')
			{
				for (var j=0;j<cpf_field.possible_fields.length;j++)
				{
					if ((typeof form.elements[i].name!='undefined') && (cpf_field.possible_fields[j]==form.elements[i].name))
					{
						return form.elements[i];
					}
				}
			}
		}

		return null;
	}

	function inject_form_select_chaining__element(element,cpf_field,initial_run)
	{
		var cpf_fields=window.nested_csv_structure.cpf_fields;

		var changes_made_already=true;

		if (cpf_field.csv_parent_heading!==null) // We need to look at parent to filter possibilities, if we have one
		{
			var current_value=(element.selectedIndex==-1)?'':element.options[element.selectedIndex].value;

			element.innerHTML=''; // Wipe list contents
			var option;

			var parent_cpf_field_element=find_cpf_field_element(element.form,cpf_fields[cpf_field.csv_parent_heading]);
			var current_parent_value=(parent_cpf_field_element.selectedIndex==-1)?'':parent_cpf_field_element.options[parent_cpf_field_element.selectedIndex].value;
			if (current_parent_value=='') // Parent unset, so this is
			{
				option=document.createElement('option');
				element.add(option,null);
				set_inner_html(option,'".addslashes(do_lang('SELECT_OTHER_FIRST','xxx'))."'.replace(/xxx/g,cpf_fields[cpf_field.csv_parent_heading].label));
				option.value='';
			} else // Parent is set, so we need to filter possibilities
			{
				// Work out available (filtered) possiblities
				var csv_data=window.nested_csv_structure.csv_files[cpf_field.csv_filename].data;
				var possibilities=[];
				for (var i=0;i<csv_data.length;i++)
				{
					if (csv_data[i][cpf_field.csv_parent_heading]==current_parent_value)
					{
						possibilities.push(csv_data[i][cpf_field.csv_heading]);
					}
				}
				possibilities.sort();

				// Add possibilities, selecting one if it matches old selection (i.e. continuity maintained)
				option=document.createElement('option');
				element.add(option,null);
				set_inner_html(option,'".addslashes(do_lang('PLEASE_SELECT'))."');
				option.value='';
				var previous_one=null;
				for (var i=0;i<possibilities.length;i++)
				{
					if (previous_one!=possibilities[i]) // don't allow dupes (which we know are sequential due to sorting)
					{ // not a dupe
						option=document.createElement('option');
						element.add(option,null);
						set_inner_html(option,escape_html(possibilities[i]));
						option.value=possibilities[i];
						if (possibilities[i]==current_value) option.selected=true;
						previous_one=possibilities[i];
					}
				}
				if (element.options.length==2) element.selectedIndex=1; // Only one thing to select, so may as well auto-select it
			}

			changes_made_already=true;
		} else
		{
			changes_made_already=false;
		}

		if (initial_run) // This may effectively be called on non-initial runs, but it would be due to the list filter changes causing a selection change that propagates
		{
			var all_refresh_functions=[];

			if (typeof window.console!='undefined')
				console.log('Looking for children of '+cpf_field.csv_heading+'...');

			for (var i in cpf_fields)
			{
				var child_cpf_field=cpf_fields[i],refresh_function,child_cpf_field_element;

				if (child_cpf_field.csv_parent_heading==cpf_field.csv_heading)
				{
					if (typeof window.console!='undefined')
						console.log(' '+cpf_field.csv_heading+' has child '+child_cpf_field.csv_heading);

					child_cpf_field_element=find_cpf_field_element(element.form,child_cpf_field);

					refresh_function=function(child_cpf_field_element,child_cpf_field) { return function() {
						if (typeof window.console!='undefined')
							console.log('UPDATING: '+child_cpf_field.csv_heading);

						if (child_cpf_field_element)
							inject_form_select_chaining__element(child_cpf_field_element,child_cpf_field,false);
					}; }(child_cpf_field_element,child_cpf_field);

					all_refresh_functions.push(refresh_function);
				}
			}

			element.onchange=function() {
				for (var i=0;i<all_refresh_functions.length;i++)
				{
					all_refresh_functions[i]();
				}
			};
		} else
		{
			element.onchange(); // Cascade
		}
	}
";
