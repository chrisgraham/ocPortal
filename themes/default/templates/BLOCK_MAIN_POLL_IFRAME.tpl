{$SET,pollid,{$FIX_ID,{$RAND}}}
<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} id="the_poll_{$GET%,pollid}{PARAM|}" name="the_poll_{$GET%,pollid}{PARAM|}" class="expandable_iframe" title="{!POLL}" src="{$FIND_SCRIPT*,poll}?param={PARAM*&}&amp;utheme={$THEME*&}&amp;zone={ZONE*&}{$KEEP*,0,1}{+START,IF,{$GET,in_panel}}&amp;in_panel=1{+END}{+START,IF,{$GET,interlock}}&amp;interlock=1{+END}">{!POLL}</iframe>
{$,<script type="text/javascript">// <![CDATA[
	//setInterval('resizeFrame(\'the_poll_{RAND%}\')',500);
//]]></script>}

