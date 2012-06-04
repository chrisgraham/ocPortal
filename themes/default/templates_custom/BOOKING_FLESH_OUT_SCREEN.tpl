{TITLE}

<p>{!BOOKING_FLESH_OUT}</p>

<script type="text/javascript">// <![CDATA[
	function recalculate_price(form)
	{
		var post='',value,type;
		for (var i=0;i<form.elements.length;i++)
		{
			if (!form.elements[i].name) continue;
			value='';
			type=form.elements[i].nodeName.toLowerCase();
			if (type=='input') type=form.elements[i].type;
			switch (type)
			{
				case 'hidden':
				case 'text':
				case 'textarea':
					value=form.elements[i].value;
					break;
				case 'select':
					value=form.elements[i].options[form.elements[i].selectedIndex].value;
					break;
			}
			post+=form.elements[i].name+'='+window.encodeURIComponent(value)+'&';
		}
		setInnerHTML(document.getElementById('price'),escape_html(do_ajax_request('{$FIND_SCRIPT;,booking_price_ajax}'+keep_stub(true),null,post).responseText));
	}
//]]></script>

<form action="{POST_URL*}" method="post">
	<div>
		{HIDDEN}

		{+START,LOOP,BOOKABLES}
			{+START,IF,{$OR,{BOOKABLE_SUPPORTS_NOTES},{$IS_NON_EMPTY,{BOOKABLE_SUPPLEMENTS}}}}
				<h2>{BOOKABLE_TITLE*}</h2>

				{+START,IF,{BOOKABLE_SUPPORTS_NOTES}}
					{+START,INCLUDE,BOOKABLE_NOTES}{+END}
				{+END}

				{+START,LOOP,BOOKABLE_SUPPLEMENTS}
					<div style="padding-left: 50px">
						<p>
							<label for="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity">
								<h3>{SUPPLEMENT_TITLE*} ({!OPTIONAL_SUPPLEMENT})</h3>

								{+START,IF,{SUPPLEMENT_SUPPORTS_QUANTITY}}
									{!QUANTITY}

									<select onchange="recalculate_price(this.form);" id="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity" name="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity">
										{$SET,quantity,0}
										{+START,WHILE,{$LT,{$GET,quantity},51}}
											<option {+START,IF,{$EQ,{SUPPLEMENT_QUANTITY},{$GET,quantity}}}selected="selected" {+END}value="{$GET*,quantity}">{$NUMBER_FORMAT*,{$GET,quantity}}</option>
											{$INC,quantity}
										{+END}
									</select>
								{+END}

								{+START,IF,{$NOT,{SUPPLEMENT_SUPPORTS_QUANTITY}}}
									{!I_WANT_THIS}

									<input{+START,IF,{$GT,{SUPPLEMENT_QUANTITY},0}} checked="checked"{+END} onchange="recalculate_price(this.form);" type="checkbox" id="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity" name="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity" value="1" />
								{+END}
							</label>
						</p>

						{+START,IF,{SUPPLEMENT_SUPPORTS_NOTES}}
							<p>
								<label for="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_notes">
									{!NOTES_FOR_US}<br />
									<textarea cols="50" rows="1" id="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_notes" name="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_notes">{SUPPLEMENT_NOTES*}</textarea>
								</label>
							</p>
						{+END}
					</div>
				{+END}
			{+END}
		{+END}
	</div>

	<hr class="spaced_rule" />

	{+START,IF,{$JS_ON}}
		{+START,BOX,,,curved}
			<strong>{!PRICE_AUTO_CALC}:</strong> {$CURRENCY_SYMBOL} <span id="price">{PRICE*}</span>
		{+END}
	{+END}

	<p class="proceed_button">
		<input class="button_page" type="submit" value="{$?,{$IS_GUEST},{!PROCEED},{!BOOK}}" />
	</p>
</form>

{+START,IF,{$JS_ON}}
	<form action="{BACK_URL*}" method="post">
		<div>
			{HIDDEN}
			<input type="image" title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" / /></p>
		</div>
	</form>
{+END}
