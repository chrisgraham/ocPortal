<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}">
	<td class="addon_name">
		<p onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{DESCRIPTION*;^}'.replace(/\n/g,'\n&lt;br /&gt;'),'50%');">
			{NAME*}
		</p>
		<p onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{FILE_LIST*;^}'.replace(/\n/g,'\n&lt;br /&gt;'),'50%');">
			{FILENAME*}
		</p>
	</td>
	<td>
		<p>
			{AUTHOR*}
		</p>
		<p>
			{ORGANISATION*}
		</p>
	</td>
	<td>
		{VERSION*}
	</td>
	<td style="color: {COLOUR*}">
		{STATUS*}
	</td>
	<td class="results_table_field addon_actions">
		{ACTIONS}

		<label class="accessibility_hidden" for="install_{NAME*}">{!INSTALL} {NAME*}</label>
		<input title="{!INSTALL} {NAME*}" type="checkbox" name="install_{NAME*}" id="install_{NAME*}" value="{PASSTHROUGH*}" {$?,{$EQ,{TYPE},install},,disabled="disabled" }/>

		<label class="accessibility_hidden" for="uninstall_{NAME*}">{!UNINSTALL} {NAME*}</label>
		<input title="{!UNINSTALL} {NAME*}" type="checkbox" name="uninstall_{NAME*}" id="uninstall_{NAME*}" value="{PASSTHROUGH*}" {$?,{$EQ,{TYPE},uninstall},,disabled="disabled" }/>
	</td>
</tr>

