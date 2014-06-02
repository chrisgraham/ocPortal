<div itemscope="itemscope" itemtype="http://schema.org/Offer" class="product_view">
	{TITLE}

	{WARNINGS}

	{CART_LINK}

	<div class="box box___catalogue_products_entry_screen"><div class="box_inner">
		<div class="hproduct"{$?,{$MATCH_KEY_MATCH,_WILD:_WILD:misc}, itemscope="itemscope" itemtype="http://schema.org/Offer"}>
			<div class="float_surrounder">
				{+START,IF_NON_EMPTY,{FIELD_7_THUMB}}
					<p class="catalogue_entry_box_thumbnail">
						{$REPLACE, rel="lightbox", rel="lightbox" itemprop="image",{FIELD_7}}
					</p>
				{+END}

				{+START,IF_NON_EMPTY,{FIELD_0}}
					<div class="fn product-name" itemprop="itemOffered">
						{FIELD_0}{$,Product name}
					</div>
				{+END}
				{+START,IF_NON_EMPTY,{FIELD_1}}
					<p class="product-ids sku">{!PRODUCT_CODE} {FIELD_1}{$,Product code}</p>
				{+END}
				{+START,IF_NON_EMPTY,{FIELD_9}}
					<div class="description" itemprop="description">
						{FIELD_9}{$,Product description}
					</div>
				{+END}
				{+START,IF_NON_EMPTY,{FIELD_2}}
					<div class="price_box">
						<span class="price">{!PRICE} <span itemprop="priceCurrency">{$CURRENCY_SYMBOL}</span><span itemprop="price">{$FLOAT_FORMAT,{FIELD_2}}</span>{$,Product price}</span>
					</div>
				{+END}
			</div>

			{+START,IF_NON_EMPTY,{$TRIM,{FIELDS}}}
				<div class="wide_table_wrap">
					<table id="product-attribute-specs-table" class="catalogue_fields_table wide_table results_table" summary="{!MAP_TABLE}">
						{+START,IF,{$NOT,{$MOBILE}}}
							<colgroup>
								<col class="catalogue_fieldmap_field_name_column" />
								<col class="catalogue_fieldmap_field_value_column" />
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
	</div></div>

	<div class="float_surrounder lined_up_boxes">
		{+START,IF_NON_EMPTY,{TRACKBACK_DETAILS}}
			<div class="trackbacks right">
				{TRACKBACK_DETAILS}
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{RATING_DETAILS}}
			<div class="ratings right">
				{RATING_DETAILS}
			</div>
		{+END}
	</div>

	<div itemscope="itemscope" itemtype="http://schema.org/WebPage">
		{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

		{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
		{+START,INCLUDE,STAFF_ACTIONS}
			1_URL={EDIT_URL*}
			1_TITLE={!_EDIT_LINK}
			1_ACCESSKEY=q
			1_REL=edit
		{+END}

		<div class="content_screen_comments">
			{COMMENT_DETAILS}
		</div>
	</div>

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
</div>
