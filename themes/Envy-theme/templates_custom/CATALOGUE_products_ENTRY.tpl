{CART_LINK}

{+START,BOX,,,med}
	<div class="hproduct">
		<div class="float_surrounder">
			<div class="product-view">
				<div class="product-main-info">
					{+START,IF_NON_EMPTY,{FIELD_1}}
						<p class="product-ids sku">{!PRODUCT_CODE} {FIELD_1}{$,Product code}</p>
					{+END}
					{+START,IF_NON_EMPTY,{FIELD_0}}
						<div class="product-name">
							<h2 class="fn">{FIELD_0}{$,Product name}</h2>
						</div>
					{+END}
					{+START,IF_NON_EMPTY,{FIELD_9}}
						<div class="description">
							{FIELD_9}{$,Product description}
						</div>
					{+END}
					{+START,IF_NON_EMPTY,{FIELD_2}}
						<div class="price-box">
							<span class="price">{!PRICE} {$CURRENCY_SYMBOL}{FIELD_2}{$,Product price}</span>
						</div>
					{+END}
					{+START,IF_NON_EMPTY,{$TRIM,{RATING}}}
						<div class="rating">
							<span class="price">{!RATING} {RATING}{$,Product rating}</span>
						</div>
					{+END}
				</div>
			</div>

			{+START,IF_NON_EMPTY,{FIELD_7_THUMB}}
				<div class="product-img-box">
					<a class="link_exempt" href="{$BASE_URL*}/{FIELD_7_PLAIN*}" target="_blank" title="{!LINK_NEW_WINDOW}">{$TRIM,{FIELD_7_THUMB}}</a>
				</div>
			{+END}
		</div>

		<div class="wide_table_wrap">
			<table id="product-attribute-specs-table" class="data-table wide_table solidborder" summary="{!MAP_TABLE}">
				<colgroup>
					<col width="30%"/>
					<col width="70%"/>
				</colgroup>

				<tbody>
					{FIELDS}
				</tbody>
			</table>
		</div>

		{CART_BUTTONS}
	</div>
{+END}
