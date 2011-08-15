<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="solidborder wide_table ocf_topic_list">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
				<col style="width: 43px" />
			{+END}
			<col style="width: 100%" />
			<col style="width: 100px" />
			<col style="width: 50px" />
			<col style="width: 50px" />
			<col style="width: 185px" />
			{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
				<col style="width: 25px" />
			{+END}
		</colgroup>
	{+END}

	<thead>
		<tr>
			<td colspan="{$?,{$CONFIG_OPTION,is_on_topic_emoticons},7,6}" class="tabletitle_internal">{FORUM_NAME*}</td>
		</tr>
		<tr>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
					<th> </th>
				{+END}
			{+END}
			<th>{!TITLE}</th>
			<th>{!STARTER}{STARTER_TITLE*}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				<th>{!COUNT_POSTS}</th>
				<th>{!COUNT_VIEWS}</th>
			{+END}
			<th>{!LAST_POST}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
					<th>
						<a href="#" onclick="event.returnValue=false; markAllTopics(); return false;"><img src="{$IMG*,ocf_topic_modifiers/unvalidated}" alt="{!TOGGLE_SELECTION}" title="{!TOGGLE_SELECTION}" /></a>
					</th>
				{+END}
			{+END}
		</tr>
	</thead>

	<tbody>
		{TOPICS}
	</tbody>
</table></div>

{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
	<div class="float_surrounder results_browser_spacing">
		{RESULTS_BROWSER}
	</div>
{+END}

{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
	{+START,IF,{$NOT,{$MOBILE}}}
		<div class="medborder medborder_box ocf_topic_actions">
			<span class="control_functions">
				<label for="fma_type">{!TOPIC_ACTIONS}: </label>
			</span>
			<form title="{!TOPIC_ACTIONS}" action="{$URL_FOR_GET_FORM*,{ACTION_URL}}" method="get" class="inline">
				{$HIDDENS_FOR_GET_FORM,{ACTION_URL}}

				<div class="inline">
					<select class="inline" name="type" id="fma_type">
						<option value="-1">-</option>
						{MODERATOR_ACTIONS}
					</select>
					<input onclick="if (addFormMarkedPosts(this.form,'mark_')) { disable_button_just_clicked(this); return true; } window.alert('{!NOTHING_SELECTED*;}'); return false;" class="button_micro" type="submit" value="{!PROCEED}" />
				</div>
			</form>

			{+START,IF,{MAY_CHANGE_MAX}}
				<form title="{!PER_PAGE}" class="inline" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get">
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
				<form title="{!ORDER}" class="inline" action="{$URL_FOR_GET_FORM*,{$SELF_URL}}" method="get">
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
		</div>
	{+END}
{+END}
{+START,IF_NON_EMPTY,{BUTTONS}}
	<div class="float_surrounder non_accessibility_redundancy">
		{BUTTONS}
		<div class="breadcrumbs_always">
			<img class="breadcrumbs_img" src="{$IMG*,treenav}" alt="&gt; " title="{!YOU_ARE_HERE}" />
			{TREE}
		</div>
	</div>
{+END}


