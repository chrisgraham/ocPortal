{TITLE}

<p>{!ADDONS_SCREEN}</p>

{+START,IF_NON_EMPTY,{ADDONS}}
	<h2>{!ADDONS}</h2>

	{+START,IF,{$JS_ON}}
		<div class="float_surrounder">
			<p class="right associated_link_to_small">
				<a href="#" onclick="var as=document.getElementsByTagName('input'); for (var i=0;i&lt;as.length;i++) { if (as[i].name.substr(0,10)=='uninstall_') as[i].checked=true; } return false;">[ {!DELETE}: {!USE_ALL} ]</a>
			</p>
		</div>
	{+END}

	<form title="{!PRIMARY_PAGE_FORM}" action="{MULTI_ACTION*}" method="post">
		<div class="not_too_tall_addons">
			<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table dottedborder">
				<colgroup>
					<col style="width: 100%" />
					<col style="width: 140px" />
					<col style="width: 50px" />
					<col style="width: 70px" />
					<col style="width: 75px" />
				</colgroup>

				<thead>
					<tr>
						<th>
							{!NAME}
						</th>
						<th>
							{!AUTHOR}
						</th>
						<th>
							{!VERSION}
						</th>
						<th>
							{!STATUS}
						</th>
						<th>
							{!ACTIONS}
						</th>
					</tr>
				</thead>

				<tbody>
					{ADDONS}
				</tbody>
			</table></div>
		</div>

		<p class="proceed_button">
			<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!INSTALL_AND_UNINSTALL}" />
		</p>
	</form>
{+END}
{+START,IF_EMPTY,{ADDONS}}
	<p class="nothing_here">
		{!NO_ADDONS_AVAILABLE}
	</p>
{+END}

<h2>{!ACTIONS}</h2>

<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list spaced_list">
	<li>
		&raquo; <a href="{$PAGE_LINK*,_SELF:_SELF:type=addon_import}">{!IMPORT_ADDON}</a> ({!IMPORT_ADDON_2})
	</li>
	<li>
		&raquo; <a href="{$PAGE_LINK*,_SELF:_SELF:type=addon_export}">{!EXPORT_ADDON_TITLE}</a>
	</li>
	<li>
		&raquo; {!ADVANCED}: <a href="{$PAGE_LINK*,_SELF:_SELF:type=modules}">{!MODULE_MANAGEMENT}</a>
	</li>
</ul>

