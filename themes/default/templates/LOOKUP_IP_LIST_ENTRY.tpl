<li>
	<label for="banned_{UNIQID*}"><a href="{LOOKUP_URL*}">{IP*}</a> ({DATE*})
	{+START,IF,{$ADDON_INSTALLED,securitylogging}}
		&nbsp; <em>{!_BANNED}: <input type="checkbox" id="banned_{UNIQID*}" name="banned[]" value="{IP*}"{+START,IF,{BANNED}} checked="checked"{+END} /></em>
	{+END}
	</label>
</li>
