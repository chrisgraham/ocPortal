<div>
	{+START,IF_PASSED,EXPANDED}
		<h3 class="toggleable_tray_title">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{$?,{EXPANDED},{!CONTRACT},{!EXPAND}}" title="{$?,{EXPANDED},{!CONTRACT},{!EXPAND}}" src="{$IMG*,{$?,{EXPANDED},contract,expand}}" /></a>
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{SECTION_TITLE*}</a>
		</h3>
		<div class="toggleable_tray" style="display: {$JS_ON,{$?,{EXPANDED},block,none},block}"{+START,IF,{$NOT,{EXPANDED}}} aria-expanded="false"{+END}>
			<div>
	{+END}


			{+START,IF,{$NOT,{SIMPLE_STYLE}}}
				<div class="various_ticks float_surrounder">
				{+START,LOOP,OUT}
					<div class="input_individual_tick">
						<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick"{+START,IF,{CHECKED}} checked="checked"{+END} type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" /> {PRETTY_NAME*}</label>
						<input type="hidden" name="label_for__{NAME*}" value="{PRETTY_NAME*}" />
						<input name="tick_on_form__{NAME*}" value="0" type="hidden" />
					</div>
				{+END}
				</div>
			{+END}
			{+START,IF,{SIMPLE_STYLE}}
				{+START,LOOP,OUT}
					<p>
						<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick"{+START,IF,{CHECKED}} checked="checked"{+END} type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" /> {PRETTY_NAME*}</label>
						<input type="hidden" name="label_for__{NAME*}" value="{PRETTY_NAME*}" />
						<input name="tick_on_form__{NAME*}" value="0" type="hidden" />
					</p>
				{+END}
			{+END}

			{+START,IF_PASSED,CUSTOM_NAME}
				<div class="various_ticks float_surrounder">
					<div class="input_other_tick">
						<input value="1" class="input_tick" onclick="document.getElementById('{CUSTOM_NAME%}_value').disabled=!this.checked;" id="{CUSTOM_NAME*}" name="{CUSTOM_NAME*}" type="checkbox" />
						<label for="{CUSTOM_NAME*}">{!OTHER}</label> <label for="{CUSTOM_NAME*}_value"><span class="associated_details">({!PLEASE_STATE})</span></label>
						<input{+START,IF_PASSED,CUSTOM_VALUE} value="{CUSTOM_VALUE*}"{+END} onchange="document.getElementById('{CUSTOM_NAME%}').checked=(this.value!=''); this.disabled=(this.value=='');" id="{CUSTOM_NAME*}_value" name="{CUSTOM_NAME*}_value" size="15" type="text" value="" />
					</div>
					<script type="text/javascript">// <![CDATA[
						document.getElementById('{CUSTOM_NAME%}_value').onchange();
					//]]></script>
				</div>
			{+END}


	{+START,IF_PASSED,EXPANDED}
			</div>
		</div>
	{+END}
</div>

