<?php

function get_templates_list()
{
	$templates_dir=get_file_base().'/data_custom/modules/pagewizard/';
	$templates=array();
	if ($handle=opendir($templates_dir))
	{
		while (false!==($entry=readdir($handle)))
		{
			if ($entry!='.' && $entry!='..')
			{
				$template_file=$templates_dir.$entry;
				$template_title=array();
				if (preg_match('/\[title ?.*\](.*)\[\/title\]/',file_get_contents($template_file),$template_title))
				{
					preg_match('/(?<=\])(.*)(?=\[)/',$template_title[0],$template_title);
					$template_name=$template_title[0];
				} else
				{
					$template_name='Unknown';
				}
				$templates[]=strtolower($template_name);
			}
		}
		asort($templates);
	}
	return $templates;
}

function get_template_contents($name)
{
	$templates_dir=get_file_base().'/data_custom/modules/pagewizard/';
	$templates=array();
	if ($handle=opendir($templates_dir))
	{
		while (false!==($entry=readdir($handle)))
		{
			if ($entry!='.' && $entry!='..')
			{
				$template_file=$templates_dir.$entry;
				$template_title=array();
				if (preg_match('/\[title ?.*\](.*)\[\/title\]/',file_get_contents($template_file),$template_title))
				{
					preg_match('/(?<=\])(.*)(?=\[)/',$template_title[0],$template_title);
					$template_name=$template_title[0];
				} else
				{
					$template_name='Unknown';
				}
				$templates[strtolower($template_name)]=$template_file;
			}
		}
	}
	if (array_key_exists(strtolower($name),$templates))
	{
		return file_get_contents($templates[strtolower($name)]);
	} else
	{
		return false;
	}
}