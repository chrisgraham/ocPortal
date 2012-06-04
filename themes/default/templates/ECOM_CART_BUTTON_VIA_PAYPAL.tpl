<form title="{!MAKE_PAYMENT}" class="right" action="{IPN_URL*}" method="post">
	<input type="hidden" name="cmd" value="_cart" />
	<input type="hidden" name="upload" value="1" />
	<input type="hidden" name="business" value="{PAYMENT_ADDRESS*}" />
	<input type="hidden" name="return" value="{$PAGE_LINK*,_SEARCH:shopping:finish:from=paypal}" />
	<input type="hidden" name="notify_url" value="{$FIND_SCRIPT*,ecommerce}?from=paypal" />
	<input type="hidden" name="no_shipping" value="0" />
	<input type="hidden" name="cancel_return" value="{$PAGE_LINK*,_SEARCH:shopping:finish:cancel=1:from=paypal}" />
	<input type="hidden" name="currency_code" value="{CURRENCY*}" />
	<input type="hidden" name="custom" value="{ORDER_ID*}" />
	<input type="hidden" name="rm" value="2" />

	{+START,IF_NON_EMPTY,{MEMBER_ADDRESS}}
		<!-- <input type="hidden" name="address_override" value="1" /> -->
		{+START,LOOP,MEMBER_ADDRESS}
			{+START,IF_NON_EMPTY,{_loop_key*}}
				<input type="hidden" name="{_loop_key*}" value="{_loop_var*}" />
			{+END}
		{+END}
	{+END}

	{+START,LOOP,ITEMS}
		<input type="hidden" name="item_name_{$ADD*,1,{_loop_key}}" value="{PRODUCT_NAME*}" />
		<input type="hidden" name="amount_{$ADD*,1,{_loop_key}}" value="{PRICE*}" />
		<input type="hidden" name="quantity_{$ADD*,1,{_loop_key}}" value="{QUANTITY*}" />
	{+END}

	<p class="purchase_button">
		<input class="button_page" type="image" src="{$IMG*,page/cart_checkout}" name="submit" alt="{!PROCEED}" title="{!PROCEED}" />
	</p>	
</form>

{+START,IF_NON_EMPTY,{NOTIFICATION_TEXT}}
	<div class="checkout_text">{NOTIFICATION_TEXT}</div>
{+END}
