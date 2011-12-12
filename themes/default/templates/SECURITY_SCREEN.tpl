{TITLE}

<h2>{!FAILED_LOGINS}</h2>

{FAILED_LOGINS}

<h2>{!SECURITY_ALERTS}</h2>

{+START,IF,{$JS_ON}}
	<p>
		{!SECURITY_PAGE_CLEANUP}
	</p>
{+END}

{ALERTS}

{+START,IF,{$JS_ON}}
	<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
		<div class="proceed_button">
			<input onclick="if (addFormMarkedPosts(this.form,'del_')) { disable_button_just_clicked(this); return true; } window.alert('{!NOTHING_SELECTED=;}'); return false;" class="button_page" type="submit" value="{!DELETE}" />
		</div>
	</form>
{+END}

