<?php

class Hook_symbol_FB_CONNECT_ACCESS_TOKEN
{
	function run($param)
	{
		require_code('facebook_connect');

		$value='';
		if (get_forum_type()=='ocf')
		{
			require_code('facebook_connect');
			$cookie=get_facebook_cookie();
			if (!is_null($cookie))
				$value=$cookie[strtolower(substr(basename(__FILE__,'.php'),11))];
		}
		return $value;
	}
}
