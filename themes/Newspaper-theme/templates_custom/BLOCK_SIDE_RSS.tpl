{+START,IF_EMPTY,{CONTENT}}
	<p class="block_no_entries">&raquo; {!NO_NEWS}</p>
{+END}
{+START,IF_NON_EMPTY,{CONTENT}}
	<div class="xhtml_validator_off">
		{CONTENT}
	</div>
{+END}
