<tr>
	{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}
	<th id="required__{$GET,randomised_id}" style="width: 100%" abbr="{PRETTY_NAME=}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th {$?,{REQUIRED*},dottedborder_barrier_a_required,dottedborder_barrier_a_nonrequired} dottedborder_huge_a">
		<input type="hidden" name="comcode__{NAME*}" value="1" />
		<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_TAGS,{PRETTY_NAME*}}" />
		<span class="field_name"><span id="requireb__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" style="display: {$?,{REQUIRED*},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>{PRETTY_NAME*}</span>{COMCODE}
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_caption">{DESCRIPTION}</div>
		{+END}
	</th>
</tr>

<tr>
	<td id="requiredx__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="input_huge_field de_th {$?,{REQUIRED*},dottedborder_barrier_a_required,dottedborder_barrier_a_nonrequired} dottedborder_huge_b">
		<div class="accessibility_hidden"><label for="{NAME*}">{PRETTY_NAME*}</label></div>
		<div id="container_for_{NAME*}" class="constrain_field container_for_wysiwyg">
			<textarea tabindex="{TABINDEX*}" class="{+START,IF,{SCROLLS}}textarea_scroll{+END} input_text{_REQUIRED} wide_field" cols="70" rows="{ROWS*}" id="{NAME*}" name="{NAME*}">{DEFAULT*}</textarea>
			{+START,IF,{$IN_STR,{REQUIRED},wysiwyg}}
				<script type="text/javascript">// <![CDATA[
					if (wysiwyg_on()) document.getElementById('{NAME*;}').readOnly=true;
				//]]></script>
			{+END}
			{+START,IF_PASSED,DEFAULT_PARSED}
				<textarea{$?,{$VALUE_OPTION,html5}, aria-hidden="true"} cols="1" rows="1" style="display: none" readonly="readonly" name="{NAME*}_parsed">{DEFAULT_PARSED*}</textarea>
			{+END}
		</div>

		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'load',function () {
				if (typeof window.setUpChangeMonitor!='undefined')
					setUpChangeMonitor(document.getElementById('required__{$GET,randomised_id}').parentNode,'{NAME*}',document.getElementById('requiredx__{$GET,randomised_id}').parentNode);
			} );
		//]]></script>
	</td>
</tr>

