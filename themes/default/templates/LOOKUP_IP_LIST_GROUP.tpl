<li>
	<label for="banned_{UNIQID*}">
		<kbd>{MASK*}</kbd>
		{+START,IF,{$ADDON_INSTALLED,securitylogging}}
			<span class="horiz_field_sep"><em>{!_BANNED}: <input type="checkbox" id="banned_{UNIQID*}" name="banned[]" value="{MASK*}"{+START,IF,{BANNED}} checked="checked"{+END} /></em></span>
		{+END}
	</label>

	<div>
		<p>
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{$?,{OPEN_DEFAULT},{!CONTRACT},{!EXPAND}}" title="{$?,{OPEN_DEFAULT},{!CONTRACT},{!EXPAND}}" src="{$IMG*,{$?,{OPEN_DEFAULT},contract,expand}}" /></a>
		</p>

		<div class="toggleable_tray" style="display: {$JS_ON,{$?,{OPEN_DEFAULT},block,none},block}"{+START,IF,{$NOT,{OPEN_DEFAULT}}} aria-expanded="false"{+END}>
			<ul>
				{GROUP}
			</ul>
		</div>
	</div>
</li>
