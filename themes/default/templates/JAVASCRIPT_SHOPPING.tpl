"use strict";

function update_cart(pro_ids)
{	
	var pro_ids_array	=	pro_ids.split(",");

	var tot			=	pro_ids_array.length;	

	for(var i=0; i<tot; i++)
	{	
		var quantity_data = 'quantity_'+pro_ids_array[i];

		var qval = document.getElementById(quantity_data).value;

		if(isNaN(qval))
		{
			alert('{!CART_VALIDATION_REQUIRE_NUMBER^;}');
			return false;
		}
	}	
}

function confirm_empty(message,action_url,form)
{	
	if(confirm(message)) 
	{
		form.action=action_url;
		return true;
	} else 
	{
		return false;
	}
}

function checkout(form_name,checkout_url)
{	
	form=document.getElementById(form_name);	
	form.action=checkout_url;
	form.submit();
	return true;
}

function confirm_admin_order_actions(action_event)
{
	if(action_event=='dispatch')
	{
		if(!confirm('{!DISPATCH_CONFIRMATION_MESSAGE^;}')) 
		{
			return false;
		}
	}
	if(action_event=='del_order')
	{
		if(!confirm('{!CANCEL_ORDER_CONFIRMATION_MESSAGE^;}')) 
		{
			return false;
		}
	}
	return true;
}
