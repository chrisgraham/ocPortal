<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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
		$info['parameters']=array('param','default_sort_column','max','labels','columns');
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

		$labels=empty($map['labels'])?array():explode(',',$map['labels']);
		$columns=empty($map['columns'])?array():array_map('intval',explode(',',$map['columns']));

		// What will we be reading?
		$file=empty($map['param'])?'example.csv':$map['param'];

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
			while (($row=fgetcsv($myfile))!==false)
			{
				if ($columns!=array())
				{
					foreach (array_keys($row) as $j=>$key)
					{
						if (!in_array($j+1,$columns)) unset($row[$key]);
					}
					$row=array_values($row);
				}

				if (implode('',$row)=='') continue;
				$_rows[]=$row;
				$i++;
			}
			fclose($myfile);

			// Work out header
			$headers=array();
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
					'FILTERABLE'=>array(),
				);
			}
		} else
		{
			// Database table...

			if (strpos(strtolower($file),'f_members')!==false)
				return paragraph('Security filter disallows display of the '.escape_html($file).' table.','red_alert');

			$_rows=array();
			$records=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$file);
			if (count($records)==0)
			{
				return paragraph(do_lang('NO_ENTRIES'),'red_alert');
			}
			$header_row=array();
			foreach ($records as $i=>$record)
			{
				if ($columns!=array())
				{
					foreach (array_keys($record) as $j=>$key)
					{
						if (!in_array($j+1,$columns)) unset($record[$key]);
					}
				}

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
				}
				$_rows[]=@array_map('strval',array_values($record));
			}
		}

		// Make sure each row has the right column count
		foreach ($_rows as &$row)
		{
			for ($j=count($row);$j<count($headers);$j++) // Too few? Pad.
			{
				$row[$j]='';
			}
			for ($j=count($headers);$j<count($row);$j++) // Too many? Truncate.
			{
				unset($row[$j]);
			}
		}

		// Work out data types
		foreach ($headers as $j=>&$header)
		{
			if ($header['SORTABLE_TYPE']!==NULL) continue; // Already known

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
			$header['SORTABLE_TYPE']=is_null($sortable_type)?'alphanumeric':$sortable_type;
		}

		// Work out filterability
		foreach ($headers as $j=>&$header)
		{
			if ($header['FILTERABLE']!==NULL) continue; // Already known

			$values=array();
			foreach ($_rows as $row)
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
		foreach ($_rows as $i=>$row)
		{
			foreach ($row as $j=>&$value)
			{
				$value=$this->apply_formatting($value,$headers[$j]['SORTABLE_TYPE']);
			}

			$rows->attach(do_template('SORTABLE_TABLE_ROW',array(
				'VALUES'=>$row,
			)));
		}

		// Final render...

		$id=uniqid('');

		$default_sort_column=max(0,empty($map['default_sort_column'])?0:(intval($map['default_sort_column'])-1));
		$max=empty($map['max'])?20:intval($map['max']);

		return do_template('SORTABLE_TABLE',array(
			'ID'=>$id,
			'DEFAULT_SORT_COLUMN'=>strval($default_sort_column),
			'MAX'=>strval($max),
			'HEADERS'=>$headers,
			'ROWS'=>$rows,
			'NUM_ROWS'=>strval(count($_rows)),
		));
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
