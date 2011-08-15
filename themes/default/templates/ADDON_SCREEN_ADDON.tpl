<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}">
	<td class="dottedborder_barrier_b_nonrequired addon_name">
		<p onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{DESCRIPTION*^;}'.replace(/\n/g,'\n&lt;br /&gt;'),'50%');">
			{NAME*}
		</p>
		<p onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{FILE_LIST*^;}'.replace(/\n/g,'\n&lt;br /&gt;'),'50%');">
			{FILENAME*}
		</p>
	</td>
	<td class="dottedborder_barrier_b_nonrequired">
		<p>
			{AUTHOR*}
		</p>
		<p>
			{ORGANISATION*}
		</p>
	</td>
	<td class="dottedborder_barrier_b_nonrequired">
		{VERSION*}
	</td>
	<td class="dottedborder_barrier_b_nonrequired" style="color: {COLOUR*}">
		{STATUS*}
	</td>
	<td class="dottedborder_barrier_b_nonrequired addon_actions">
		{ACTIONS}
	
		<label class="accessibility_hidden" for="install_{NAME*}">{!INSTALL} {NAME*}</label>
		<input title="{!INSTALL} {NAME*}" type="checkbox" name="install_{NAME*}" id="install_{NAME*}" value="{PASSTHROUGH*}" {$?,{$EQ,{TYPE},install},,disabled="disabled" }/>

		<label class="accessibility_hidden" for="uninstall_{NAME*}">{!DELETE} {NAME*}</label>
		<input title="{!DELETE} {NAME*}" type="checkbox" name="uninstall_{NAME*}" id="uninstall_{NAME*}" value="{PASSTHROUGH*}" {$?,{$EQ,{TYPE},uninstall},,disabled="disabled" }/>
	</td>
</tr>

