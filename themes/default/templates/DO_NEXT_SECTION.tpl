{+START,IF,{$EQ,{TITLE},{!GLOBAL_NAVIGATION}}}
<hr class="spaced_rule" />
{+END}

<nav class="do_next_section_wrap" role="navigation">
	{$,Layout table needed to ensure perfect alignment (height indeterminate)}
	<table summary="" class="do_next_section">
		<colgroup>
			<col class="do_next_column1" />
			<col class="do_next_column2" />
			<col class="do_next_column3" />
			<col class="do_next_column4" />
			<col class="do_next_column5" />
			<col class="do_next_column6" />
			<col class="do_next_column7" />
		</colgroup>

		<tbody>
			<tr>
				<td class="do_next_pretty_pad"></td>
				<td colspan="2" class="do_next_pretty_title_{!en_left}"></td>
				<td class="do_next_pretty_title">{TITLE}</td>
				<td colspan="2" class="do_next_pretty_title_{!en_right}"></td>
				<td class="do_next_pretty_pad"></td>
			</tr>
			<tr>
				<td class="do_next_pretty_top_{!en_left}"></td>
				<td colspan="5" class="do_next_pretty_top"></td>
				<td class="do_next_pretty_top_{!en_right}"></td>
			</tr>
			<tr>
				<td class="do_next_pretty_mid_{!en_left}"></td>
				<td colspan="5" class="do_next_section_inner">
					{$,Layout table needed to align icons across rows, without assuming icon label width}
					<div class="wide_table_wrap"><table summary="" class="wide_table">
						<tbody>
							<tr>
								{CONTENT}

								{+START,IF,{$GT,{I},4}}
									{$,Finish off the row}
									{$SET,I,{I}}
									{+START,WHILE,{$NEQ,{$REM,{$GET,I},4},0}}
										<td class="do_next_item_spacer"></td>
										{$INC,I}
									{+END}
								{+END}
							</tr>
						</tbody>
					</table></div>
				</td>
				<td class="do_next_pretty_mid_{!en_right}"></td>
			</tr>
			<tr>
				<td class="do_next_pretty_bottom_{!en_left}"></td>
				<td colspan="5" class="do_next_pretty_bottom"></td>
				<td class="do_next_pretty_bottom_{!en_right}"></td>
			</tr>
		</tbody>
	</table>
</nav>
