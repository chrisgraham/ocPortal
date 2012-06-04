<div id="status_updates" class="float_surrounder">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h2 class="status-icon">{TITLE*}</h2>
	{+END}

	<form id="fp_status_form" action="#" method="post">
		<input type="hidden" name="zone" value="{$?,{$ZONE},{$ZONE*},frontpage}" />
		<input type="hidden" name="page" value="{$PAGE*}" />
		<table class="status_table">
			<colgroup>
				<col style="width: 100%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<td>
						<div class="status_box_outer">
							<label class="accessibility_hidden" for="activity_status">{!TYPE_HERE}</label>
							<textarea class="status_box fade_input" name="status" id="activity_status" rows="2">{!TYPE_HERE}</textarea>
						</div>
					</td>
					<td nowrap="nowrap" >
						<div class="status_controls">
							{+START,IF,{$ADDON_INSTALLED,chat}}
								<select class="drop-down" name="privacy" size="1">
									<option selected="selected">
										{!PUBLIC}
									</option>
									<option>
										{!FRIENDS_ONLY}
									</option>
								</select>
							{+END}
							{+START,IF,{$NOT,{$ADDON_INSTALLED,chat}}}
								<input type="hidden" name="privacy" value="{!PUBLIC}" />
							{+END}
							<input onclick="disable_button_just_clicked(this);" type="submit" class="login-but button_pageitem" name="button" id="button" value="{!UPDATE}" />
							<p id="notify" class="update_success">254 {!activities:CHARACTERS_LEFT}</p> <!-- Do not remove; the AJAX notifications are inserted here. -->
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<script type="text/javascript">//<![CDATA[
	if (jQuery('#fp_status_form').length != 0) {
		jQuery('textarea', '#fp_status_form').bind('focus', sUpdateF);
		jQuery('textarea', '#fp_status_form').bind('blur', sUpdateB);
		jQuery('#fp_status_form').submit(sUpdateSubmit);
		jQuery('textarea', '#fp_status_form').keyup(sUpdateCount);
		jQuery('textarea', '#fp_status_form').keypress(sUpdateCount);
	}
//]]></script>
