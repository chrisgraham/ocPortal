{TITLE}

<p>
	{!SSL_PAGE_SELECT}
</p>

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	<div class="float_surrounder">
		<div class="ssl_page">
			{CONTENT}
		</div>
	</div>

	<br />
	<div class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
	</div>
</form>

