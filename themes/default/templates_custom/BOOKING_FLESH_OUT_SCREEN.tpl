{TITLE}

<script type="text/javascript">// <![CDATA[
	function recalculate_price(form)
	{
		var post='',value,type;
		for (var i=0;i<form.elements.length;i++)
		{
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
			post+=form.elements[i].name+'='+window.encodeURIComponent(value);
		}
		load_XML_doc('{$FIND_SCRIPT;,booking_price_ajax}'+keep_stub(),function(ajax_result_frame,ajax_result) { document.getElementById('price')=ajax_result_frame.responseText; },post);
	}
//]]></script>

<form action="{POST_URL*}" method="post">
	<div>
		{HIDDEN}

		{+START,LOOP,BOOKABLES}
			{+START,IF,{$OR,{BOOKABLE_SUPPORTS_NOTES},{$IS_NON_EMPTY,{BOOKABLE_SUPPLEMENTS}}}}
				<h2>{BOOKABLE_TITLE*}</h2>

				{+START,IF,{BOOKABLE_SUPPORTS_NOTES}}
					<label for="bookable_{BOOKABLE_ID*}_notes">
						{!NOTES_FOR_US}:<br />
						<textarea id="bookable_{BOOKABLE_ID*}_notes" name="bookable_{BOOKABLE_ID*}_notes">{BOOKABLE_NOTES*}</textarea>
					</label>
				{+END}

				{+START,LOOP,{BOOKABLE_SUPPLEMENTS}}
					<label for="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity">
						{SUPPLEMENT_TITLE*}

						{+START,IF,{SUPPLEMENT_SUPPORTS_QUANTITY}}
							<select onchange="recalculate_price(this.form);" id="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity" name="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity">
								{+START,LOOP,{BOOKABLE_QUANTITY}}
									<option value="{_loop_var*}"{+START,IF,{$EQ,{SUPPLEMENT_QUANTITY},{_loop_var}}} selected="selected"{+END}>{$INTEGER_FORMAT*,{_loop_var}}</option>
								{+END}
							</select>
						{+END}

						{+START,IF,{$NOT,{SUPPLEMENT_SUPPORTS_QUANTITY}}}
							<input{+START,IF,{$GTE,{SUPPLEMENT_QUANTITY},1}} checked="checked"{+END} onchange="recalculate_price(this.form);" type="checkbox" id="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity" name="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_quantity" value="1" />
						{+END}
					</label>
				
					{+START,IF,{SUPPLEMENT_SUPPORTS_NOTES}}
						<label for="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_notes">
							{!NOTES_FOR_US}:<br />
							<textarea id="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_notes" name="bookable_{BOOKABLE_ID*}_supplement_{SUPPLEMENT_ID*}_notes">{SUPPLEMENT_NOTES*}</textarea>
						</label>
					{+END}
				{+END}
			{+END}
		{+END}
	</div>
</form>

{+START,IF,{$JS_ON}}
	<p>
		<strong>{!PRICE}:</strong> <span id="price">{PRICE*}</span>
	</p>
{+END}

{+START,IF,{$JS_ON}}
	<form action="{BACK_URL*}" method="post">
		<div>
			{HIDDEN}
			<input type="image" title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" / /></p>
		</div>
	</form>
{+END}
