<div class="captcha">
	<a target="_blank" title="{!PLAY_AUDIO_VERSION}: {!LINK_NEW_WINDOW}" href="{$FIND_SCRIPT*,securityimage,1}?mode=audio{$KEEP*,0,1}">{!PLAY_AUDIO_VERSION}</a>
	{+START,IF,{$VALUE_OPTION,css_captcha_only}}
		<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} style="width:100px; height: 52px" title="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" src="{$FIND_SCRIPT*,securityimage}{$KEEP*,1,1}">{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}</iframe>
	{+END}
	{+START,IF,{$NOT,{$VALUE_OPTION,css_captcha_only}}}
		<img class="no_alpha" title="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" alt="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" src="{$FIND_SCRIPT*,securityimage}{$KEEP*,1,1}" />
	{+END}
</div>
<div class="accessibility_hidden"><label for="security_image">{!AUDIO_CAPTCHA}</label></div>
<input tabindex="{TABINDEX*}" maxlength="6" size="6" class="input_text_required" value="" type="text" id="security_image" name="security_image" />

<script type="text/javascript">// <![CDATA
	addEventListenerAbstract(window,'pageshow',function () {
		document.getElementById('captcha').src+='&'; // Force it to reload latest captcha
	} );
//]]></script>
