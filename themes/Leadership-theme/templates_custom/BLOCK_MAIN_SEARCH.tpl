<form onsubmit="if (typeof this.elements['contents']=='undefined') { disable_button_just_clicked(this); return true; } if (checkFieldForBlankness(this.elements['contents'],event)) { return true; } return false;" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
	{$HIDDENS_FOR_GET_FORM,{URL}}

	<div>
		<input class="search-box" onkeyup="update_ajax_search_list(this,event);" type="text" id="search_content" name="content" value="" />

		<input class="search-but" type="submit" value="Search" onfocus="if (this.value=='Search') this.value='';" />

		{+START,LOOP,LIMIT_TO}
			<input type="hidden" name="{_loop_var*}" value="1" />
		{+END}
		{+START,LOOP,EXTRA}
			<input type="hidden" name="{_loop_key*}" value="{_loop_var*}" />
		{+END}
		<input type="hidden" name="author" value="{AUTHOR*}" />
		<input type="hidden" name="days" value="{DAYS*}" />
		<input type="hidden" name="sort" value="{SORT*}" />
		<input type="hidden" name="direction" value="{DIRECTION*}" />
		<input type="hidden" name="only_titles" value="{ONLY_TITLES*}" />
		<input type="hidden" name="only_search_meta" value="{ONLY_SEARCH_META*}" />
		<input type="hidden" name="boolean_search" value="{BOOLEAN_SEARCH*}" />
		<input type="hidden" name="conjunctive_operator" value="{CONJUNCTIVE_OPERATOR*}" />
	</div>
</form>
