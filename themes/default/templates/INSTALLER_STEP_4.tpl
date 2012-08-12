<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post" onsubmit="return submit_settings(this);">
	<div>
		<input type="hidden" name="default_lang" value="{LANG*}" />
		<input name="db_type" type="hidden" value="{DB_TYPE*}" />
		<input name="forum_type" type="hidden" value="{FORUM_TYPE*}" />
		<input name="board_path" type="hidden" value="{BOARD_PATH*}" />

		<div class="installer_main_min">
			{+START,IF_NON_EMPTY,{MESSAGE}}
				<div class="lonely_label">{MESSAGE}</div>
			{+END}

			{SECTIONS}
		</div>

		<p class="proceed_button">
			<input class="button_page" type="submit" value="{!INSTALL} ocPortal" />
		</p>
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
				if ((cs) && (cs.style.display=='none')) toggle_section('Cookie_space_settings');
				var cd=document.getElementById('cookie_domain');
				if ((cd) && (cd.value!='')) cd.value='.'+domain.value;
			}
		}
	//]]></script>
{+END}
