<tr>
	<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{ABBR=}"{+END}>
		{NAME*}
	</th>

	{+START,IF,{$MOBILE}}
	</tr>
	<tr>
	{+END}

	<td>
		{VALUE}
	</td>
</tr>

