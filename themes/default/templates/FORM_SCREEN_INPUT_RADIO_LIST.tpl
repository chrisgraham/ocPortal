{+START,IF_PASSED,NAME}
	<div id="error_{NAME*}" style="display: none" class="input_error_here"></div>
{+END}

{CONTENT}

{+START,IF_PASSED,NAME}
	{+START,IF,{REQUIRED}}
		<input type="hidden" name="require__{NAME*}" value="1" />
	{+END}

	{+START,IF_PASSED,CODE}
		<script type="text/javascript">// <![CDATA[
			choose_picture('{$FIX_ID;,j_{NAME}_{CODE}}',document.getElementById('{$FIX_ID;,j_{NAME}_{CODE}}_img'),'{NAME;}',null);
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
