{$,Tab buttons}
<div class="float_surrounder">
	<div class="ze_tabs tabs" role="tablist">
		{+START,IF_PASSED,PREVIEW}
			<a aria-controls="view_{ID*}" role="tab" title="{!PREVIEW}: {ID*}" href="#" id="view_tab_{ID*}" class="tab tab_first tab_selected" onkeypress="if (enter_pressed(event)) this.onclick(event);" onclick="select_ze_tab('{ID*;}','view'); reload_preview('{ID*;}'); return false;">{!PREVIEW}</a>
		{+END}
		{+START,IF_PASSED,COMCODE}
			<a aria-controls="edit_{ID*}" role="tab" title="{!EDIT}: {ID*}" href="#" id="edit_tab_{ID*}" class="tab{+START,IF_NON_PASSED,PREVIEW} tab_first{+END}" onkeypress="if (enter_pressed(event)) this.onclick(event);" onclick="select_ze_tab('{ID*;}','edit'); return false;">{!EDIT}</a>
		{+END}
		<a aria-controls="info_{ID*}" role="tab" title="{!DETAILS}: {ID*}" href="#" id="info_tab_{ID*}" class="tab{+START,IF_NON_PASSED,SETTINGS} tab_last{+END}{+START,IF_NON_PASSED,PREVIEW}{+START,IF_NON_PASSED,COMCODE} tab_first{+END}{+END}" onkeypress="if (enter_pressed(event)) this.onclick(event);" onclick="select_ze_tab('{ID*;}','info'); return false;">{!DETAILS}</a>
		{+START,IF_PASSED,SETTINGS}
			<a aria-controls="settings_{ID*}" role="tab" title="{!SETTINGS}: {ID*}" href="#" id="settings_tab_{ID*}" class="tab tab_last" onkeypress="if (enter_pressed(event)) this.onclick(event);" onclick="select_ze_tab('{ID*;}','settings'); return false;">{!SETTINGS}</a>
		{+END}
	</div>
</div>

{$,Actual tab' contents follows}

{+START,IF_PASSED,PREVIEW}
	<div id="view_{ID*}" style="display: block" aria-labeledby="view_tab_{ID*}" role="tabpanel">
		{+START,IF_EMPTY,{PREVIEW}}
			<p class="nothing_here">{!NONE}</p>
		{+END}
		{+START,IF_NON_EMPTY,{PREVIEW}}
			{$PARAGRAPH,{PREVIEW}}
		{+END}

		<script type="text/javascript">// <![CDATA[
			disable_preview_scripts(document.getElementById('view_{ID*}'));
		//]]></script>
	</div>
{+END}

{+START,IF_PASSED,COMCODE}
	<div id="edit_{ID*}" style="{+START,IF_NON_PASSED,PREVIEW}display: block{+END}{+START,IF_PASSED,PREVIEW}display: none{+END}" aria-labeledby="edit_tab_{ID*}" role="tabpanel">
		<form title="{ID*}: {!COMCODE}" action="index.php" method="post">
			<p>
				<label for="edit_{ID*}_textarea">{!COMCODE}:</label> <a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{$PAGE_LINK*,_SEARCH:userguide_comcode}"><img class="comcode_supported_icon" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a>
				{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
					{+START,IF,{$JS_ON}}
						<span class="horiz_field_sep associated_link"><a id="toggle_wysiwyg_edit_{ID*}_textarea" href="#" onclick="return toggle_wysiwyg('edit_{ID*}_textarea');"><abbr title="{!TOGGLE_WYSIWYG_2}">{!ENABLE_WYSIWYG}</abbr></a></span>
					{+END}
				{+END}
			</p>
			{+START,IF_NON_EMPTY,{COMCODE_EDITOR}}
				<div>
					<div class="post_special_options">
						<div class="float_surrounder" role="toolbar">
							{COMCODE_EDITOR}
						</div>
					</div>
				</div>
			{+END}
			<div class="constrain_field">
				<textarea onchange="set_edited_panel(null,'{ID*;}');" rows="50" cols="20" class="{$?,{IS_PANEL},ze_textarea,ze_textarea_middle} textarea_scroll{CLASS*}" id="edit_{ID*}_textarea" name="{ID*}">{COMCODE*}</textarea>

				{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
					<script type="text/javascript">// <![CDATA[
						if ((window.wysiwyg_on) && (wysiwyg_on())) document.getElementById('edit_{ID*;}_textarea').readOnly=true;
					//]]></script>
				{+END}
				{+START,IF_PASSED,DEFAULT_PARSED}
					<textarea cols="1" rows="1" style="display: none" readonly="readonly" name="edit_{ID*;}_textarea_parsed">{DEFAULT_PARSED*}</textarea>
				{+END}
			</div>
		</form>
	</div>
{+END}

<div id="info_{ID*}" style="{+START,IF_NON_PASSED,PREVIEW}display: block{+END}{+START,IF_PASSED,PREVIEW}display: none{+END}" aria-labeledby="info_tab_{ID*}" role="tabpanel">
	<p class="lonely_label">
		<span class="field_name">{!PAGE_TYPE}:</span>
	</p>
	<p>{TYPE*}</p>

	<p class="lonely_label">
		<span class="field_name">{!NAME}:</span>
	</p>
	<p><kbd>{ID*}</kbd></p>

	{+START,IF_NON_EMPTY,{EDIT_URL}}
		<p class="lonely_label">
			<span class="field_name">{!ACTIONS}:</span>
		</p>
		<ul class="actions_list">
			<li><a title="{!EDIT_IN_FULL_PAGE_EDITOR}: {ID*} {!LINK_NEW_WINDOW}" target="_blank" href="{EDIT_URL*}">{!EDIT_IN_FULL_PAGE_EDITOR}</a></li>
		</ul>
	{+END}

	{+START,IF_PASSED,ZONES}
		{+START,IF,{$ADDON_INSTALLED,redirects_editor}}
			<form title="{ID*}: {!DRAWS_FROM}" action="index.php" method="post">
				<p class="lonely_label">
					<label for="redirect_{ID*}" class="field_name">{!DRAWS_FROM}:</label>
				</p>
				{+START,IF_NON_EMPTY,{ZONES}}
					<select onchange="set_edited_panel(null,'{ID*;}'); var editor=document.getElementById('edit_tab_{ID*;}'); if (editor) editor.style.display=(this.options[this.selectedIndex].value=='{CURRENT_ZONE*;}')?'block':'none';" id="redirect_{ID*}" name="redirect_{ID*}">
						<option value="{ZONE*}">{!NA}</option>
						{ZONES}
					</select>
				{+END}
				{+START,IF_EMPTY,{ZONES}}
					<input maxlength="80" onchange="set_edited_panel(null,'{ID*;}'); var editor=document.getElementById('edit_tab_{ID*;}'); if (editor) editor.style.display=(this.value=='{CURRENT_ZONE*;}')?'block':'none';" size="20" id="redirect_{ID*}" name="redirect_{ID*}" value="{CURRENT_ZONE*}" type="text" />
				{+END}
			</form>
		{+END}
	{+END}
</div>

{+START,IF_PASSED,SETTINGS}
	<div id="settings_{ID*}" style="display: none" aria-labeledby="settings_tab_{ID*}" role="tabpanel">
		<form title="{ID*}: {!SETTINGS}" id="middle_fields" action="index.php">
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col class="field_name_column" />
						<col class="field_input_column" />
					</colgroup>
				{+END}

				<tbody>
					{SETTINGS}
				</tbody>
			</table></div>
		</form>
	</div>
{+END}

