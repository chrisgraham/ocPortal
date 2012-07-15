<div class="menu_editor_branch_wrap">
	{CHILD_BRANCHES}

	<div id="branches_go_before_{I*}"><span style="display: none"></span></div>

	<ul class="actions_list">
		<li>
			<a rel="add" href="#" id="add_new_menu_linka_{I*}" onclick="return add_new_menu_item(this.id.substr(19),{CLICKABLE_SECTIONS*});"><img alt="" src="{$IMG*,treefield/plus}" /></a>
			<a rel="add" href="#" id="add_new_menu_linkb_{I*}" onclick="return add_new_menu_item(this.id.substr(19),{CLICKABLE_SECTIONS*});">{!ADD_BRANCH}</a>
		</li>
	</ul>
</div>
