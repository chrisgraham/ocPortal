{CONTENT}

{+START,IF_PASSED,NAME}
	{$,Images}
	{+START,IF_PASSED,CODE}
		<script type="text/javascript">// <![CDATA[
			choose_picture('{$FIX_ID;,j_{NAME}_{CODE}}',document.getElementById('{$FIX_ID;,j_{NAME}_{CODE}}_img'),'{NAME;}',event);
		//]]></script>
	{+END}

	{$,If is for deletion}
	{+START,IF,{$EQ,{NAME},delete}}
		<script type="text/javascript">// <![CDATA[
			add_event_listener_abstract(window,'load',function () {
				assign_radio_deletion_confirm('{NAME;}');
			} );
		//]]></script>
	{+END}
{+END}
