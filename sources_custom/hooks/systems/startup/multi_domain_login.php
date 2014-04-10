<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		multi_domain_login
 */

class Hook_startup_multi_domain_login
{
	function run($MICRO_BOOTUP,$MICRO_AJAX_BOOTUP)
	{
		if ((!$MICRO_AJAX_BOOTUP) && (!$MICRO_BOOTUP) && (running_script('index')))
		{
			//if (isset($_POST['login_username'])) return;	Actually, we'll use caching to avoid this

			$value="<!-- Syndicate sessions -->\n";
			$value.='<script>';
			//$url=$this->session_syndicate_code(ocp_srv('HTTP_HOST'),preg_replace('#^.*://[^/]*(/|$)#','',get_base_url()));
			//$value.='new Image().src=\''.addslashes($url).'\';';
			foreach ($GLOBALS['SITE_INFO'] as $key=>$_val)
			{
				if (substr($key,0,strlen('ZONE_MAPPING_'))=='ZONE_MAPPING_')
				{
					if ($_val[0]!=ocp_srv('HTTP_HOST'))
					{
						$url=$this->session_syndicate_code($_val[0],$_val[1]);
						$value.='new Image().src=\''.addslashes($url).'\';';
					}
				}
			}
			$value.="</script>\n\n";

			attach_to_screen_header($value);
		}
	}

	function session_syndicate_code($domain,$path)
	{
		$url='http://'.$domain.'/'.$path.(($path=='')?'':'/').'data_custom/multi_domain_login.php';
		$url.='?session_expiry_time='.get_option('session_expiry_time');
		$url.='&session_id='.strval(get_session_id());
		$url.='&guest_session='.(is_guest()?'1':'0');
		return $url;
	}
}
