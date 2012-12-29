<?php

function fix_geoposition($lstring,$category_id)
{
	$type='yahoo';

	// Web service to get remaining latitude/longitude
	if ($type=='bing')
	{
		$url='http://dev.virtualearth.net/REST/v1/Locations?query='.urlencode($lstring).'&o=xml&key=AvmgsVWtIoJeCnZXdDnu3dQ7izV9oOowHCNDwbN4R1RPA9OXjfsQX1Cr9HSrsY4j';
	} elseif ($type=='yahoo')
	{
		$url='http://where.yahooapis.com/geocode?q='.urlencode($lstring).'&appid=dj0yJmk9N0x3TTdPaDNvdElCJmQ9WVdrOWFGWjVOa3hzTldFbWNHbzlNVFU0TXpBMU9EWTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD1mNg--';
	} elseif ($type=='google')
	{
		$url='http://maps.googleapis.com/maps/api/geocode/xml?address='.urlencode($lstring).'&sensor=false';
	} else exit('unknown type');
	$result=http_download_file($url);
	$matches=array();
	if ((($type=='bing') && (preg_match('#<Latitude>([\-\d\.]+)</Latitude>\s*<Longitude>([\-\d\.]+)</Longitude>#',$result,$matches)!=0)) || (($type=='google') && (preg_match('#<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>#',$result,$matches)!=0)) || (($type=='yahoo') && (preg_match('#<latitude>([\-\d\.]+)</latitude>\s*<longitude>([\-\d\.]+)</longitude>#',$result,$matches)!=0)))
	{
		$latitude=floatval($matches[1]);
		$longitude=floatval($matches[2]);

		$fields=$GLOBALS['SITE_DB']->query_select('catalogue_fields',array('*'),array('c_name'=>'_catalogue_category'),'ORDER BY cf_order');
		require_code('content');
		$assocated_catalogue_entry_id=get_bound_content_entry('catalogue_category',strval($category_id));
		$GLOBALS['SITE_DB']->query_update('catalogue_efv_float',array('cv_value'=>$latitude),array('ce_id'=>$assocated_catalogue_entry_id,'cf_id'=>$fields[0]['id']),'',1);
		$GLOBALS['SITE_DB']->query_update('catalogue_efv_float',array('cv_value'=>$longitude),array('ce_id'=>$assocated_catalogue_entry_id,'cf_id'=>$fields[1]['id']),'',1);

		return '1';
	}
	return '0';
}

function find_nearest_location($latitude,$longitude,$latitude_field_id=NULL,$longitude_field_id=NULL,$error_tolerance=0.0005/*very roughly 60 metres each way*/)
{
	$where='';

	$where.='(';
	$where.='(l_latitude>'.float_to_raw_string($latitude-$error_tolerance,10);
	$where.=' AND ';
	$where.='l_latitude<'.float_to_raw_string($latitude+$error_tolerance,10).')';
	if ($latitude-$error_tolerance<-45.0)
	{
		$where.=' OR ';
		$where.='(l_latitude>'.float_to_raw_string($latitude-$error_tolerance+90.0,10);
		$where.=' AND ';
		$where.='l_latitude<'.float_to_raw_string($latitude+$error_tolerance+90.0,10).')';
	}
	if ($latitude+$error_tolerance>45.0)
	{
		$where.=' OR ';
		$where.='(l_latitude>'.float_to_raw_string($latitude-$error_tolerance-90.0,10);
		$where.=' AND ';
		$where.='l_latitude<'.float_to_raw_string($latitude+$error_tolerance-90.0,10).')';
	}
	$where.=')';

	$where.=' AND ';

	$where.='(';
	$where.='(l_longitude>'.float_to_raw_string($longitude-$error_tolerance,10);
	$where.=' AND ';
	$where.='l_longitude<'.float_to_raw_string($longitude+$error_tolerance,10).')';
	if ($longitude-$error_tolerance<-90.0)
	{
		$where.=' OR ';
		$where.='(l_longitude>'.float_to_raw_string($longitude-$error_tolerance+180.0,10);
		$where.=' AND ';
		$where.='l_longitude<'.float_to_raw_string($longitude+$error_tolerance+180.0,10).')';
	}
	if ($longitude+$error_tolerance>90.0)
	{
		$where.=' OR ';
		$where.='(l_longitude>'.float_to_raw_string($longitude-$error_tolerance-180.0,10);
		$where.=' AND ';
		$where.='l_longitude<'.float_to_raw_string($longitude+$error_tolerance-180.0,10).')';
	}
	$where.=')';

	if ((is_null($latitude_field_id)) || (is_null($longitude_field_id))) // Just do a raw query on locations table
	{
		$query='SELECT * FROM '.get_table_prefix().'locations WHERE '.$where;
		$locations=$GLOBALS['SITE_DB']->query($query);
	} else // Catalogue query (works both for entries and categories that use custom fields)
	{
		$where=str_replace(array('l_latitude','l_longitude'),array('a.cv_value','b.cv_value'),$where);
		$query='SELECT a.ce_id,c.id,cc_title,a.cv_value AS l_latitude,b.cv_value AS l_longitude FROM '.get_table_prefix().'catalogue_efv_float a JOIN '.get_table_prefix().'catalogue_efv_float b ON a.ce_id=b.ce_id AND a.cf_id='.strval($latitude_field_id).' AND b.cf_id='.strval($longitude_field_id).' LEFT JOIN '.get_table_prefix().'catalogue_entry_linkage x ON a.ce_id=x.catalogue_entry_id AND '.db_string_equal_to('x.content_type','catalogue_category').' LEFT JOIN '.get_table_prefix().'catalogue_categories c ON c.id=x.content_id WHERE '.$where;
		$locations=$GLOBALS['SITE_DB']->query($query,NULL,NULL,false,false,array('cc_title'));
	}

	if (count($locations)==0)
	{
		if (($latitude-$error_tolerance<-90.0) && ($latitude+$error_tolerance>90.0) && ($longitude-$error_tolerance<-90.0) && ($longitude+$error_tolerance>90.0))
		{
			return NULL; // Nothing, in whole world
		}

		return find_nearest_location($latitude,$longitude,$latitude_field_id,$longitude_field_id,$error_tolerance*1.3);
	}

	$best=mixed();
	$best_at=mixed();
	foreach ($locations as $l)
	{
		$dist=sqrt($l['l_latitude']*$l['l_latitude']+$l['l_longitude']*$l['l_longitude']);

		if ((is_null($best)) || ($dist<$best))
		{
			$best=$dist;
			$best_at=$l;
		}
	}
	$locations=array($best_at);

	return $locations[0];
}
