<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_google_map_users
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
		$info['parameters']=array('title','region','cluster','filter_usergroup','filter_term','geolocate_user','username_prefix','latitude','longitude','width','height',/*'api_key',no longer used*/'zoom','center');
		return $info;
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		//add cpf
		$GLOBALS['FORUM_DRIVER']->install_create_custom_field('latitude',100,0,1,1,0,'','short_text');
		$GLOBALS['FORUM_DRIVER']->install_create_custom_field('longitude',100,0,1,1,0,'','short_text');
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_javascript('javascript_ajax');
		require_lang('google_map_users');

		// Set up config/defaults
		$geolocate_user=array_key_exists('geolocate_user',$map)?$map['geolocate_user']:'1';
		if (!array_key_exists('title',$map)) $map['title']='';
		if (!array_key_exists('region',$map)) $map['region']='';
		if (!array_key_exists('username_prefix',$map)) $map['username_prefix']='Member: ';
		if (!array_key_exists('latitude',$map)) $map['latitude']='';
		if (!array_key_exists('longitude',$map)) $map['longitude']='';
		$mapwidth=array_key_exists('width',$map)?$map['width']:'100%';
		$mapheight=array_key_exists('height',$map)?$map['height']:'300px';
		$api_key=array_key_exists('api_key',$map)?$map['api_key']:'';
		$set_zoom=array_key_exists('zoom',$map)?$map['zoom']:'3';
		$set_center=array_key_exists('center',$map)?$map['center']:'0';
		$cluster=array_key_exists('cluster',$map)?$map['cluster']:'0';

		// Ensure installed
		$latitude_cpf_id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON f.cf_name=t.id','f.id',array('text_original'=>'ocp_latitude'));
		$longitude_cpf_id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON f.cf_name=t.id','f.id',array('text_original'=>'ocp_longitude'));
		if(is_null($longitude_cpf_id) || is_null($latitude_cpf_id))
		{
			require_code('zones2');
			reinstall_block('main_google_map_users');

			$latitude_cpf_id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON f.cf_name=t.id','f.id',array('text_original'=>'ocp_latitude'));
			$longitude_cpf_id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON f.cf_name=t.id','f.id',array('text_original'=>'ocp_longitude'));

			//return paragraph('The maps block has not been installed correctly, the CPFs are missing.','','nothing_here');
		}

		// Data query
		$query='SELECT m_username,mf_member_id,m_primary_group,field_'.$latitude_cpf_id.',field_'.$longitude_cpf_id.' FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m ON m.id=f.mf_member_id WHERE '.db_string_not_equal_to('field_'.$longitude_cpf_id,'').' AND '.db_string_not_equal_to('field_'.$latitude_cpf_id,'');

		// Filtering
		if (!array_key_exists('filter_usergroup',$map)) $map['filter_usergroup']='';
		if ($map['filter_usergroup']!='')
		{
			require_code('ocfiltering');
			$allowed_groups=ocfilter_to_idlist_using_memory($map['filter_usergroup'],$GLOBALS['FORUM_DRIVER']->get_usergroup_list());
			$query.=' AND (';
			foreach ($allowed_groups as $i=>$bit)
			{
				if ($i!=0) $query.=' OR ';
				$query.='m_primary_group='.$bit;
			}
			$query.=')';
		}
		if (!array_key_exists('filter_term',$map)) $map['filter_term']='';
		if ($map['filter_term']!='')
		{
			$query.=' AND m_username LIKE \''.db_encode_like('%'.$map['filter_term'].'%').'\'';
		}

		// Get results
		$members_to_show=$GLOBALS['FORUM_DB']->query($query);

		if (count($members_to_show)==0) // If there's nothing to show
		{
			if ($geolocate_user=='0') // Exit, but only if we can't geolocate users via the block (i.e. self-healing)
				return paragraph(do_lang_tempcode('NO_ENTRIES'),'','nothing_here');
		}

		// Make marker data Javascript-friendly
		$member_data_js="var data=[";
		foreach($members_to_show as $i=>$member_data)
		{
			if ($i!=0) $member_data_js.=',';
			$member_data_js.="['".addslashes($member_data['m_username'])."',".
				float_to_raw_string(floatval($member_data['field_'.$latitude_cpf_id])).",".
				float_to_raw_string(floatval($member_data['field_'.$longitude_cpf_id])).",".
				strval($member_data['m_primary_group'])."]";
		}
		$member_data_js.="];";

		// See if we need to detect the current user's long/lat
		$member_longitude=get_ocp_cpf('longitude',get_member());
		$member_latitude=get_ocp_cpf('latitude',get_member());
		$update_url=get_base_url().'/data_custom/set_coordinates.php?mid='.strval(get_member()).'&coord=';
		if ((!empty($member_longitude) && !empty($member_latitude)) || (is_guest()))
		{
			$update_url='';
		}

		return do_template('BLOCK_MAIN_GOOGLE_MAP_USERS',array('TITLE'=>$map['title'],'GEOLOCATE_USER'=>$geolocate_user,'CLUSTER'=>$cluster,'SET_COORD_URL'=>$update_url,'REGION'=>$map['region'],'DATA'=>$member_data_js,'USERNAME_PREFIX'=>$map['username_prefix'],'WIDTH'=>$mapwidth, 'HEIGHT'=>$mapheight, 'LATITUDE'=>$map['latitude'], 'LONGITUDE'=>$map['longitude'], 'ZOOM'=>$set_zoom,'CENTER'=>$set_center));
	}
}


