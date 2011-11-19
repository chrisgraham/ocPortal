{$SET,IMAGE_TYPES,{IMAGE_TYPES}}

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

