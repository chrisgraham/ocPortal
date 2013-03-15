<form title="{!PRIMARY_PAGE_FORM}" action="install.php?step=2" method="post">
	{HIDDEN}

	<div class="installer_main_min">
		<p id="install_welcome">
			<strong>Welcome! &middot; Bienvenue! &middot; Willkommen! &middot; Bienvenidos! &middot; Welkom! &middot; Swaagatam! &middot; Irashaimasu! &middot; Huan yin! &middot; Dobro pozhalovat'! &middot; Witaj!</strong>
		</p>

		{+START,IF_NON_EMPTY,{WARNINGS}}
			{WARNINGS}
		{+END}

		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
			<colgroup>
				<col style="width: 50%" />
				<col style="width: 50%" />
			</colgroup>

			<tbody>
				<tr>
					<th style="width: auto" class="dottedborder_barrier">{!PLEASE_CHOOSE_LANG} (&dagger;)</th>
					<td class="dottedborder_barrier">
						<div class="accessibility_hidden"><label for="default_lang">{!PLEASE_CHOOSE_LANG}</label></div>
						<select id="default_lang" name="default_lang">
							{LANGUAGES}
						</select>
					</td>
				</tr>
			</tbody>
		</table></div>
	</div>

	<div class="proceed_button">
		<input class="button_page" type="submit" value="{!PROCEED} (&hellip;)" />
	</div>

	<p>&dagger; Currently we do not ship additional languages with ocPortal. However a <a href="https://translations.launchpad.net/ocportal/4.2.0">growing number</a> of <a target="_blank" title="community translations are on Launchpad: {!LINK_NEW_WINDOW}" href="http://ocportal.com/docs/tut_intl.htm">community translations are on Launchpad</a>.</p>
</form>


