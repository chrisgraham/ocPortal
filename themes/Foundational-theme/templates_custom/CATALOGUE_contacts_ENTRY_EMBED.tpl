<li class="un-line">
	<h5>{+START,IF_NON_EMPTY,{VIEW_URL}}<a href="{VIEW_URL*}">{+END}{+START,FRACTIONAL_EDITABLE,{FIELD_0_PLAIN},field_0,_SEARCH:cms_catalogues:type=__edit_entry:id={ID},1}{FIELD_0} {FIELD_1}{+END}{+START,IF_NON_EMPTY,{VIEW_URL}}</a>{+END}</h5>
	{+START,IF,{$OR,{$IS_NON_EMPTY,{FIELD_12_PLAIN}},{$IS_NON_EMPTY,{$REPLACE,/,,{FIELD_11}}}}}
		<p{+START,IF_NON_EMPTY,{FIELD_12_PLAIN}} style="background:url('{$THUMBNAIL,{FIELD_12_PLAIN},54}') no-repeat;"{+END}>
			{FIELD_11}
		</p>
	{+END}
</li>

