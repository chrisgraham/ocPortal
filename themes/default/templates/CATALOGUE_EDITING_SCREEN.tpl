{TITLE}

{$PARAGRAPH,{TEXT}}

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}" target="_top">
	<div>
		{HIDDEN}

		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table scrollable_inside">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col class="field_name_column" />
					<col class="field_input_column" />
				</colgroup>
			{+END}

			<tbody>
				{FIELDS}
			</tbody>
		</table></div>

		<h2>{!FIELDS_EXISTING}</h2>
		{FIELDS_EXISTING}

		<h2>{!FIELDS_NEW}</h2>
		<p>{!FIELDS_NEW_HELP}</p>
		{FIELDS_NEW}

		<script type="text/javascript">// <![CDATA[
			catalogue_field_change_watching();
		//]]></script>

		{+START,INCLUDE,FORM_STANDARD_END}{+END}
	</div>
</form>
