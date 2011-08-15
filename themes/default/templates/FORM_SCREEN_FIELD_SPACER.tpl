<tr class="form_screen_field_spacer">
	<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END} class="de_th dottedborder_divider"{+START,IF_PASSED,TITLE} abbr="{$STRIP_TAGS*,{TITLE}}"{+END}>
		{+START,IF_PASSED,TITLE}
			{+START,IF,{$JS_ON}}{+START,IF_NON_PASSED,FORCE_OPEN}
				<a id="fes{TITLE|}" onkeypress="return this.onclick(event);" onclick="toggleSubordinateFields(this.getElementsByTagName('img')[0],'fes{TITLE|}_help'); return false;" href="#"><img class="inline_image_2 right" alt="{!CONTRACT}: {TITLE*}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>

				{+START,IF_PASSED,SECTION_HIDDEN}{+START,IF,{SECTION_HIDDEN}}
					<script type="text/javascript">// <![CDATA[
						addEventListenerAbstract(window,'load',function () {
							document.getElementById('fes{TITLE|}').onclick();
						} );
					//]]></script>
				{+END}{+END}
			{+END}{+END}

			<h2{+START,IF,{$JS_ON}}{+START,IF_NON_PASSED,FORCE_OPEN} onkeypress="return this.onclick(event);" onclick="toggleSubordinateFields(this.parentNode.getElementsByTagName('img')[0],'fes{TITLE|}_help'); return false;"{+END}{+END}>{TITLE*}</h2>
		{+END}

		{+START,IF_PASSED,HELP}{+START,IF_NON_EMPTY,{HELP}}
			<div{+START,IF_PASSED,TITLE} id="fes{TITLE|}_help"{+END}>
				{HELP*}
			</div>
		{+END}{+END}
	</th>
</tr>

