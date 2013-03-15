{+START,BOX,{TITLE*},,{$?,{$GET,in_panel},panel,classic}}
	<ul class="compact_list">
		{+START,LOOP,YEARS}
			<li>{YEAR}
				<ul class="compact_list associated_details">
					{+START,LOOP,TIMES}
						<li>
							<a href="{URL*}">{MONTH_STRING}</a>
						</li>
					{+END}
				</ul>
			</li>
		{+END}
	</ul>
{+END}
