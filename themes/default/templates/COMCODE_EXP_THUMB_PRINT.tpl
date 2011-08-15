<div>
	<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode); return false;"><img alt="{!EXPAND}: {!IMAGE}: {TEXT*}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
	<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode); return false;">{!IMAGE}: {TEXT*}</a>
	<div class="hide_tag hide_button_spacing" style="display: {$JS_ON,none,block}">
		{+START,BOX}
			<img title="" alt="{TEXT*}" src="{URL_FULL*}" />
		{+END}
	</div></div><br />

