<div>
	{+START,IF_PASSED,EXPANDED}
		<h4 class="comcode_quote_h4">
			<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">
				<img title="" alt="{!EXPAND}/{!CONTRACT}" src="{$IMG*,{$?,{EXPANDED},contract,expand}}" />
			</a>

			<a class="hide_button non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">{SECTION_TITLE*}</a>
		</h4>
		<div class="hide_tag" style="display: {$JS_ON,{$?,{EXPANDED},block,none},block}">
			<div class="comcode_quote_content comcode_quote_content_titled">
	{+END}


			{+START,IF,{$NOT,{SIMPLE_STYLE}}}
				<div class="input_compound_ticks float_surrounder">
				{$SET,PREVIOUS_TICK,0}
				{+START,LOOP,OUT}
					<div class="{$?,{$GET,PREVIOUS_TICK},input_compound_tick,input_compound_tick_first}">
						{+START,IF,{$NOT,{CHECKED}}}
							<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick" type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" {+START,IF,{DISABLED}}disabled="disabled" {+END} /> {PRETTY_NAME*}</label>
						{+END}
						{+START,IF,{CHECKED}}
							<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick" checked="checked" type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" {+START,IF,{DISABLED}}disabled="disabled" {+END}/> {PRETTY_NAME*}</label>
						{+END}
						<input type="hidden" name="label_for__{NAME*}" value="{PRETTY_NAME*}" />
						<input name="tick_on_form__{NAME*}" value="0" type="hidden" />
						{$SET,PREVIOUS_TICK,1}
					</div>
				{+END}
				</div>
			{+END}
			{+START,IF,{SIMPLE_STYLE}}
				{+START,LOOP,OUT}
					<p>
						{+START,IF,{$NOT,{CHECKED}}}
							<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick" type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" /> {PRETTY_NAME*}</label>
						{+END}
						{+START,IF,{CHECKED}}
							<label for="i_{NAME*}"><input title="{DESCRIPTION*}" tabindex="{TABINDEX*}" class="input_tick" checked="checked" type="checkbox" id="i_{NAME*}" name="{NAME*}" value="1" /> {PRETTY_NAME*}</label>
						{+END}
						<input type="hidden" name="label_for__{NAME*}" value="{PRETTY_NAME*}" />
						<input name="tick_on_form__{NAME*}" value="0" type="hidden" />
					</p>
				{+END}
			{+END}


	{+START,IF_PASSED,EXPANDED}
			</div>
		</div>
	{+END}
</div>

