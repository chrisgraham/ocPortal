<?php

class Hook_symbol_FB_CONNECT_UID
{
	function run($param)
	{
		if ((is_guest()) && (!$GLOBALS['IS_ACTUALLY_ADMIN'])) return ''; // Theoretically unneeded, but if FB cookie is invalid then we need to assume getUser may be wrong (if Guest, and not SU, it implies we found it was invalid in facebook_connect.php)

		$value='';
		if (get_forum_type()=='ocf')
		{
			require_code('facebook_connect');
			global $FACEBOOK_CONNECT;
			if (!is_null($FACEBOOK_CONNECT))
			{
				@ini_set('ocproducts.type_strictness','0');
				$value=strval($FACEBOOK_CONNECT->getUser());
				@ini_set('ocproducts.type_strictness','1');
				if ($value=='0') $value='';
			}
		}
		return $value;
	}
}
