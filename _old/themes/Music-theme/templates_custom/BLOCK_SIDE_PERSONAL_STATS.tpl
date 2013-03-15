<div class="faux_tab_container">
	<h2>{$USERNAME*}</h2>

	<div class="right"><img src="{$AVATAR*,{$USER}}" title="{!AVATAR}" alt="{!AVATAR}" /></div>

	{+START,IF_NON_EMPTY,{CONTENT}}
		<ul class="compact_list">
			{CONTENT}
		</ul>
	{+END}
	{+START,IF_NON_EMPTY,{LINKS}}
		<ul class="compact_list">
			{LINKS}
		</ul>
	{+END}
</div>
