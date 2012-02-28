<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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
		$info['parameters']=array('title','region','cluster','filter_term','filter_category','geolocate_user','latfield','longfield','catalogue','width','height',/*'api_key',*/'zoom','center','latitude','longitude','show_links','min_latitude','max_latitude','min_longitude','max_longitude','star_entry','filter_hours','max_results','extra_sources');
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
		if (!array_key_exists('catalogue',$map)) $map['catalogue']='';
		if (!array_key_exists('longfield',$map)) $map['longfield']='Longitude';
		if (!array_key_exists('latfield',$map)) $map['latfield']='Latitude';
		$min_latitude=array_key_exists('min_latitude',$map)?$map['min_latitude']:'';
		$max_latitude=array_key_exists('max_latitude',$map)?$map['max_latitude']:'';
		$min_longitude=array_key_exists('min_longitude',$map)?$map['min_longitude']:'';
		$max_longitude=array_key_exists('max_longitude',$map)?$map['max_longitude']:'';
		$longitude_key=$map['longfield'];
		$latitude_key=$map['latfield'];
		$catalogue_name=$map['catalogue'];
		$star_entry=array_key_exists('star_entry',$map)?$map['star_entry']:'';
		$max_results=((array_key_exists('max_results',$map)) && ($map['max_results']!=''))?intval($map['max_results']):1000;
		$icon=array_key_exists('icon',$map)?$map['icon']:'';
		if (!array_key_exists('filter_category',$map)) $map['filter_category']='';
		if (!array_key_exists('filter_term',$map)) $map['filter_term']='';
		if (!array_key_exists('filter_hours',$map)) $map['filter_hours']='';

		$data=array();
		if ($catalogue_name!='')
		{
			// Data query
			$query='SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'catalogue_entries WHERE ce_validated=1 AND '.db_string_equal_to('c_name',$catalogue_name);

			// Filtering
			if ($map['filter_category']!='')
			{
				require_code('ocfiltering');
				$query.=' AND ('.ocfilter_to_sqlfragment($map['filter_category'],'id','catalogue_categories','cc_parent_id','cc_id','id').')';
			}
			if ($map['filter_hours']!='')
			{
				$query.=' AND ce_add_date>'.strval(time()-60*60*intval($map['filter_hours']));
			}

			// Info about our catalogue
			$catalogue_rows=$GLOBALS['SITE_DB']->query_select('catalogues',array('*'),array('c_name'=>$catalogue_name),'',1);
			if (!array_key_exists(0,$catalogue_rows))
			{
				return paragraph('Could not find the catalogue named "'.escape_html($catalogue_name).'".','','nothing_here');
			}
			$catalogue_row=$catalogue_rows[0];

			// Get results
			$entries_to_show=array();
			if ($star_entry!='') // Ensure this entry loads
			{
				$entries_to_show=array_merge($entries_to_show,$GLOBALS['SITE_DB']->query($query.' AND id='.strval(intval($star_entry))));
				$query.=' AND id<>'.strval(intval($star_entry));
			}
			$entries_to_show=array_merge($entries_to_show,$GLOBALS['SITE_DB']->query($query.' ORDER BY ce_add_date DESC',$max_results));
			if ((count($entries_to_show)==0) && (($min_latitude=='') || ($max_latitude=='') || ($min_longitude=='') || ($max_longitude==''))) // If there's nothing to show and no given bounds
			{
				//return paragraph(do_lang_tempcode('NO_ENTRIES'),'','nothing_here');
			}

			// Make marker data Javascript-friendly
			foreach($entries_to_show as $i=>$entry_row)
			{
				$entry_row['allow_rating']=0; // Performance: So rating is not loaded
			
				$details=get_catalogue_entry_map($entry_row,$catalogue_row,'CATEGORY',$catalogue_name,NULL);

				$two_d_list=$details['FIELDS_2D'];

				$longitude=NULL;
				$latitude=NULL;
				$entry_title='';
				$all_output='';
				foreach ($two_d_list as $index=>$l)
				{
					if ($l['NAME']==$longitude_key) $longitude=$l['VALUE'];
					if ($l['NAME']==$latitude_key) $latitude=$l['VALUE'];
					if ($index==0) $entry_title=$l['VALUE'];
					$all_output.=(is_object($l['VALUE'])?$l['VALUE']->evaluate():$l['VALUE']).' ';
				}
				if (is_object($longitude)) $longitude=$longitude->evaluate();
				if (is_object($latitude)) $latitude=$latitude->evaluate();
				if (is_object($entry_title)) $entry_title=$entry_title->evaluate();

				if ((is_numeric($longitude)) && (is_numeric($latitude)))
				{
					if (($map['filter_term']=='') || (strpos(strtolower($all_output),strtolower($map['filter_term']))!==false))
					{
						$details['LONGITUDE']=float_to_raw_string(floatval($longitude));
						$details['LATITUDE']=float_to_raw_string(floatval($latitude));

						$details['ENTRY_TITLE']=$entry_title;

						$entry_content=do_template('CATALOGUE_googlemap_ENTRY_EMBED',$details,NULL,false,'CATALOGUE_DEFAULT_ENTRY_EMBED');//put_in_standard_box(hyperlink($url,do_lang_tempcode('VIEW')),do_lang_tempcode('CATALOGUE_ENTRY').' ('.do_lang_tempcode('IN',get_translated_text($catalogue['c_title'])).')');
						$details['ENTRY_CONTENT']=$entry_content;
					
						$details['STAR']='0';
						if ($star_entry!='')
						{
							if (($entry_row['id']==intval($star_entry)))
								$details['STAR']='1';
						}

						$details['CC_ID']=strval($entry_row['cc_id']);
						
						$details['ICON']='';

						$data[]=$details;
					}
				}
			}
		}

		$hooks_to_use=explode('|',array_key_exists('extra_sources',$map)?$map['extra_sources']:'');
		$hooks=find_all_hooks('blocks','main_google_map');
		foreach (array_keys($hooks) as $hook)
		{
			if (in_array($hook,$hooks_to_use))
			{
				require_code('hooks/blocks/main_google_map/'.$hook);
				$ob=object_factory('Hook_Map_'.$hook);
				$data=array_merge($data,$ob->get_data($map,$max_results,$min_latitude,$max_latitude,$min_longitude,$max_longitude,$latitude_key,$longitude_key,$catalogue_row,$catalogue_name));
			}
		}

		$uniqid=uniqid('');
		$div_id='div_'.$catalogue_name.'_'.$uniqid;

		return do_template('BLOCK_MAIN_GOOGLE_MAP',array('TITLE'=>$map['title'],'ICON'=>$icon,'MIN_LATITUDE'=>$min_latitude,'MAX_LATITUDE'=>$max_latitude,'MIN_LONGITUDE'=>$min_longitude,'MAX_LONGITUDE'=>$max_longitude,'DATA'=>$data,'SHOW_LINKS'=>$set_show_links,'DIV_ID'=>$div_id,'CLUSTER'=>$cluster,'REGION'=>$map['region'],'WIDTH'=>$mapwidth, 'HEIGHT'=>$mapheight, 'LATITUDE'=>$map['latitude'],'LONGITUDE'=>$map['longitude'],'ZOOM'=>$set_zoom,'CENTER'=>$set_center));
	}
}
