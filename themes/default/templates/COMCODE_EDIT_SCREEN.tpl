{TITLE}

{+START,INCLUDE,HANDLE_CONFLICT_RESOLUTION}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

{TEXT}

{POSTING_FORM}

{+START,IF,{$NOT,{NEW}}}
	<div class="buttons_group">
		<a href="{DELETE_URL*}" title="{!DELETE}: {ZONE*}:{FILE*}"><img class="button_pageitem" src="{$IMG*,pageitem/delete}" title="{!DELETE}" alt="{!DELETE}" /></a>
	</div>
{+END}

{REVISION_HISTORY}

