<tr>
	{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}
	<th id="required__{$GET,randomised_id}" style="width: 100%" abbr="{PRETTY_NAME=}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th dottedborder_barrier_a_required dottedborder_huge_a">
		<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_TAGS,{PRETTY_NAME*}}" />
		<span class="field_name"><span id="requireb__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" class="inline"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>{PRETTY_NAME*}</span>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div class="associated_caption">{DESCRIPTION}</div>
		{+END}
	</th>
</tr>

<tr>
	<td id="requiredx__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="input_huge_field dottedborder_barrier_a_required dottedborder_huge_b">
		<div class="accessibility_hidden"><label for="{NAME*}">{PRETTY_NAME*}</label></div>
		{+START,IF,{INLINE_LIST}}
		<select size="{+START,IF_PASSED,SIZE}{SIZE*}{+END}{+START,IF_NON_PASSED,SIZE}15{+END}" tabindex="{TABINDEX*}" class="input_list{REQUIRED*} wide_field" id="{NAME*}" name="{NAME*}">
		{+END}
		{+START,IF,{$NOT,{INLINE_LIST}}}
		<select tabindex="{TABINDEX*}" class="input_list" id="{NAME*}" name="{NAME*}">
		{+END}
			{CONTENT}
		</select>

		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'load',function () {
				if (typeof window.setUpChangeMonitor!='undefined')
					setUpChangeMonitor(document.getElementById('required__{$GET,randomised_id}').parentNode,'{NAME*}',document.getElementById('requiredx__{$GET,randomised_id}').parentNode);
			} );
		//]]></script>
	</td>
</tr>

