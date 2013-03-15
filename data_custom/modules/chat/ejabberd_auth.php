#!/usr/bin/php
<?php

/*
Copyright (c) <2005> LISSY Alexandre, "lissyx" <alexandrelissy@free.fr>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software andassociated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to thefollowing conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Altered for ocPortal by ocProducts
*/

error_reporting(0);
$auth=new JabberAuth();
chdir(dirname(__FILE__));
require('../../../info.php');
$auth->dbhost=isset($SITE_INFO['db_site_host'])?$SITE_INFO['db_site_host']:'localhost';
$auth->dbuser=$SITE_INFO['db_site_user'];
$auth->dbpass=$SITE_INFO['db_site_password'];
$auth->dbbase=$SITE_INFO['db_site'];
$auth->play(); // We simply start process !

class JabberAuth {
	var $dbhost; /* MySQL server */
	var $dbuser; /* MySQL user */
	var $dbpass; /* MySQL password */
	var $dbbase; /* MySQL database where users are stored */

	var $debug=true; 				      /* Debug mode */
	var $debugfile="../../errorlog.php";  /* Debug output */
	/*
	 * For both debug and logging, ejabberd have to be able to write.
	 */

	var $jabber_user;   /* This is the jabber user passed to the script. filled by $this->command() */
	var $jabber_pass;   /* This is the jabber user password passed to the script. filled by $this->command() */
	var $jabber_server; /* This is the jabber server passed to the script. filled by $this->command(). Useful for VirtualHosts */
	var $jid;           /* Simply the JID, if you need it, you have to fill. */
	var $data;          /* This is what SM component send to us. */

	var $dateformat="M d H:i:s"; /* Check date() for string format. */
	var $command; /* This is the command sent ... */
	var $mysock;  /* MySQL connection ressource */
	var $stdin;   /* stdin file pointer */
	var $stdout;  /* stdout file pointer */

	function JabberAuth()
	{
		@define_syslog_variables();
		@openlog("pipe-auth", LOG_NDELAY, LOG_SYSLOG);

		if($this->debug) {
			@error_reporting(E_ALL);
			@ini_set("log_errors", "1");
			@ini_set("error_log", $this->debugfile);
		}
		$this->logg("Starting pipe-auth ..."); // We notice that it's starting ...
		$this->openstd();
	}

	function stop()
	{
		$this->logg("Shutting down ..."); // Sorry, have to go ...
		closelog();
		$this->closestd(); // Simply close files
		exit(0); // and exit cleanly
	}

	function openstd()
	{
		$this->stdout=@fopen("php://stdout", "w"); // We open STDOUT so we can read
		$this->stdin=@fopen("php://stdin", "r"); // and STDIN so we can talk !
	}

	function readstdin()
	{
		$l=@fgets($this->stdin, 3); // We take the length of string
		$length=@unpack("n", $l); // ejabberd give us something to play with ...
		$len=$length["1"]; // and we now know how long to read.
		if($len > 0) { // if not, we'll fill logfile ... and disk full is just funny once
			$this->logg("Reading $len bytes ... "); // We notice ...
			$data=@fgets($this->stdin, $len+1);
			// $data=iconv("UTF-8", "ISO-8859-15", $data); // To be tested, not sure if still needed.
			$this->data=rtrim($data,"\n"); // We set what we got.
			$this->logg("IN: ".$data);
		}
	}

	function closestd()
	{
		@fclose($this->stdin); // We close everything ...
		@fclose($this->stdout);
	}

	function out($message)
	{
		@fwrite($this->stdout, $message); // We reply ...
		$dump=@unpack("nn", $message);
		$dump=$dump["n"];
		$this->logg("OUT: ". $dump);
	}

	function myalive()
	{
		if(!is_resource($this->mysock) || !@mysql_ping($this->mysock)) { // check if we have a MySQL connection and if it's valid.
			$this->mysql(); // We try to reconnect if MySQL gone away ...
			return @mysql_ping($this->mysock); // we simply try again, to be sure ...
		} else {
			return true; // so good !
		}
	}

	function play()
	{
		do {
			$this->readstdin(); // get data
			$length=strlen($this->data); // compute data length
			if($length > 0 ) { // for debug mainly ...
				$this->logg("GO: ".$this->data);
				$this->logg("data length is : ".$length);
			}
			$ret=$this->command(); // play with data !
			$this->logg("RE: " . $ret); // this is what WE send.
			$this->out($ret); // send what we reply.
			$this->data=NULL; // more clean. ...
		} while (true);
	}

