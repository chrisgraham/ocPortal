{TITLE}

{+START,IF_NON_EMPTY,{PRE}}
<div class="index_page_fancier_page_pre"{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
	{PRE}
</div>
{+END}

{+START,IF_NON_EMPTY,{CONTENT}}
	<div class="index_page_fancier_page_entries"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
		{+START,IF_PASSED,ARRAY}
			{+START,LOOP,CONTENT}
				{+START,IF_NON_EMPTY,{_loop_var}}
					<h2>{_loop_key}</h2>

					<div class="not_too_tall">
						{_loop_var}
					</div>
				{+END}
			{+END}
			{+START,IF_PASSED,EMPTY}
				<p class="nothing_here">
					{!NONE}
				</p>
			{+END}
		{+END}
		{+START,IF_NON_PASSED,ARRAY}
			{CONTENT}
		{+END}
	</div>
{+END}
{+START,IF_EMPTY,{CONTENT}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{POST}}
	<div class="index_page_fancier_page_post">
		{POST}
	</div>
{+END}

{+START,IF_PASSED,RESULTS_BROWSER}
	<br />
	<div class="float_surrounder">
		{RESULTS_BROWSER}
	</div>
{+END}

{+START,IF_PASSED,ADD_URL}
	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={ADD_URL*}
		1_TITLE={!ADD}
		1_REL=add
	{+END}
{+END}
