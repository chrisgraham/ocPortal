<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		java_uploader_ftp_source_code
 */

class Hook_addon_registry_java_uploader_ftp_source_code
{
	/**
	 * Get a list of file permissions to set
	 *
	 * @return array			File permissions to set
	 */
	function get_chmod_array()
	{
		return array();
	}

	/**
	 * Get the version of ocPortal this addon is for
	 *
	 * @return float			Version number
	 */
	function get_version()
	{
		return ocp_version_number();
	}

	/**
	 * Get the addon category
	 *
	 * @return string			The category
	 */
	function get_category()
	{
		return 'Development';
	}

	/**
	 * Get the addon author
	 *
	 * @return string			The author
	 */
	function get_author()
	{
		return 'Chris Graham';
	}

	/**
	 * Find other authors
	 *
	 * @return array			A list of co-authors that should be attributed
	 */
	function get_copyright_attribution()
	{
		return array(
			'Richard Johnson',
		);
	}

	/**
	 * Get the addon licence (one-line summary only)
	 *
	 * @return string			The licence
	 */
	function get_licence()
	{
		return 'Based on open code posted without a license';
	}

	/**
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
	function get_description()
	{
		return 'A modified version of the third-party Open Source HTML Large File Uploader code. It has been improved quite significantly to integrate very seamlessly with ocPortal. This code is included so people can modify it themselves also -- but mainly because it is needed in order to generate a signed certificate, so users can see that it is your domain that is certifying the applet as safe.';
	}

	/**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
	function get_applicable_tutorials()
	{
		return array(
		);
	}

	/**
	 * Get a mapping of dependency types
	 *
	 * @return array			File permissions to set
	 */
	function get_dependencies()
	{
		return array(
			'requires'=>array(
			),
			'recommends'=>array(
			),
			'conflicts_with'=>array(
			)
		);
	}

