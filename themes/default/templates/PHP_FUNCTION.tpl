<br />
<a name="link_{CLASS*}.{FUNCTION*}" id="link_{CLASS*}.{FUNCTION*}"></a>

<span class="php_parameter_type">{RETURN_TYPE*}</span> {FUNCTION*}({PARAMETERS})
{+START,IF_NON_EMPTY,{FILENAME}}
[ {!IN,{FILENAME*}} ]
{+END}
<br />

<div class="php_function_inner">
	<p>{DESCRIPTION}</p>

	<p>{!PARAMETERS}&hellip;</p>

	{FULL_PARAMETERS}

	{+START,IF_NON_EMPTY,{RETURN}}
		<p>{!RETURNS}&hellip;</p>

		<!-- Layout table needed due to ensure consistant indentation against unknown width range -->
		<div class="wide_table_wrap"><table summary="" class="wide_table">
			<colgroup>
				<col style="width: 110px" />
				<col style="width: 100%" />
			</colgroup>

			<tbody>
				{RETURN}
			</tbody>
		</table></div>
	{+END}
	{+START,IF_EMPTY,{RETURN}}
		<p class="nothing_here">{!NO_RETURN_VALUE}</p>
	{+END}
</div>

<br />

<a class="right" title="{!RETURN_TO_FUNCTION_INDEX}" href="#class_index_{CLASS*}" target="_self"><img class="inline_image" src="{$IMG*,top}" alt="{!RETURN_TO_FUNCTION_INDEX}" title=""/></a>

{+START,IF_NON_EMPTY,{CODE}}
<a class="hide_button" title="{!VIEW_SOURCE_CODE}" href="#" onclick="event.returnValue=false; toggleSectionInline('{CLASS*;}.{FUNCTION*;}','block'); return false;"><img alt="{!EXPAND}: {!VIEW_SOURCE_CODE}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
<div class="hide_button_spacing" id="{CLASS*}.{FUNCTION*}" style="display: {$JS_ON,none,block}">
	<span class="xhtml_validator_off">
		{CODE`}
	</span>
</div>
{+END}

<hr class="spaced_rule" />

