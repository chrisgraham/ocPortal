{$SET,RAND,_{$RAND}}

<div class="form_ajax_target">
	<section id="tray_{!SITE_WATCHLIST|}" class="box box___block_main_staff_website_monitoring">
		<h3 class="toggleable_tray_title">
			<a title="{!EDIT}: {!SITE_WATCHLIST}" class="top_left_toggleicon" href="#" onclick="return staff_block_flip_over('website_monitoring_list{$GET,RAND}');">{!EDIT}</a>

			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{!SITE_WATCHLIST|}');"><img alt="{!CONTRACT}: {$STRIP_TAGS,{!SITE_WATCHLIST}}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>

			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{!SITE_WATCHLIST|}');">{!SITE_WATCHLIST}</a>
		</h3>

		<div class="toggleable_tray">
			<div class="wide_table_wrap" id="website_monitoring_list{$GET,RAND}"><table summary="{!COLUMNED_TABLE}" class="results_table wide_table autosized_table">
				<thead>
					<tr>
						<th>{!config:SITE_NAME}</th>
						<th>Google Rank</th>
						<th>Alexa Rank</th>
						<th>Alexa Traffic</th>
						<th>archive.org</th>
						<th>{!LINKS}</th>
					</tr>
				</thead>
				<tbody>
					{+START,LOOP,GRIDDATA}
						<tr>
							<td>{SITETITLE*}</td>
							<td>{GRANK*}/10</td>
							<td>{ALEXAR`}</td>
							<td>{ALEXAT`}</td>
							<td><a class="suggested_link" href="http://web.archive.org/web/*/{URL*}">{!VIEW}</a></td>
							<td><a class="suggested_link" href="{URL*}">{!VIEW}</a></td>
						</tr>
					{+END}
				</tbody>
			</table></div>

			<form title="{!SITE_WATCHLIST}: {!EDIT}"{+START,IF,{$JS_ON}} style="display: none" aria-hidden="true"{+END} action="{URL*}" method="post" id="website_monitoring_list{$GET,RAND}_form">
				<div class="constrain_field">
					<label for="website_monitoring_list_edit" class="accessibility_hidden">{!EDIT}</label>
					<textarea class="wide_field" id="website_monitoring_list_edit" name="website_monitoring_list_edit" rows="10" cols="90">{+START,LOOP,SITEURLS}{_loop_key*}={_loop_var*}&#10;&#10;{+END}</textarea>
				</div>

				<div class="buttons_group">
					<input onclick="disable_button_just_clicked(this);{+START,IF,{$HAS_PRIVILEGE,comcode_dangerous}} return ajax_form_submit(event,this.form,'{BLOCK_NAME*;~}','{MAP*;~}');{+END}" class="button_pageitem" type="submit" id="submitsites" name="submitsites" value="{!SAVE}" />
				</div>
			</form>

			{$REQUIRE_JAVASCRIPT,javascript_ajax}
			{$REQUIRE_JAVASCRIPT,javascript_validation}
			{$REQUIRE_JAVASCRIPT,javascript_staff}
		</div>
	</section>
</div>

{+START,IF,{$JS_ON}}
	<script type="text/javascript">// <![CDATA[
		handle_tray_cookie_setting('{!SITE_WATCHLIST|}');
	//]]></script>
{+END}
