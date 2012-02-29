<blockquote class="comcode_hide">
	<div>
		<h4 class="comcode_quote_h4">
			<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}: {$STRIP_TAGS,{TEXT}}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			
			<a class="hide_button non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">{TEXT}</a>
		</h4>
		<div class="hide_tag" style="display: {$JS_ON,none,block}"{$?,{$VALUE_OPTION,html5}, aria-expanded="false"}>
			<div class="comcode_quote_content comcode_quote_content_titled"><div class="float_surrounder">
				{CONTENT}
			</div></div>
		</div>
	</div>
</blockquote>
