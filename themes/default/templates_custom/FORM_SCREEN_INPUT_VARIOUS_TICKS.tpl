<div>
	{+START,IF_PASSED,EXPANDED}
		<h4 class="comcode_quote_h4">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">
				<img alt="{!EXPAND}/{!CONTRACT}" src="{$IMG*,{$?,{EXPANDED},contract,expand}}" />
			</a>

			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{SECTION_TITLE*}</a>
		</h4>

		<div class="toggleable_tray" style="display: {$JS_ON,{$?,{EXPANDED},block,none},block}"{+START,IF,{$NOT,{EXPANDED}}} aria-expanded="false"{+END}>
	{+END}

			{+START,IF,{$NOT,{SIMPLE_STYLE}}}
				<div class="various_ticks float_surrounder">
					{+START,LOOP,OUT}
						<div class="input_individual_tick">
							<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick"{+START,IF,{CHECKED}} checked="checked"{+END} type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" {+START,IF,{DISABLED}}disabled="disabled" {+END}/> {PRETTY_NAME*}</label>
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

	{+START,IF_PASSED,EXPANDED}
		</div>
	{+END}
</div>

