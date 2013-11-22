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
			<input class="buttons__cart_update button_page" type="submit" name="update" onclick="return update_cart('{PRO_IDS;*}');" value="{!UPDATE}"/>
		{+END}

		{+START,IF_NON_EMPTY,{EMPTY_CART_URL*}}
			<input class="buttons__cart_empty button_page" type="submit" onclick="return confirm_empty('{!EMPTY_CONFIRM}','{EMPTY_CART_URL;*}',this.form);" value="{!EMPTY_CART}"/>
		{+END}

		<input type="hidden" name="product_ids" id="product_ids" value="{PRO_IDS*}"/>

		{+START,IF_NON_EMPTY,{CONT_SHOPPING}}
			<a class="menu__rich_content__catalogues__products button_page" href="{CONT_SHOPPING_URL*}"><span>{!CONTINUE_SHOPPING}</span></a>
		{+END}
	</div>
</form>

{PROCEED_BOX}
