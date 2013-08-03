<ul class="horizontal_links associated_links_block_group horiz_field_sep">
	{+START,IF,{$SHOW_DOCS}}{+START,IF_PASSED,URL}
		<li><a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{URL*}"><img class="comcode_supported_icon" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a></li>
	{+END}{+END}
	<li><a rel="nofollow" class="link_exempt" title="{!EMOTICONS_POPUP}: {!LINK_NEW_WINDOW}" target="_blank" href="{$FIND_SCRIPT*,emoticons}?field_name={NAME*}{$KEEP*;,0,1}" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT;*,emoticons}?field_name={NAME*;}{$KEEP*;,0,1}'),'field_emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;"><img class="comcode_supported_icon" alt="{!EMOTICONS_POPUP}" src="{$IMG*,comcode_emoticon}" title="{!EMOTICONS_POPUP}" /></a></li>

	{+START,IF,{$AND,{$JS_ON},{W}}}
		<li><a rel="nofollow" id="toggle_wysiwyg_{NAME*}" href="#" onclick="return toggle_wysiwyg('{NAME;}');"><abbr title="{!TOGGLE_WYSIWYG_2}">{!ENABLE_WYSIWYG}</abbr></a></li>
	{+END}
</ul>
