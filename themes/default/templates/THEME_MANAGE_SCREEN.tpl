{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<h2>{!EXISTING_THEMES}</h2>

<div class="variable_table theme_manage_table">
	<table summary="{!COLUMNED_TABLE}">
		<thead>
			<tr>
				<th>{!THEME}</th>
				<th>{!_ADDED}</th>
				<th colspan="4">{!EDIT}</th>
			</tr>
		</thead>
		<tbody>
			{THEMES}
		</tbody>
	</table>

	<div class="theme_manage_footnote">
		{+START,IF,{$HAS_FORUM}}
			<p><sup>*</sup> {!MEMBERS_MAY_ALTER_THEME}</p>
		{+END}
		<p><sup>*</sup> {THEME_DEFAULT_REASON*}</p>
	</div>

</div>

<script type="text/javascript">// <![CDATA[
	load_previews();
//]]></script>

<h2>{!NEW}</h2>

<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list">
	{+START,IF,{$ADDON_INSTALLED,themewizard}}
		<li>&raquo; <a href="{$PAGE_LINK*,adminzone:admin_themewizard:misc}">{!THEMEWIZARD}</a></li>
	{+END}
	<li>&raquo; <a href="{$PAGE_LINK*,adminzone:admin_themes:add_theme}">{!ADD_THEME}</a> ({!EMPTY})</li>
</ul>

<h2>{!THEME_EXPORT}</h2>

{+START,BOX,,,light}
<img class="help_jumpout" alt="" src="{$IMG*,help_jumpout}" />
<p>
	{!IMPORT_EXPORT_THEME_HELP,{$PAGE_LINK*,adminzone:admin_addons:addon_import}}
</p>
{+END}

<h2>{!ZONES}</h2>

<p>{!THEMES_AND_ZONES}</p>
<ul>
	{+START,LOOP,ZONES}
		<li>{1*} <span class="associated_link_to_small">(<a title="edit: {!EDIT_ZONE}: {1*}" onclick="var t=this; window.fauxmodal_confirm('{!SWITCH_MODULE_WARNING=;}',function(result) { if (result) { click_link(t); } }); return false;" href="{$PAGE_LINK*,_SEARCH:admin_zones:_edit:{0}:redirect={$SELF_URL&}}">edit</a>)</span></li>
	{+END}
</ul>

