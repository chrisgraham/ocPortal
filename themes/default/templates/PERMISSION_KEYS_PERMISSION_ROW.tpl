<tr>
	<td>
		<label for="key_{UID*}">{!MATCH_KEY}</label> <input maxlength="255" type="text" id="key_{UID*}" name="key_{UID*}" value="{KEY*}" />
	</td>
	{CELLS}
	<td>
		{+START,IF,{$JS_ON}}
		<input type="button" value="{+START,IF,{ALL_OFF}}+{+END}{+START,IF,{$NOT,{ALL_OFF}}}-{+END}" onclick="{CODE*}; this.value=(this.value=='-')?'+':'-';" />
		{+END}
	</td>
</tr>
