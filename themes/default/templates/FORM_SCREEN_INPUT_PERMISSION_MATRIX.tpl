<script type="text/javascript">// <![CDATA[
	window.perm_serverid='{SERVER_ID;/}';
//]]></script>

<div id="enter_the_matrix">
	<table summary="{!MAP_TABLE}" class="variable_table dottedborder">
		<thead>
			<tr>
				<th>
					{!GROUP}<br /><br />{!PINTERFACE_PRESETS}
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
				<td class="dottedborder_barrier_b_nonrequired sp_cell">
				</td>

				<td class="dottedborder_barrier_b_nonrequired sp_cell">
					<input type="button" value="+/-" onclick="permissions_toggle(this.parentNode);" />
				</td>

				{+START,LOOP,OVERRIDES}
					<td class="dottedborder_barrier_b_nonrequired sp_cell">
						<input type="button" value="+/-" onclick="permissions_toggle(this.parentNode);" />
					</td>
				{+END}

				{+START,IF,{$JS_ON}}
					<td class="dottedborder_barrier_b_nonrequired sp_cell">
					</td>
				{+END}
			</tr>
		</tbody>
	</table>
</div>
