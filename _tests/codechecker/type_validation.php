<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2009

 See text/en/licence.txt for full licencing information.

*/

/**
 * Find whether the specified string is alphanumeric or not.
 *
 * @param  string			The string to test
 * @return boolean		  Whether the string is alphanumeric or not
 */
function is_alphanumeric($string)
{
	//removed-assert

	return preg_match('#^[a-zA-Z0-9\_\-\.]*$#',$string)!=0;
}

/**
 * Find whether the specified address is a valid e-mail address or not.
 *
 * @param  string			The string to test (Note: This is typed string, not e-mail, because it has to function on failure + we could make an infinite loop)
 * @return boolean		  Whether the string is an email address or not
 */
function is_valid_email_address($string)
{
	//removed-assert

	if ($string=='') return false;

	return (preg_match('#^[a-zA-Z0-9\._\-]+@[a-zA-Z0-9\._\-]+$#',$string)!=0); // Put "\.[a-zA-Z0-9_\-]+" before $ to ensure a two+ part domain
}


