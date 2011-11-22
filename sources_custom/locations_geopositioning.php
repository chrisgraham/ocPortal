<?php

function find_nearest_location($latitude,$longitude,$latitude_field_id=NULL,$longitude_field_id=NULL,$error_tolerance=0.0005/*very roughly 60 metres each way*/)
{
	$where='';

	$where.='(';
	$where.='(l_latitude>'.float_to_raw_string($latitude-$error_tolerance);
	$where.=' AND ';
	$where.='l_latitude<'.float_to_raw_string($latitude+$error_tolerance).')';
	if ($latitude-$error_tolerance<-45)
	{
		$where.=' OR ';
		$where.='(l_latitude>'.float_to_raw_string($latitude-$error_tolerance+90);
		$where.=' AND ';
		$where.='l_latitude<'.float_to_raw_string($latitude+$error_tolerance+90).')';
	}
	if ($latitude+$error_tolerance>45)
	{
		$where.=' OR ';
		$where.='(l_latitude>'.float_to_raw_string($latitude-$error_tolerance-90);
		$where.=' AND ';
		$where.='l_latitude<'.float_to_raw_string($latitude+$error_tolerance-90).')';
	}
	$where.=')';

	$where.=' AND ';

	$where.='(';
	$where.='(l_longitude>'.float_to_raw_string($longitude-$error_tolerance);
	$where.=' AND ';
	$where.='l_longitude<'.float_to_raw_string($longitude+$error_tolerance).')';
	if ($longitude-$error_tolerance<-45)
	{
		$where.=' OR ';
		$where.='(l_longitude>'.float_to_raw_string($longitude-$error_tolerance+90);
		$where.=' AND ';
		$where.='l_longitude<'.float_to_raw_string($longitude+$error_tolerance+90).')';
	}
	if ($longitude+$error_tolerance>45)
	{
		$where.=' OR ';
		$where.='(l_longitude>'.float_to_raw_string($longitude-$error_tolerance-90);
		$where.=' AND ';
		$where.='l_longitude<'.float_to_raw_string($longitude+$error_tolerance-90).')';
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
		if (($latitude-$error_tolerance<-90) && ($latitude+$error_tolerance>90) && ($longitude-$error_tolerance<-90) && ($longitude+$error_tolerance>90))
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
