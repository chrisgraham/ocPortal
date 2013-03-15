{TITLE}

<h2>{!MANAGE_WORDFILTER}</h2>

<p>
	{!OBSCENITY_WARNING}
</p>

{+START,IF_NON_EMPTY,{TPL}}
	<div>
		<h3 class="toggleable_tray_title">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{!PROCEED}</a>
		</h3>

		<div class="toggleable_tray" style="display: {$JS_ON,none,block}" aria-expanded="false">
			{TPL}
		</div>
	</div>
{+END}
{+START,IF_EMPTY,{TPL}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

<h2>{!ADD_WORDFILTER}</h2>

<p>{!HELP_ADD_WORDFILTER}</p>

{+START,IF_NON_PASSED_OR_FALSE,SKIP_REQUIRED_NOTICE}
<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
{+END}

{ADD_FORM}

