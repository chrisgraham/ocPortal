{+START,IF_NON_EMPTY,{SUMMARY}}
	<div class="float_surrounder">
		{SUMMARY`}
	</div>
{+END}
{+START,IF_EMPTY,{SUMMARY}}
	<p>
		{!NO_SUMMARY}
	</p>
{+END}

<p class="shunted_button">
	<a href="{URL*}"><img class="button_pageitem" alt="{!VIEW}" title="{!VIEW}" src="{$IMG*,pageitem/goto}" /></a>
</p>
