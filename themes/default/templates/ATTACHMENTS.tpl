{+START,IF,{$NOT,{$MOBILE}}}
	<p>
		{!ATTACHMENT_HELP}
	</p>
	<p>
		{!ATTACHMENT_HELP_3}
	</p>
{+END}
<p>
	{!ATTACHMENT_HELP_2,{IMAGE_TYPES*}}
</p>
<script type="text/javascript">// <![CDATA[
	var attachment_template='{ATTACHMENT_TEMPLATE/^;}';
//]]></script>

<div id="attachment_store">
	{ATTACHMENTS}
</div>

{+START,IF,{$JS_ON}}
	<script type="text/javascript">// <![CDATA[
		var maxAttachments={MAX_ATTACHMENTS#};
		var numAttachments={NUM_ATTACHMENTS#};
	//]]></script>
{+END}

