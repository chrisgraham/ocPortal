<div class="form_group">
	<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('{ID*;}','block'); return false;"><img id="e_{ID*}" {+START,IF_PASSED,VISIBLE}alt="{!CONTRACT}: {NAME*}" title="{!CONTRACT}"{+END}{+START,IF_NON_PASSED,VISIBLE}alt="{!EXPAND}: {NAME*}" title="{!EXPAND}"{+END} src="{+START,IF_PASSED,VISIBLE}{$IMG*,contract}{+END}{+START,IF_NON_PASSED,VISIBLE}{$IMG*,expand}{+END}" /></a> <a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('{ID*;}','block'); return false;">{NAME*}</a>
	<div id="{ID*}"{+START,IF_NON_PASSED,VISIBLE} style="display: {$JS_ON,none,block}"{+END}>
		<br />
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 198px" />
					<col style="width: 100%" />
				</colgroup>
			{+END}

			<tbody>
				{FIELDS}
			</tbody>
		</table></div>
	</div>
</div>

