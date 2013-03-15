{TITLE}

{+START,IF_NON_EMPTY,{PRE}}
	<div class="index_screen_fancier_screen_pre" itemprop="description">
		{PRE}
	</div>
{+END}

{+START,IF_NON_EMPTY,{CONTENT}}
	<div class="index_screen_fancier_screen_entries" itemprop="significantLinks">
		{+START,IF_PASSED_AND_TRUE,ARRAY}
			{+START,LOOP,CONTENT}
				{+START,IF_NON_EMPTY,{_loop_var}}
					<h2>{_loop_key}</h2>

					<div class="not_too_tall">
						{_loop_var}
					</div>
				{+END}
			{+END}
			{+START,IF_EMPTY,{CONTENT}}
				<p class="nothing_here">
					{!NONE}
				</p>
			{+END}
		{+END}
		{+START,IF_NON_PASSED_OR_FALSE,ARRAY}
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
	<div class="index_screen_fancier_screen_post">
		{POST}
	</div>
{+END}

{+START,IF_PASSED,PAGINATION}
	<div class="float_surrounder">
		{PAGINATION}
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
