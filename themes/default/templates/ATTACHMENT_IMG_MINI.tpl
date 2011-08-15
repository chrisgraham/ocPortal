{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
{+END}

{+START,IF,{$NEQ,{A_THUMB},0}}
<script type="text/javascript">// <![CDATA[
	var te_{PASS_ID%}_{RAND%}="{SCRIPT#}?id={ID#}{$KEEP#,0,1}&for_session={$SESSION_HASHED#}";
//]]></script>
{+END}
{+START,IF,{$EQ,{A_THUMB},1}}<a target="_blank" title="{A_DESCRIPTION*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}">{+END}<img class="no_alpha attachment_img" id="te_{PASS_ID*}_{RAND*}" src="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;thumb={A_THUMB*}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}" title="{A_DESCRIPTION*}"{+START,IF,{$EQ,{A_THUMB},1}} alt="{!IMAGE_ATTACHMENT,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}},{CLEAN_SIZE*}}"{+END}{+START,IF,{$NEQ,{A_THUMB},1}} alt="{A_DESCRIPTION*}"{+END} />{+START,IF,{$EQ,{A_THUMB},1}}</a>{+END}
