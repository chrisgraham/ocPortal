{+START,IF,{$NOT,{$_GET,in_main_include_module}}}
	{TITLE}

	{+START,IF_PASSED,RESULTS}
		<h2>{!SEARCH_RESULTS_ARE,{NUM_RESULTS*},{SEARCH_TERM*}}</h2>

		{+START,IF_EMPTY,{RESULTS}}
			<p class="nothing_here red_alert">{!NO_RESULTS_SEARCH}</p>
		{+END}
		{+START,IF_NON_EMPTY,{RESULTS}}
			<div class="float_surrounder">
				{RESULTS}
			</div>

			{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
				<div class="float_surrounder results_browser_spacing">
					{RESULTS_BROWSER}
				</div>
			{+END}
		{+END}
	{+END}

	{+START,IF_PASSED,RESULTS}
	<h2>
		{!SETTINGS}
		{+START,IF_NON_EMPTY,{RESULTS}}
		<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('search_form','block'); return false;"><img id="e_search_form" src="{$IMG*,expand}" alt="{!SHOW_SEARCH_FORM}" title="{!SHOW_SEARCH_FORM}" /></a>
		{+END}
	</h2>
	{+END}
	<div{+START,IF_PASSED,RESULTS}{+START,IF_NON_EMPTY,{RESULTS}} style="display: {$JS_ON,none,block}"{+END}{+END} id="search_form">
		<p>
			{!SEARCH_HELP}
		</p>

		{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
		{+START,IF,{$AND,{$SHOW_DOCS},{$HAS_SPECIFIC_PERMISSION,see_software_docs}}}
			{+START,INCLUDE,STAFF_ACTIONS}
				STAFF_ACTIONS_TITLE={!STAFF_ACTIONS}
				1_URL={$BRAND_BASE_URL*}/docs{$VERSION*}/pg/tut_search
				1_TITLE={!HELP}
				1_REL=help
			{+END}
		{+END}

		<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get" class="main_search_form">
			{$HIDDENS_FOR_GET_FORM,{URL}}

			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col width="150px" />
						<col width="100%" />
						<col width="100" />
					</colgroup>
				{+END}

				<tbody>
					<tr>
						<th class="dottedborder_barrier">{!SEARCH_FOR}</th>
						<td class="dottedborder_barrier" colspan="2">
							<div class="accessibility_hidden"><label for="search_content">{!SEARCH_FOR}</label></div>
							<div class="constrain_field">
								<input onkeyup="update_ajax_search_list(this,event);" class="wide_field" type="text" size="48" id="search_content" name="content" value="{+START,IF_PASSED,CONTENT}{CONTENT*}{+END}" />
							</div>
							{$SHIFT_DECODE,search_options_message}
						</td>
					</tr>
					<tr>
						<th class="dottedborder_barrier">{!OPTIONS}</th>
						<td class="dottedborder_barrier" colspan="2">
							{+START,IF,{$NOT,{$VALUE_OPTION,disable_boolean_search}}}
								{+START,IF,{$NOT,{OLD_MYSQL}}}
								<label for="boolean_search"><input type="checkbox" id="boolean_search" {+START,IF,{BOOLEAN_SEARCH}}checked="checked" {+END}name="boolean_search" value="1" onclick="document.getElementById('boolean_options').style.display=this.checked?'block':'none'; trigger_resize();" /> {!BOOLEAN_SEARCH}</label>
								<div style="display: {$JS_ON,none,block}" id="boolean_options">
								{+END}
									{+START,IF,{OLD_MYSQL}}
										<p><label for="conjunctive_operator_and"><input type="radio" {+START,IF,{AND}}checked="checked" {+END}id="conjunctive_operator_and" name="conjunctive_operator" value="AND" />{!SEARCH_AND}</label><br />
										<label for="conjunctive_operator_or"><input type="radio" {+START,IF,{$NOT,{AND}}}checked="checked" {+END}id="conjunctive_operator_or" name="conjunctive_operator" value="OR" />{!SEARCH_OR}</label></p>
									{+END}
									<p>{!BOOLEAN_HELP}</p>
								{+START,IF,{$NOT,{OLD_MYSQL}}}
								</div>
								{+END}
							{+END}
							<p><label for="only_titles"><input type="checkbox" {+START,IF,{ONLY_TITLES}}checked="checked" {+END}id="only_titles" name="only_titles" value="1" /> {!ONLY_TITLES}</label></p>
						</td>
					</tr>
					<tr>
						<th class="dottedborder_barrier">{USER_LABEL*}</th>
						<td class="dottedborder_barrier" colspan="2">
							<div class="accessibility_hidden"><label for="search_author">{USER_LABEL*}</label></div>
							<div class="constrain_field">
								<span class="invisible_ref_point">&nbsp;</span><input class="wide_field" onkeyup="update_ajax_author_list(this,event);" type="text" value="{AUTHOR*}" id="search_author" name="author" />
							</div>
						</td>
					</tr>
					<tr>
						<th class="dottedborder_barrier">{DAYS_LABEL*}</th>
						<td class="dottedborder_barrier" colspan="2">
							<div class="accessibility_hidden"><label for="search_days">{DAYS_LABEL*}</label></div>
							<select id="search_days" name="days">
								<option selected="selected" value="-1">{!NA}</option>
								<option {+START,IF,{$EQ,{DAYS},2}}selected="selected" {+END}value="2">{!SUBMIT_AGE_DAYS,2}</option>
								<option {+START,IF,{$EQ,{DAYS},5}}selected="selected" {+END}value="5">{!SUBMIT_AGE_DAYS,5}</option>
								<option {+START,IF,{$EQ,{DAYS},15}}selected="selected" {+END}value="15">{!SUBMIT_AGE_DAYS,15}</option>
								<option {+START,IF,{$EQ,{DAYS},30}}selected="selected" {+END}value="30">{!SUBMIT_AGE_DAYS,30}</option>
								<option {+START,IF,{$EQ,{DAYS},45}}selected="selected" {+END}value="45">{!SUBMIT_AGE_DAYS,45}</option>
								<option {+START,IF,{$EQ,{DAYS},60}}selected="selected" {+END}value="60">{!SUBMIT_AGE_DAYS,60}</option>
								<option {+START,IF,{$EQ,{DAYS},120}}selected="selected" {+END}value="120">{!SUBMIT_AGE_DAYS,120}</option>
								<option {+START,IF,{$EQ,{DAYS},240}}selected="selected" {+END}value="240">{!SUBMIT_AGE_DAYS,240}</option>
								<option {+START,IF,{$EQ,{DAYS},365}}selected="selected" {+END}value="365">{!SUBMIT_AGE_DAYS,365}</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="dottedborder_barrier">{!SORT_BY}</th>
						<td class="dottedborder_barrier" colspan="2">
							<div class="accessibility_hidden"><label for="search_direction">{!DIRECTION}</label></div>
							<div class="accessibility_hidden"><label for="search_sort">{!SORT_BY}</label></div>
							<select id="search_sort" name="sort">
								<option {+START,IF,{$EQ,{SORT},relevance}}selected="selected" {+END}value="relevance">{!RELEVANCE}</option>
								<option {+START,IF,{$EQ,{SORT},add_date}}selected="selected" {+END}value="add_date">{!DATE}</option>
								<option {+START,IF,{$EQ,{SORT},title}}selected="selected" {+END}value="title">{!TITLE}</option>
								{+START,IF,{CAN_ORDER_BY_RATING}}
									<option {+START,IF,{$EQ,{SORT},rating}}selected="selected" {+END}value="rating">{!RATING}</option>
								{+END}
								{+START,LOOP,EXTRA_SORT_FIELDS}
									<option {+START,IF,{$EQ,{SORT},{_loop_key*}}}selected="selected" {+END}value="{_loop_key*}">{_loop_var*}</option>
								{+END}
							</select>
							<select id="search_direction" name="direction">
								<option {+START,IF,{$EQ,{DIRECTION},ASC}}selected="selected" {+END}value="ASC">{!ASCENDING}</option>
								<option {+START,IF,{$EQ,{DIRECTION},DESC}}selected="selected" {+END}value="DESC">{!DESCENDING}</option>
							</select>
						</td>
					</tr>
					{SPECIALISATION}
				</tbody>
			</table></div>

			<br />
			<div class="proceed_button">
				<input onclick="disable_button_just_clicked(this);" accesskey="u" class="button_page" type="submit" value="{!SEARCH_TITLE}" />
			</div>
		</form>
	</div>
{+END}

{+START,IF,{$_GET,in_main_include_module}}
	{$SET,URL,{$REPLACE,results,misc,{URL}}}
	{+START,BOX,,,med}
		<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$GET,URL}}" method="get" class="main_search_form">
			{$HIDDENS_FOR_GET_FORM,{$GET,URL}}

			<div class="search_fields float_surrounder">
				<div class="search_button">
					<input onclick="disable_button_just_clicked(this);" accesskey="u" class="button_pageitem" type="submit" value="Filter Results" />
				</div>

				{$,<div class="search_option">
					<label for="search_content">{!SEARCH_FOR}</label>
					<input onkeyup="update_ajax_search_list(this,event);" class="wide_field" type="text" size="48" id="search_content" name="content" value="{+START,IF_PASSED,CONTENT}{CONTENT*}{+END}" />
				</div>}
				<input type="hidden" name="content" value="" />

				<div class="search_option">
					<label for="search_author">{USER_LABEL*}</label>
					<span class="invisible_ref_point">&nbsp;</span><input class="wide_field" onkeyup="update_ajax_author_list(this,event);" type="text" value="{AUTHOR*}" id="search_author" name="author" />
				</div>

				{$,<div class="search_option">
					<label for="search_days">{DAYS_LABEL*}</label>
					<select id="search_days" name="days">
						<option selected="selected" value="-1">{!NA}</option>
						<option {+START,IF,{$EQ,{DAYS},2}}selected="selected" {+END}value="2">{!SUBMIT_AGE_DAYS,2}</option>
						<option {+START,IF,{$EQ,{DAYS},5}}selected="selected" {+END}value="5">{!SUBMIT_AGE_DAYS,5}</option>
						<option {+START,IF,{$EQ,{DAYS},15}}selected="selected" {+END}value="15">{!SUBMIT_AGE_DAYS,15}</option>
						<option {+START,IF,{$EQ,{DAYS},30}}selected="selected" {+END}value="30">{!SUBMIT_AGE_DAYS,30}</option>
						<option {+START,IF,{$EQ,{DAYS},45}}selected="selected" {+END}value="45">{!SUBMIT_AGE_DAYS,45}</option>
						<option {+START,IF,{$EQ,{DAYS},60}}selected="selected" {+END}value="60">{!SUBMIT_AGE_DAYS,60}</option>
						<option {+START,IF,{$EQ,{DAYS},120}}selected="selected" {+END}value="120">{!SUBMIT_AGE_DAYS,120}</option>
						<option {+START,IF,{$EQ,{DAYS},240}}selected="selected" {+END}value="240">{!SUBMIT_AGE_DAYS,240}</option>
						<option {+START,IF,{$EQ,{DAYS},365}}selected="selected" {+END}value="365">{!SUBMIT_AGE_DAYS,365}</option>
					</select>
				</div>}
				<input type="hidden" name="days" value="-1" />

				{$,<div class="search_option">
					<label for="search_sort">{!SORT_BY}</label></div>
					<select id="search_sort" name="sort">
						<option {+START,IF,{$EQ,{SORT},relevance}}selected="selected" {+END}value="relevance">{!RELEVANCE}</option>
						<option {+START,IF,{$EQ,{SORT},add_date}}selected="selected" {+END}value="add_date">{!DATE}</option>
						<option {+START,IF,{$EQ,{SORT},title}}selected="selected" {+END}value="title">{!TITLE}</option>
						{+START,IF,{CAN_ORDER_BY_RATING}}
							<option {+START,IF,{$EQ,{SORT},rating}}selected="selected" {+END}value="rating">{!RATING}</option>
						{+END}
						{+START,LOOP,EXTRA_SORT_FIELDS}
							<option {+START,IF,{$EQ,{SORT},{_loop_key*}}}selected="selected" {+END}value="{_loop_key*}">{_loop_var*}</option>
						{+END}
					</select>
				</div>}
				<input type="hidden" name="sort" value="title" />

				{$,<div class="search_option">
					<label for="search_direction">{!DIRECTION}</label></div>
					<select id="search_direction" name="direction">
						<option {+START,IF,{$EQ,{DIRECTION},ASC}}selected="selected" {+END}value="ASC">{!ASCENDING}</option>
						<option {+START,IF,{$EQ,{DIRECTION},DESC}}selected="selected" {+END}value="DESC">{!DESCENDING}</option>
					</select>
				</div>}
				<input type="hidden" name="search_direction" value="ASC" />

				{$,Edit this to change the arrangement (order can not be changed within a row)}
				{$SET,fields_to_show_row_1,Country|State|City|Mission|Kulapati/Kulamata} {$,Everything earlier in the template that is uncommented will also show in this first row}
				{$SET,fields_to_show_row_2,Age range|Gender|Marital Status|Usergroup|Nickname (Petit Nom)}

				{$SET,row_1,}
				{$SET,row_2,}
				{SPECIALISATION} {$,This will not display anything as the template produces no output -- it does set "row_1" and "row_2" though}
				{$GET,row_1}
			</div>

			<div class="search_fields float_surrounder">
				{+START,IF_PASSED,RESULTS}
					<div class="search_button">
						<input onclick="window.location.href='{$PAGE_LINK;*,site:members}';" class="button_pageitem" type="button" value="Reset Filter" />
					</div>
				{+END}

				{$GET,row_2}
			</div>
		</form>
	{+END}
	
	<br />

	{$SET,done_search,0}
	{+START,IF_PASSED,RESULTS}
		{$SET,done_search,1}

		{+START,IF_EMPTY,{RESULTS}}
			<p class="nothing_here red_alert">{!NO_RESULTS_SEARCH}</p>
		{+END}
		{+START,IF_NON_EMPTY,{RESULTS}}
			<p>The following members match your search&hellip;</p>

			<div class="float_surrounder">
				{RESULTS}
			</div>

			{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
				<div class="float_surrounder results_browser_spacing">
					{$REPLACE,/results,/misc,{$REPLACE,=results,=misc,{RESULTS_BROWSER}}}
				</div>
			{+END}
		{+END}
	{+END}
{+END}
