{TITLE}

{+START,INCLUDE,HANDLE_CONFLICT_RESOLUTION}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<div class="menu_editor_page docked" id="menu_editor_wrap">
	<form title="" action="{URL*}" method="post">
		<!-- In separate form due to mod_security -->
		<textarea aria-hidden="true" cols="30" rows="3" style="display: none" name="template" id="template">{CHILD_BRANCH_TEMPLATE*}</textarea>
	</form>

	<form title="{!PRIMARY_PAGE_FORM}" id="edit_form" action="{URL*}" method="post">
		<div class="float_surrounder menu_edit_main">
			<div class="menu_editor_rh_side">
				<h2>{!HELP}</h2>

				<p>{!BRANCHES_DESCRIPTION,{$PAGE_LINK*,_SEARCH:admin_sitetree:site_tree}}</p>

				<p>{!ENTRY_POINTS_DESCRIPTION}</p>
			</div>

			<div class="menu_editor_lh_side">
				<h2>{!BRANCHES}</h2>

				<input type="hidden" name="highest_order" id="highest_order" value="{HIGHEST_ORDER*}" />

				<div class="menu_editor_root">
					{ROOT_BRANCH}
				</div>
			</div>

			<p class="proceed_button">
				<input accesskey="u" class="button_page" type="submit" value="{!SAVE}" onclick="if (validate_menu('{!MISSING_CAPTION_ERROR;}','{!MISSING_URL_ERROR;}')) { disable_button_just_clicked(this); return true; } else return false;" />
			</p>
		</div>

		<div id="mini_form_hider" style="display: none" class="float_surrounder">
			<div class="menu_editor_rh_side">
				<img onkeypress="this.onclick(event);" onclick="var e=document.getElementById('menu_editor_wrap'); if (e.className.indexOf(' docked')==-1) { e.className='menu_editor_page docked'; this.src='{$IMG*;,arrow_box_hover}'; } else { e.className='menu_editor_page'; this.src='{$IMG*;,arrow_box}'; }" class="dock_button" alt="" title="{!TOGGLE_DOCKED_FIELD_EDITING}" src="{$IMG*,arrow_box_hover}" />

				<h2>{!CHOOSE_ENTRY_POINT}</h2>

				<div class="accessibility_hidden"><label for="tree_list">{!ENTRY}</label></div>
				<input onchange="var e=document.getElementById('url_'+current_selection); if (!e) return; e.value=this.value; e=document.getElementById('edit_form').elements['url']; e.value=this.value; e=document.getElementById('edit_form').elements['caption_'+window.current_selection]; if (e.value=='') e.value=this.selected_title.replace(/^.*:\s*/,'');" style="display: none" type="text" id="tree_list" name="tree_list" value="" />
				<div id="tree_list__root_tree_list">
					<!-- List put in here -->
				</div>
				<script type="text/javascript">// <![CDATA[
					var current_selection='';
					var site_tree=new tree_list('tree_list','data/site_tree.php?get_perms=0{$KEEP;}&start_links=1','','',false,null,false,true);
				//]]></script>

				<p class="associated_details">
					{!CLICK_ENTRY_POINT_TO_USE}
				</p>

				<ul class="actions_list" role="navigation">
					<li><a href="#" onclick="return menu_editor_add_new_page();">{!SPECIFY_NEW_PAGE}</a></li>
				</ul>
			</div>

			<div class="menu_editor_lh_side">
				<h2>{!EDIT_SELECTED_FIELD}</h2>

				<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col class="field_name_column" />
							<col class="field_input_column" />
						</colgroup>
					{+END}

					<tbody>
						{FIELDS_TEMPLATE}
					</tbody>
				</table></div>
			</div>
		</div>

		<input type="hidden" name="confirm" value="1" />
	</form>

	<div class="box box___menu_editor_screen">
		<h2 class="toggleable_tray_title">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {!DELETE_MENU}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{!DELETE_MENU}</a>
		</h2>

		<div class="toggleable_tray" id="delete_menu" style="{$JS_ON,display: none,}" aria-expanded="false">
			<p>{!ABOUT_DELETE_MENU}</p>

			<form title="{!DELETE}" action="{DELETE_URL*}" method="post">
				<p class="proceed_button">
					<input type="hidden" name="confirm" value="1" />

					<input class="button_pageitem" type="submit" value="{!DELETE}" onclick="var form=this.form; window.fauxmodal_confirm('{!CONFIRM_DELETE;,{MENU_NAME*}}',function(answer) { if (answer) form.submit(); }); return false;" />
				</p>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">// <![CDATA[
	var all_menus=[];
	{+START,LOOP,ALL_MENUS}
		all_menus.push('{_loop_var;/}');
	{+END}

	var cf=function() { var e=document.getElementById('menu_editor_wrap'); if (e.className.indexOf(' docked')==-1) smooth_scroll(find_pos_y(document.getElementById('caption_'+window.current_selection))); };
	document.getElementById('url').ondblclick=cf;
	document.getElementById('caption_long').ondblclick=cf;
	document.getElementById('match_tags').ondblclick=cf;
//]]></script>
