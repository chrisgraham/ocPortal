{TITLE}

<div class="float_surrounder">
	<div class="ocf_avatar_page_old_avatar">
		{AVATAR}
	</div>
	<div class="ocf_avatar_page_text">
		<p>{!AVATAR_CHANGE,{WIDTH*},{HEIGHT*},{USERNAME*}}</p>
	</div>
</div>

<br />

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}" enctype="multipart/form-data">
	{HIDDEN}

	<div>
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

		{+START,INCLUDE,FORM_STANDARD_END}{+END}
	</div>
</form>

