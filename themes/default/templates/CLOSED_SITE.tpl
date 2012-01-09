<div class="closed_site_special_message">
	<div class="closed_site_special_message_inner">
		{+START,BOX,{$SITE_NAME*}}
			{CLOSED}
			<p>
				{+START,IF_NON_EMPTY,{JOIN_URL}}
					<!-- Re-enable if you want to allow people to easily join when the site is closed (or just give them the URL) <a href="{JOIN_URL*}"><img class="button_page page_icon" src="{$IMG*,page/join}" title="" alt="{!JOIN}" /></a> -->
				{+END}
				<a onclick="return open_link_as_overlay(this);" accesskey="l" rel="nofollow" href="{LOGIN_URL*}"><img class="button_page page_icon" src="{$IMG*,page/login}" title="" alt="{!_LOGIN}" /></a>
			</p>
		{+END}
	</div>
</div>

