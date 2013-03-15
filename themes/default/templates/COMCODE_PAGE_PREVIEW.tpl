<div class="float_surrounder">
	{$TRUNCATE_LEFT,{SUMMARY`},300,0,1}

	{+START,IF_EMPTY,{SUMMARY}}
		<p>
			{!NO_SUMMARY}
		</p>
	{+END}
</div>
<p class="shunted_button">
	<a title="{!VIEW}: {PAGE*}" href="{URL*}"><img alt="{!VIEW}" title="{!VIEW}" class="button_pageitem" src="{$IMG*,pageitem/goto}" /></a>
</p>
