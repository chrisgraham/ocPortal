<form title="{!PRIMARY_PAGE_FORM}" action="install.php?step=5" method="post" onsubmit="return submit_settings(this);">
	<div>
		<input type="hidden" name="default_lang" value="{LANG*}" />
		<input name="db_type" type="hidden" value="{DB_TYPE*}" />
		<input name="forum_type" type="hidden" value="{FORUM_TYPE*}" />
		<input name="board_path" type="hidden" value="{BOARD_PATH*}" />

		<div class="installer_main_min">
			<div>
				{MESSAGE}
			</div>

			{SECTIONS}
		</div>

		<div class="proceed_button">
			<input class="button_page" type="submit" value="{!INSTALL} ocPortal" />
		</div>
	</div>
</form>

{+START,IF_PASSED,JS}
<script type="text/javascript">// <![CDATA[
{JS/}
	var domain=document.getElementById('domain');
	if (domain)
	{
		domain.onchange=function() {
			var cs=document.getElementById('Cookie_space_settings');
			if ((cs) && (cs.style.display=='none')) toggleSection('Cookie_space_settings');
			var cd=document.getElementById('cookie_domain');
			if ((cd) && (cd.value!='')) cd.value='.'+domain.value;
		}
	}
//]]></script>
{+END}
