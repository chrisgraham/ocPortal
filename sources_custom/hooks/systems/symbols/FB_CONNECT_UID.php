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
				$value=strval($FACEBOOK_CONNECT->getUser());
				if ($value=='0') $value='';
			}
		}
		return $value;
	}
}
