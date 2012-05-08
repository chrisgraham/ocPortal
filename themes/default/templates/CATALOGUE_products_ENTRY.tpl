{CART_LINK}

{+START,BOX,,,light}
	<div class="hproduct"{$?,{$AND,{$MATCH_KEY_MATCH,_WILD:_WILD:misc},{$VALUE_OPTION,html5}}, itemscope="itemscope" itemtype="http://schema.org/Offer"}>
		<div class="float_surrounder">
			{+START,IF_NON_EMPTY,{FIELD_7_THUMB}}
				<p class="product-img-box">
					<a rel="lightbox" class="link_exempt" href="{+START,IF,{$NOT,{$IN_STR,{FIELD_7_PLAIN},://}}}{$BASE_URL*}/{+END}{FIELD_7_PLAIN*}" target="_blank" alt="{FIELD_0}" title="{!LINK_NEW_WINDOW}"{$?,{$VALUE_OPTION,html5}, itemprop="image"}>{$TRIM,{FIELD_7_THUMB}}</a>
				</p>
			{+END}

			<div class="product-view">
				<div class="product-main-info">
					{+START,IF_NON_EMPTY,{FIELD_0}}
						<div class="accessibility_hidden product-name">
							<h2 class="fn"{$?,{$VALUE_OPTION,html5}, itemprop="itemOffered"}>{FIELD_0}{$,Product name}</h2>
						</div>
					{+END}
					{+START,IF_NON_EMPTY,{FIELD_1}}
						<p class="product-ids sku">{!PRODUCT_CODE} {FIELD_1}{$,Product code}</p>
					{+END}
					{+START,IF_NON_EMPTY,{FIELD_9}}
						<div class="description"{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
							{FIELD_9}{$,Product description}
						</div>
					{+END}
					{+START,IF_NON_EMPTY,{FIELD_2}}
						<div class="price-box">
							<span>{!PRICE} <span{$?,{$VALUE_OPTION,html5}, itemprop="priceCurrency"}>{$CURRENCY_SYMBOL}</span><span class="price"{$?,{$VALUE_OPTION,html5}, itemprop="price"}>{$FLOAT_FORMAT,{FIELD_2}}</span>{$,Product price}</span>
						</div>
					{+END}
				</div>
			</div>
		</div>

		{+START,IF_NON_EMPTY,{$TRIM,{FIELDS}}}
			<div class="wide_table_wrap">
				<table id="product-attribute-specs-table" class="data-table wide_table solidborder" summary="{!MAP_TABLE}">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col style="width: 30%"/>
							<col style="width: 70%"/>
						</colgroup>
					{+END}

					<tbody>
						{FIELDS}
					</tbody>
				</table>
			</div>
		{+END}

		{CART_BUTTONS}
	</div>
{+END}
