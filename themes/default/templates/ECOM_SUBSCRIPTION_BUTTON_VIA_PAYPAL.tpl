<form title="{!MAKE_PAYMENT}" class="left" action="{IPN_URL*}" method="post">
	<input type="hidden" name="cmd" value="_xclick-subscriptions" />
	<input type="hidden" name="business" value="{PAYMENT_ADDRESS*}" />
	<input type="hidden" name="notify_url" value="{$FIND_SCRIPT*,ecommerce}?from=paypal&amp;product={PRODUCT*}" />
	<input type="hidden" name="no_shipping" value="1" />
	<input type="hidden" name="return" value="{$PAGE_LINK*,_SEARCH:purchase:finish:product={PRODUCT}:from=paypal}" />
	<input type="hidden" name="cancel_return" value="{$PAGE_LINK*,_SEARCH:purchase:finish:cancel=1:from=paypal}" />
	<input type="hidden" name="currency_code" value="{CURRENCY*}" />
	<input type="hidden" name="custom" value="{PURCHASE_ID*}" />
	<input type="hidden" name="a3" value="{AMOUNT*}" />
	<input type="hidden" name="p3" value="{LENGTH*}" />
	<input type="hidden" name="t3" value="{$UCASE*,{LENGTH_UNITS}}" />
	<input type="hidden" name="src" value="1" />
	<input type="hidden" name="sra" value="1" />
	<input type="hidden" value="1" name="no_note" />
	<input type="hidden" value="{!SUBSCRIPTION_FOR,{$USERNAME}}" name="item_name" />
	<input type="hidden" name="rm" value="2" />

	<div class="purchase_button">
		<input style="border: 0px" class="button_page" type="image" src="https://www.paypal.com/en_US/i/btn/x-click-but23.gif" name="submit" alt="Make payments with PayPal - it's fast, free and secure!" />
	</div>
</form>

