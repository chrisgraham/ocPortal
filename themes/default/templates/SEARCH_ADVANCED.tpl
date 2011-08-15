{+START,IF,{$OR,{$AND,{UNDERNEATH},{$IS_NON_EMPTY,{OPTIONS}}},{$IS_NON_EMPTY,{OPTIONS}}}}
<tr>
	<td colspan="3">
		<h3 class="search_advanced_title">{!ADVANCED}&hellip;</h3>
		{$SHIFT_DECODE,search_template_help}

		{OPTIONS}

		{+START,IF,{UNDERNEATH}}
			<br />
			<div>
				<div class="search_option">
					<label for="search_under">{!SEARCH_UNDERNEATH}</label>:
				</div>
				<div class="left">
					{+START,IF,{AJAX}}
						{TREE}
					{+END}
					{+START,IF,{$NOT,{AJAX}}}
					<select id="search_under" name="search_under">
						{TREE}
					</select>
					{+END}
				</div>
			</div>
		{+END}
	</td>
</tr>
{+END}
<!--
{+START,IF,{$NOT,{$IS_GUEST}}}
<tr>
	<td colspan="3">
		<h3 class="search_tabular_header">{!SAVE_SEARCH}&hellip;</h3>
	</td>
</tr>
<tr>
	<th class="dottedborder_barrier">{!SAVE_SEARCH}</th>
	<td class="dottedborder_barrier" colspan="2">
		<p>{!SAVE_SEARCH_DESCRIPTION}</p>
		<div class="accessibility_hidden"><label for="save_title">{!TITLE}</label></div>
		<input maxlength="255" type="text" size="48" value="" id="save_title" name="save_title" />
		<p>&raquo; <a href="{$PAGE_LINK*,_SELF:_SELF:my}">{!SAVED_SEARCHES}</a></p>
	</td>
</tr>
{+END}
-->
