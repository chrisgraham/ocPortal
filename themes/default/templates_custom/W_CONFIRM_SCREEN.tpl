{TITLE}

<p>{!Q_SURE}</p>

<form method="post" enctype="multipart/form-data" action="{URL*}">
	<input type="hidden" name="type" value="{COMMAND*}" />
	<input type="hidden" name="item" value="{ITEM*}" />
	<input type="hidden" name="user" value="{USER*}" />
	<input type="hidden" name="param" value="{PARAM*}" />

	<p class="proceed_button">
		<input class="button_page" type="submit" value="{!PROCEED}" />
	</p>
</form>

