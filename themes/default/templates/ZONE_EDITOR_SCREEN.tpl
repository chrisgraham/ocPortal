{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<p><img class="inline_image" src="{$IMG*,help}" alt="" /> {!ZE_HOW_TO_SAVE}</p>

<div class="float_surrounder" id="ze_panels_wrap">
	<div id="p_panel_left" class="ze_panel" onmouseover="ze_ie6(this); this.className='ze_panel ze_panel_expanded'; if (!this.style.width) this.style.width='16em'; ze_animate_to(this,38,true);" onmouseout="this.className='ze_panel'; if (!this.style.width) this.style.width='38em'; ze_animate_to(this,16,false);">
		{LEFT_EDITOR}
	</div>

	<div id="p_panel_right" class="ze_panel" onmouseover="ze_ie6(this); this.className='ze_panel ze_panel_expanded'; if (!this.style.width) this.style.width='16em'; ze_animate_to(this,38,true);" onmouseout="this.className='ze_panel'; if (!this.style.width) this.style.width='38em'; ze_animate_to(this,16,false);">
		{RIGHT_EDITOR}
	</div>

	<div class="ze_middle" onmouseover="ze_ie6(this);">
		{MIDDLE_EDITOR}
	</div>
</div>

<hr class="spaced_rule" />

<form title="{!SAVE}" action="{URL*}" method="post" target="_self">
	<div id="edit_field_store" style="display: none">
		&nbsp;
	</div>

	<p class="proceed_button">
		<input class="button_page" type="button" value="{!SAVE}" onclick="fetch_more_fields(); this.form.submit();" /> {!ZE_CLICK_TO_EDIT}
	</p>
</form>

<p>{!MANY_PANEL_TYPES,{$PAGE_LINK*,cms:cms_comcode_pages:_ed:lang={LANG}:page_link={ID}%3Apanel_top},{$PAGE_LINK*,cms:cms_comcode_pages:_ed:lang={LANG}:page_link={ID}%3Apanel_bottom}}</p>