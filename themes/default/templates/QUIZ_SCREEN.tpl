{TITLE}

{WARNING_DETAILS}

{$REQUIRE_CSS,quizzes}

{+START,IF_NON_EMPTY,{START_TEXT}}
	<div class="box box___quiz_screen"><div class="box_inner">
		<div itemprop="description">
			{START_TEXT}
		</div>
	</div></div>
{+END}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,quiz,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

{+START,IF_NON_EMPTY,{TIMEOUT}}
	<script>// <![CDATA[
		setTimeout(function() { document.getElementById('quiz_form').submit(); }, {TIMEOUT%}*1000);
		setInterval(function() { var st=document.getElementById('quiz_timer'); var new_value=window.parseInt(get_inner_html(st))-1; if (new_value>=0) set_inner_html(st,new_value); }, 1000);
	//]]></script>

	<p class="quiz_timer">
		{!TIME_REMAINING,<strong><span id="quiz_timer">{TIMEOUT*}</span></strong>}
	</p>
{+END}

<form title="{!SAVE}" id="quiz_form" class="quiz_form" method="post" onsubmit="return check_form(this);" action="{URL*}">
	<div>
		<div class="wide_table_wrap"><table class="map_table form_table wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col class="quiz_field_name_column" />
					<col class="quiz_field_input_column" />
				</colgroup>
			{+END}

			<tbody>
				{FIELDS}
			</tbody>
		</table></div>

		<p class="proceed_button">
			<input accesskey="u" class="buttons__save button_screen" type="submit" value="{!SUBMIT}" />
		</p>
	</div>
</form>

<script>// <![CDATA[
	var e=get_elements_by_class_name(document.getElementById('quiz_form'),'field_input');
	for (var i=0;i<e.length;i++)
		set_up_change_monitor(e[i].childNodes[0]);
//]]></script>

{$REVIEW_STATUS,quiz,{ID}}

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={EDIT_URL*}
	1_TITLE={!EDIT}
	1_ACCESSKEY=q
	1_REL=edit
	1_ICON=menu/_generic_admin/edit_this
{+END}

