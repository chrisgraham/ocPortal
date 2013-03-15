<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="autosized_table wide_table results_table">
	<tbody>
		<tr>
			<th>{!USERNAME}</th>
			<td>{NAME*}</td>
		</tr>
		<tr>
			<th>{!MEMBER_ID}</th>
			<td>{ID*}</td>
		</tr>
		<tr>
			<th>{!IP_ADDRESS}</th>
			<td>
				<ul>
					<li class="whois_ip">{IP*}</li>
					{IP_LIST}
				</ul>
			</td>
		</tr>
		<tr>
			<th>{!ACTIONS}</th>
			<td>
				<ul class="actions_list">
					<li><a href="http://www.samspade.org/t/ipwhois?a={IP*}">Reverse-DNS/WHOIS</a></li>
					<li><a href="http://network-tools.com/default.asp?prog=ping&amp;Netnic=whois.arin.net&amp;host={IP*}">Ping</a></li>
					<li><a href="http://network-tools.com/default.asp?prog=trace&amp;Netnic=whois.arin.net&amp;host={IP*}">Tracert</a></li>
					<li><a href="http://netgeo.caida.org/perl/netgeo.cgi?target={IP*}">Geo-Lookup</a></li>
				</ul>
			</td>
		</tr>
	</tbody>
</table></div>
