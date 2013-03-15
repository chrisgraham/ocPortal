<div class="menu_editor_branch" id="branch_wrap_{I*}">
	<div id="branch_{I*}">
		<label id="label_caption_{I*}" for="caption_{I*}">{!CAPTION}: </label>
		<input maxlength="255" onfocus="make_field_selected(this);" ondblclick="var e=document.getElementById('menu_editor_wrap'); if (e.className.indexOf(' docked')==-1) smooth_scroll(find_pos_y(document.getElementsByTagName('h2')[2]));" type="text" value="{CAPTION*}" id="caption_{I*}" name="caption_{I*}" />

		<input type="hidden" value="{CAPTION_LONG*}" id="caption_long_{I*}" name="caption_long_{I*}" />
		<input type="hidden" value="{URL*}" id="url_{I*}" name="url_{I*}" />
		<input type="hidden" id="match_tags_{I*}" name="match_tags_{I*}" value="{PAGE_ONLY*}" />
		<input type="hidden" id="theme_img_code_{I*}" name="theme_img_code_{I*}" value="{THEME_IMG_CODE*}" />
		<input type="hidden" id="parent_{I*}" name="parent_{I*}" value="{PARENT*}" />
		<input type="hidden" id="order_{I*}" name="order_{I*}" value="{ORDER*}" />
		<input type="hidden" id="new_window_{I*}" name="new_window_{I*}" value="0" />
		<input type="hidden" id="check_perms_{I*}" name="check_perms_{I*}" value="0" />
		<div class="accessibility_hidden"><label id="label_branch_type_{I*}" for="branch_type_{I*}">{!MENU_ENTRY_BRANCH}</label></div>
		<select style="display: none" onclick="this.onchange(event);" onchange="menu_editor_branch_type_change(this.name.substr(12,this.name.length));" title="{$STRIP_TAGS,{!MENU_ENTRY_BRANCH;}}" id="branch_type_{I*}" name="branch_type_{I*}">
			{+START,IF,{$NOT,{CLICKABLE_SECTIONS}}}
				<option value="page">{!PAGE}</option>
			{+END}
			<option value="branch_minus">{!CONTRACTED_BRANCH}</option>
			<option value="branch_plus">{!EXPANDED_BRANCH}</option>
		</select>

		<input type="image" class="horiz_field_sep" src="{$IMG*,results/sortablefield_desc}" id="down_{I*}" alt="{!MOVE_DOWN}" onkeypress="if (enter_pressed()) this.onclick(event);" onclick="handle_ordering(this,false,true); return false;" />
		<input type="image" src="{$IMG*,results/sortablefield_asc}" id="up_{I*}" alt="{!MOVE_UP}" onkeypress="if (enter_pressed()) this.onclick(event);" onclick="handle_ordering(this,true,false); return false;" />

		<input class="horiz_field_sep" value="{!DELETE}" type="button" id="del_{I*}" name="del_{I*}" onclick="delete_menu_branch(this);" />
	</div>

	<script type="text/javascript">// <![CDATA[
		document.getElementById('new_window_{I%}').value='{NEW_WINDOW%}';
		document.getElementById('check_perms_{I%}').value='{CHECK_PERMS%}';
		document.getElementById('branch_type_{I%}').selectedIndex={+START,IF,{$NOT,{CLICKABLE_SECTIONS}}}{BRANCH_TYPE%}{+END}{+START,IF,{CLICKABLE_SECTIONS}}({BRANCH_TYPE%}==0)?0:({BRANCH_TYPE%}-1){+END};
	//]]></script>
	<div class="menu_editor_branch_indent" id="branch_{I*}_follow_1" style="{DISPLAY*}">
		{BRANCH}
	</div>
	<div class="menu_editor_branch_indent" id="branch_{I*}_follow_2" style="{DISPLAY*}">
	</div>
</div>

