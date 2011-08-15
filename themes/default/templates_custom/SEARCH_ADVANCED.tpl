{+START,IF,{$NOT,{$_GET,in_main_include_module}}}
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
{+END}

{+START,IF,{$_GET,in_main_include_module}}
	{OPTIONS}
{+END}
