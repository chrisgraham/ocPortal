<?php

function require_javascript($javascript)
{
	if (($javascript=='javascript_swfupload') && (!in_safe_mode()))
	{
		attach_to_screen_header('
			<!-- Third party script for BrowserPlus runtime (Google Gears included in Gears runtime now) -->
			<script type="text/javascript" src="http://bp.yahooapis.com/2.4.21/browserplus-min.js"></script>
		');

		$javascript='javascript_plupload';
	}

	non_overridden__require_javascript($javascript);
}

