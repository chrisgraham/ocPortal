{TITLE}

<h2>{!MANAGE_WORDFILTER}</h2>

<p>
	{!OBSCENITY_WARNING}
</p>

{+START,IF_NON_EMPTY,{TPL}}
<div>
	<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('evil','block'); return false;"><img id="e_evil" alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
	<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('evil','block'); return false;">{!PROCEED}</a>
	<div class="hide_button_spacing" id="evil" style="display: {$JS_ON,none,block}">
		{TPL}
	</div></div>

<br />
{+END}
{+START,IF_EMPTY,{TPL}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

<h2>{!ADD_WORDFILTER}</h2>

<p>{!HELP_ADD_WORDFILTER}</p>

{+START,IF_NON_PASSED,SKIP_REQUIRED_NOTICE}
<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
{+END}

{ADD_FORM}

