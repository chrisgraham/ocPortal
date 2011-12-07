<div class="accessibility_hidden"><label for="{STUB*}_hour">{!HOUR}</label></div>
<div class="accessibility_hidden"><label for="{STUB*}_minute">{!MINUTE}</label></div>

<select tabindex="{TABINDEX*}" id="{STUB*}_hour" name="{STUB*}_hour"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required"{+END}>
	<option value="">-</option>
	{HOURS}
</select>
:
<select tabindex="{TABINDEX*}" id="{STUB*}_minute" name="{STUB*}_minute"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required"{+END}>
	<option value="">-</option>
	{MINUTES}
</select>
