<tr class="form_table_field_spacer">
	<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END} class="table_heading_cell">
		{+START,IF_PASSED,TITLE}
			{+START,IF,{$JS_ON}}{+START,IF_NON_PASSED_OR_FALSE,FORCE_OPEN}
				<a class="toggleable_tray_button" id="fes{TITLE|}" onkeypress="return this.onclick.call(this,event);" onclick="toggle_subordinate_fields(this.getElementsByTagName('img')[0],'fes{TITLE|}_help'); return false;" href="#"><img class="vertical_alignment right" alt="{!CONTRACT}: {TITLE*}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>

				{+START,IF_PASSED_AND_TRUE,SECTION_HIDDEN}
					<script type="text/javascript">// <![CDATA[
						add_event_listener_abstract(window,'load',function (event) {
							document.getElementById('fes{TITLE|}').onclick(event);
						} );
					//]]></script>
				{+END}
			{+END}{+END}

			<h2{+START,IF,{$JS_ON}}{+START,IF_NON_PASSED_OR_FALSE,FORCE_OPEN} class="toggleable_tray_button" onkeypress="return this.onclick.call(this,event);" onclick="toggle_subordinate_fields(this.parentNode.getElementsByTagName('img')[0],'fes{TITLE|}_help'); return false;"{+END}{+END}>{TITLE*}</h2>
		{+END}

		{+START,IF_PASSED,HELP}{+START,IF_NON_EMPTY,{HELP}}
			<div{+START,IF_PASSED,TITLE} id="fes{TITLE|}_help"{+END}>
				{$PARAGRAPH,{HELP*}}
			</div>
		{+END}{+END}
	</th>
</tr>

