{+START,IF,{$OR,{$IS_NON_EMPTY,{PREVIOUS_URL}},{$IS_NON_EMPTY,{NEXT_URL}}}}
	<div class="trinav_wrap">
		<p class="trinav_left">
			{+START,IF_NON_EMPTY,{PREVIOUS_URL}}
				<a rel="prev" accesskey="j" href="{PREVIOUS_URL*}"><img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/previous}" /></a>
			{+END}
			{+START,IF_EMPTY,{PREVIOUS_URL}}
				<img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/no_previous}" />
			{+END}
		</p>

		<p class="trinav_right">
			{+START,IF_NON_EMPTY,{NEXT_URL}}
				<a rel="next" accesskey="k" href="{NEXT_URL*}"><img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/next}" /></a>
			{+END}
			{+START,IF_EMPTY,{NEXT_URL}}
				<img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/no_next}" />
			{+END}
		</p>

		{+START,IF_PASSED,PAGE_NUM}
			{+START,IF_PASSED,NUM_PAGES}
				<p class="trinav_mid text"><span>
					{!PAGE_OF,{PAGE_NUM*},{NUM_PAGES*}}
				</span></p>
			{+END}
		{+END}
	</div>
{+END}

