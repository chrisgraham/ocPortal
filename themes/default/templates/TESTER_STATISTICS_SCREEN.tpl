{TITLE}

<p>
	{!TESTER_STATISTICS_INTRO}
</p>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table">
	<colgroup>
		<col style="width: 250px" />
		<col style="width: 100%" />
	</colgroup>
	<tbody>
		<tr>
			<th>{!NUM_TESTS}</th>
			<td>{NUM_TESTS*}</td>
		</tr>
		<tr>
			<th>{!NUM_TESTS_,{!TEST_SUCCESSFUL}}</th>
			<td>{NUM_TESTS_SUCCESSFUL*}</td>
		</tr>
		<tr>
			<th>{!NUM_TESTS_,{!TEST_FAILED}}</th>
			<td>{NUM_TESTS_FAILED*}</td>
		</tr>
		<tr>
			<th>{!NUM_TESTS_,{!TEST_INCOMPLETE}}</th>
			<td>{NUM_TESTS_INCOMPLETE*}</td>
		</tr>
	</tbody>
</table></div>

{TESTERS}
