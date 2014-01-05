<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		sortable_tables
 */

class Block_main_sortable_table
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=1;
		$info['locked']=false;
		$info['parameters']=array('param','default_sort_column','max','labels','columns_display','columns_tooltip','guid');
		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_javascript('javascript_sortable_tables');
		require_css('sortable_tables');

		$letters=array(
			'A',
			'B',
			'C',
			'D',
			'E',
			'F',
			'G',
			'H',
			'I',
			'J',
			'K',
			'L',
			'M',
			'N',
			'O',
			'P',
			'Q',
			'R',
			'S',
			'T',
			'U',
			'V',
			'W',
			'X',
			'Y',
			'Z',
		);
		$numbers=array(
			'1',
			'2',
			'3',
			'4',
			'5',
			'6',
			'7',
			'8',
			'9',
			'10',
			'11',
			'12',
			'13',
			'14',
			'15',
			'16',
			'17',
			'18',
			'19',
			'20',
			'21',
			'22',
			'23',
			'24',
			'25',
			'26',
		);
		if (!empty($map['columns_display'])) $map['columns_display']=str_replace($letters,$numbers,$map['columns_display']);
		if (!empty($map['columns_tooltip'])) $map['columns_tooltip']=str_replace($letters,$numbers,$map['columns_tooltip']);

		$labels=empty($map['labels'])?array():explode(',',$map['labels']);
		$columns_display=empty($map['columns_display'])?array():array_map('intval',explode(',',$map['columns_display']));
		$columns_tooltip=empty($map['columns_tooltip'])?array():array_map('intval',explode(',',$map['columns_tooltip']));

		$guid=empty($map['guid'])?'':$map['guid'];

		// What will we be reading?
		$file=empty($map['param'])?'example.csv':$map['param'];

		$headers=array();
		$_rows=array();
		$tooltip_headers=array();
		$_rows_tooltip=array();
		$_rows_raw=array();

		// CSV file
		if ((substr($file,-4)=='.csv') || (preg_match('#^[\w\.]+$#',$file)==0/*Not safe as a table name*/))
		{
			// Find/validate path
			if (substr($file,-4)!='.csv') return paragraph('We only accept CSV files, for security reasons.','red_alert');
			$path=get_custom_file_base().'/uploads/website_specific/'.filter_naughty($file);
			if (!is_file($path)) return paragraph('File not found ('.escape_html($file).').','red_alert');

			// Load data
			$i=0;
			$myfile=fopen($path,'rt');
			$full_header_row=mixed();
			while (($row=fgetcsv($myfile))!==false)
			{
				// Fix any bad unicode
				if (get_charset()=='utf-8')
				{
					foreach ($row as $j=>$val)
					{
						$val=fix_bad_unicode($val);
					}
				}

				// Get tooltip columns
				$row_tooltip=array();
				foreach ($row as $j=>$val)
				{
					if (in_array($j+1,$columns_tooltip))
					{
						$row_tooltip[]=$val;
					}
				}
				$_rows_tooltip[]=$row_tooltip;

				if ($i!=0)
				{
					// Make sure row has the right column count
					for ($j=count($row);$j<count($full_header_row);$j++) // Too few? Pad.
					{
						$row[$j]='';
					}
					for ($j=count($full_header_row);$j<count($row);$j++) // Too many? Truncate.
					{
						unset($row[$j]);
					}

					$_rows_raw[]=array_combine($full_header_row,$row);
				} else
				{
					$full_header_row=$row;
				}

				// Filter to displayed table columns
				if ($columns_display!=array() || $columns_tooltip!=array())
				{
					foreach (array_keys($row) as $key)
					{
						if ($columns_display==array())
						{
							if (in_array($key+1,$columns_tooltip)) unset($row[$key]);
						} else
						{
							if (!in_array($key+1,$columns_display)) unset($row[$key]);
						}
					}
					$row=array_values($row);
				}

				if (implode('',$row)=='') continue;
				$_rows[]=$row;
				$i++;
			}
			fclose($myfile);

			// Work out header
			if (isset($_rows[0]))
			{
				$header_row=array_shift($_rows);

				if (count($header_row)<2)
				{
					return paragraph('We expect at least two headers. Make sure you save as a true comma-deliminated CSV file.','red_alert');
				}
			} else
			{
				return paragraph('Empty CSV file.','red_alert');
			}

			// Prepare initial header templating
			foreach ($header_row as $j=>$_header)
			{
				$headers[]=array(
					'LABEL'=>isset($labels[$j])?$labels[$j]:$_header,
					'SORTABLE_TYPE'=>NULL,
					'FILTERABLE'=>NULL,
				);
			}
			$tooltip_header_row=array_shift($_rows_tooltip);
			foreach ($tooltip_header_row as $j=>$_header)
			{
				$tooltip_headers[]=isset($labels[$j])?$labels[$j]:$_header;
			}
		} else
		{
			// Database table...

			if (strpos(strtolower($file),'f_members')!==false)
				return paragraph('Security filter disallows display of the '.escape_html($file).' table.','red_alert');

			$records=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$file);
			if (count($records)==0)
			{
				return paragraph(do_lang('NO_ENTRIES'),'red_alert');
			}
			$header_row=array();
			foreach ($records as $i=>$record)
			{
				// Get tooltip columns
				$row_tooltip=array();
				$j=0;
				foreach ($record as $key=>$val)
				{
					if (in_array($j+1,$columns_tooltip))
					{
						$row_tooltip[$key]=$val;
					}
					$j++;
				}
				$_rows_tooltip[]=array_values($row_tooltip);

				if ($i!=0)
					$_rows_raw[]=$record;

				// Filter to displayed table columns
				if ($columns_display!=array() || $columns_tooltip!=array())
				{
					foreach (array_keys($record) as $j=>$key)
					{
						if ($columns_display==array())
						{
							if (in_array($j+1,$columns_tooltip)) unset($record[$key]);
						} else
						{
							if (!in_array($j+1,$columns_display)) unset($record[$key]);
						}
					}
					$row=array_values($record);
				}
				$_rows[]=@array_map('strval',array_values($record));

				if ($i==0)
				{
					$prefixes=array();
					foreach (array_keys($record) as $key)
					{
						$prefixes[]=(strpos($key,'_')===false)?'':(preg_replace('#_.*$#s','',$key).'_');
					}
					$prefixes=array_count_values($prefixes);
					asort($prefixes);
					$prefix='';
					if (end($prefixes)>count($record)-3)
					{
						$prefix=key($prefixes);
					}

					foreach (array_keys($record) as $j=>$key)
					{
						$headers[]=array(
							'LABEL'=>isset($labels[$j])?$labels[$j]:titleify(preg_replace('#^'.preg_quote($prefix,'#').'#','',$key)),
							'SORTABLE_TYPE'=>NULL,
							'FILTERABLE'=>NULL,
						);
					}

					foreach (array_keys($row_tooltip) as $j=>$key)
					{
						$tooltip_headers[]=isset($labels[$j])?$labels[$j]:titleify(preg_replace('#^'.preg_quote($prefix,'#').'#','',$key));
					}
				}
			}
		}

		// Work out data types
		foreach ($headers as $j=>&$header)
		{
			if ($header['SORTABLE_TYPE']!==NULL) continue; // Already known

			$header['SORTABLE_TYPE']=$this->determine_field_type($_rows,$j);
		}

		// Work out filterability
		foreach ($headers as $j=>&$header)
		{
			if ($header['FILTERABLE']!==NULL) continue; // Already known

			$values=array();
			foreach ($_rows as &$row)
			{
				$values[]=$row[$j];
			}
			$values=array_unique($values);
			natsort($values);
			foreach ($values as $i=>$value)
			{
				$values[$i]=$this->apply_formatting($values[$i],$headers[$j]['SORTABLE_TYPE']);
			}
			$header['FILTERABLE']=(count($values)>10)?array():$values;
		}

		// Create template-ready data
		$rows=new ocp_tempcode();
		$tooltip_headers_sortable=array();
		foreach (array_keys($tooltip_headers) as $j)
		{
			$field_type=$this->determine_field_type($_rows_tooltip,$j);
			$tooltip_headers_sortable[]=$field_type;
		}
		foreach ($_rows as $i=>&$row)
		{
			foreach ($row as $j=>&$value)
			{
				$value=$this->apply_formatting($value,$headers[$j]['SORTABLE_TYPE']);
			}

			$tooltip_values=array();
			foreach ($tooltip_headers as $j=>&$header)
			{
				$tooltip_values[$header]=$this->apply_formatting($_rows_tooltip[$i][$j],$tooltip_headers_sortable[$j]);
			}

			$rows->attach(do_template('SORTABLE_TABLE_ROW',array(
				'_GUID'=>$guid,
				'VALUES'=>$row,
				'TOOLTIP_VALUES'=>$tooltip_values,
				'RAW_DATA'=>serialize($_rows_raw[$i]),
			)));
		}

		// Final render...

		$id=uniqid('');

		$default_sort_column=max(0,empty($map['default_sort_column'])?0:(intval($map['default_sort_column'])-1));
		$max=empty($map['max'])?20:intval($map['max']);

		return do_template('SORTABLE_TABLE',array(
			'_GUID'=>$guid,
			'ID'=>$id,
			'DEFAULT_SORT_COLUMN'=>strval($default_sort_column),
			'MAX'=>strval($max),
			'HEADERS'=>$headers,
			'ROWS'=>$rows,
			'NUM_ROWS'=>strval(count($_rows)),
		));
	}

	/**
	 * Find a field type for a row index.
	 *
	 * @param  array		Rows.
	 * @param  integer	Column offset.
	 * @return string		Field type.
	 * @set integer float date currency alphanumeric
	 */
	function determine_field_type($_rows,$j)
	{
		$sortable_type=mixed();
		foreach ($_rows as $row)
		{
			if ($row[$j]!='')
			{
				if ((is_numeric($row[$j])) && (strpos($row[$j],'.')===false))
				{
					if (is_null($sortable_type))
					{
						$sortable_type='integer';
					} else
					{
						if ($sortable_type!='integer' && $sortable_type!='float'/*an integer value can also fit a float*/)
						{
							$sortable_type=NULL;
							break;
						}
					}
					continue;
				}

				if ((is_numeric($row[$j])) && (strpos($row[$j],'.')!==false))
				{
					if ((is_null($sortable_type)) || ($sortable_type=='integer'/*an integer value may upgrade to a float*/))
					{
						$sortable_type='float';
					} else
					{
						if ($sortable_type!='float')
						{
							$sortable_type=NULL;
							break;
						}
					}
					continue;
				}

				if ((preg_match('#^\d\d\d\d-\d\d-\d\d$#',$row[$j])!=0) || (preg_match('#^\d\d-\d\d-\d\d\d\d$#',$row[$j])!=0))
				{
					if (is_null($sortable_type))
					{
						$sortable_type='date';
					} else
					{
						if ($sortable_type!='date')
						{
							$sortable_type=NULL;
							break;
						}
					}
					continue;
				}

				if (addon_installed('ecommerce'))
				{
					require_code('ecommerce');
					if (preg_match('#^'.preg_quote(ecommerce_get_currency_symbol(),'#').'#',$row[$j])!=0)
					{
						if (is_null($sortable_type))
						{
							$sortable_type='currency';
						} else
						{
							if ($sortable_type!='currency')
							{
								$sortable_type=NULL;
								break;
							}
						}
						continue;
					}
				}

				// No pattern matched, has to be alphanumeric
				$sortable_type=NULL;
				break;
			}
		}
		return is_null($sortable_type)?'alphanumeric':$sortable_type;
	}

	/**
	 * Apply formatting to a cell value.
	 *
	 * @param  string		Value to apply formatting to.
	 * @param  ID_TEXT	Sortable type.
	 * @set integer float date currency alphanumeric
	 * @return string		Formatted value.
	 */
	function apply_formatting($value,$sortable_type)
	{
		if (($sortable_type=='integer') && (is_numeric($value)))
			$value=number_format(intval($value),0,'.',',');

		if (($sortable_type=='float') && (is_numeric($value)))
		{
			$num_digits=0;
			if (strpos($value,'.')!==false) $num_digits=strlen($value)-strpos($value,'.')-1;
			$value=number_format(floatval($value),$num_digits,'.',',');
		}

		return $value;
	}

}
