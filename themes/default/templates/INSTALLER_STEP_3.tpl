{+START,IF_PASSED,JS}
<script type="text/javascript">// <![CDATA[
{JS/}
//]]></script>
{+END}

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="install.php?step=4">
	{HIDDEN}

	<div class="installer_main_min">
		<p>
			{!WELCOME_A,<a title="{!WELCOME_B}: {!LINK_NEW_WINDOW}" rel="external" href="http://ocportal.com/docs{$VERSION*}/pg/tut_install" target="_blank">{!WELCOME_B}</a>}
		</p>

		<p>
			{!FORUM_CHOICE}
		</p>

		<p>
			{!CAREFUL}
		</p>

		{+START,IF,{$JS_ON}}
		<!-- Layout table needed due to ensure perfect alignment -->
		<table summary="" class="installer_forums">
			<tbody>
				<tr>
					<td colspan="2" class="installer_forum_headers">
						<div id="install_versiontop">
							<div class="left">{!FORUM_SOFTWARE}</div>
							<div class="right">{!FORUM_VERSION}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="installer_forum_list">
						{FORUMS}
					</td>
					<td class="installer_forum_version">
						<div id="versions">
							{VERSION}
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		{+END}
		{+START,IF,{$NOT,{$JS_ON}}}
			{SIMPLE_FORUMS}
		{+END}
		<br />
		<div id="forum_path" style="display: {$JS_ON,none,block}">
			<p>{!FORUM_PATH_TEXT}</p>
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
				<colgroup>
					<col style="width: 30%" />
					<col style="width: 70%" />
				</colgroup>

				<tbody>
					<tr>
						<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{!_FORUM_PATH}"{+END} class="dottedborder_barrier">{!FORUM_PATH}</th>
						<td class="dottedborder_barrier">
							<div class="accessibility_hidden"><label for="board_path">{!_FORUM_PATH}</label></div>
							<div class="constrain_field"><input class="wide_field" type="text" size="60" id="board_path" name="board_path" value="{FORUM_PATH_DEFAULT*}" /></div>
						</td>
					</tr>
				</tbody>
			</table></div>
		</div>
		<br />
		<div class="wide_table_wrap"><table summary="" class="dottedborder wide_table">
			<colgroup>
				<col style="width: 50%" />
				<col style="width: 50%" />
			</colgroup>

			<tbody>
				<tr>
					<td class="dottedborder_barrier">{!USE_MULTI_DB} <div class="associated_details">{!REQUIRES_MORE_INFO}</div></td>
					<td class="dottedborder_barrier">
						<label for="yes"><input type="radio" name="use_multi_db" value="1" id="yes" />{!YES}</label>
						<label class="radio_horiz_spacer" for="no"><input type="radio" name="use_multi_db" value="0" id="no" checked="checked" />{!NO}</label>
					</td>
				</tr>

				<tr>
					<td class="dottedborder_barrier">{!USE_MSN} <div class="associated_details">{!REQUIRES_MORE_INFO}</div></td>
					<td class="dottedborder_barrier">
						<label for="yes2"><input type="radio" name="use_msn" value="1" id="yes2" />{!YES}</label>
						<label class="radio_horiz_spacer" for="no2"><input type="radio" name="use_msn" value="0" id="no2" checked="checked" />{!NO}</label>
					</td>
				</tr>
			</tbody>
		</table></div>

		<br />
		<div>
			<label for="db_type">{!DB_CHOICE}</label>:
			<select id="db_type" name="db_type">
				{DATABASES}
			</select>
		</div>
	</div>

	<div class="proceed_button">
		<input class="button_page" type="submit" value="{!SURE}" />
	</div>
</form>

