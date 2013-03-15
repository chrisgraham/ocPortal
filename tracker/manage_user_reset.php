<?php
# MantisBT - a php based bugtracking system

# MantisBT is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# MantisBT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MantisBT.  If not, see <http://www.gnu.org/licenses/>.

	/**
	 * @package MantisBT
	 * @copyright Copyright (C) 2000 - 2002  Kenzaburo Ito - kenito@300baud.org
	 * @copyright Copyright (C) 2002 - 2010  MantisBT Team - mantisbt-dev@lists.sourceforge.net
	 * @link http://www.mantisbt.org
	 */
	 /**
	  * MantisBT Core API's
	  */
	require_once( 'core.php' );

	form_security_validate('manage_user_reset');

	auth_reauthenticate();
	access_ensure_global_level( config_get( 'manage_user_threshold' ) );

	$f_user_id = gpc_get_int( 'user_id' );

	user_ensure_exists( $f_user_id );

	$t_result = user_reset_password( $f_user_id );
	$t_redirect_url = 'manage_user_page.php';

	form_security_purge('manage_user_reset');

	html_page_top( null, $t_result ? $t_redirect_url : null );

	echo '<br />';
	echo '<div align="center">';

	if ( false == $t_result ) {
		# PROTECTED
		echo lang_get( 'account_reset_protected_msg' ) . '<br />';
	} else {
		# SUCCESS
		if ( ( ON == config_get( 'send_reset_password' ) ) && ( ON == config_get( 'enable_email_notification' ) ) ) {
			# send the new random password via email
			echo lang_get( 'account_reset_msg' ) . '<br />';
		} else {
			# email notification disabled, then set the password to blank
			echo lang_get( 'account_reset_msg2' ) . '<br />';
		}
	}

	print_bracket_link( $t_redirect_url, lang_get( 'proceed' ) );
	echo '</div>';
	html_page_bottom();
