{TITLE}

{+START,IF_NON_EMPTY,{TRACKBACKS}}
	{+START,IF,{LOTS}}
		<p><em>{!ONLY_1000_SHOWN}</em></p>
	{+END}

	<form title="{!PRIMARY_PAGE_FORM}" action="{$PAGE_LINK*,_SEARCH:admin_trackbacks:delete}" method="post">
		{TRACKBACKS}

		<p class="proceed_button">
			<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!DELETE}" />
		</p>
	</form>
{+END}
{+START,IF_EMPTY,{TRACKBACKS}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}
