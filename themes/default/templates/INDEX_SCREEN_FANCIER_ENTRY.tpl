<div class="lightborder index_page_fancier_entry">
	{+START,IF_PASSED,IMG}
		{+START,IF_NON_EMPTY,{URL}}<a {+START,IF_PASSED,TARGET}target="{TARGET*}" {+END}href="{URL*}" title="{TITLE*}">{+END}<img style="float: right" alt="" src="{IMG*}" />{+START,IF_NON_EMPTY,{URL}}</a>{+END}
	{+END}

	<div class="index_page_fancier_entry_link">&raquo; {+START,IF_NON_EMPTY,{URL}}<a {+START,IF_PASSED,TARGET}target="{TARGET*}" {+END}href="{URL*}" title="{$STRIP_TAGS,{NAME*}}{+START,IF_NON_EMPTY,{TITLE}}: {$STRIP_TAGS,{TITLE*}}{+END}">{+END}{NAME*}{+START,IF_NON_EMPTY,{URL}}</a>{+END}{+START,IF_PASSED,COUNT} <span class="index_page_fancier_entry_count">{COUNT*}</span>{+END}</div>
	{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<div class="index_page_fancier_entry_description">
		{DESCRIPTION`}
	</div>
	{+END}

	{+START,IF_PASSED,SUP}
		<div class="index_page_fancier_entry_sup">
			{SUP}
		</div>
	{+END}
</div>
