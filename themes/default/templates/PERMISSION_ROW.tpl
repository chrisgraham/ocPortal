<tr class="{$CYCLE,zebra,zebra_0,zebra_1}">
	<th>
		{PERMISSION*}
		{+START,IF_PASSED,DESCRIPTION}<img src="{$IMG*,1x/help}" srcset="{$IMG*,2x/help} 2x" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{DESCRIPTION;^*}','auto');" alt="{!HELP}" />{+END}
	</th>
	{CELLS}
	<td>
		{+START,IF,{$JS_ON}}
			<input class="button_micro" type="button" value="{$?,{HAS},-,+}" onclick="{CODE*}; this.value=(this.value=='-')?'+':'-';" />
		{+END}
	</td>
</tr>
