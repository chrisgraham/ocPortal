<div class="gallery_tease_pic_wrap"><div class="gallery_tease_pic">
	{+START,BOX}
		<div class="float_surrounder">
			<div class="left">
				<h3>{TITLE*}</h3>

				<p>
					{!_SUBGALLERY_BITS,{NUM_IMAGES*},{NUM_VIDEOS*},{$NUMBER_FORMAT*,{$ADD,{NUM_VIDEOS},{NUM_IMAGES}}}}
				</p>
				<p class="proceed_button">
					<a href="{URL*}"><img title="{!ENTER}" alt="{!ENTER}" class="button_pageitem" src="{$IMG*,pageitem/goto}" /></a>
				</p>
			</div>
			{+START,IF_NON_EMPTY,{PIC}}
				<div class="gallery_tease_pic_pic">
					{+START,IF_NON_EMPTY,{MEMBER_INFO}}
						<br />
						{+START,BOX,,,light}
						{MEMBER_INFO}
						{+END}
					{+END}
					{+START,IF_EMPTY,{MEMBER_INFO}}
						<a href="{URL*}"><img src="{PIC*}" alt="{TITLE*}" /></a>
					{+END}
				</div>
			{+END}
			{+START,IF_NON_EMPTY,{TEASER}}
				<div class="gallery_tease_pic_teaser">
					{+START,BOX}
						{TEASER}
					{+END}
				</div>
			{+END}
		</div>
	{+END}
</div></div>

