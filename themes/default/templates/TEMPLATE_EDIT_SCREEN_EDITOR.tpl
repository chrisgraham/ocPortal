<div id="template_editing_{I*}" style="display: {DISPLAY*}">
	{+START,BOX,,,light}
		<h2>{!EDITING,{FILE_SAVE_TARGET*}}</h2>

		<input type="hidden" name="f{I*}file" value="{FILE*}" />
		<input type="hidden" name="{CODENAME*}" value="f{I*}" />

		{+START,IF_NON_EMPTY,{GUID}}
			<div class="right">
				<a onclick="window.fauxmodal_confirm('{$STRIP_TAGS,{!HELP_INSERT_DISTINGUISHING_TEMPCODE;}}',function(result) { if (result) { insertTextbox(document.getElementById('f{I*}_new'),'{'+'+START,IF,{'+'$EQ,{'+'_GUID},{GUID*}}}\n{'+'+END}'); } }); return false;" href="#">{!INSERT_DISTINGUISHING_TEMPCODE}</a>
			</div>
		{+END}
		<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('f{I*;}sdp','block'); return false;"><img id="e_f{I*}sdp" alt="{!EXPAND}: {!SYMBOLS_AND_DIRECTIVES}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
		<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('f{I*;}sdp','block'); return false;">{!SYMBOLS_AND_DIRECTIVES}</a>
		<div class="hide_button_spacing" style="display: {$JS_ON,none,block}" id="f{I*}sdp">
			{PARAMETERS}
			{DIRECTIVES}
			{SYMBOLS}
			{PROGRAMMATIC_SYMBOLS}
			{ABSTRACTION_SYMBOLS}
			{ARITHMETICAL_SYMBOLS}
			{FORMATTING_SYMBOLS}
			{LOGICAL_SYMBOLS}
			<br />
		</div>

		<h3><label for="f{I*}_new">{!TEMPLATE}</label></h3>
		<div class="constrain_field">
			<textarea onkeydown="if (key_pressed(event,9)) { insertTextbox(this,'	'); return false; }" id="f{I*}_new" name="f{I*}_new" cols="70" rows="22" class="wide_field textarea_scroll">{CONTENTS*}</textarea>
		</div>

		<div class="original_template">
			<h3>
				<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}: {!ORIGINAL}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
				<label for="f{I*}_old"><a class="non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode.parentNode); return false;">{!ORIGINAL}</a>:</label>
			</h3>
			<div class="hide_tag" style="display: {$JS_ON,none,block}">
				<div class="constrain_field">
					<textarea id="f{I*}_old" name="f{I*}_old" cols="70" rows="15" readonly="readonly" class="wide_field">{OLD_CONTENTS*}</textarea>
				</div>
			</div>
		</div>

		{+START,IF_NON_EMPTY,{GUIDS}}
			<div>
				<h3>
					<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
					<a class="non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">GUIDs</a>
				</h3>
				<div class="hide_tag" style="display: {$JS_ON,none,block}">
					<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="variable_table revision_box solidborder wide_table">
						<thead>
							<tr>
								<th>{!FILENAME}</th>
								<th>{!LINE}</th>
								<th>GUID</th>
							</tr>
						</thead>
						<tbody>
							{+START,LOOP,GUIDS}
								<tr class="template_edit_guid_{$EQ,{THIS_GUID},{GUID}}">
									<td>
										<kbd>{FILENAME*}</kbd>
									</td>
									<td>
										{+START,IF,{$ADDON_INSTALLED,code_editor}}
											<a target="_blank" title="{LINE*}: {!LINK_NEW_WINDOW}" href="{$BASE_URL*}/code_editor.php?path={FILENAME*}&amp;line={LINE*}">{LINE*}</a>
										{+END}
										{+START,IF,{$NOT,{$ADDON_INSTALLED,code_editor}}}
											{LINE*}
										{+END}
									</td>
									<td>
										<a onclick="insertTextbox(document.getElementById('f{I*;}_new'),'{'+'+START,IF,{'+'$EQ,{'+'_GUID},{THIS_GUID}}}\n{'+'+END}'); return false;" href="#">{THIS_GUID*}</a>
									</td>
								</tr>
							{+END}
						</tbody>
					</table></div>
				</div>
			</div>
		{+END}

		<br />

		{REVISION_HISTORY}

		{+START,IF_NON_EMPTY,{PREVIEW_URL}}
			<div class="right">
				<input onclick="this.form.target='_blank'; this.form.action='{PREVIEW_URL*}';" accesskey="p" class="button_pageitem" type="submit" value="{!PREVIEW}" />
			</div>
		{+END}
	{+END}
</div>


