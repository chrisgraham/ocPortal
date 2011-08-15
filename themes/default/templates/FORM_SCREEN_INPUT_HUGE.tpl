<tr>
	{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}
	<th id="required__{$GET,randomised_id}" style="width: 100%" abbr="{PRETTY_NAME=}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th{+START,IF,{REQUIRED*}} dottedborder_barrier_a_required{+END} dottedborder_huge_a">
		<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_TAGS,{PRETTY_NAME*}}" />
		<span class="field_name"><span id="requireb__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" style="display: {$?,{REQUIRED*},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>{PRETTY_NAME*}</span>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_caption">{DESCRIPTION}</div>
		{+END}
	</th>
</tr>

<tr>
	<td id="requiredx__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="input_huge_field de_th{+START,IF,{REQUIRED*}} dottedborder_barrier_a_required{+END} dottedborder_huge_b">
		<div class="accessibility_hidden"><label for="{NAME*}">{PRETTY_NAME*}</label></div>
		<div id="container_for_{NAME*}" class="constrain_field">
			<textarea tabindex="{TABINDEX*}" class="{+START,IF,{SCROLLS}}textarea_scroll{+END} input_text{_REQUIRED} wide_field" cols="70" rows="{ROWS*}" id="{NAME*}" name="{NAME*}">{DEFAULT*}</textarea>

			{+START,IF_PASSED,RAW}<input type="hidden" name="pre_f_{NAME*}" value="1" />{+END}
		</div>

		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'load',function () {
				if (typeof window.setUpChangeMonitor!='undefined')
					setUpChangeMonitor(document.getElementById('required__{$GET,randomised_id}').parentNode,'{NAME*}',document.getElementById('requiredx__{$GET,randomised_id}').parentNode);
			} );
		//]]></script>
	</td>
</tr>

