{+START,BOX,Tips,,,tray_open,,,1,}
	<!--<div class="standardbox_wrap_classic tips_wrap">-->
	<div class="standardbox_classic">
		<div class="standardbox_main_classic">
			<p>
				{TIP}
			</p>
			<div class="tips_trail">
				{+START,IF_NON_EMPTY,{TIP_CODE}}
					<p class="community_block_tagline">
						{+START,IF,{$RUNNING_SCRIPT,staff_tips}}
							[ <a href="{$FIND_SCRIPT*,staff_tips}?dismiss={TIP_CODE*}{$KEEP*}">{!DISMISS_TIP}</a> | <a accesskey="k" href="{$FIND_SCRIPT*,staff_tips}{$KEEP*}">{!ANOTHER_TIP}</a> ]
						{+END}
						{+START,IF,{$NOT,{$RUNNING_SCRIPT,staff_tips}}}
							[ <a href="{$PAGE_LINK*,adminzone:start:dismiss={TIP_CODE}}">{!DISMISS_TIP}</a> | <a accesskey="k" href="{$PAGE_LINK*,adminzone:start}">{!ANOTHER_TIP}</a> ]
						{+END}
					</p>
				{+END}
			</div>
		</div>
	</div>
{+END}
