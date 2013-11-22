{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
<div id="{$GET*,wrapper_id}">
	<section class="box box___block_side_shoutbox"><div class="box_inner">
		<h3>{!SHOUTBOX}</h3>

		{MESSAGES}

		<form title="{!SHOUTBOX}" onsubmit="if (check_field_for_blankness(this.elements['shoutbox_message'],event)) { disable_button_just_clicked(this); return true; } return false;" target="_self" action="{URL*}" method="post">
			{$INSERT_SPAMMER_BLACKHOLE}

			<div>
				<p class="accessibility_hidden"><label for="shoutbox_message">{!MESSAGE}</label></p>
				<p class="constrain_field"><input autocomplete="off" value="" type="text" onfocus="if (this.value=='{!MESSAGE;}') this.value='';" id="shoutbox_message" name="shoutbox_message" alt="{!MESSAGE}" class="wide_field" /></p>
			</div>

			<div class="constrain_field">
				<p class="proceed_button">
					<input type="submit" value="{!SEND_MESSAGE}" class="buttons__send wide_button" />
				</p>
			</div>
		</form>
	</div></section>

	{$REQUIRE_JAVASCRIPT,javascript_ajax}
	{$REQUIRE_JAVASCRIPT,javascript_validation}

	<script>// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),[],{ },false,true);
		} );
	//]]></script>
</div>
