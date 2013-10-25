<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/**
 * Determine whether the necessary PHP extensions to support encryption are available. For normal use, you should probably use is_encryption_enabled() instead.
 *
 * @return boolean	Encryption available?
 */
function is_encryption_available()
{
	return function_exists('openssl_pkey_get_public');
}

/**
 * Determine whether encryption support is available and enabled in the site's preferences, and the keys are in place.
 *
 * @return boolean	Encryption enabled?
 */
function is_encryption_enabled()
{
	$public_key=get_option('encryption_key');
	$private_key=get_option('decryption_key');
	return ((function_exists('openssl_pkey_get_public')) && ($public_key!='') && ($private_key!='') && (file_exists($public_key)) && (file_exists($private_key)));
}

/**
 * Encrypt some data using asymmetric encryption and the site's public key. This will return the original data if encryption is disabled. It will add a magic marker to the start of the returned string to show it's been encrypted.
 * A fatal error will occur if the public key cannot be found, or if encryption fails for whatever reason.
 * Note that this will blindly re-encrypt data which has already been encrypted. You should check data with is_data_encrypted() first.
 *
 * @param  string		Data to be encrypted
 * @return string		Encrypted data, with magic marker
 */
function encrypt_data($data)
{
	require_lang('encryption');

	if (!is_encryption_enabled()) return $data;
	if ($data=='') return $data;
	if (is_data_encrypted($data)) return $data;

	if (!function_exists('openssl_pkey_get_public')) return $data;
	if (!function_exists('openssl_public_encrypt')) return $data;

	/* See http://uk.php.net/manual/en/function.openssl-pkey-get-public.php */
	$key=openssl_pkey_get_public('file://'.get_option('encryption_key'));
	if ($key===false)
	{
		attach_message(do_lang_tempcode('ENCRYPTION_KEY_ERROR'),'warn');
		return '';
	}

	$maxlength=117;
	$output='';
	while (strlen($data)>0)
	{
		$input=substr($data,0,$maxlength);
		$data=substr($data,$maxlength);
		$encrypted='';
		if (!openssl_public_encrypt($input,$encrypted,$key))
		{
			attach_message(do_lang_tempcode('ENCRYPTION_ERROR'),'warn');
			return '';
		}

		$output.=$encrypted;
	}
	return '(Encrypted!)'.base64_encode($output);
}

/**
 * Determine if some data has already been encrypted: i.e. if it has a magic encryption marker.
 *
 * @param  string			Data to check
 * @return boolean		Encrypted?
 */
function is_data_encrypted($data)
{
	if (!is_string($data)) return false;
	return (substr($data,0,12)=='(Encrypted!)');
}

/**
 * Remove the magic encryption marker from some data. This should be used if the data is to be displayed or presented for editing, but not if it's to be put in the database.
 * If the data does not have a magic encryption marker, the original string will be returned.
 *
 * @param  string		Data
 * @return string		Data, without the magic marker
 */
function remove_magic_encryption_marker($data)
{
	if (!is_data_encrypted($data)) return $data;
	return substr($data,12);
}

/**
 * Decrypt data using asymmetric encryption, and the site's private key (as unlocked by the given passphrase).
 * A fatal error will occur if the passphrase is empty, the key cannot be found, or if decryption fails for whatever reason.
 *
 * @param  string		Data to be decrypted
 * @param  string		Passphrase to unlock the site's private key
 * @return string		Decrypted data
 */
function decrypt_data($data,$passphrase)
{
	require_lang('encryption');

	if ($data=='') return '';

	if (!function_exists('openssl_pkey_get_private')) return '';
	if (!function_exists('openssl_private_decrypt')) return '';

	// Check the passphrase isn't empty (if it is legitimately empty, we're doing the site a favour by bailing out)
	if ($passphrase=='')
	{
		attach_message(do_lang_tempcode('ENCRYPTION_KEY_ERROR'),'warn');
		return '';
	}

	// Remove the magic encryption marker and base64-decode it first
	$data=base64_decode(remove_magic_encryption_marker(str_replace('<br />','',$data)));

	$key=openssl_pkey_get_private(array('file://'.get_option('decryption_key'),$passphrase));
	if ($key===false)
	{
		attach_message(do_lang_tempcode('ENCRYPTION_KEY_ERROR'),'warn');
		return '';
	}

	$maxlength=strlen($data);
	$decryption_keyfile=file_get_contents(get_option('decryption_key'));
	if (strpos($decryption_keyfile,'AES')===false)
	{
		$maxlength=128/*1024 bit key assumption*/;
	} elseif (strpos($decryption_keyfile,'AES-256')!==false)
	{
		$maxlength=256;
	} elseif (strpos($decryption_keyfile,'AES-512')!==false)
	{
		$maxlength=512;
	}

	$output='';
	while (strlen($data)>0)
	{
		$input=substr($data,0,$maxlength);
		$data=substr($data,$maxlength);
		$decrypted='';
		if (!openssl_private_decrypt($input,$decrypted,$key))
		{
			attach_message(do_lang_tempcode('DECRYPTION_ERROR'),'warn');
			return $output;
		}

		$output.=$decrypted;
	}
	return $output;
}
