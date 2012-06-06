{+START,SET,PREVIEW_CONTENTS}
	{+START,IF_NON_EMPTY,{SUMMARY}}
		<div class="float_surrounder">
			{SUMMARY`}
		</div>
	{+END}
	{+START,IF_EMPTY,{SUMMARY}}
		<p>
			{!NO_SUMMARY}
		</p>
	{+END}

	{+START,IF_PASSED,BREADCRUMBS}{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<p>
			{!LOCATED_IN,{BREADCRUMBS}}
		</p>
	{+END}{+END}

	{+START,IF_PASSED,URL}
		<p class="shunted_button">
			<a href="{URL*}"><img class="button_pageitem" alt="{!VIEW}" title="{!VIEW}" src="{$IMG*,pageitem/goto}" /></a>
		</p>
	{+END}
{+END}

{+START,IF_PASSED,TITLE}
	<section class="box box___simple_preview_box"><div class="box_inner">
		<h3>{TITLE*}</h3>

		{$GET,PREVIEW_CONTENTS}
	</div></section>
{+END}

{+START,IF_NON_PASSED,TITLE}
	{$GET,PREVIEW_CONTENTS}
{+END}
