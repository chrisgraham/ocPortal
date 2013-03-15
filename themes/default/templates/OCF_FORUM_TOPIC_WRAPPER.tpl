<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table ocf_topic_list">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
				<col class="ocf_forum_topic_wrapper_column_column1" />
			{+END}
			<col class="ocf_forum_topic_wrapper_column_column2" />
			<col class="ocf_forum_topic_wrapper_column_column3" />
			<col class="ocf_forum_topic_wrapper_column_column4" />
			<col class="ocf_forum_topic_wrapper_column_column5" />
			<col class="ocf_forum_topic_wrapper_column_column6{$?,{$MATCH_KEY_MATCH,_WILD:members},_shorter}" />
			{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
				<col class="ocf_forum_topic_wrapper_column_column7" />
			{+END}
		</colgroup>
	{+END}

	<thead>
		<tr>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
					<th class="ocf_forum_box_left"></th>
				{+END}
			{+END}
			<th>{!TITLE}</th>
			<th>{!STARTER}{STARTER_TITLE*}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				<th>{!COUNT_POSTS}</th>
				<th>{!COUNT_VIEWS}</th>
			{+END}
			<th{+START,IF_EMPTY,{MODERATOR_ACTIONS}} class="ocf_forum_box_right"{+END}>{!LAST_POST}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
					<th class="ocf_forum_box_right">
						<a href="#" onclick="event.returnValue=false; mark_all_topics(event); return false;"><img src="{$IMG*,ocf_topic_modifiers/unvalidated}" alt="{!TOGGLE_SELECTION}" title="{!TOGGLE_SELECTION}" /></a>
					</th>
				{+END}
			{+END}
		</tr>
	</thead>

	<tbody>
		{TOPICS}

		<tr>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
					<td class="ocf_column1 ocf_forum_box_bleft"></td>
				{+END}
			{+END}
			<td class="ocf_column1{+START,IF,{$MOBILE}} ocf_forum_box_bleft{+END}"></td>
			<td class="ocf_column1"></td>
			{+START,IF,{$NOT,{$MOBILE}}}
				<td class="ocf_column1"></td>
				<td class="ocf_column1"></td>
			{+END}
			<td class="ocf_column1{+START,IF,{$OR,{$MOBILE},{$IS_EMPTY,{MODERATOR_ACTIONS}}}} ocf_forum_box_bright{+END}"></td>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
					<td class="ocf_column1 ocf_forum_box_bright"></td>
				{+END}
			{+END}
		</tr>
	</tbody>
</table></div>

{+START,IF_NON_EMPTY,{PAGINATION}}
	<div class="float_surrounder pagination_spacing">
		{PAGINATION}
	</div>
{+END}

{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
	{+START,IF,{$NOT,{$MOBILE}}}
		<div class="box ocf_topic_actions"><div class="box_inner">
			<span class="field_name">
				<label for="fma_type">{!TOPIC_ACTIONS}: </label>
			</span>
			<form title="{!TOPIC_ACTIONS}" action="{$URL_FOR_GET_FORM*,{ACTION_URL}}" method="get" class="inline">
				{$HIDDENS_FOR_GET_FORM,{ACTION_URL}}

				<div class="inline">
					<select class="dropdown_actions" name="type" id="fma_type">
						<option value="misc">-</option>
						{MODERATOR_ACTIONS}
					</select>
					<input onclick="if (add_form_marked_posts(this.form,'mark_')) { disable_button_just_clicked(this); return true; } window.fauxmodal_alert('{!NOTHING_SELECTED=;}'); return false;" class="button_micro" type="submit" value="{!PROCEED}" />
				</div>
			</form>

			{+START,IF,{MAY_CHANGE_MAX}}
				<form title="{!PER_PAGE}" class="inline" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}{+START,IF,{$EQ,{TYPE},pt}}#tab__pts{+END}" method="get">
					{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},max}

					<div class="inline">
						<label for="max">{!PER_PAGE}:
						<select{+START,IF,{$JS_ON}} onchange="this.form.submit();"{+END} name="max" id="max">
							<option value="10"{$?,{$EQ,{MAX},10}, selected="selected",}>10</option>
							<option value="20"{$?,{$EQ,{MAX},20}, selected="selected",}>20</option>
							<option value="30"{$?,{$EQ,{MAX},30}, selected="selected",}>30</option>
							<option value="50"{$?,{$EQ,{MAX},50}, selected="selected",}>50</option>
							<option value="100"{$?,{$EQ,{MAX},100}, selected="selected",}>100</option>
							<option value="300"{$?,{$EQ,{MAX},300}, selected="selected",}>300</option>
						</select>
						</label>
						{+START,IF,{$NOT,{$JS_ON}}}
							<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!CHANGE}" />
						{+END}
					</div>
				</form>
			{+END}

			{+START,IF_NON_EMPTY,{ORDER}}
				<form title="{!ORDER}" class="inline" action="{$URL_FOR_GET_FORM*,{$SELF_URL}}{+START,IF,{$EQ,{TYPE},pt}}#tab__pts{+END}" method="get">
					{$HIDDENS_FOR_GET_FORM,{$SELF_URL},order}

					<div class="inline">
						<label for="order">{!ORDER}:
						<select{+START,IF,{$JS_ON}} onchange="this.form.submit();"{+END} name="order" id="order">
							<option value="last_post"{$?,{$EQ,{ORDER},last_post}, selected="selected",}>{!FORUM_ORDER_BY_LAST_POST}</option>
							<option value="first_post"{$?,{$EQ,{ORDER},first_post}, selected="selected",}>{!FORUM_ORDER_BY_FIRST_POST}</option>
							<option value="title"{$?,{$EQ,{ORDER},title}, selected="selected",}>{!FORUM_ORDER_BY_TITLE}</option>
						</select>
						</label>
						{+START,IF,{$NOT,{$JS_ON}}}
							<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SORT}" />
						{+END}
					</div>
				</form>
			{+END}
		</div></div>
	{+END}
{+END}
