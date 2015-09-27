<div id="command_line">
	<div id="commands_go_here">
		<p>{!WELCOME_TO_OCCLE}</p>
		<hr />
		{+START,IF_NON_EMPTY,{COMMANDS}}{COMMANDS}{+END}
	</div>
	<div class="xhtml_validator_off">
		<form title="{!PRIMARY_PAGE_FORM}" autocomplete="off" action="{SUBMIT_URL*}" method="post" id="occle_form" onsubmit="return occle_form_submission(document.getElementById('occle_command').value);">
			<div id="command_prompt">
				<label for="occle_command">{PROMPT*}</label>
				<input type="text" id="occle_command" name="command" onkeyup="return occle_handle_history(this,event.keyCode?event.keyCode:event.charCode,event);" value="" role="textbox" />
				<input class="button_micro" type="submit" value="{!GO_COMMAND=}" />
			</div>
		</form>
	</div>
	<script type="text/javascript">
	// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			try { document.getElementById("occle_command").focus(); } catch (e) { }
		} );
	// ]]>
	</script>
</div>
