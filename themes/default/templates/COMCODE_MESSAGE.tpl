{+START,IF,{$SHOW_DOCS}}{+START,IF_PASSED,URL}<a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{URL*}"><img class="comcode_button" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a>{+END}{+END}<a class="link_exempt" title="{!EMOTICONS_POPUP}: {!LINK_NEW_WINDOW}" target="_blank" href="{$FIND_SCRIPT*,emoticons}?field_name={NAME*}{$KEEP*;,0,1}" onclick="window.open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name={NAME*;}{$KEEP*;,0,1}'),'field_emoticon_chooser','width=180,height=500,status=no,resizable=yes,scrollbars=no'); return false;"><img class="comcode_button" alt="{!EMOTICONS_POPUP}" src="{$IMG*,comcode_emoticon}" title="{!EMOTICONS_POPUP}" /></a>

{+START,IF,{$AND,{$JS_ON},{W}}}
	[<a id="toggle_wysiwyg_{NAME*}" class="wysiwyg_button" href="#" onclick="return toggle_wysiwyg('{NAME;}');"><abbr title="{!TOGGLE_WYSIWYG_2}">{!ENABLE_WYSIWYG}</abbr></a>]
{+END}

