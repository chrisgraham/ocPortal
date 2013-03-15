<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

require_code('relations');
$table_descriptions=get_table_descriptions();
$relation_map=get_relation_map();

$tables_by=get_tables_by_addon();

foreach($tables_by as $t=>$ts)
{
	echo '<h2>';
	echo escape_html($t);
	echo '</h2>';
	sort($ts);
	echo '<ul>';
	foreach ($ts as $table)
	{
		echo '<li>'.escape_html($table);
		if (isset($table_descriptions[$table]))
			echo ' &ndash; <span style="color: green">'.$table_descriptions[$table].'</span>';
		echo '<ul>';
		$fields=$GLOBALS['SITE_DB']->query_select('db_meta',array('m_name','m_type'),array('m_table'=>$table));
		foreach ($fields as $field)
		{
			$type=str_replace('?','',str_replace('*','',$field['m_type']));
			$extra='';
			if (isset($relation_map[$table.'.'.$field['m_name']]))
				$extra.=' ( &rarr; <strong>'.escape_html($relation_map[$table.'.'.$field['m_name']]).'</strong>)';
			if (strpos($field['m_type'],'*')!==false) $extra.=' (<u>Key field</u>)';
			if (strpos($field['m_type'],'?')!==false) $extra.=' (<em>May be NULL</em>)';
			echo '<li><strong>'.escape_html($type).'</strong> '.escape_html($field['m_name']).$extra.'</li>';
		}
		echo '</ul>';
		echo '<br /></li>';
	}
	echo '</ul>';
}
