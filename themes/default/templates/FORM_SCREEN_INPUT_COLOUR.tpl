{+START,IF,{TRUE_FIELD}}
	<div class="float_surrounder">
		<div id="colours_go_here"></div>
		<script type="text/javascript">// <![CDATA[
			make_colour_chooser('{NAME;}','{DEFAULT;}','',{TABINDEX%},' ','input_colour{_REQUIRED}');
			do_color_chooser();
		//]]></script>
	</div>
{+END}
{+START,IF,{$NOT,{TRUE_FIELD}}}
	<tr>
		<td {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="form_table_huge_field_description_is_under form_table_huge_field{+START,IF,{REQUIRED}} required{+END}">
			<div id="colours_go_here"></div>
			<script type="text/javascript">// <![CDATA[
				make_colour_chooser('{NAME;}','{DEFAULT;}','',{TABINDEX%},'{PRETTY_NAME;}','input_colour{_REQUIRED}');
				do_color_chooser();
			//]]></script>
		</td>
	</tr>
	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<tr>
			<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="form_table_description_under_cell{+START,IF,{REQUIRED}} required{+END}">
				<div class="associated_details">{DESCRIPTION}</div>
			</th>
		</tr>
	{+END}
{+END}
