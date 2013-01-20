<?php

class Hook_startup_param_restrict
{
	function run()
	{
		$max=100;

		foreach ($_GET as $key=>$val)
		{
			if ((strpos($key,'max')!==false) && (is_numeric($val)))
			{
				if (intval($val)>$max) $_GET[$key]=strval($max);
			}
		}
	}
}
