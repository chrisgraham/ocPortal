<h1 class="screen_title">{$SITE_NAME*} members</h1>

{+START,IF_PASSED,SYMBOLS}
	<div class="float_surrounder"><div class="pagination alphabetical_jumper">
		{+START,LOOP,SYMBOLS}<a class="results_continue alphabetical_jumper_cont" target="_top" href="{$PAGE_LINK*,_SELF:_SELF:start={START}:sort=m_username ASC}">{SYMBOL*}</a>{+END}
	</div></div>
{+END}

<div class="advanced_member_search">
	{$BLOCK,block=main_include_module,param=site:search:misc:ocf_members:force_non_tabular=1:keep_no_frames=1,leave_page_and_zone=1,merge_parameters=1}
</div>

{$,If no search done yet, fall back to conventional module results...}
{+START,IF,{$NOT,{$GET,done_search}}}
	{+START,IF_EMPTY,{$_GET,filter}}
		<p>We have the following members on {$SITE_NAME*}&hellip;</p>
	{+END}
	{+START,IF_NON_EMPTY,{$_GET,filter}}
		<p>The following members match your quick search&hellip;</p>
	{+END}

	<div class="float_surrounder">
		{+START,LOOP,MEMBER_BOXES}
			{_loop_var}
		{+END}
	</div>

	<div class="float_surrounder">
		{PAGINATION}
	</div>
{+END}
