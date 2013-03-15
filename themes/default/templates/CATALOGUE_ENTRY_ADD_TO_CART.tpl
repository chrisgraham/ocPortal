<div class="float_surrounder">
	<div class="add_to_cart">
		{+START,IF_NON_EMPTY,{ACTION_URL}}
			<div class="purchase_buy">
				<form title="{!ADD_TO_CART}" method="post" action="{ACTION_URL*}">	
					<input class="button_page" {+START,IF,{OUT_OF_STOCK}}onclick="window.fauxmodal_alert('{!OUT_OF_STOCK;}'); return false;" {+END}type="image" src="{$IMG*,page/cart_add}" title="{!ADD_TO_CART}" alt="{!ADD_TO_CART}"/>
					<input type="hidden" id="quantity" name="quantity" value="1" />
					<input type="hidden" name="product_id" value="{PRODUCT_ID*}"/>	
				</form>

				{+START,IF,{$IS_GUEST}}
					<p class="associated_details">{!COOKIES_AS_GUEST}</p>
				{+END}
			</div>
		{+END}

		{$,Re-enable this if you want to be able to buy with bypassing the cart}
		{+START,SET,commented_out}
			{+START,IF_NON_EMPTY,{PURCHASE_ACTION_URL}}
				<div class="purchase_buy">
					<form title="{!BUY_NOW}" method="post" enctype="multipart/form-data" action="{PURCHASE_ACTION_URL*}">
						<input class="button_page" type="image" src="{$IMG*,page/shopping_buy_now}" title="{!BUY_NOW}" alt="{!BUY_NOW}"/>
							{+START,IF,{$EQ,{ALLOW_OPTOUT_TAX},1}}
								<div class="tax_opted_out">
									<input type="checkbox" name="tax_opted_out" id="tax_opted_out" value="1"/>
									<label for="tax_opted_out">{!CUSTOMER_OPTING_OUT_OF_TAX_SHORT}</label>
								</div>
							{+END}
					</form>
				</div>
			{+END}
		{+END}
	</div>
</div>
