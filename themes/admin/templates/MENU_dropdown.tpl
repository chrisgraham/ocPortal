{$REQUIRE_CSS,menu__dropdown}

{+START,IF_NON_EMPTY,{CONTENT}}
	<nav class="menu_type__dropdown" role="navigation">
		<ul onmouseout="return deset_active_menu()" class="nl" id="r_{MENU|*}_d">
			{CONTENT}

			{$SET,RAND,{$RAND}}
			<li class="non_current last toplevel"{+START,IF,{$GET,HAS_CHILDREN}}{+START,IF,{$NOT,{$MOBILE}}} onmousemove="if (!this.timer) this.timer=window.setTimeout(function() { var ret=pop_up_menu('{MENU|;*}_dexpand_{$GET;*,RAND}','below','{MENU|;*}_d',event,true); try { document.getElementById('search_content').focus(); } catch (e) {}; return ret; } , 200);" onmouseout="if (this.timer) { window.clearTimeout(this.timer); this.timer=null; }"{+END}{+END}>
				<a href="{$TUTORIAL_URL*,tutorials}" onkeypress="this.onclick(event);" onclick="cancel_bubbling(event);{+START,IF,{$GET,HAS_CHILDREN}} deset_active_menu();{+END}" class="toplevel_link last"{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin,adminzone}} onfocus="return pop_up_menu('{MENU|;*}_dexpand_{$GET;*,RAND}','below','{MENU|;*}_d',event,true);"{+END}><img alt="" src="{$IMG*,icons/32x32/menu/adminzone/help}" srcset="{$IMG*,icons/64x64/menu/adminzone/help} 2x" /> <span>{!HELP}</span></a>
				{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin,adminzone}}
					<div aria-haspopup="true" onmouseover="if (active_menu==null) return set_active_menu(this.id,'{MENU|;*}_d'); else return false;" onmouseout="return deset_active_menu();" class="nlevel menu_help_section" id="{MENU|*}_dexpand_{$GET;*,RAND}" style="display: none">
						{$,Admin Zone search}
						<div class="adminzone_search">
							<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,adminzone:admin:search}}" method="get" class="inline">
								{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,adminzone:admin:search}}

								<div>
									<label for="search_content" class="accessibility_hidden">{!SEARCH}</label>
									<input size="25" type="search" id="search_content" name="content" class="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},,field_input_non_filled}" onfocus="placeholder_focus(this); require_javascript('javascript_ajax_people_lists'); require_javascript('javascript_ajax');" onblur="placeholder_blur(this);" onkeyup="if (typeof update_ajax_admin_search_list!='undefined') update_ajax_admin_search_list(this,event);" value="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},{$_GET*,content},{!SEARCH}}" title="{!ADMIN_ZONE_SEARCH_SYNTAX}" />
									{+START,IF,{$JS_ON}}
										<div class="accessibility_hidden"><label for="new_window">{!NEW_WINDOW}</label></div>
										<input title="{!NEW_WINDOW}" type="checkbox" value="1" id="new_window" name="new_window" />
									{+END}
									<input onclick="form.action='{$URL_FOR_GET_FORM;*,{$PAGE_LINK,adminzone:admin:search}}'; if ((form.new_window) &amp;&amp; (form.new_window.checked)) form.target='_blank'; else form.target='_top';" class="buttons__search button_screen_item" type="submit" value="{!SEARCH_ADMIN}" />
									{+START,IF,{$JS_ON}}
										<input onclick="form.action='{$BRAND_BASE_URL;*}/index.php?page=search&amp;type=results'; form.target='_blank';" class="buttons__menu__pages__help button_screen_item" type="submit" value="{!SEARCH_TUTORIALS}" />
									{+END}
								</div>
							</form>
						</div>
					</div>
				{+END}
			</li>
		</ul>

		{$REQUIRE_JAVASCRIPT,javascript_menu_popup}
	</nav>
{+END}
