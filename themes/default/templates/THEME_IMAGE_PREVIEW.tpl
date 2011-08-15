{+START,BOX,{!CURRENT},,med}
	<div class="float_surrounder">
		<img class="theme_image_preview" src="{URL*}" title="" alt="{!THEME_IMAGE}" />

		<p>{!THEME_IMAGE_CURRENTLY_LIKE,{WIDTH*},{HEIGHT*}}</p>

		{+START,IF,{UNMODIFIED}}
			<p>{!THEME_IMAGE_CURRENTLY_UNMODIFIED}</p>
		{+END}
		
		<p>{!RIGHT_CLICK_SAVE_AS}</p>
	</div>
{+END}

