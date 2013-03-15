{$SET,pollid,{$FIX_ID,{$RAND}}}
<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} id="the_poll_{$GET%,pollid}{PARAM|}" name="the_poll_{$GET%,pollid}{PARAM|}" class="expandable_iframe" title="{!POLL}" src="{$FIND_SCRIPT*,poll}?param={PARAM&*}&amp;utheme={$THEME&*}&amp;zone={ZONE&*}{$KEEP*,0,1}">{!POLL}</iframe>
{$,<script type="text/javascript">// <![CDATA[
	window.setInterval(function() \{ resize_frame('the_poll_{$GET%,pollid}'); \},500);
//]]></script>}

