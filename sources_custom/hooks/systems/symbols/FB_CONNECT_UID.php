<?php

class Hook_symbol_FB_CONNECT_UID
{
	function run($param)
	{
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
