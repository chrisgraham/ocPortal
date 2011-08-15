<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="solidborder wide_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 110px" />
			<col style="width: 110px" />
		</colgroup>
	{+END}

	<tbody>
		<tr>
			<th class="de_th meta_data_title">{!RESOLUTION}</th>
			<td class="de_th meta_data_title">{WIDTH*} &times; {HEIGHT*}</td>
		</tr>
		<tr>
			<th class="de_th meta_data_title">{!VIDEO_LENGTH}</th>
			<td class="de_th meta_data_title">{$TIME_PERIOD*,{LENGTH}}</td>
		</tr>
	</tbody>
</table></div>
