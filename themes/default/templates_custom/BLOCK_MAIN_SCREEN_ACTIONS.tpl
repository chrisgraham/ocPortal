<{$?,{$VALUE_OPTION,html5},aside,div} class="medborder_box medborder" id="screen_actions_outer"><div id="screen_actions">
	<div>{$BLOCK,block=main_facebook_like}</div>
	<div class="print"><a class="link_exempt" title="{!PRINT_THIS_SCREEN}" rel="print" target="_blank" title="{!PRINT_THIS_SCREEN}: {!LINK_NEW_WINDOW}" href="{PRINT_URL*}"></a></div>
	<div class="recommend"><a class="link_exempt" title="{!OCP_RECOMMEND}" target="_blank" title="{!OCP_RECOMMEND}: {!LINK_NEW_WINDOW}" href="{RECOMMEND_URL*}"></a></div>
	{+START,IF,{$BROWSER_MATCHES,ie}}
		<div class="favorites"><a class="link_exempt" title="{!ADD_TO_FAVORITES}" href="#" onclick="window.external.AddFavorite(window.location.href,document.title); return false;"></a></div>
	{+END}
	{$,<div class="facebook"><a class="link_exempt" title="{!ADD_TO_FACEBOOK}" target="_blank" title="{!ADD_TO_FACEBOOK}: {!LINK_NEW_WINDOW}" href="http://www.facebook.com/sharer.php?u={EASY_SELF_URL*}"></a></div>}
	<div class="twitter"><a class="link_exempt" title="{!ADD_TO_TWITTER}" target="_blank" title="{!ADD_TO_TWITTER}: {!LINK_NEW_WINDOW}" onclick="this.setAttribute('href','http://twitter.com/share?count=horizontal&amp;counturl={EASY_SELF_URL;*}&amp;original_referer={EASY_SELF_URL;*}&amp;text='+window.encodeURIComponent(document.title)+'&amp;url={EASY_SELF_URL;*}');" href="http://twitter.com/home?status=RT%20{EASY_SELF_URL*}"></a></div>
	<div class="stumbleupon"><a class="link_exempt" title="{!ADD_TO_STUMBLEUPON}" target="_blank" title="{!ADD_TO_STUMBLEUPON}: {!LINK_NEW_WINDOW}" href="http://www.stumbleupon.com/submit?url={EASY_SELF_URL*}"></a></div>
	<div class="digg"><a class="link_exempt" title="{!ADD_TO_DIGG}" target="_blank" title="{!ADD_TO_DIGG}: {!LINK_NEW_WINDOW}" href="http://digg.com/submit?phase=2&amp;url={EASY_SELF_URL*}"></a></div>
	{+START,IF,{$ADDON_INSTALLED,bookmarks}}
		{$,<div class="favorites"><a class="link_exempt" title="Bookmark this" href="{$FIND_SCRIPT*,bookmarks}?no_redirect=1&amp;type=ad&amp;url={$SELF_URL*&}&amp;title={TITLE*&}" onclick="window.faux_open(maintain_theme_in_link(this.getAttribute('href')),'','width=600,height=500,status=yes,resizable=yes,scrollbars=yes'); return false;"></a></div>}
	{+END}

	<div class="google_plusone">
		<div class="g-plusone" data-size="small" data-count="true" data-href="{EASY_SELF_URL*}"></div>
		{$EXTRA_FOOT,<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>}
	</div>
</div></{$?,{$VALUE_OPTION,html5},aside,div}>
