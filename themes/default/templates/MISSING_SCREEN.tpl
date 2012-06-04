{TITLE}

<p>
	{!MISSING_PAGE,{PAGE*}}
</p>

{+START,IF_PASSED,DID_MEAN}
	<p>
		{!WERE_YOU_LOOKING_FOR,<a href="{$PAGE_LINK*,{$ZONE}:{DID_MEAN}}">{DID_MEAN*}</a>}
	</p>
{+END}

{+START,SET,BUTTONS}
	{+START,IF_NON_EMPTY,{ADD_URL}}
		<a rel="add" href="{ADD_URL*}"><img class="button_page" src="{$IMG*,page/new}" alt="{!ADD_NEW_PAGE}" title="{!ADD_NEW_PAGE}" /></a>
	{+END}

	{+START,IF_PASSED,ADD_REDIRECT_URL}
		{+START,IF_NON_EMPTY,{ADD_REDIRECT_URL}}
			<a href="{ADD_REDIRECT_URL*}"><img class="button_page" src="{$IMG*,page/redirect}" alt="{!REDIRECTING}" title="{!REDIRECTING}" /></a>
		{+END}
	{+END}
{+END}
{+START,IF_NON_EMPTY,{$TRIM,{$GET,BUTTONS}}}
	<p class="buttons_group">
		{$GET,BUTTONS}
	</p>
{+END}

<h2>{!SITE_MAP}</h2>

{$BLOCK,block=main_sitemap,quick_cache=1}

{+START,IF,{$ADDON_INSTALLED,search}}
	<h2>{!SEARCH}</h2>

	{$BLOCK,block=main_search,failsafe=1}
{+END}
