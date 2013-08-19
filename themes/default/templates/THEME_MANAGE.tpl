		{+START,IF,{$GET,done_one_theme}}
			<tr>
				<td colspan="6" class="theme_manage_table_spacer">&nbsp;</td>
			</tr>
		{+END}

		<tr>
			<td>
				<strong>{TITLE*}</strong>
				<div class="associated_caption">{!CODENAME}: <em>{NAME*}</em></div>
				{+START,IF_PASSED,SEED}
					<div class="associated_caption">{!SEED_COLOUR}: <strong style="background: white; color: #{SEED*}">{SEED*}</strong></div>
				{+END}
			</td>
			<td>
				{DATE*}
				<div class="associated_caption">{!BY_SIMPLE,<em>{AUTHOR`}</em>}</div>
			</td>
			<td class="do_theme_item" rowspan="2" onclick="click_link(this.getElementsByTagName('a')[0]);" onkeypress="if (enter_pressed(event)) return this.onclick.call(this,event);" onmouseout="this.className='do_theme_item';" onmouseover="this.className='do_theme_item_hover';">
				<div><a rel="edit" title="{!EDIT_THEME}: {NAME*}" href="{EDIT_URL*}"><img alt="{!EDIT_THEME}" title="" src="{$IMG*,bigicons/edit_this}" /></a></div>
				<div><a title="{!EDIT_THEME}: {NAME*}" href="{EDIT_URL*}">{!EDIT_THEME}</a></div>
			</td>
			<td class="do_theme_item" rowspan="2" onclick="click_link(this.getElementsByTagName('a')[0]);" onkeypress="if (enter_pressed(event)) return this.onclick.call(this,event);" onmouseout="this.className='do_theme_item';" onmouseover="this.className='do_theme_item_hover';">
				<div><a rel="edit" title="{!EDIT_CSS}: {NAME*}" href="{CSS_URL*}" onclick="cancelBubbling(event); if ('{NAME*;}'=='default') { var t=this; window.fauxmodal_confirm('{!EDIT_DEFAULT_THEME_WARNING;}',function(result) { if (result) { click_link(t); } }); return false; } return true;"><img alt="{!EDIT_CSS}" title="" src="{$IMG*,bigicons/edit_css}" /></a></div>
				<div><a title="{!EDIT_CSS}: {NAME*}" href="{CSS_URL*}" onclick="cancelBubbling(event); if ('{NAME*;}'=='default') { var t=this; window.fauxmodal_confirm('{!EDIT_DEFAULT_THEME_WARNING;}',function(result) { if (result) { click_link(t); } }); return false; } return true;">{!EDIT_CSS}</a></div>
			</td>
			<td class="do_theme_item" rowspan="2" onclick="click_link(this.getElementsByTagName('a')[0]);" onkeypress="if (enter_pressed(event)) return this.onclick.call(this,event);" onmouseout="this.className='do_theme_item';" onmouseover="this.className='do_theme_item_hover';">
				<div><a rel="edit" title="{!EDIT_TEMPLATES}: {NAME*}" href="{TEMPLATES_URL*}" onclick="cancelBubbling(event); if ('{NAME*;}'=='default') { var t=this; window.fauxmodal_confirm('{!EDIT_DEFAULT_THEME_WARNING;}',function(result) { if (result) { click_link(t); } }); return false; } return true;"><img alt="{!EDIT_TEMPLATES}" title="" src="{$IMG*,bigicons/edit_templates}" /></a></div>
				<div><a title="{!EDIT_TEMPLATES}: {NAME*}" href="{TEMPLATES_URL*}" onclick="cancelBubbling(event); if ('{NAME*;}'=='default') { var t=this; window.fauxmodal_confirm('{!EDIT_DEFAULT_THEME_WARNING;}',function(result) { if (result) { click_link(t); } }); return false; } return true;">{!EDIT_TEMPLATES}</a></div>
			</td>
			<td class="do_theme_item" rowspan="2" onclick="click_link(this.getElementsByTagName('a')[0]);" onkeypress="if (enter_pressed(event)) return this.onclick.call(this,event);" onmouseout="this.className='do_theme_item';" onmouseover="this.className='do_theme_item_hover';">
				<div><a rel="edit" title="{!MANAGE_THEME_IMAGES}: {NAME*}" href="{IMAGES_URL*}" onclick="cancelBubbling(event); if ('{NAME*;}'=='default') { var t=this; window.fauxmodal_confirm('{!EDIT_DEFAULT_THEME_WARNING;}',function(result) { if (result) { click_link(t); } }); return false; } return true;"><img alt="{!MANAGE_THEME_IMAGES}" title="" src="{$IMG*,bigicons/manage_images}" /></a></div>
				<div><a title="{!MANAGE_THEME_IMAGES}: {NAME*}" href="{IMAGES_URL*}" onclick="cancelBubbling(event); if ('{NAME*;}'=='default') { var t=this; fauxmodal_confirm('{!EDIT_DEFAULT_THEME_WARNING;}',function(result) { if (result) { click_link(t); } }); return false; } return true;">{!MANAGE_THEME_IMAGES}</a></div>
			</td>
		</tr>
		<tr>
			<td class="manage_theme_export" colspan="2">
				{+START,IF,{$NEQ,{NAME},default}}
					<a onclick="var t=this; window.fauxmodal_confirm('{!SWITCH_MODULE_WARNING=;}',function(result) { if (result) { click_link(t); } }); return false;" href="{$PAGE_LINK*,adminzone:admin_addons:_addon_export:exp=theme:theme={NAME}}">{!EXPORT_THEME_AS_ADDON}</a>
					&middot;
				{+END}
				<a id="theme_preview__{NAME*}" target="_blank" title="{!PREVIEW}: {!LINK_NEW_WINDOW}" href="{$PAGE_LINK*,::keep_theme={NAME}}">{!PREVIEW}</a>

				&middot;
				<a href="{SCREEN_PREVIEW_URL*}">{!SCREEN_PREVIEWS}</a>

			</td>
		</tr>
		<tr>
			<td colspan="6" class="manage_theme_theme_usage">
				{+START,IF_NON_EMPTY,{THEME_USAGE}}{THEME_USAGE*}{+END}
				{+START,IF,{$EQ,{NAME},default}}
					{+START,IF_NON_EMPTY,{THEME_USAGE}}<br /><br />{+END}{!DEFAULT_THEME_INHERITANCE}
				{+END}
			</td>
		</tr>

		{$SET,done_one_theme,1}

