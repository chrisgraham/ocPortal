<li class="catalogue_product_box news1">
	{+START,BOX,,,curved}
		<div class="product_list">
			{+START,IF_NON_EMPTY,{FIELD_7_THUMB}}
				<div class="entry_box_thumbnail">
					<a title="" class="product_image">{FIELD_7_THUMB}</a>
				</div>
				
			{+END}
			<div class="name">
				<span class="name">{FIELD_0}</span>
			</div>
			<div class="ratings">
				<span class="ratings">{RATING}</span>
			</div>
			<div class="price_box">
				<span class="price">{$CURRENCY_SYMBOL}{FIELD_2}</span>
			</div>
			<div class="actions">
				<a href="{ADD_TO_CART*}"><img class="button_pageitem action_image" src="{$IMG*,pageitem/cart_add}" title="{!ADD_TO_CART}" alt="{!ADD_TO_CART}"/></a>
				<a href="{VIEW_URL*}"><img class="button_pageitem action_image" src="{$IMG*,pageitem/goto}" title="{!GO_FOR_IT}" alt="{!GO_FOR_IT}"/></a>			
			</div>
		</div>
	{+END}
</li>
