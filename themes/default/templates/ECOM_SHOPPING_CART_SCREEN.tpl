{TITLE}

<form title="{!PRIMARY_PAGE_FORM}" action="{FORM_URL*}" method="post" itemscope="itemscope" itemtype="http://schema.org/CheckoutPage">
	<h2>{!CART_HEADING}</h2>

	{RESULTS_TABLE}

	{+START,IF_NON_EMPTY,{PRO_IDS}}
		{+START,IF,{$EQ,{ALLOW_OPTOUT_TAX},1}}
			<div class="checkout_text">
				<input type="checkbox" name="tax_opted_out" id="tax_opted_out" value="1"{+START,IF,{$EQ,{ALLOW_OPTOUT_TAX_VALUE},1}} checked="true"{+END} />
				<label for="tax_opted_out">{!CUSTOMER_OPTING_OUT_OF_TAX}</label>
			</div>
		{+END}
	{+END}

	<div class="buttons_group" itemprop="significantLinks">
		{$,Put first, so it associates with the enter key}
		{+START,IF_NON_EMPTY,{PRO_IDS}}
			<input class="button_page" type="image" name="update" src="{$IMG*,page/cart_update}" onclick="return update_cart('{PRO_IDS;*}');" alt="{!UPDATE}" title="{!UPDATE}"/>
		{+END}

		{+START,IF_NON_EMPTY,{EMPTY_CART*}}
			<input class="button_page" type="image" src="{$IMG*,page/cart_empty}" onclick="return confirm_empty('{!EMPTY_CONFIRM}','{EMPTY_CART;*}',this.form);" alt="{!EMPTY_CART}" title="{!EMPTY_CART}"/>
		{+END}

		<input type="hidden" name="product_ids" id="product_ids" value="{PRO_IDS*}"/>

		{+START,IF_NON_EMPTY,{CONT_SHOPPING}}
			<a href="{CONT_SHOPPING*}"><img class="button_page" src="{$IMG*,page/shopping_continue}" alt="{!CONTINUE_SHOPPING}" title="{!CONTINUE_SHOPPING}"/></a>
		{+END}
	</div>
</form>

{PROCEED_BOX}
