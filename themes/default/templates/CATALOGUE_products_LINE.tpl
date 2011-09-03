<div class="catalogue_product_box"><div class="catalogue_product_box_inner">
	{+START,BOX,<span class="name">{FIELD_0}</span>,,med}
		<div class="product-list">
			{+START,IF_NON_EMPTY,{FIELD_7_THUMB}}
				<div class="product-image-box">
					<a href="{VIEW_URL*}" class="product-image">{FIELD_7_THUMB}</a>
				</div>
			{+END}
			<div class="ratings">
				<span class="ratings">{RATING}</span>
			</div>
			<div class="price-box">
				<span class="price">{$CURRENCY_SYMBOL}{$FLOAT_FORMAT,{FIELD_2}}</span>
			</div>
			<div class="actions">
				<a href="{ADD_TO_CART*}"><img class="button_pageitem action-image" src="{$IMG*,pageitem/cart_add}" title="{!ADD_TO_CART}" alt="{!ADD_TO_CART}"/></a>
				<a href="{VIEW_URL*}"><img class="button_pageitem action-image" src="{$IMG*,pageitem/goto}" title="{!GO_FOR_IT}" alt="{!GO_FOR_IT}"/></a>			
			</div>
		</div>
	{+END}
</div></div>
