{+START,BOX,{!WEATHER_REPORT},100%,{$?,{$GET,in_panel},panel,curved},,,{$?,{$IS_NON_EMPTY,{COND}}}}
	<div>
		{+START,IF_NON_EMPTY,{IMAGE}}
			<span>
				<img src="{IMAGE`}" alt="{!WEATHER_IMAGE}" title=""/>
			</span>
		{+END}

		<ul class="nl">
			<li class="compact_list associated_link_to_small"><b>{TITLE}</b></li>
			{+START,IF_NON_EMPTY,{COND}}
				<li class="compact_list associated_link_to_small">
					{COND`}
				</li>		
			{+END}
			{+START,IF_NON_EMPTY,{FORECAST}}
				<li class="compact_list associated_link_to_small">
					{FORECAST`}
				</li>
			{+END}
		</ul>
	</div>
{+END}
