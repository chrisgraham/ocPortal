<div>
	<h2 onclick="event.returnValue=false; hideTag(this.parentNode); return false;">
		<a class="hide_button right" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}: {!OCGIFTS_TITLE}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>

		{!OCGIFTS_TITLE}
	</h2>
	<div class="hide_tag" style="display: {$JS_ON,none,block}">
		{+START,LOOP,GIFTS}
			{+START,BOX}
				{+START,IF_NON_EMPTY,{IMAGE_URL}}
					<img src="{$THUMBNAIL*,{IMAGE_URL},50}" style="margin: 0 5px 5px 0; float: left;" />
				{+END}

				<div>
					{GIFT_EXPLANATION}
				</div>

				{+START,IF_NON_EMPTY,{GIFT_URL}}
					<p class="right">
						<span class="associated_details">(<a href="{GIFT_URL*}">{!SEE_MORE}</a>)</span>
					</p>
				{+END}
			{+END}
		{+END}
			
		{+START,IF_EMPTY,{GIFTS}}
			<p class="nothing_here">
				<span class="ocf_member_detailer_titler">{!NO_GIFTS_TO_DISPLAY}</span>
			</p>
		{+END}
	</div>
</div>
