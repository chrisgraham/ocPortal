{TITLE}

{+START,IF_PASSED,SYMBOLS}
	<div class="float_surrounder"><div class="results_browser alpha_jumper">
		{+START,LOOP,SYMBOLS}<a class="results_continue alpha_jumper_cont" target="_top" href="{$PAGE_LINK*,_SELF:_SELF:md_start={START}:md_max={MAX*}:md_sort=m_username ASC}">{SYMBOL*}</a>{+END}
	</div></div>
{+END}
{RESULTS_TABLE}

<h2>{!SEARCH}</h2>

<form title="{!SEARCH}" target="_self" method="get" action="{GET_URL*}" onsubmit="try { window.scrollTo(0,0); } catch(e) {};">
	<div>
		{HIDDEN}

		<label for="member_filter"><span class="invisible_ref_point">&nbsp;</span><input maxlength="80" onkeyup="update_ajax_member_list(this,null,false,event);" type="text" id="member_filter" name="filter" value="{SEARCH*}" /> <input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SEARCH}" /> ({!SEARCH_MEMBER_EXAMPLE})</label>
	</div>
</form>

