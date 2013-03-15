<h3>{TITLE*}</h3>

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
	<a class="more" href="{URL*}">{!READ_MORE}</a>
</p>
