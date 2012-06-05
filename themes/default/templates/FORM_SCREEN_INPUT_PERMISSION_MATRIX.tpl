<script type="text/javascript">// <![CDATA[
	window.perm_serverid='{SERVER_ID;/}';
//]]></script>

<div class="permissions_matrix_wrap" id="enter_the_matrix">
	<table summary="{!MAP_TABLE}" class="autosized_table results_table">
		<thead>
			<tr>
				<th>
					{!GROUP} &amp; {!PINTERFACE_PRESETS}
				</th>

				<th class="view_header">
					<img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{!PINTERFACE_VIEW},UL_ESCAPED}{$KEEP*}" title="{!PINTERFACE_VIEW}" alt="{!PINTERFACE_VIEW}" />
				</th>

				{+START,LOOP,OVERRIDES}
					<th class="sp_header">
						<img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{TITLE},UL_ESCAPED}{$KEEP*}" title="{TITLE*}" alt="{TITLE*}" />
					</th>
				{+END}

				{+START,IF,{$JS_ON}}
					<th>
					</th>
				{+END}
			</tr>
		</thead>

		<tbody>
			{PERMISSION_ROWS}

			<tr>
				<td class="form_table_field_name sp_cell">
				</td>

				<td class="form_table_field_input sp_cell">
					<input class="button_micro" type="button" value="+/-" onclick="permissions_toggle(this.parentNode);" />
				</td>

				{+START,LOOP,OVERRIDES}
					<td class="form_table_field_input sp_cell">
						<input class="button_micro" type="button" value="+/-" onclick="permissions_toggle(this.parentNode);" />
					</td>
				{+END}

				{+START,IF,{$JS_ON}}
					<td class="form_table_field_input sp_cell">
					</td>
				{+END}
			</tr>
		</tbody>
	</table>
</div>
