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
					<li><a href="http://whatismyipaddress.com/ip/{IP*}">Reverse-DNS/WHOIS</a></li>
					<li><a href="https://ping.eu/ping/?host={IP*}">Ping</a></li>
					<li><a href="https://ping.eu/traceroute/?host={IP*}">Tracert</a></li>
					<li><a href="http://www.infosniper.net/index.php?ip_address={IP*}">Geo-Lookup</a></li>
				</ul>
			</td>
		</tr>
	</tbody>
</table></div>