	function command()
	{
		$data=$this->splitcomm(); // This is an array, where each node is part of what SM sent to us :
		// 0=>the command,
		// and the others are arguments .. e.g. : user, server, password ...

		if($this->myalive()) { // Check we can play with MySQL
			if(strlen($data[0]) > 0 ) {
				$this->logg("Command was : ".$data[0]);
			}
			switch($data[0]) {
				case "isuser": // this is the "isuser" command, used to check for user existance
						$this->jabber_user=$data[1];
						$parms=$data[1];  // only for logging purpose
						$return=$this->checkuser();
					break;

				case "auth": // check login, password
						$this->jabber_user=$data[1];
						$this->jabber_pass=$data[3];
						$parms=$data[1].":".$data[2].":".md5($data[3]); // only for logging purpose
						$return=$this->checkpass();
					break;

				case "setpass":
						$return=false; // We do not want jabber to be able to change password
					break;

				default:
						$this->stop(); // if it's not something known, we have to leave.
						// never had a problem with this using ejabberd, but might lead to problem ?
					break;
			}

			$return=($return) ? 1 : 0;

			if(strlen($data[0]) > 0 && strlen($parms) > 0) {
				$this->logg("Command : ".$data[0].":".$parms." ==> ".$return." ");
			}
			return @pack("nn", 2, $return);
		} else {
			// $this->prevenir(); // Maybe useful to tell somewhere there's a problem ...
			return @pack("nn", 2, 0); // it's so bad.
		}
	}

	function checkpass()
	{
		global $SITE_INFO;
		/*if (isset($SITE_INFO['base_url']))
		{
			$p=parse_url($SITE_INFO['base_url']);
			if ($this->jabber_server!=$p['host']) return false;
		}*/

		$result=mysql_query('SELECT * FROM '.$SITE_INFO['table_prefix'].'f_members WHERE m_username=\''.mysql_real_escape_string($this->jabber_user).'\'');
		$row=mysql_fetch_assoc($result);
		if (!$row)
		{
			if (strpos($this->jabber_user,'.')!==false)
			{
				$this->jabber_user=str_replace('.',' ',$this->jabber_user);
				$result=mysql_query('SELECT * FROM '.$SITE_INFO['table_prefix'].'f_members WHERE m_username=\''.mysql_real_escape_string($this->jabber_user).'\'');
				$row=mysql_fetch_assoc($result);
				if (!$row) return false;
			} else
			{
				return false;
			}
		}

		$password_compatibility_scheme=$row['m_password_compat_scheme'];
		if ($row['m_pass_hash_salted']==$this->jabber_pass) return true;
		switch ($password_compatibility_scheme)
		{
			case '': // ocPortal style salted MD5 algorithm
				return (md5($row['m_pass_salt'].md5($this->jabber_pass))==$row['m_pass_hash_salted']);
			case 'vb3': // vBulletin (used on ocportal.com a lot, for legacy reasons)
				return (md5(md5($this->jabber_pass).$row['m_pass_salt'])==$row['m_pass_hash_salted']);
			case 'plain':
				return ($this->jabber_pass==$row['m_pass_hash_salted']);
			case 'md5': // Old style plain md5
				return (md5($this->jabber_pass)==$row['m_pass_hash_salted']);
			default:
				return false;
		}
	}

	function checkuser()
	{
		global $SITE_INFO;
		/*if (isset($SITE_INFO['base_url']))
		{
			$p=parse_url($SITE_INFO['base_url']);
			if ($this->jabber_server!=$p['host']) return false;
		}*/

		$result=mysql_query('SELECT * FROM '.$SITE_INFO['table_prefix'].'f_members WHERE m_username=\''.mysql_real_escape_string($this->jabber_user).'\'');
		$row=mysql_fetch_assoc($result);
		if (!$row)
		{
			if (strpos($this->jabber_user,'.')!==false)
			{
				$this->jabber_user=str_replace('.',' ',$this->jabber_user);
				$result=mysql_query('SELECT * FROM '.$SITE_INFO['table_prefix'].'f_members WHERE m_username=\''.mysql_real_escape_string($this->jabber_user).'\'');
				$row=mysql_fetch_assoc($result);
				if (!$row) return false;
			} else
			{
				return false;
			}
		}
		return true;
	}

	function splitcomm() // simply split command and arugments into an array.
	{
		return explode(":", $this->data);
	}

	function mysql() // "MySQL abstraction", this opens a permanent MySQL connection, and fill the ressource
	{
		$this->mysock=@mysql_pconnect($this->dbhost, $this->dbuser, $this->dbpass);
		@mysql_select_db($this->dbbase, $this->mysock);
		$this->logg("MySQL :: ". (is_resource($this->mysock) ? "Connect�" : "D�connect�"));
	}

	function logg($message) // pretty simple
	{
		if (@in_array('test',$_SERVER['argv']))
			echo $message."\n";
	}
}
