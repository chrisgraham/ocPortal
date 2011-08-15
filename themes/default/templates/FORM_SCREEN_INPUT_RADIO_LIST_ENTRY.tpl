{+START,IF,{$NOT,{CHECKED}}}
	<label for="{$FIX_ID,j_{NAME*}_{VALUE*}}"><input tabindex="{TABINDEX*}" class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{VALUE}}" name="{NAME*}" value="{VALUE*}" /> {TEXT}</label>
{+END}
{+START,IF,{CHECKED}}
	<label for="{$FIX_ID,j_{NAME*}_{VALUE*}}"><input tabindex="{TABINDEX*}" class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{VALUE}}" name="{NAME*}" value="{VALUE*}" checked="checked" /> {TEXT}</label>
{+END}
{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<div class="associated_caption">{DESCRIPTION*}</div>
{+END}
<br />
