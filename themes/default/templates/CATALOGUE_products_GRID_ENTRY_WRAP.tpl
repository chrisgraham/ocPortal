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
		<span class="price">{$CURRENCY_SYMBOL}{$FLOAT_FORMAT,{FIELD_2}}</span>
	</div>

	<div class="buttons_group">
		<a class="buttons__cart_add button_pageitem" href="{ADD_TO_CART*}"><span>{!ADD_TO_CART}</span></a>
		<a class="buttons__goto button_pageitem" href="{VIEW_URL*}"><span>{!GO_FOR_IT}</span></a>			
	</div>
</div></section>
