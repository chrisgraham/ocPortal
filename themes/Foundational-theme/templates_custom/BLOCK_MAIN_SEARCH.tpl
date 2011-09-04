{+START,IF,{$NOT,{$GET,in_panel}}}<div class="centered_inline_block"><div class="inline_block">{+END}{+START,BOX,,,{$?,{$GET,in_panel},panel,light},,,}
	<form onsubmit="if (typeof this.elements['contents']=='undefined') { disable_button_just_clicked(this); return true; } if (checkFieldForBlankness(this.elements['contents'],event)) { return true; } return false;" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
		{$HIDDENS_FOR_GET_FORM,{URL}}

		<div>
			{+START,IF,{$EQ,{INPUT_FIELDS},1}}
				<div class="constrain_field">
					<input class="wide_field" onkeyup="update_ajax_search_list(this);" type="text" id="search_content" name="content" value="" />
				</div>
			{+END}
			{+START,IF,{$NEQ,{INPUT_FIELDS},1}}
				{+START,LOOP,INPUT_FIELDS}
					<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="variable_table wide_table search_field_table">
						<tbody>
							<tr>
								<th class="de_th">
									{_loop_var*}
								</th>
								<td>
									<label class="accessibility_hidden" for="search_{_loop_key*}">{_loop_var*}</label>
									<input {+START,IF,{$EQ,{_loop_key},content}}onkeyup="update_ajax_search_list(this);" {+END}type="text" id="search_{_loop_key*}" name="{_loop_key*}" value="" />
								</td>
							</tr>
						</tbody>
					</table></div>
				{+END}
			{+END}

			<div class="proceed_button">
				<input class="button" type="submit" value="Search" onfocus="if (this.value=='Search') this.value='';" />
			</div>

			{+START,LOOP,LIMIT_TO}
				<input type="hidden" name="{_loop_var*}" value="1" />
			{+END}
			{+START,LOOP,EXTRA}
				<input type="hidden" name="{_loop_key*}" value="{_loop_var*}" />
			{+END}
			<input type="hidden" name="author" value="{AUTHOR*}" />
			<input type="hidden" name="days" value="{DAYS*}" />
			<input type="hidden" name="sort" value="{SORT*}" />
			<input type="hidden" name="direction" value="{DIRECTION*}" />
			<input type="hidden" name="only_titles" value="{ONLY_TITLES*}" />
			<input type="hidden" name="only_search_meta" value="{ONLY_SEARCH_META*}" />
			<input type="hidden" name="boolean_search" value="{BOOLEAN_SEARCH*}" />
			<input type="hidden" name="conjunctive_operator" value="{CONJUNCTIVE_OPERATOR*}" />
		</div>
       
	</form>
	
	<p class="associated_details">
		<a href="{$PAGE_LINK*,site:search}">Advanced search</a>
	</p>
{+END}{+START,IF,{$NOT,{$GET,in_panel}}}</div></div>{+END}
