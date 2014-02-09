<div>
	<h2>
		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {!TEST_RESULTS}" title="{!CONTRACT}" src="{$IMG*,1x/trays/contract}" srcset="{$IMG*,2x/trays/contract} 2x" /></a>
		<span onclick="/*Access-note: code has other activation*/ return toggleable_tray(this.parentNode.parentNode);">{!TEST_RESULTS}</span>
	</h2>

	<div class="toggleable_tray" style="display: block" aria-expanded="true">
		<div class="wide_table_wrap"><table class="columned_table wide_table results_table autosized_table">
			<thead>
				<tr>
					<th>
						{!NAME}
					</th>

					<th>
						{!DATE}
					</th>

					<th>
						{!MARKS}
					</th>

					<th>
						{!PERCENTAGE}
					</th>

					<th>
						{!STATUS}
					</th>
				</tr>
			</thead>

			<tbody>
				{+START,LOOP,ENTRIES}
					<tr>
						<td>
							<a onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{QUIZ_START_TEXT;^*}','auto');" href="{QUIZ_URL*}">{QUIZ_NAME*}</a>
						</td>

						<td>
							{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_quiz,adminzone}}
								<a href="{$PAGE_LINK*,adminzone:admin_quiz:__quiz_results:{ENTRY_ID}}">{ENTRY_DATE*}</a>
							{+END}

							{+START,IF,{$NOT,{$HAS_ACTUAL_PAGE_ACCESS,admin_quiz,adminzone}}}
								{ENTRY_DATE*}
							{+END}
						</td>

						<td>
							{MARKS_RANGE*} / {OUT_OF*}
						</td>

						<td>
							{PERCENTAGE_RANGE*}%
						</td>

						<td>
							{+START,IF_PASSED,PASSED}
								{+START,IF,{PASSED}}
									<span class="multilist_mark yes">{!PASSED}</span>
								{+END}

								{+START,IF,{$NOT,{PASSED}}}
									<span class="multilist_mark no">{!FAILED}</span>
								{+END}
							{+END}

							{+START,IF_NON_PASSED,PASSED}
								{!UNKNOWN}
							{+END}
						</td>
					</tr>
				{+END}
			</tbody>
		</table></div>
	</div>
</div>
