{$JAVASCRIPT_INCLUDE,javascript_galleries}
{$JAVASCRIPT_INCLUDE,javascript_ajax}

{+START,BOX,,,med}
	<div class="left">
		{+START,IF_NON_EMPTY,{NEXT_LINK}}
			<a {+START,IF,{$_GET,slideshow}}onclick="return slideshow_backward();" {+END}rel="prev" accesskey="j" href="{NEXT_LINK*}"><img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/previous}" /></a>
		{+END}
		{+START,IF_EMPTY,{NEXT_LINK}}
			<img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/no_previous}" />
		{+END}
	</div>

	<div class="right">
		{+START,IF_NON_EMPTY,{SLIDESHOW_LINK}}
			{+START,IF,{$_GET,slideshow}}
				<input type="hidden" id="next_slide" name="next_slide" value="{SLIDESHOW_NEXT_LINK*}" />
			{+END}
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$JS_ON}}{+START,IF,{$NOT,{$_GET,slideshow}}}
					<a class="link_exempt" rel="nofollow" target="_blank" title="{!SLIDESHOW}: {!NEW_WINDOW}" href="{SLIDESHOW_LINK*}"><img class="button_page" title="{!SLIDESHOW}" alt="{!SLIDESHOW}" src="{$IMG*,page/slideshow}" /></a>
				{+END}{+END}
			{+END}
		{+END}

		{+START,IF_NON_EMPTY,{PREVIOUS_LINK}}
			<a {+START,IF,{$_GET,slideshow}}onclick="return slideshow_forward();" {+END}rel="next" accesskey="k" href="{PREVIOUS_LINK*}"><img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/next}" /></a>
		{+END}
		{+START,IF_EMPTY,{PREVIOUS_LINK}}
			<img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/no_next}" />
		{+END}
	</div>

	{$,Different positioning of buttons for mobiles, due to limited space}
	{+START,IF_NON_EMPTY,{SLIDESHOW_LINK}}
		{+START,IF,{$MOBILE}}
			{+START,IF,{$JS_ON}}{+START,IF,{$NOT,{$_GET,slideshow}}}
				<div class="right">
					<a class="link_exempt" rel="nofollow" target="_blank" title="{!SLIDESHOW}: {!NEW_WINDOW}" href="{SLIDESHOW_LINK*}"><img class="button_page" title="{!SLIDESHOW}" alt="{!SLIDESHOW}" src="{$IMG*,page/slideshow}" /></a>
				</div>
			{+END}{+END}
		{+END}
	{+END}

	<div class="nav_mid">
		<script type="text/javascript">// <![CDATA[
		addEventListenerAbstract(window,'real_load',function () {
			window.slideshow_current_position={_N%}-{_X%}-1;
			window.slideshow_total_slides={_N%};

			{+START,IF,{$_GET,slideshow}}
				initialise_slideshow();
			{+END}
		} );
		//]]></script>

		{+START,IF,{$_GET,slideshow}}
			{!VIEWING_SLIDE,{X*},{N*}}<br />

			{+START,IF_NON_EMPTY,{SLIDESHOW_NEXT_LINK}}
				<span id="changer_wrap">{!CHANGING_IN,xxx}</span>
			{+END}
			
			{+START,IF_EMPTY,{PREVIOUS_LINK}}
				{!LAST_SLIDE}
			{+END}
		{+END}

		{+START,IF,{$NOT,{$_GET,slideshow}}}
			{!VIEWING_GALLERY_ENTRY,{X*},{N*}}
		{+END}
	</div>
{+END}
