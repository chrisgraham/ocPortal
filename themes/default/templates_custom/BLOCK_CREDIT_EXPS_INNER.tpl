<label for="product">{LABEL_BUY}</label>
<select name="product" id="product" onchange="update_product_info_display();">
	{+START,LOOP,CREDIT_KINDS}
		<option {+START,IF,{$EQ,{NUM_CREDITS},50}}selected="selected" {+END}value="{NUM_CREDITS*}_CREDITS">{$NUMBER_FORMAT*,{NUM_CREDITS}} credits</option>
	{+END}
</select>

{+START,LOOP,CREDIT_KINDS}
	<div class="creditsinfo" id="info_{NUM_CREDITS*}_CREDITS">
		<p>{!BLOCK_CREDITS_EXP_INNER_MSG,{$NUMBER_FORMAT*,{NUM_CREDITS}},{$COMCODE,[currency="{S_CURRENCY}" bracket="1"]{PRICE}[/currency]}}</p>

		<div class="wide_table_wrap"><table summary="" class="wide_table">
			<tr>
				<th>
					{TH_PRIORITY}
				</th>
				<th>
					{TH_MINUTES}
				</th>
			</tr>
	
			<tr>
				<td>
					{L_B}
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},{B_MINUTES}}}</strong> {MINUTES}
				</td>
			</tr>
	
			<tr>
				<td>
					{L_N}
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},{N_MINUTES}}}</strong> {MINUTES}
				</td>
			</tr>
	
			<tr>
				<td>
					{L_D}
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},{D_MINUTES}}}</strong> {MINUTES}
				</td>
			</tr>
	
			<tr>
				<td>
					{L_H}
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},{H_MINUTES}}}</strong> {MINUTES}
				</td>
			</tr>
	
			<tr>
				<td>
					{L_E}
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},{E_MINUTES}}}</strong> {MINUTES}
				</td>
			</tr>
		</table></div>
	</div>
{+END}

<script type="text/javascript">// <![CDATA[
	function update_product_info_display()
	{
		var product=document.getElementById('product');
		var value=product.options[product.selectedIndex].value;
		var creditsinfo=get_elements_by_class_name(document.body,'creditsinfo');
		for (var i=0;i<creditsinfo.length;i++)
		{
			creditsinfo[i].style.display=(creditsinfo[i].id=='info_'+value)?'block':'none';
		}
	}
	update_product_info_display();
//]]></script>
