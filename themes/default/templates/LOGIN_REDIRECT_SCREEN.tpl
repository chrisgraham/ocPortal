{REFRESH}

{TITLE}

<div class="site_special_message">
	<div class="site_special_message_inner">
		<form title="{!PROCEED}" action="{URL*}" id="redir_form" method="post">
			{+START,BOX,,,curved}
				{TEXT}

				<p>
					{!PROCEED_TEXT,<input accesskey="c" class="buttonhyperlink" type="submit" value="{!HERE}" />}
				</p>

				{POST}
			 {+END}
		 </form>
	</div>
</div>

