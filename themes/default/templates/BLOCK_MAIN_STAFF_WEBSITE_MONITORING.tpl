<div class="form_ajax_target"><div class="no_stbox_padding">
	{+START,BOX,{!SITE_WATCHLIST},,,tray_open,,,1,<a title="{!EDIT}: {!SITE_WATCHLIST}" class="topleftlink" href="#" onclick="return intoeditmode();">{!EDIT}</a>}
		<div id="watchlistshow" class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="dottedborder wide_table">
			<colgroup>
				<col style="width: 25%" />
				<col style="width: 12%" />
				<col style="width: 12%" />
				<col style="width: 12%" />
				<col style="width: 12%" />
				<col style="width: 12%" />
			</colgroup>

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
						<td class="dottedborder_barrier_b_nonrequired">{SITETITLE*}</td>
						<td class="dottedborder_barrier_b_nonrequired">{GRANK*}/10</td>
						<td class="dottedborder_barrier_b_nonrequired">{ALEXAR`}</td>
						<td class="dottedborder_barrier_b_nonrequired">{ALEXAT`}</td>
						<td class="dottedborder_barrier_b_nonrequired"><a href="http://web.archive.org/web/*/{URL*}">{!VIEW}</a></td>
						<td class="dottedborder_barrier_b_nonrequired"><a href="{URL*}">{!VIEW}</a></td>
					</tr>
				{+END}
			</tbody>
		</table></div>

		<form title="{!SITE_WATCHLIST}: {!EDIT}" {+START,IF,{$JS_ON}} style="display: none"{$?,{$VALUE_OPTION,html5}, aria-hidden="true"}{+END}action="{URL*}" method="post" id="watchlistform">
			<div class="constrain_field">
				<label for="watchlistsites" class="accessibility_hidden">{!EDIT}</label>
				<textarea class="wide_field" id="watchlistsites" name="watchlistsites" rows="10" cols="90">{+START,LOOP,SITEURLS}{_loop_key*}={_loop_var*}

{+END}</textarea>
			</div>
			<div class="button_panel">
				<input onclick="disable_button_just_clicked(this);{+START,IF,{$HAS_SPECIFIC_PERMISSION,comcode_dangerous}} return ajax_form_submit(event,this.form,'{BLOCK_NAME~;*}','{MAP~;*}');{+END}" class="button_pageitem" type="submit" id="submitsites" name="submitsites" value="{!SAVE}" />
			</div>
		</form>

		<script type="text/javascript">// <![CDATA[
			require_javascript('javascript_ajax');
			require_javascript('javascript_validation');

			function intoeditmode()
			{
				var watchlistform=document.getElementById('watchlistform');
				var show=document.getElementById('watchlistshow');

				if (watchlistform.style.display=='none')
				{
					set_display_with_aria(watchlistform,'block');
					set_display_with_aria(show,'none');
				} else
				{
					set_display_with_aria(watchlistform,'none');
					set_display_with_aria(show,'block');
				}
				return false;
			}
		//]]></script>
	{+END}
</div></div>
