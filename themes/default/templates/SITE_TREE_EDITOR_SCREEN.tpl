{TITLE}

<div class="float_surrounder">
	<div class="site_tree_right">
		<div class="box box___site_tree_editor_screen"><div class="box_inner">
			<h2>{!SELECTION_DETAILS}</h2>

			<div id="details_target">
				{!NO_ENTRY_POINT_SELECTED}
			</div>
		</div></div>
	</div>

	<div class="site_tree_left">
		<div class="box box___site_tree_editor_screen"><div class="box_inner">
			<h2>{!SITE_TREE}</h2>

			<div class="accessibility_hidden"><label for="tree_list">{!ENTRY}</label></div>
			<form title="{!PRIMARY_PAGE_FORM}" action="index.php" method="post">
				<input onchange="update_details_box(this)" style="display: none" type="text" id="tree_list" name="tree_list" value="{$_GET*,id}" />
				<div id="tree_list__root_tree_list" class="sitemap_editor">
					<!-- List put in here -->
				</div>
			</form>
			<script type="text/javascript">// <![CDATA[
				var site_tree=new tree_list('tree_list','data/site_tree.php?start_links=1&get_perms=0{$KEEP;/}','','',false,null,true);

				var actions_tpl='{!ACTIONS;/}:<ul role="navigation" class="actions_list">[1]<\/ul>';
				var actions_tpl_item='<li><a href="[2]">[1]<\/a><\/li>';

				var info_tpl='<div class="wide_table_wrap"><table class="results_table wide_table autosized_table" summary="{!MAP_TABLE;}"><tbody>[1]<\/tbody><\/table><\/div>';
				var info_tpl_item='<tr><th>[1]<\/th><td>[2]<\/td><\/tr>';

				var edit_zone_url='{$PAGE_LINK*;,_SEARCH:admin_zones:type=_edit:id=!}';
				var add_zone_url='{$PAGE_LINK*;,_SEARCH:admin_zones:type=add}';
				var zone_editor_url='{$PAGE_LINK*;,_SEARCH:admin_zones:type=_editor:id=!}';
				var permission_tree_editor_url='{$PAGE_LINK*;,_SEARCH:admin_permissions:type=misc:id=!}';
				var edit_page_url='{$PAGE_LINK*;,cms:cms_comcode_pages:type=_ed:page_link=!}';
				var export_page_url='{$PAGE_LINK*;,_SELF:_SELF:type=export:page_link=!}';
				var add_page_url='{$PAGE_LINK*;,_SELF:_SELF:type=pagewizard:zone=!}';
				var delete_url='{$PAGE_LINK*;,_SELF:_SELF:type=_delete:zone=[1]:page__[2]=1}';
				var stats_url='{+START,IF,{$ADDON_INSTALLED,stats}}{$PAGE_LINK*;,_SEARCH:admin_stats:type=_page:iscreen=!}{+END}';
				var move_url='{$PAGE_LINK;,_SELF:_SELF:type=_move:zone=[1]:destination_zone=[3]:page__[2]=1}'; // Intentionally not escaped
			//]]></script>
		</div></div>
	</div>
</div>

{+START,IF,{$ADDON_INSTALLED,redirects_editor}}
	<p>
		{!PAGE_DRAG,{$PAGE_LINK*,_SEARCH:admin_redirects}}
	</p>
{+END}
