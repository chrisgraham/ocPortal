{TITLE}

<h2>{!DETAILS}</h2>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table">
	<colgroup>
		<col style="width: 140px" />
		<col style="width: 100%" />
	</colgroup>

	<tbody>
	<tr>
		<th>{!USERNAME}</th>
		<td>{NAME*}</td>
	</tr>
{+START,IF,{$NOT,{$IS_GUEST,{ID}}}}
	<tr>
		<th>{!MEMBER_ID}</th>
		<td>#<strong>{ID*}</strong> &nbsp; <em>{!_BANNED}: {MEMBER_BANNED*}</em></td>
	</tr>
{+END}
{+START,IF_NON_EMPTY,{IP}}
	<tr>
		<th>{!IP_ADDRESS}</th>
		<td><strong>{IP*}</strong> &nbsp; <em>{!_BANNED}: {IP_BANNED*}</em></td>
	</tr>
{+END}
	<tr>
		<th>{!RELATED_SCREENS}</th>
		<td>
{+START,IF_PASSED,PROFILE_URL}
			&raquo; <a href="{PROFILE_URL*}">{!VIEW_PROFILE}</a><br />
{+END}
{+START,IF_PASSED,ACTION_LOG_URL}
			&raquo; <a href="{ACTION_LOG_URL*}">{!VIEW_ACTION_LOGS}</a><br />
{+END}
{+START,IF_PASSED,POINTS_URL}
			&raquo; <a href="{POINTS_URL*}">{!POINTS}</a><br />
{+END}
{+START,IF_PASSED,AUTHOR_URL}
			&raquo; <a href="{AUTHOR_URL*}">{!VIEW_AUTHOR}</a><br />
{+END}
{+START,IF_PASSED,SEARCH_URL}
			&raquo; <a rel="search" href="{SEARCH_URL*}">{!SEARCH}</a><br />
{+END}
		</td>
	</tr>
{+START,IF_NON_EMPTY,{IP}}
	<tr>
		<th>{!ACTIONS}</th>
		<td>
			<!-- If you like new windows, add this... title="{!LINK_NEW_WINDOW}" target="_blank"  -->
			&raquo; <a rel="external" href="http://whatismyipaddress.com/ip/{IP*}">Reverse-DNS/WHOIS</a> <br />
			&raquo; <a rel="external" href="http://network-tools.com/default.asp?prog=ping&amp;Netnic=whois.arin.net&amp;host={IP*}">Ping</a> <br />
			&raquo; <a rel="external" href="http://network-tools.com/default.asp?prog=trace&amp;Netnic=whois.arin.net&amp;host={IP*}">Tracert</a> <br />
			&raquo; <a rel="external" href="http://www.infosniper.net/index.php?ip_address={IP*}">Geo-Lookup</a>
		</td>
	</tr>
{+END}
	</tbody>
</table></div>

<h2>{!BANNED_ADDRESSES}</h2>

{+START,IF_NON_EMPTY,{IP_LIST}}
	<form title="{!PRIMARY_PAGE_FORM}" action="{$SELF_URL*}" method="post">
		{!IP_LIST}
		<ul>
			{IP_LIST}
		</ul>
		
		<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SET}" />
	</form>
{+END}
{+START,IF_EMPTY,{IP_LIST}}
	<p class="nothing_here">
		{!NONE}
	</p>
{+END}

<h2>{!_VIEWS}</h2>

{STATS}

{+START,IF_NON_EMPTY,{ALERTS}}
	<h2>{!SECURITY_ALERTS}</h2>
	
	{ALERTS}
{+END}

