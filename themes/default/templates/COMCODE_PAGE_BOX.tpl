{+START,SET,PREVIEW_CONTENTS}
	{+START,IF_NON_EMPTY,{SUMMARY}}
		<div class="float_surrounder">
			{$TRUNCATE_LEFT,{SUMMARY`},300,0,1}
		</div>
	{+END}
	{+START,IF_EMPTY,{SUMMARY}}
		<p>
			{!NO_SUMMARY}
		</p>
	{+END}

	{+START,IF_PASSED,BREADCRUMBS}{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>
			{!LOCATED_IN,{BREADCRUMBS}}
		</p></nav>
	{+END}{+END}

	<p class="shunted_button">
		<a class="buttons__goto button_pageitem" href="{URL*}"><span>{!VIEW}</span></a>
	</p>
{+END}

{+START,IF_PASSED,TITLE}
	<section class="box box___comcode_page_box"><div class="box_inner">
		<h3>
			{+START,IF,{GIVE_CONTEXT}}
				{!CONTENT_IS_OF_TYPE,{!PAGE},{TITLE*}}
			{+END}

			{+START,IF,{$NOT,{GIVE_CONTEXT}}}
				{TITLE*}
			{+END}
		</h3>

		{$GET,PREVIEW_CONTENTS}
	</div></section>
{+END}

{+START,IF_NON_PASSED,TITLE}
	{$GET,PREVIEW_CONTENTS}
{+END}
