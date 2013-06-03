<div>
	<h2>
		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {!OCGIFTS_TITLE}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
		<span onclick="return toggleable_tray(this.parentNode.parentNode);">{!OCGIFTS_TITLE}</span>
	</h2>

	{$REQUIRE_CSS,gifts}

	<div class="toggleable_tray" style="display: {$JS_ON,none,block}" aria-expanded="false">
		{+START,LOOP,GIFTS}
			<div class="box box___ocf_member_screen_gifts_wrap"><div class="box_inner">
				<div class="float_surrounder">
					{+START,IF_NON_EMPTY,{IMAGE_URL}}
						<img src="{$THUMBNAIL*,{IMAGE_URL},50}" class="left float_separation" />
					{+END}

					{GIFT_EXPLANATION}
				</div>
			</div></div>
		{+END}

		{+START,IF_EMPTY,{GIFTS}}
			<p class="nothing_here">
				<span class="ocf_member_detailer_titler">{!NO_GIFTS_TO_DISPLAY}</span>
			</p>
		{+END}
	</div>
</div>
