<?php

/* NB: Needs PHP5 */

require_css('openid');
require_javascript('javascript_jquery');
require_javascript('javascript_openid');

$url=build_url(array('page'=>''),'');
echo '
	<script type="text/javascript">// <![CDATA[
	$(function() {
	  $("#openid").openid({
		img_path: "{{ MEDIA_URL }}img/openid/",
		txt: {
		  label: "Enter your {username} for <b>{provider}<\/b>",
		  username: "username",
		  title: "Select where you\"d like to log in from.",
		  sign: "log in"
		}
	  });
	});
	//]]></script>

	<form title="OpenID (manually)" method="post" action="'.escape_html($url->evaluate()).'" id="openid"><span></span></form>
	<form title="OpenID (other)" method="post" action="'.escape_html($url->evaluate()).'" id="openid_manual">
		<label for="openid_identifier">Other service</label>:
		<input id="openid_identifier" name="openid_identifier" type="text" size="30" value="" />
		<input type="submit" value="Go" />
	</form>
';
