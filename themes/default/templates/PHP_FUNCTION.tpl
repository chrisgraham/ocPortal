<a id="link_{CLASS*}.{FUNCTION*}"></a>

<p>
	<span class="php_parameter_type">{RETURN_TYPE*}</span> {FUNCTION*}({PARAMETERS})
	{+START,IF_NON_EMPTY,{FILENAME}}
		[ {!IN,{FILENAME*}} ]
	{+END}
</p>

<div class="php_function_inner">
	<p>{DESCRIPTION}</p>

	<p>{!PARAMETERS}&hellip;</p>

	{FULL_PARAMETERS}

	{+START,IF_NON_EMPTY,{RETURN}}
		<p>{!RETURNS}&hellip;</p>

		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="autosized_table">
			<tbody>
				{RETURN}
			</tbody>
		</table></div>
	{+END}
	{+START,IF_EMPTY,{RETURN}}
		<p class="nothing_here">{!NO_RETURN_VALUE}</p>
	{+END}
</div>

<p>
	<a class="right" title="{!RETURN_TO_FUNCTION_INDEX}" href="#class_index_{CLASS*}" target="_self"><img class="top_vertical_alignment" src="{$IMG*,top}" alt="{!RETURN_TO_FUNCTION_INDEX}"/></a>
</p>

{+START,IF_NON_EMPTY,{CODE}}
	<div class="float_surrounder">
		<div class="float_surrounder">
			<a class="toggleable_tray_button ttb_left" title="{!VIEW_SOURCE_CODE}" href="#" onclick="return toggleable_tray('{CLASS;*}.{FUNCTION;*}');"><img alt="{!EXPAND}: {!VIEW_SOURCE_CODE}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
		</div>

		<div class="toggleable_tray toggleable_tray_pulldown_spacer" id="{CLASS*}.{FUNCTION*}" style="display: {$JS_ON,none,block}" aria-expanded="false">
			<span class="xhtml_validator_off">
				{CODE`}
			</span>
		</div>
	</div>
{+END}

<hr class="spaced_rule" />

