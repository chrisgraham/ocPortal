{TITLE}

{+START,IF_PASSED,TEXT}
	<div>
		{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}</p>{+END}
	</div>
{+END}

{+START,IF_PASSED,POST_URL}{+START,IF_PASSED,SUBMIT_NAME}
	<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_NON_PASSED,GET}method="post" {+END}{+START,IF_PASSED,GET}method="get" {+END}action="{POST_URL*}">
		{TABLE}
		
		{+START,IF_PASSED,FIELDS}
			<br />
		
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
		{+END}

		{+START,IF_PASSED,HIDDEN}
			<div>
				{HIDDEN}
			</div>
		{+END}

		{+START,IF_PASSED,SUBMIT_NAME}
			<p class="proceed_button"><input class="button_page" type="submit" value="{SUBMIT_NAME*}" /></p>
		{+END}
	</form>
{+END}{+END}

{+START,IF_NON_PASSED,SUBMIT_NAME}
	{TABLE}
{+END}
