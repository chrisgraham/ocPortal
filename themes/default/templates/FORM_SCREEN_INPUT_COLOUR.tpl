{+START,IF,{TRUE_FIELD}}
	<div class="float_surrounder">
		<div id="colours_go_here">&nbsp;</div>
		<script type="text/javascript">// <![CDATA[
			makeColourChooser('{NAME;}','{DEFAULT;}','',{TABINDEX%},' ','input_colour{_REQUIRED}');
			doColorChooser();
		//]]></script>
	</div>
{+END}
{+START,IF,{$NOT,{TRUE_FIELD}}}
	<tr>
		<td {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="input_huge_field de_th{+START,IF,{REQUIRED*}} dottedborder_barrier_b_required{+END}">
			<div id="colours_go_here">&nbsp;</div>
			<script type="text/javascript">// <![CDATA[
				makeColourChooser('{NAME;}','{DEFAULT;}','',{TABINDEX%},'{PRETTY_NAME;}','input_colour{_REQUIRED}');
				doColorChooser();
			//]]></script>
		</td>
	</tr>
	{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<tr>
		<th style="width: 100%" abbr="{PRETTY_NAME=}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th{+START,IF,{REQUIRED*}} dottedborder_barrier_a_required{+END}">
			<div class="associated_caption">{DESCRIPTION}</div>
		</th>
	</tr>
	{+END}
{+END}
