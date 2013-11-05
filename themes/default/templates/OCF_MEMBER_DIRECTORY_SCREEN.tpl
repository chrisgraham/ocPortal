{TITLE}

{+START,IF_NON_EMPTY,{RESULTS_TABLE}}
	{+START,IF_PASSED,SYMBOLS}
		<div class="float_surrounder"><div class="pagination alphabetical_jumper">
			{+START,LOOP,SYMBOLS}{+START,IF,{$EQ,{$_GET,md_start},{START}}}<span class="results_page_num">{SYMBOL*}</span>{+END}{+START,IF,{$NEQ,{$_GET,md_start},{START}}}<a class="results_continue alphabetical_jumper_cont" target="_self" href="{$PAGE_LINK*,_SELF:_SELF:md_start={START}:md_max={MAX}:md_sort=m_username ASC}">{SYMBOL*}</a>{+END}{+END}
		</div></div>
	{+END}
	{RESULTS_TABLE}
{+END}
{+START,IF_EMPTY,{RESULTS_TABLE}}
	<p class="nothing_here">{!NO_RESULTS}</p>
{+END}

<h2>{!SEARCH}</h2>

<form title="{!SEARCH}" target="_self" method="get" action="{GET_URL*}" onsubmit="try { window.scrollTo(0,0); } catch(e) {};">
	<div>
		{HIDDEN}

		<label for="member_filter"><span class="invisible_ref_point"></span><input {+START,IF,{$MOBILE}}autocorrect="off" {+END}autocomplete="off" maxlength="80" onkeyup="update_ajax_member_list(this,null,false,event);" type="text" id="member_filter" name="filter" value="{SEARCH*}" /> <input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SEARCH}" /> ({!SEARCH_MEMBER_EXAMPLE})</label>
	</div>
</form>

