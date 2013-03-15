<figure>
	<object width="{A_WIDTH|}" height="{A_HEIGHT|}" type="application/x-shockwave-flash" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
		<param name="movie" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
		<param name="quality" value="high" />
		<param name="pluginspage" value="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" />

		<!--[if !IE]> -->
			<object width="{A_WIDTH|}" height="{A_HEIGHT|}" data="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" type="application/x-shockwave-flash">
				<param name="movie" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
				<param name="quality" value="high" />
				<param name="pluginspage" value="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" />

				{!ANIMATION}; {A_DESCRIPTION}
			</object>
		<!-- <![endif]-->
	</object>

	{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
		<figcaption class="associated_details">
			{A_DESCRIPTION}
		</figcaption>
	{+END}
</figure>