	/**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(
			'sources_custom/hooks/systems/addon_registry/java_uploader_ftp_source_code.php',
			'data_custom/javaupload/Checker.class',
			'data_custom/javaupload/Checker.java',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/class-use/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/resources/index.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/index.html',
			'data_custom/javaupload/commons-net-1.4.1/index.html',
			'data_custom/javaupload/index.html',
			'data_custom/javaupload/commons-net-1.4.1/commons-net-1.4.1.jar',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/allclasses-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/allclasses-noframe.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/constant-values.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/deprecated-list.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/chargen.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/chargen.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/daytime.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/echo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/finger.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/ftp.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/fwhois.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/IOUtil.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/mail.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/messages.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/PrintCommandListener.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/rdate.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/rexec.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/rlogin.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/rshell.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/server2serverFTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/TelnetClientExample.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/tftp.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/class-use/weatherTelnet.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/daytime.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/echo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/finger.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ftp.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/fwhois.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/IOUtil.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/mail.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/messages.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/class-use/ExtendedNNTPOps.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/class-use/MessageThreading.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/class-use/newsgroups.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/class-use/NNTPUtils.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/class-use/post.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/ExtendedNNTPOps.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/MessageThreading.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/newsgroups.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/NNTPUtils.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/nntp/post.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/class-use/NTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/class-use/TimeClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/NTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/ntp/TimeClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/PrintCommandListener.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/rdate.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/rexec.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/rlogin.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/rshell.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/server2serverFTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/TelnetClientExample.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/tftp.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/examples/weatherTelnet.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/help-doc.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/index-all.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/class-use/RCommandClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/class-use/RExecClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/class-use/RLoginClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/RCommandClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/RExecClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/bsd/RLoginClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/CharGenTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/CharGenUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/CharGenTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/CharGenUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DatagramSocketClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DatagramSocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DaytimeTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DaytimeUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DefaultDatagramSocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DefaultSocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DiscardTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/DiscardUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/EchoTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/EchoUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/FingerClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/MalformedServerReplyException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/ProtocolCommandEvent.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/ProtocolCommandListener.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/ProtocolCommandSupport.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/SocketClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/SocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/TimeTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/TimeUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/class-use/WhoisClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DatagramSocketClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DatagramSocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DaytimeTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DaytimeUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DefaultDatagramSocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DefaultSocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DiscardTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/DiscardUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/EchoTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/EchoUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/FingerClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/Configurable.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/DefaultFTPFileListParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPClientConfig.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPConnectionClosedException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFile.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFileEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFileEntryParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFileIterator.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFileList.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFileListParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPFileListParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPListParseEngine.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/class-use/FTPReply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/Configurable.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/DefaultFTPFileListParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPClientConfig.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPConnectionClosedException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFile.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFileEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFileEntryParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFileIterator.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFileList.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFileListParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPFileListParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPListParseEngine.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/FTPReply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/CompositeFileEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/ConfigurableFTPFileEntryParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/DefaultFTPFileEntryParserFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/EnterpriseUnixFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/FTPFileEntryParserFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/FTPTimestampParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/FTPTimestampParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/MVSFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/NTFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/OS2FTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/OS400FTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/ParserInitializationException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/RegexFTPFileEntryParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/UnixFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/VMSFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/class-use/VMSVersioningFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/CompositeFileEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/DefaultFTPFileEntryParserFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/EnterpriseUnixFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/FTPFileEntryParserFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/FTPTimestampParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/FTPTimestampParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/MVSFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/NTFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/OS2FTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/OS400FTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/ParserInitializationException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/RegexFTPFileEntryParserImpl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/UnixFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/VMSFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ftp/parser/VMSVersioningFTPEntryParser.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/CopyStreamAdapter.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/CopyStreamEvent.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/CopyStreamException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/CopyStreamListener.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/DotTerminatedMessageReader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/DotTerminatedMessageWriter.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/FromNetASCIIInputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/FromNetASCIIOutputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/SocketInputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/SocketOutputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/ToNetASCIIInputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/ToNetASCIIOutputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/class-use/Util.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/CopyStreamAdapter.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/CopyStreamEvent.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/CopyStreamException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/CopyStreamListener.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/DotTerminatedMessageReader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/DotTerminatedMessageWriter.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/FromNetASCIIInputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/FromNetASCIIOutputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/SocketInputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/SocketOutputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/ToNetASCIIInputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/ToNetASCIIOutputStream.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/io/Util.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/MalformedServerReplyException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/Article.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/ArticlePointer.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/Article.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/ArticlePointer.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NewGroupsOrNewsQuery.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NewsgroupInfo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NNTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NNTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NNTPCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NNTPConnectionClosedException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/NNTPReply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/SimpleNNTPHeader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/Threadable.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/class-use/Threader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NewGroupsOrNewsQuery.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NewsgroupInfo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NNTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NNTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NNTPCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NNTPConnectionClosedException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/NNTPReply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/SimpleNNTPHeader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/Threadable.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/nntp/Threader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/NTPUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/NtpUtils.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/NtpV3Impl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/NtpV3Packet.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/TimeInfo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/class-use/TimeStamp.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/NTPUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/NtpUtils.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/NtpV3Impl.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/NtpV3Packet.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/TimeInfo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ntp/TimeStamp.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/class-use/POP3.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/class-use/POP3Client.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/class-use/POP3Command.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/class-use/POP3MessageInfo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/class-use/POP3Reply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/POP3.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/POP3Client.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/POP3Command.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/POP3MessageInfo.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/pop3/POP3Reply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ProtocolCommandEvent.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ProtocolCommandListener.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/ProtocolCommandSupport.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/RelayPath.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/SimpleSMTPHeader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/SMTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/SMTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/SMTPCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/SMTPConnectionClosedException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/class-use/SMTPReply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/RelayPath.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/SimpleSMTPHeader.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/SMTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/SMTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/SMTPCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/SMTPConnectionClosedException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/smtp/SMTPReply.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/SocketClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/SocketFactory.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/EchoOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/InvalidTelnetOptionException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/SimpleOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/SuppressGAOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/TelnetClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/TelnetCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/TelnetNotificationHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/TelnetOption.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/TelnetOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/class-use/TerminalTypeOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/EchoOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/InvalidTelnetOptionException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/SimpleOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/SuppressGAOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/TelnetClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/TelnetCommand.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/TelnetNotificationHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/TelnetOption.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/TelnetOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/telnet/TerminalTypeOptionHandler.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPAckPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPDataPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPErrorPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPPacketException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPReadRequestPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPRequestPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/class-use/TFTPWriteRequestPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTP.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPAckPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPDataPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPErrorPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPPacketException.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPReadRequestPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPRequestPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/tftp/TFTPWriteRequestPacket.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/TimeTCPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/TimeUDPClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/class-use/ListenerList.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/ListenerList.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/package-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/package-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/package-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/util/package-use.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/org/apache/commons/net/WhoisClient.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/overview-frame.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/overview-summary.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/overview-tree.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/package-list',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/packages.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/resources/inherit.gif',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/serialized-form.html',
			'data_custom/javaupload/commons-net-1.4.1/docs/apidocs/stylesheet.css',
			'data_custom/javaupload/commons-net-1.4.1/LICENSE.txt',
			'data_custom/javaupload/commons-net-1.4.1/NOTICE.txt',
			'data_custom/javaupload/compile.bat',
			'data_custom/javaupload/compile.sh',
			'data_custom/javaupload/ExtensionFileFilter.class',
			'data_custom/javaupload/keystore',
			'data_custom/javaupload/Net.jar',
			'data_custom/javaupload/test.html',
			'data_custom/javaupload/UnsignedUploader.jar',
			'data_custom/javaupload/Uploader$1.class',
			'data_custom/javaupload/Uploader$2.class',
			'data_custom/javaupload/Uploader.class',
			'data_custom/javaupload/Uploader.jar',
			'data_custom/javaupload/Uploader.java',
		);
	}
}