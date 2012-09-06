<section class="box box___simple_preview_box"><div class="box_inner">
	{+START,IF_PASSED,TITLE}{+START,IF_NON_EMPTY,{TITLE}}
		<h3>{TITLE*}</h3>
	{+END}{+END}

	{+START,IF_PASSED,REP_IMAGE}
		<div class="right float_separation"><a href="{URL*}">{REP_IMAGE}</a></div>
	{+END}

	{+START,IF_NON_EMPTY,{SUMMARY}}
		<div class="float_surrounder">
			{$PARAGRAPH,{SUMMARY}}
		</div>
	{+END}
	{+START,IF_EMPTY,{SUMMARY}}
		<p>
			{!NO_SUMMARY}
		</p>
	{+END}

	{+START,IF_PASSED,ENTRY_DETAILS}
		<p class="associated_details">
			{$,Displays summary of gallery contents}
			({ENTRY_DETAILS})
		</p>
	{+END}
	{+START,IF_PASSED,ENTRY_DETAILS_PREBRACKETED}
		<p class="associated_details">
			{$,Displays summary of gallery contents}
			{ENTRY_DETAILS}
		</p>
	{+END}

	{+START,IF_PASSED,BREADCRUMBS}{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>
			{!LOCATED_IN,{BREADCRUMBS}}
		</p></nav>
	{+END}{+END}

	{+START,IF_PASSED,URL}
		<p class="shunted_button">
			<a href="{URL*}"><img class="button_pageitem" alt="{!VIEW}" title="{!VIEW}" src="{$IMG*,pageitem/goto}" /></a>
		</p>
	{+END}
</div></section>
