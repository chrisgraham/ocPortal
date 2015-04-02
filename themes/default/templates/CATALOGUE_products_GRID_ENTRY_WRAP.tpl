<section class="box box___catalogue_products_grid_entry_wrap"><div class="box_inner">
	<h3><span class="name">{FIELD_0}</span></h3>

	{+START,IF_NON_EMPTY,{FIELD_7_THUMB}}
		<div class="catalogue_entry_box_thumbnail">
			<a href="{VIEW_URL*}">{FIELD_7_THUMB}</a>
		</div>
	{+END}

	<div class="ratings">
		{RATING}
	</div>

	<div class="price_box">
		<span class="price">{$CURRENCY_SYMBOL}{$FLOAT_FORMAT*,{FIELD_2_PLAIN}}</span>
	</div>

	<div>
		<a href="{ADD_TO_CART*}"><img class="button_pageitem" src="{$IMG*,pageitem/cart_add}" title="{!ADD_TO_CART}" alt="{!ADD_TO_CART}"/></a>
		<a href="{VIEW_URL*}"><img class="button_pageitem" src="{$IMG*,pageitem/goto}" title="{!GO_FOR_IT}" alt="{!GO_FOR_IT}"/></a>			
	</div>
</div></section>
