<div class="wide_table_wrap">
	<table class="wide_table solidborder" summary="{!COLUMNED_TABLE}">
		<colgroup>
			<col style="width: 200px" />
			<col style="width: 100%" />
		</colgroup>

		<thead>
			<tr>
				<th>{!NAME}</th>
				<th>{!CURRENT}</th>
			</tr>
		</thead>

		<tbody>
			{+START,LOOP,MAP}
				<tr>
					<th>
						{{_loop_key*}}
					</th>
					<td>
						{+START,IF_PASSED,_loop_var} {$,Is not NULL}
							<div class="whitespace">{$PREG_REPLACE,\s*$,,{$PREG_REPLACE,^\s*,,{_loop_var*}}}</div>
						{+END}
					</td>
				</tr>
			{+END}
		</tbody>
	</table>
</div>
