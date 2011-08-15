{TITLE}

<script type="text/javascript">// <![CDATA[
	function handle_bookmark_selection(ob,id)
	{
		var form=document.getElementById('selected_actions').getElementsByTagName('form')[0];
		form.action='{FORM_URL;}';

		var fields=document.getElementsByTagName('input'),i,some_checked=false;
		for (i=0;i<fields.length;i++)
		{
			if ((fields[i].name.substr(0,9)=='bookmark_') && (fields[i].checked))
			{
				some_checked=true;
			}
		}

		document.getElementById('selected_actions_some').style.display=some_checked?'block':'none';
		document.getElementById('selected_actions_none').style.display=some_checked?'none':'block';

		addFormMarkedPosts(form,'bookmark_');
		
		var folder_list=document.getElementById('folder');
		var _fv=document.getElementById('folder_'+id);
		var fv=_fv?_fv.value:'';
		if (fv=='') fv='!';
		for (i=0;i<folder_list.options.length;i++)
		{
			if (folder_list.options[i].value==fv)
			{
				folder_list.selectedIndex=i;
				if ((folder_list.onchange!='undefined') && (folder_list.onchange)) folder_list.onchange();
				if ((folder_list.fakeonchange!='undefined') && (folder_list.fakeonchange)) folder_list.fakeonchange();
				break;
			}
		}
	}
//]]></script>

{+START,IF_EMPTY,{BOOKMARKS}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}
{+START,IF_NON_EMPTY,{BOOKMARKS}}
	{+START,LOOP,BOOKMARKS}
		<h2>{CAPTION*}</h2>

		<form title="{CAPTION*}" onsubmit="if (checkFieldForBlankness(this.elements['caption'],event) &amp;&amp; checkFieldForBlankness(this.elements['page_link'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{$PAGE_LINK*,_SELF:_SELF:type=_edit:id={ID}}" method="post">
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col style="width: 140px" />
						<col style="width: 100%" />
					</colgroup>
				{+END}

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
								<a class="bookmark_preview_link external_link inline_image_2" href="{$PAGE_LINK*,{PAGE_LINK}}" title="{!PREVIEW}: {!LINK_NEW_WINDOW}" target="_blank">{!PREVIEW}</a>
								<input maxlength="255" size="{$?,{$MOBILE},30,31}" type="text" id="page_link_{ID*}" name="page_link" value="{PAGE_LINK*}" />
							</div>
						</td>
					</tr>
					<tr>
						<th>{!ACTIONS}</th>
						<td>
							 <input class="button_pageitem" type="submit" value="{!EDIT}" />
							 <input class="button_pageitem" type="submit" name="delete" value="{!DELETE}" />

							 <label class="button_options_spacer" for="bookmark_{ID*}">{!CHOOSE}:</label> <input onclick="handle_bookmark_selection(this,'{ID*}');" type="checkbox" id="bookmark_{ID*}" name="bookmark_{ID*}" value="1" />
						</td>
					</tr>
				</tbody>
			</table></div>
		</form>
	{+END}

	<div id="selected_actions" class="form_with_gap">
		{+START,BOX,{!MOVE_OR_DELETE_BOOKMARKS}}
			<div id="selected_actions_some" style="display: none">
				{FORM}
			</div>
			<div id="selected_actions_none">
				<p class="nothing_here">{!NOTHING_SELECTED_YET}</p>
			</div>
		{+END}
	</div>
{+END}

