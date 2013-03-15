<div class="float_surrounder">
	<div class="display_type_{DISPLAY_TYPE*}">
		{ENTRIES}
	</div>
</div>

{+START,IF_EMPTY,{ENTRIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

