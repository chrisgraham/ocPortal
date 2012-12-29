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
		$info['parameters']=array('filter','ocselect','title','region','cluster','geolocate_user','latfield','longfield','catalogue','width','height',/*'api_key',*/'zoom','center','latitude','longitude','show_links','min_latitude','max_latitude','min_longitude','max_longitude','star_entry','max_results','extra_sources','guid');
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
		require_lang('google_map');

		// Set up config/defaults
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
		if (!array_key_exists('filter',$map)) $map['filter']='';
		$ocselect=array_key_exists('ocselect',$map)?$map['ocselect']:'';
		$guid=array_key_exists('guid',$map)?$map['guid']:'';

		$data=array();

		// Info about our catalogue
		$catalogue_row=mixed();
		if ($catalogue_name!='')
		{
			$catalogue_rows=$GLOBALS['SITE_DB']->query_select('catalogues',array('*'),array('c_name'=>$catalogue_name),'',1);
			if (!array_key_exists(0,$catalogue_rows))
			{
				return paragraph('Could not find the catalogue named "'.escape_html($catalogue_name).'".','','nothing_here');
			}
			$catalogue_row=$catalogue_rows[0];
		}

		$hooks_to_use=explode('|',array_key_exists('extra_sources',$map)?$map['extra_sources']:'');
		$hooks=find_all_hooks('blocks','main_google_map');
		$entries_to_load=array();
		foreach (array_keys($hooks) as $hook)
		{
			if (in_array($hook,$hooks_to_use))
			{
				require_code('hooks/blocks/main_google_map/'.$hook);
				$ob=object_factory('Hook_Map_'.$hook);
				$hook_results=$ob->get_data($map,$max_results,$min_latitude,$max_latitude,$min_longitude,$max_longitude,$latitude_key,$longitude_key,$catalogue_row,$catalogue_name);
				$data=array_merge($data,$hook_results[0]);
				$entries_to_load=$hook_results[1]+$entries_to_load;
			}
		}

		if ($star_entry!='') // Ensure this entry loads
		{
			$entries_to_load[intval($star_entry)]=true;
		}

		if ($catalogue_name!='')
		{
			// Preparing for data query
			$where='r.ce_validated=1 AND '.db_string_equal_to('r.c_name',$catalogue_name);
			$join='';
			$extra_select_sql='';

			// Filtering
			$where.=' AND (1=1';
			if ($map['filter']!='')
			{
				if ($map['filter']=='/')
				{
					$where.=' AND (0=1)';
				} else
				{
					require_code('ocfiltering');
					$where.=' AND ('.ocfilter_to_sqlfragment($map['filter'],'r.id','catalogue_categories','cc_parent_id','cc_id','r.id').')';
				}
			}
			if ($ocselect!='')
			{
				// Convert the filters to SQL
				require_code('ocselect');
				list($extra_select,$extra_join,$extra_where)=ocselect_to_sql($GLOBALS['SITE_DB'],parse_ocselect($ocselect),'catalogue_entry',$catalogue_name);
				$extra_select_sql.=implode('',$extra_select);
				$join.=implode('',$extra_join);
				$where.=$extra_where;
			}
			$where.=')';
			if (count($entries_to_load)!=0)
			{
				foreach ($entries_to_load as $entry_id=>$allow)
				{
					if ($allow)
						$where.=' OR r.id='.strval($entry_id);
				}
			}

			// Finishing data query
			$query='SELECT r.*'.$extra_select_sql.' FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'catalogue_entries r'.$join.' WHERE '.$where;

			// Get results
			$entries_to_show=array();
			$entries_to_show=array_merge($entries_to_show,$GLOBALS['SITE_DB']->query($query.' ORDER BY ce_add_date DESC',$max_results));
			if ((count($entries_to_show)==0) && (($min_latitude=='') || ($max_latitude=='') || ($min_longitude=='') || ($max_longitude==''))) // If there's nothing to show and no given bounds
			{
				//return paragraph(do_lang_tempcode('NO_ENTRIES'),'','nothing_here');
			}

			// Make marker data Javascript-friendly
			foreach ($entries_to_show as $i=>$entry_row)
			{
				$entry_row['allow_rating']=0; // Performance: So rating is not loaded

				$details=get_catalogue_entry_map($entry_row,$catalogue_row,'CATEGORY',$catalogue_name,NULL);

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
					$details['LONGITUDE']=float_to_raw_string(floatval($longitude),10);
					$details['LATITUDE']=float_to_raw_string(floatval($latitude),10);

					$details['ENTRY_TITLE']=$entry_title;
					if (isset($map['guid']) && $map['guid']!='') $details['_GUID']=$map['guid'];

					$entry_content=do_template('CATALOGUE_googlemap_FIELDMAP_ENTRY_WRAP',$details+array('GIVE_CONTEXT'=>false),NULL,false,'CATALOGUE_DEFAULT_FIELDMAP_ENTRY_WRAP');
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

		$uniqid=uniqid('');
		$div_id='div_'.$catalogue_name.'_'.$uniqid;

		return do_template('BLOCK_MAIN_GOOGLE_MAP',array(
			'_GUID'=>($guid=='')?'939dd8fe2397bba0609fba129a8a3bfd':$guid,
			'TITLE'=>$map['title'],
			'ICON'=>$icon,
			'MIN_LATITUDE'=>$min_latitude,
			'MAX_LATITUDE'=>$max_latitude,
			'MIN_LONGITUDE'=>$min_longitude,
			'MAX_LONGITUDE'=>$max_longitude,
			'DATA'=>$data,
			'SHOW_LINKS'=>$set_show_links,
			'DIV_ID'=>$div_id,
			'CLUSTER'=>$cluster,
			'REGION'=>$map['region'],
			'WIDTH'=>$mapwidth,
			'HEIGHT'=>$mapheight,
			'LATITUDE'=>$map['latitude'],
			'LONGITUDE'=>$map['longitude'],
			'ZOOM'=>$set_zoom,
			'CENTER'=>$set_center,
		));
	}
}
