<tr>
	<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{NICE_NAME*}"{+END} class="de_th dottedborder_barrier_a_nonrequired">
		<span class="field_name">{NICE_NAME*}</span>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div class="associated_caption">{DESCRIPTION}</div>
		{+END}
	</th>

	<td class="dottedborder_barrier_b_nonrequired">
		<div class="accessibility_hidden"><label for="{NAME*}">{NICE_NAME*}</label></div>
		<div class="constrain_field">
			{INPUT}
		</div>
	</td>
</tr>
