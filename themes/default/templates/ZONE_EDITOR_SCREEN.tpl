{TITLE}

{+START,INCLUDE,HANDLE_CONFLICT_RESOLUTION}{+END}

{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<p class="vertical_alignment">
	<img src="{$IMG*,help}" alt="" /> <span>{!ZE_HOW_TO_SAVE}</span>
</p>

<div class="float_surrounder" id="ze_panels_wrap">
	<div id="p_panel_left" class="ze_panel" onmouseover="this.className='ze_panel ze_panel_expanded'; if (!this.style.width) this.style.width='16em'; ze_animate_to(this,45,true);" onmouseout="this.className='ze_panel'; if (!this.style.width) this.style.width='45em'; ze_animate_to(this,16,false);">
		{LEFT_EDITOR}
	</div>

	<div id="p_panel_right" class="ze_panel" onmouseover="this.className='ze_panel ze_panel_expanded'; if (!this.style.width) this.style.width='16em'; ze_animate_to(this,45,true);" onmouseout="this.className='ze_panel'; if (!this.style.width) this.style.width='45em'; ze_animate_to(this,16,false);">
		{RIGHT_EDITOR}
	</div>

	<div class="ze_middle">
		{MIDDLE_EDITOR}
	</div>
</div>

<hr class="spaced_rule" />

<form title="{!SAVE}" action="{URL*}" method="post" target="_self">
	<div id="edit_field_store" style="display: none">
	</div>

	<p class="proceed_button vertical_alignment">
		<input class="button_page" type="button" value="{!SAVE}" onclick="fetch_more_fields(); this.form.submit();" /> <span class="associated_details">{!ZE_CLICK_TO_EDIT}</span>
	</p>
</form>

<p class="vertical_alignment">
	<img src="{$IMG*,help}" alt="" /> <span>{!MANY_PANEL_TYPES,{$PAGE_LINK*,cms:cms_comcode_pages:_ed:lang={LANG}:page_link={ID}%3Apanel_top},{$PAGE_LINK*,cms:cms_comcode_pages:_ed:lang={LANG}:page_link={ID}%3Apanel_bottom}}</span>
</p>
