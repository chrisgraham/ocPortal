{+START,BOX,Recent Projects}
	<div class="recent">
		{ENTRIES}

		{+START,IF_EMPTY,{ENTRIES}}
			<p class="nothing_here">
				{!NO_ENTRIES}
			</p>
		{+END}
	</div>
{+END}
