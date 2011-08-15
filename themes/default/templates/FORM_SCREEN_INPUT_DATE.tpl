<div class="accessibility_hidden"><label for="{STUB%}_day">{!DAY}</label></div>
<div class="accessibility_hidden"><label for="{STUB%}_month">{!MONTH}</label></div>
<div class="accessibility_hidden"><label for="{STUB%}_year">{!YEAR}</label></div>
{+START,IF,{$NOT,{NULL_OK}}}
	<input type="hidden" name="{STUB%}" value="1" />
{+END}

<select tabindex="{TABINDEX*}" id="{STUB%}_day" name="{STUB%}_day"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required date"{+END}>
	<option value="">---</option>
	{DAYS}
</select>
<select tabindex="{TABINDEX*}" id="{STUB%}_month" name="{STUB%}_month"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required date"{+END}>
	<option value="">---</option>
	{MONTHS}
</select>
<select tabindex="{TABINDEX*}" id="{STUB%}_year" name="{STUB%}_year"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required date"{+END}>
	<option value="">---</option>
	{YEARS}
</select>

{TIME}

{+START,IF,{$JS_ON}}
	<img class="inline_image" id="cal{STUB#}Button" title="{!SHOW_DATE_CHOOSER}" alt="{!SHOW_DATE_CHOOSER}" src="{$IMG*,date_chooser/pdate}" />
{+END}

<div id="cal{STUB#}Container" class="inline">&nbsp;</div>

<script type="text/javascript">// <![CDATA[
	var cal{STUB%}=null;
	var link{STUB%}=document.getElementById('cal{STUB;}Button');
	if (link{STUB%}) link{STUB%}.onclick=function() { initialise_date_field('{STUB%}','cal{STUB%}','link{STUB%}'); };
//]]></script>

