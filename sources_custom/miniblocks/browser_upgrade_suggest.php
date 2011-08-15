<?php

$ie_needed=array_key_exists('ie_needed',$map)?floatval($map['ie_needed']):7.0; // Latest at time of writing is 8.0. Suggest 6.0 or 7.0 as often people have no choice about upgrading (if they are on corporate PC's, if they pirated Windows (!), or if they are on an old version of Windows

require_code('browser_detect');
require_lang('browser_upgrade_suggest');

$message='';

$browser = new Browser();
if (($browser->getBrowser()==Browser::BROWSER_FIREFOX) && (floatval($browser->getVersion())<3.6))
{
	if ($browser->getPlatform()==Browser::PLATFORM_LINUX)
	{
		$message=do_lang('UPGRADE_FIREFOX_LINUX');
	} else
	{
		$message=do_lang('UPGRADE_FIREFOX');
	}
}
if (($browser->getBrowser()==Browser::BROWSER_SAFARI) && (floatval($browser->getVersion())<5.0))
{
	if ($browser->getPlatform()==Browser::PLATFORM_APPLE)
	{
		$message=do_lang('UPGRADE_SAFARI_MAC');
	} else
	{
		$message=do_lang('UPGRADE_SAFARI');
	}
}
if (($browser->getBrowser()==Browser::BROWSER_CHROME) && (floatval($browser->getVersion())<8.0))
{
	if ($browser->getPlatform()==Browser::PLATFORM_LINUX)
	{
		$message=do_lang('UPGRADE_CHROME_LINUX');
	} else
	{
		$message=do_lang('UPGRADE_CHROME');
	}
}
if (($browser->getBrowser()==Browser::BROWSER_IE) && (floatval($browser->getVersion())<$ie_needed))
{
	switch ($browser->getVersion())
	{
		case 8.0:
			$year='2009';
			break;
		case 7.0:
			$year='2007';
			break;
		case 6.0:
			$year='2001';
			break;
		default:
			$year='pre-2001';
			break;
	}
	$message=do_lang('UPGRADE_IE',escape_html($year));
}
if (($browser->getBrowser()==Browser::BROWSER_OPERA) && (floatval($browser->getVersion())<11.0))
{
	$message=do_lang('UPGRADE_OPERA');
}

if ($message!='')
{
	$out=put_in_standard_box($message,'',NULL,'curved');
	$out->evaluate_echo();
}
