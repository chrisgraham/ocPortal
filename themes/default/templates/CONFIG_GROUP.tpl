<a name="group_{GROUP_NAME*}" id="group_{GROUP_NAME*}"></a>
<div class="no_stbox_padding">
	{+START,BOX,{CURRENT_GROUP}}
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
			<colgroup>
				<col style="width: 198px" />
				<col style="width: 100%" />
			</colgroup>

			<tbody>
				{+START,IF_NON_EMPTY,{GROUP_DESCRIPTION}}<tr><th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th forcedottedborder"><div>{GROUP_DESCRIPTION*}</div></th></tr>{+END}

				{GROUP}
			</tbody>
		</table></div>
	{+END}
</div>
<br />
