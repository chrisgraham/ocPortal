<?php


function sync_member($member_id)
{
	$db_host='hostname';
	$db_name='dbname';
	$db_user='username';
	$db_password='password';
	$db_table='tablename';
	
	$username_fields=array('sur_name','first_name','last_name'); //Fields that forms the username
	
	$field_remap=array(
		'email_address'=>array(
			'email',
			array(),
			''
		),
		'groups'=>array(
			NULL,
			array(),
			''
		),
		'dob_day'=>array(
			NULL,
			array(),
			''
		),
		'dob_month'=>array(
			NULL,
			array(),
			''
		),
		'dob_year'=>array(
			NULL,
			array(),
			''
		),
		'timezone'=>array(
			NULL,
			array(),
			''
		),
		'primary_group'=>array(
			NULL,
			array(),
			''
		),
		'language'=>array(
			NULL,
			array(),
			''
		),
		'city'=>array(
			'city',
			array(),
			''
		),
		'country'=>array(
			'country',
			array(),
			''
		)
	);
	$non_cpf=array('password','email_address','groups','dob_day','dob_month','dob_year','timezone','primary_group','language');
	
	$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
	$record=$GLOBALS['FORUM_DRIVER']->get_member_row($member_id);
	$cpf_fields=$GLOBALS['FORUM_DRIVER']->get_custom_fields($member_id);
	
	$dbh=new PDO('mysql:host='.$db_host.';dbname='.$db_name, $db_user, $db_password);
	$sth=$dbh->prepare("SELECT * FROM ".$db_table." WHERE TRIM(CONCAT(".$username_fields[0].",' ',".$username_fields[1].",' ',".$username_fields[2].")) = '".$record['m_username']."'");
	$sth->execute();
	$users=$sth->fetchAll(PDO::FETCH_ASSOC);
	
	if (count($users))
	{
		$remote_member_id=$users[0]['id'];
	}
	else
	{
		$sth=$dbh->prepare("INSERT INTO ".$db_table." (first_name) VALUES ('".$record['m_username']."')");
		$sth->execute();
		$remote_member_id=$dbh->lastInsertId();
	}
	
	foreach ($field_remap as $key=>$value)
	{
		if ($value[0]==NULL) continue;
		if (in_array($key,$non_cpf))
		{
			$insert_value=$record['m_'.$key];
		}
		else
		{
			$insert_value=$cpf_fields[$key];
		}
		if (count($value[1]))
		{
			$insert_value=isset($value[1][$insert_value])?$value[1][$insert_value]:$insert_value;
		}
		$sth=$dbh->prepare("UPDATE ".$db_table." SET ".$value[0]." = '".$insert_value."' WHERE id = ".$remote_member_id);
		$sth->execute();
	}
}