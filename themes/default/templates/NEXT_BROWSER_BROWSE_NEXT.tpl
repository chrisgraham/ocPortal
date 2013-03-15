{+START,IF,{$OR,{$IS_NON_EMPTY,{PREVIOUS_LINK}},{$IS_NON_EMPTY,{NEXT_LINK}}}}
	<div class="float_surrounder">
		<p style="float: left">
			{+START,IF_NON_EMPTY,{PREVIOUS_LINK}}
				<a rel="prev" accesskey="j" href="{PREVIOUS_LINK*}"><img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/previous}" /></a>
			{+END}
			{+START,IF_EMPTY,{PREVIOUS_LINK}}
				<img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/no_previous}" />
			{+END}
		</p>
		<p style="float: right">
			{+START,IF_NON_EMPTY,{NEXT_LINK}}
				<a rel="next" accesskey="k" href="{NEXT_LINK*}"><img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/next}" /></a>
			{+END}
			{+START,IF_EMPTY,{NEXT_LINK}}
				<img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/no_next}" />
			{+END}
		</p>
		{+START,IF_PASSED,PAGE_NUM}
		{+START,IF_PASSED,NUM_PAGES}
			<p class="nav_mid">
				{!PAGE_OF,{PAGE_NUM*},{NUM_PAGES*}}
			</p>
		{+END}
		{+END}
	</div>
{+END}

