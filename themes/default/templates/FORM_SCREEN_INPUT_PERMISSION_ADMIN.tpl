<tr id="access_{GROUP_ID*}_sp_container">
	<th class="de_th dottedborder_barrier_a_nonrequired">
		<p class="form_field_name field_name">{GROUP_NAME*}</p>
		<p><em>{!ADMIN}</em></p>
	</th>

	<td class="dottedborder_barrier_b_nonrequired">
		{+START,IF_NON_EMPTY,{OVERRIDES}}
			<div class="accessibility_hidden"><label for="access_{GROUP_ID*}">{PINTERFACE_VIEW*} ({GROUP_NAME*})</label></div>
			<input id="access_{GROUP_ID*}" name="_ignore" type="checkbox" checked="checked" disabled="disabled" />
		{+END}

		{+START,IF_EMPTY,{OVERRIDES}}
			<label for="access_{GROUP_ID*}">
				<div class="accessibility_hidden"><label for="access_{GROUP_ID*}">{PINTERFACE_VIEW*} ({GROUP_NAME*})</label></div>
				<input id="access_{GROUP_ID*}" name="_ignore" type="checkbox" checked="checked" disabled="disabled" />
				{PINTERFACE_VIEW*}
			</label>
		{+END}
	</td>

	{+START,LOOP,OVERRIDES}
		<td class="dottedborder_barrier_b_nonrequired">
			<div class="accessibility_hidden"><label for="access_{GROUP_ID*}_{_loop_key*}">{!NA}</label></div>
			<input name="_ignore" type="checkbox" id="access_{GROUP_ID*}_{_loop_key*}" checked="checked" disabled="disabled" />
		</td>
	{+END}

	{+START,IF,{$OR,{FORCE_PRESETS},{$IS_NON_EMPTY,{OVERRIDES}}}}
	{+START,IF,{$JS_ON}}
		<td class="dottedborder_barrier_b_nonrequired">
		</td>
	{+END}
	{+END}
</tr>
