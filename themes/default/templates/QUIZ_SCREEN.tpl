{TITLE}

{WARNING_DETAILS}

{$CSS_INCLUDE,quizzes}

{+START,IF_NON_EMPTY,{START_TEXT}}
	{+START,BOX,,,curved}
		<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{START_TEXT}
		</div>
	{+END}

	<hr class="spaced_rule" />
{+END}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,quiz,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}<br />{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

{+START,IF_NON_EMPTY,{TIMEOUT}}
	<script type="text/javascript">// <![CDATA[
		setTimeout(function() { window.fauxmodal_alert('{!OUT_OF_TIME;;}',function() { document.getElementById('survey').submit(); } ); }, {TIMEOUT%}*1000);
		setInterval(function() { var st=document.getElementById('survey_timer'); var new_value=window.parseInt(getInnerHTML(st))-1; if (new_value>=0) setInnerHTML(st,new_value); }, 1000);
	//]]></script>

	<p>
		{!TIME_REMAINING,<strong><span id="survey_timer">{TIMEOUT*}</span></strong>}
	</p>
	<br />
{+END}

<form title="{!SAVE}" id="survey" method="post" onsubmit="return checkForm(this);" action="{URL*}">
	<div>
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 280px" />
					<col style="width: 100%" />
				</colgroup>
			{+END}

			<tbody>
				{FIELDS}
			</tbody>
		</table></div>

		<p class="proceed_button">
			<input accesskey="u" class="button_page" type="submit" value="{!SAVE}" />
		</p>
	</div>
</form>

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		if (typeof window.setUpChangeMonitor!='undefined')
		{
			var e=get_elements_by_class_name(document.getElementById('survey'),'field_input');
			for (var i=0;i<e.length;i++)
			{
				setUpChangeMonitor(e[i]);
			}
		}
	} );
//]]></script>

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={EDIT_URL*}
	1_TITLE={!EDIT}
	1_ACCESSKEY=q
	1_REL=edit
{+END}

