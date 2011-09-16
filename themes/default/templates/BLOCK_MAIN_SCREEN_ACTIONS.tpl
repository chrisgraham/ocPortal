<{$?,{$VALUE_OPTION,html5},aside,div} class="medborder_box medborder" id="screen_actions_outer"><div id="screen_actions">
	<div class="print"><a rel="print nofollow" target="_blank" title="{!PRINT_THIS_SCREEN}: {!LINK_NEW_WINDOW}" href="{PRINT_URL*}">{!PRINT_THIS_SCREEN}</a></div>
	<div class="recommend"><a rel="nofollow" target="_blank" title="{!OCP_RECOMMEND}: {!LINK_NEW_WINDOW}" href="{RECOMMEND_URL*}">{!OCP_RECOMMEND}</a></div>
	{+START,IF,{$BROWSER_MATCHES,ie}}
		<div class="favorites"><a href="#" onclick="window.external.AddFavorite(window.location.href,document.title); return false;">{!ADD_TO_FAVORITES}</a></div>
	{+END}
	<div class="facebook"><a target="_blank" title="{!ADD_TO_FACEBOOK}: {!LINK_NEW_WINDOW}" href="http://www.facebook.com/sharer.php?u={EASY_SELF_URL*}">{!ADD_TO_FACEBOOK}</a></div>
	<div class="twitter"><a target="_blank" title="{!ADD_TO_TWITTER}: {!LINK_NEW_WINDOW}" onclick="this.setAttribute('href','http://twitter.com/share?count=horizontal&amp;counturl={EASY_SELF_URL;*}&amp;original_referer={EASY_SELF_URL;*}&amp;text='+window.encodeURIComponent(document.title)+'&amp;url={EASY_SELF_URL;*}');" href="http://twitter.com/home?status=RT%20{EASY_SELF_URL*}">{!ADD_TO_TWITTER}</a></div>
	{$,<div class="stumbleupon"><a target="_blank" title="{!ADD_TO_STUMBLEUPON}: {!LINK_NEW_WINDOW}" href="http://www.stumbleupon.com/submit?url={EASY_SELF_URL*}">{!ADD_TO_STUMBLEUPON}</a></div>}
	{$,<div class="digg"><a target="_blank" title="{!ADD_TO_DIGG}: {!LINK_NEW_WINDOW}" href="http://digg.com/submit?phase=2&amp;url={EASY_SELF_URL*}">{!ADD_TO_DIGG}</a></div>}
	{$,<div class="favorites"><a href="{$FIND_SCRIPT*,bookmarks}?no_redirect=1&amp;type=ad&amp;url={$SELF_URL*&}&amp;title={TITLE*&}" onclick="window.open(maintain_theme_in_link(this.getAttribute('href')),'','width=600,height=500,status=yes,resizable=yes,scrollbars=yes'); return false;">Bookmark this</a></div>}
</div></{$?,{$VALUE_OPTION,html5},aside,div}>
