<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/*EXTRA FUNCTIONS: proc\_.+|stream_set_blocking|stream_get_contents|stream_set_timeout*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/**
 * Send an e-mail.
 *
 * @param  string		The TO address.
 * @param  string		The subject.
 * @param  string		The message.
 * @param  string		Additional headers.
 * @param  string		Additional stuff to send to sendmail executable (if appropriate, only works when safe mode is off).
 * @return boolean	Success status.
 */
function manualproc_mail($to,$subject,$message,$additional_headers,$additional_flags='')
{
	$descriptorspec=array(
	   0=>array('pipe','r'), // stdin is a pipe that the child will read from
	   1=>array('pipe','w'), // stdout is a pipe that the child will write to
	   2=>array('pipe','w') // stderr is a file to write to
	);
	$pipes=array();
	if (substr($additional_flags,0,1)!=' ') $additional_flags=' '.$additional_flags;
	//$additional_flags.=' -v';		mini_sendmail puts everything onto stderr if using this https://github.com/mattrude/mini_sendmail/blob/master/mini_sendmail.c
	$command=ini_get('sendmail_path').$additional_flags;
	$handle=proc_open($command,$descriptorspec,$pipes);
	if ($handle!==false)
	{
		fprintf($pipes[0],"To: %s\n",$to);
		fprintf($pipes[0],"Subject: %s\n",$subject);
		fprintf($pipes[0],"%s\n",$additional_headers);
		fprintf($pipes[0],"\n%s\n",$message);
		fclose($pipes[0]);

		$test=proc_get_status($handle);

		$retmsg='';
		$stdout=stream_get_contents($pipes[1]);
		$retmsg.=$stdout;
		fclose($pipes[1]);
		$stderr=stream_get_contents($pipes[2]);
		$retmsg.=$stderr;
		fclose($pipes[2]);

		if (!$test['running'])
		{
			$retcode=$test['exitcode'];
		} else
		{
			$retcode=proc_close($handle);
		}
		if (($retcode==-1) && ($stderr=='')) $retcode=0; // https://bugs.php.net/bug.php?id=29123

		if ($retcode!=0)
		{
			trigger_error('Sendmail error code: '.strval($retcode).' ['.$retmsg.']',E_USER_WARNING);
			return false;
		}
	} else
	{
		trigger_error('Could not connect to sendmail process',E_USER_WARNING);
		return false;
	}
	return true;
}
