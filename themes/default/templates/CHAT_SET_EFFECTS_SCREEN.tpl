{TITLE}

{CHAT_SOUND}

<p>
	{!CHOOSE_SOUND_EFFECTS}
</p>

<form title="{!PRIMARY_PAGE_FORM}" action="{POST_URL*}" method="post" enctype="multipart/form-data">
	{HIDDEN}

	<div>
		{SETTING_BLOCKS}

		{+START,INCLUDE,FORM_STANDARD_END}{+END}
	</div>
</form>
