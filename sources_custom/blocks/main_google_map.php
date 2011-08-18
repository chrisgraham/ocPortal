<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_google_map
{
	
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Kamen / Chris Graham / temp1024';
		$info['organisation']='Miscellaneous';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('title','region','cluster','filter_term','filter_category','geolocate_user','latfield','longfield','catalogue','width','height',/*'api_key',*/'zoom','center','latitude','longitude','show_links');
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
		require_code('catalogues');
		require_lang('main_google_map');

		// Set up config/defaults
		$geolocate_user=array_key_exists('geolocate_user',$map)?$map['geolocate_user']:'1';
		if (!array_key_exists('title',$map)) $map['title']='';
		if (!array_key_exists('region',$map)) $map['region']='';
		if (!array_key_exists('latitude',$map)) $map['latitude']='0';
		if (!array_key_exists('longitude',$map)) $map['longitude']='0';
		$mapwidth=array_key_exists('width',$map)?$map['width']:'100%';
		$mapheight=array_key_exists('height',$map)?$map['height']:'300px';
		$api_key=array_key_exists('api_key',$map)?$map['api_key']:'';
		$set_zoom=array_key_exists('zoom',$map)?$map['zoom']:'3';
		$set_center=array_key_exists('center',$map)?$map['center']:'0';
		$set_show_links=array_key_exists('show_links',$map)?$map['show_links']:'1';
		$cluster=array_key_exists('cluster',$map)?$map['cluster']:'0';
		if ((!array_key_exists('catalogue',$map)) || ($map['catalogue']=='')) $map['catalogue']='contacts'; //default value
		if (!array_key_exists('longfield',$map)) $map['longfield']='Longitude';
		if (!array_key_exists('latfield',$map)) $map['latfield']='Latitude';
		$longitude_key=$map['longfield'];
		$latitude_key=$map['latfield'];
		$catalogue_name=$map['catalogue'];

		// Data query
		$query='SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'catalogue_entries WHERE '.db_string_equal_to('c_name',$catalogue_name);

		// Filtering
		if (!array_key_exists('filter_category',$map)) $map['filter_category']='';
		if ($map['filter_category']!='')
		{
			require_code('ocfiltering');
			$query.=' AND ('.ocfilter_to_sqlfragment($map['filter_category'],'id','catalogue_categories','cc_parent_id','id','cc_id').')';
		}
		if (!array_key_exists('filter_term',$map)) $map['filter_term']='';

		$entries_url=build_url(array('page'=>'catalogues','type'=>'entry','id'=>'!'),'_SEARCH');
		$entries_url=$entries_url->evaluate();

		// Info about our catalogue
		$catalogue_rows=$GLOBALS['SITE_DB']->query_select('catalogues',array('*'),array('c_name'=>$catalogue_name),'',1);
		if (!array_key_exists(0,$catalogue_rows))
		{
			return paragraph('Could not find the catalogue named "'.escape_html($catalogue_name).'".','','nothing_here');
		}
		$catalogue_row=$catalogue_rows[0];

		// Get results
		$entries_to_show=$GLOBALS['SITE_DB']->query($query.' ORDER BY ce_add_date DESC',4000/*reasonable limit*/);
		if (count($entries_to_show)==0) // If there's nothing to show
		{
			return paragraph(do_lang_tempcode('NO_ENTRIES'),'','nothing_here');
		}

		// Make marker data Javascript-friendly
		$data=array();
		foreach($entries_to_show as $i=>$entry_row)
		{
			$details=get_catalogue_entry_map($entry_row,$catalogue_row,'PAGE','DEFAULT',NULL);

			$two_d_list=$details['FIELDS_2D'];

			$longitude=NULL;
			$latitude=NULL;
			$entry_title='';
			foreach ($two_d_list as $index=>$l)
			{
				if ($l['NAME']==$longitude_key) $longitude=$l['VALUE'];
				if ($l['NAME']==$latitude_key) $latitude=$l['VALUE'];
				if ($index==0) $entry_title=$l['VALUE'];
			}
			if (is_object($longitude)) $longitude=$longitude->evaluate();
			if (is_object($latitude)) $latitude=$latitude->evaluate();
			if (is_object($entry_title)) $entry_title=$entry_title->evaluate();

			if ((is_numeric($longitude)) && (is_numeric($latitude)))
			{
				if (($map['filter_term']=='') || (strpos($entry_title,$map['filter_term'])!==false))
				{
					$details['LONGITUDE']=float_to_raw_string(floatval($longitude));
					$details['LATITUDE']=float_to_raw_string(floatval($latitude));
					$details['ENTRY_TITLE']=$entry_title;
					$details['CC_ID']=strval($entry_row['cc_id']);
					
					$data[]=$details;
				}
			}
		}

		$uniqid=uniqid('');
		$div_id='div_'.$catalogue_name.'_'.$uniqid;

		return do_template('BLOCK_MAIN_GOOGLE_MAP',array('TITLE'=>$map['title'],'DATA'=>$data,'ENTRIES_URL'=>$entries_url,'SHOW_LINKS'=>$set_show_links,'DIV_ID'=>$div_id,'CLUSTER'=>$cluster,'REGION'=>$map['region'],'WIDTH'=>$mapwidth, 'HEIGHT'=>$mapheight, 'LATITUDE'=>$map['latitude'], 'LONGITUDE'=>$map['longitude'], 'ZOOM'=>$set_zoom,'CENTER'=>$set_center));
	}
}
