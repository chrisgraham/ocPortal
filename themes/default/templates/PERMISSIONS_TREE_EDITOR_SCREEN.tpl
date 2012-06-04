{TITLE}

<p>{!PERMISSIONS_TREE_EDITOR_ABOUT_SP,{$PAGE_LINK*,adminzone:admin_permissions:type=specific}}</p>

<div class="float_surrounder">
	<div class="pte_help_box">
		{+START,BOX,{!PERMISSIONS_TREE_EDITOR_HOW_WORK},,light}
			<p>{!PERMISSIONS_TREE_EDITOR_ABOUT_BARRIERS,<img src="{$IMG*,led_on}" alt="" />}</p>

			<p>{!PERMISSIONS_TREE_EDITOR_ABOUT_GROUP,<img src="{$IMG*,permlevels/3}" alt="" />}</p>

			<p class="pte_tips">{!PERMISSIONS_TREE_EDITOR_ABOUT_MULTI_SELECT}</p>

			<p class="pte_tips">{!PERMISSIONS_TREE_EDITOR_ABOUT_HOVER_FOR_PERMISSIONS}</p>

			<p class="pte_tips">{!PERMISSIONS_TREE_EDITOR_INHERIT}</p>
		{+END}
	</div>

	<div>
		{+START,BOX,{!SITE_TREE}}
			<div class="pte_tree">
				<!-- onmouseover="fade_icons_out();" onmouseout="fade_icons_in();" firefox too buggy -->
				<div class="pte_icon_box">
					{+START,BOX,,,light}
						<form title="{!CHOOSE} {!_USERGROUP}" action="index.php" method="post">
							<img alt="" src="{$IMG*,pte_view_help}" /><strong><label for="group">{!PERMISSIONS_TREE_EDITOR_ICON_LABEL}:</label></strong>
							<select id="group" name="group" onclick="this.onchange(event);" onchange="update_group_displayer(this)">
								{GROUPS}
							</select>
						</form>
						<p>{!PERMISSIONS_TREE_EDITOR_ICON_SPECIFIC,<span id="group_name">{INITIAL_GROUP*}</span>}</p>
					{+END}
				</div>

				<form title="{!PRIMARY_PAGE_FORM}" action="index.php" method="post">
					<div class="accessibility_hidden"><label for="tree_list">{!ENTRY}</label></div>
					<input onchange="update_permission_box(this)" style="display: none" type="text" id="tree_list" name="tree_list" value="{$_GET*,id}" />
				</form>
				<div id="tree_list__root_tree_list" class="tree_list__root_tree_list pt_editor">
					<!-- List put in here -->
				</div>
				<script type="text/javascript">// <![CDATA[
					var site_tree=new tree_list('tree_list','data/site_tree.php?start_links=1&get_perms=1{$KEEP;}','','',true);
					var column_color='{COLOR*;}';

					window.usergroup_titles=[];
					{+START,LOOP,USERGROUPS}
						window.usergroup_titles[{_loop_key}]='{_loop_var;}';
					{+END}
				//]]></script>
			</div>
		{+END}
	</div>
</div>

<div class="pte_set_box">
	{+START,BOX,{!PERMISSIONS_TREE_EDITOR_PERMISSIONS_FOR_SELECTION}}
		<p>
			{!PERMISSION_INHERITANCE_HOVER}
		</p>

		<form title="{!PRIMARY_PAGE_FORM}" method="post" action="index.php">
			<div class="float_surrounder">
				<div style="display: none" id="selection_form_fields">
					{EDITOR}

					<br />
				</div>

				<p style="float: {!en_right}" id="selection_message">
					{!PERMISSIONS_TREE_EDITOR_NONE_SELECTED}
				</p>
				<div>
					<input type="button" class="button_page" id="selection_button" disabled="disabled" value="{!SET}" onclick="set_permissions(document.getElementById('tree_list'));" />
				</div>
			</div>
		</form>
	{+END}
</div>
