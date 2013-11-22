{TITLE}

<p>
	{!HOSTING_COPY_SUCCESS}
</p>

<form action="{INSTALL_URL*}" method="post">
	{HIDDEN}
	<input type="hidden" name="ftp_folder" value="{FTP_FOLDER*}" />

	<div class="proceed_button">
		<input buttons__proceed type="submit" value="{!PROCEED}" />
	</div>
</form>

