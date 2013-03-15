{TITLE}

{$REQUIRE_JAVASCRIPT,javascript_bookmarks}

{+START,IF_EMPTY,{BOOKMARKS}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}
{+START,IF_NON_EMPTY,{BOOKMARKS}}
	{+START,LOOP,BOOKMARKS}
		<h2>{CAPTION*}</h2>

		<form title="{CAPTION*}" onsubmit="if (check_field_for_blankness(this.elements['caption'],event) &amp;&amp; check_field_for_blankness(this.elements['page_link'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{$PAGE_LINK*,_SELF:_SELF:type=_edit:id={ID}}" method="post">
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table results_table autosized_table">
				<tbody>
					<tr>
						<th>{!CAPTION}</th>
						<td>
							<div class="constrain_field">
								<div class="accessibility_hidden"><label for="caption_{ID*}">{!CAPTION}</label></div>
								<input maxlength="255" size="{$?,{$MOBILE},30,50}" class="wide_field" type="text" id="caption_{ID*}" name="caption" value="{CAPTION*}" />
							</div>
						</td>
					</tr>
					<tr>
						<th>{!BOOKMARK_FOLDER}</th>
						<td>
							<div class="constrain_field">
								<div class="accessibility_hidden"><label for="folder_{ID*}">{!BOOKMARK_FOLDER}</label></div>
								<input maxlength="80" size="{$?,{$MOBILE},30,50}" disabled="disabled" type="text" id="folder_{ID*}" name="folder" value="{FOLDER*}" />
							</div>
						</td>
					</tr>
					<tr>
						<th>{!PAGE_LINK}</th>
						<td>
							<div class="constrain_field">
								<div class="accessibility_hidden"><label for="page_link_{ID*}">{!PAGE_LINK}</label></div>
								<a class="bookmark_preview_link external_link vertical_alignment" href="{$PAGE_LINK*,{PAGE_LINK}}" title="{!PREVIEW}: {!LINK_NEW_WINDOW}" target="_blank">{!PREVIEW}</a>
								<input maxlength="255" size="{$?,{$MOBILE},30,31}" type="text" id="page_link_{ID*}" name="page_link" value="{PAGE_LINK*}" />
							</div>
						</td>
					</tr>
					<tr>
						<th>{!ACTIONS}</th>
						<td class="vertical_alignment">
							 <input class="button_pageitem" type="submit" value="{!EDIT}" />
							 <input class="button_pageitem" type="submit" name="delete" value="{!DELETE}" />

							 <label class="horiz_field_sep vertical_alignment" for="bookmark_{ID*}">{!CHOOSE}:</label> <input onclick="handle_bookmark_selection(this,'{ID*}',event,'{POST_URL;}');" type="checkbox" id="bookmark_{ID*}" name="bookmark_{ID*}" value="1" />
						</td>
					</tr>
				</tbody>
			</table></div>
		</form>
	{+END}

	<div id="selected_actions" class="form_with_gap">
		<div class="box box___bookmarks_screen"><div class="box_inner">
			<h2>{!MOVE_OR_DELETE_BOOKMARKS}</h2>

			<div id="selected_actions_some" style="display: none">
				{FORM}
			</div>
			<div id="selected_actions_none">
				<p class="nothing_here">{!NOTHING_SELECTED_YET}</p>
			</div>
		</div></div>
	</div>
{+END}

