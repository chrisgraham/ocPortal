{+START,IF,{$NOT,{$GET,fancy_screen}}}
	<tr>
		<th class="de_th">{$REPLACE,/, / ,{NAME*}}:</th>
		<td>{VALUE*}</td>
	</tr>
{+END}

{+START,IF,{$GET,fancy_screen}}
	{+START,IF,{$GET,main}}
		<div class="associated_details">{VALUE*}</div>
	{+END}
	{+START,IF,{$NOT,{$GET,main}}}
		<tr>
			<th class="de_th">{$REPLACE,/, / ,{NAME*}}:</th>
			<td>{VALUE*}</td>
		</tr>
	{+END}
{+END}
