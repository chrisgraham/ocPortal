<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	{HIDDEN}

	<div class="installer_main_min">
		<p id="install_welcome">
			<strong>Welcome! &middot; Bienvenue! &middot; Willkommen! &middot; Bienvenidos! &middot; Welkom! &middot; Swaagatam! &middot; Irashaimasu! &middot; Huan yin! &middot; Dobro pozhalovat'! &middot; Witaj!</strong>
		</p>

		{+START,IF_NON_EMPTY,{WARNINGS}}
			{WARNINGS}
		{+END}

		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table">
			<colgroup>
				<col class="installer_left_column" />
				<col class="installer_right_column" />
			</colgroup>

			<tbody>
				<tr>
					<th class="form_table_field_name">{!PLEASE_CHOOSE_LANG} (&dagger;)</th>
					<td class="form_table_field_input">
						<div class="accessibility_hidden"><label for="default_lang">{!PLEASE_CHOOSE_LANG}</label></div>
						<select id="default_lang" name="default_lang">
							{LANGUAGES}
						</select>
					</td>
				</tr>
			</tbody>
		</table></div>
	</div>

	<p class="proceed_button">
		<input class="button_page" type="submit" value="{!PROCEED} (&hellip;)" />
	</p>

	<p>&dagger; Currently we do not ship additional languages with ocPortal. However a <a href="https://translations.launchpad.net/ocportal/4.2.0">growing number</a> of <a target="_blank" title="community translations are on Launchpad: {!LINK_NEW_WINDOW}" href="http://ocportal.com/docs/tut_intl.htm">community translations are on Launchpad</a>.</p>
</form>


