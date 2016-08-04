<?php

error_reporting(E_ALL & ~E_DEPRECATED);
ini_set('track_errors', '1');
$php_errormsg = '';

set_error_handler(function($errno, $errstr, $errfile, $errline) {
	echo 'In error handler with ' . $errstr . "\n";

	if ($errno == E_DEPRECATED) {
		return true; // Should suppress $php_errormsg being set
	}

	eval('class foo { function foo() {} }');
	echo '$php_errormsg: ' . (($php_errormsg == '') ? 'None' : $php_errormsg) . "\n";
});

1 / 0; // Trigger an error
