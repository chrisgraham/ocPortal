{+START,BOX,,,med}
	<div class="left">
		{+START,IF_NON_EMPTY,{NEXT_LINK}}
			<a rel="prev" accesskey="j" href="{NEXT_LINK*}"><img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/previous}" /></a>
		{+END}
		{+START,IF_EMPTY,{NEXT_LINK}}
			<img class="button_page" title="{!PREVIOUS}" alt="{!PREVIOUS}" src="{$IMG*,page/no_previous}" />
		{+END}
		{+START,IF_NON_EMPTY,{SLIDESHOW_NEXT_LINK}}{+START,IF,{$JS_ON}}
			{+START,IF,{$NOT,{$_GET,slideshow}}}
				<a class="link_exempt" rel="nofollow" style="visibility: hidden" target="_blank" title="{!SLIDESHOW}: {!NEW_WINDOW}" href="{SLIDESHOW_LINK*}"><img class="button_page" title="{!SLIDESHOW}" alt="{!SLIDESHOW}" src="{$IMG*,page/slideshow}" /></a>
			{+END}
			{+START,IF,{$_GET,slideshow}}
				<input type="hidden" id="next_slide" name="next_slide" value="{SLIDESHOW_NEXT_LINK*}" /> 
			{+END}
		{+END}{+END}
	</div>
	<div class="right">
		{+START,IF_NON_EMPTY,{PREVIOUS_LINK}}
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$JS_ON}}{+START,IF,{$NOT,{$_GET,slideshow}}}
					<a class="link_exempt" rel="nofollow" target="_blank" title="{!SLIDESHOW}: {!NEW_WINDOW}" href="{SLIDESHOW_LINK*}"><img class="button_page" title="{!SLIDESHOW}" alt="{!SLIDESHOW}" src="{$IMG*,page/slideshow}" /></a>
				{+END}{+END}
			{+END}
			<a rel="next" accesskey="k" href="{PREVIOUS_LINK*}"><img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/next}" /></a>
		{+END}
		{+START,IF_EMPTY,{PREVIOUS_LINK}}
			<img class="button_page" title="{!NEXT}" alt="{!NEXT}" src="{$IMG*,page/no_next}" />
		{+END}
	</div>
	{+START,IF_NON_EMPTY,{PREVIOUS_LINK}}
		{+START,IF,{$MOBILE}}
			{+START,IF,{$JS_ON}}{+START,IF,{$NOT,{$_GET,slideshow}}}
				<div class="right">
					<a class="link_exempt" rel="nofollow" target="_blank" title="{!SLIDESHOW}: {!NEW_WINDOW}" href="{SLIDESHOW_LINK*}"><img class="button_page" title="{!SLIDESHOW}" alt="{!SLIDESHOW}" src="{$IMG*,page/slideshow}" /></a>
				</div>
			{+END}{+END}
		{+END}
	{+END}
	<div class="nav_mid">
		{+START,IF,{$_GET,slideshow}}
			{!VIEWING_SLIDE,{X*},{N*}}<br />

			{+START,IF_NON_EMPTY,{SLIDESHOW_NEXT_LINK}}
				<span id="changer_wrap">{!CHANGING_IN,xxx}</span>

				<script type="text/javascript">// <![CDATA[
					var num_seconds=5; /* Change as needed */

					setInnerHTML(document.getElementById('changer'),num_seconds);

					var timer=window.setInterval(function() {
						num_seconds--;
						setInnerHTML(document.getElementById('changer'),num_seconds);
					
						if (num_seconds==0)
						{
							window.clearInterval(timer);
							window.location=document.getElementById('next_slide').value;
						}
					} ,1000);

					var stop_function=function() {
						setInnerHTML(document.getElementById('changer_wrap'),'{!STOPPED;}');
						window.clearInterval(timer);
					};
					addEventListenerAbstract(window,'keypress',stop_function);
					addEventListenerAbstract(window,'click',stop_function);
				//]]></script>
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
