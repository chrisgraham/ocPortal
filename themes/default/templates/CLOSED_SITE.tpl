{$REQUIRE_CSS,messages}

<div class="closed_site_special_message">
	<div class="closed_site_special_message_inner">
		<div class="box box___closed_site"><div class="box_inner">
			<h2>{$SITE_NAME*}</h2>

			<p>
				{CLOSED}
			</p>
			{+START,IF,{$IS_GUEST}}
				<p>
					{+START,IF_NON_EMPTY,{JOIN_URL}}
						{$,Re-enable if you want to allow people to easily join when the site is closed (or just give them the URL) <a href="\{JOIN_URL*\}"><img class="button_page" src="\{$IMG*,page/join\}" alt="\{!JOIN\}" /></a>}
					{+END}
					<a onclick="return open_link_as_overlay(this);" accesskey="l" rel="nofollow" href="{LOGIN_URL*}"><img class="button_page" src="{$IMG*,page/login}" alt="{!_LOGIN}" /></a>
				</p>
			{+END}
		</div></div>
	</div>
</div>

