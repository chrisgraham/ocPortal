{TITLE}

{!TRANSLATE_CONTENT_SCREEN,{LANG_NICE_NAME*}}

{+START,IF_NON_EMPTY,{INTERTRANS}}
	<p>
		{!POWERED_BY,<a rel="external" title="Google: {!LINK_NEW_WINDOW}" target="_blank" href="http://translate.google.com/">Google</a>}.
	</p>
{+END}

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	<div class="wide_table_wrap really_long_table_wrap"><table summary="{!COLUMNED_TABLE}" class="results_table wide_table autosized_table">
		<thead>
			<tr>
				<th>
					{!ORIGINAL}{+START,IF,{$NEQ,{LANG_ORIGINAL_NAME},{LANG}}} ({LANG_NICE_ORIGINAL_NAME*}?){+END}
				</th>
				<th>
					{LANG_NICE_NAME*}
				</th>
				{+START,IF_NON_EMPTY,{INTERTRANS}}
					<th>
						{!ACTIONS}
					</th>
				{+END}
			</tr>
		</thead>

		<tbody>
			{LINES}
		</tbody>
	</table></div>

	<p class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
	</p>

	{+START,IF,{TOO_MANY}}
		<p class="more_here">{!TRANSLATE_TOO_MANY,{TOTAL*},{MAX*}}</p>
	{+END}
</form>

<form title="" id="hack_form" action="http://translate.google.com/translate_t" method="post">
	<div>
		<input type="hidden" id="hack_input" name="text" value="" />
		<input type="hidden" name="langpair" value="en|{INTERTRANS*}" />
	</div>
</form>

