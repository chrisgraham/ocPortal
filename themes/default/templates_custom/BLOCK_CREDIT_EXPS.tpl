<label for="product">Buy</label>
<select name="product" id="product" onchange="update_product_info_display();">
	{+START,LOOP,CREDIT_KINDS}
		<option {+START,IF,{$EQ,{NUM_CREDITS},50}}selected="selected" {+END}value="{NUM_CREDITS*}CREDITS">{$NUMBER_FORMAT*,{NUM_CREDITS}} credits</option>
	{+END}
</select>

{+START,LOOP,CREDIT_KINDS}
	<div class="creditsinfo" id="info_{NUM_CREDITS*}CREDITS">
		<p><strong>{$NUMBER_FORMAT*,{NUM_CREDITS}}</strong> credits currently cost {$COMCODE,[currency="GBP" bracket="1"]{PRICE}[/currency]} &dagger;&dagger; and are good for:</p>

		<div class="wide_table_wrap"><table summary="" class="wide_table">
			<tr>
				<th>
					Priority level
				</th>
				<th>
					Number of minutes
				</th>
			</tr>
	
			<tr>
				<td>
					Budget priority
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},10}}</strong> minutes
				</td>
			</tr>
	
			<tr>
				<td>
					Normal priority
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},8}}</strong> minutes
				</td>
			</tr>
	
			<tr>
				<td>
					Day priority
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},7}}</strong> minutes
				</td>
			</tr>
	
			<tr>
				<td>
					High priority
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},5}}</strong> minutes
				</td>
			</tr>
	
			<tr>
				<td>
					Emergencies
				</td>
				<td>
					<strong>{$NUMBER_FORMAT*,{$MULT,{NUM_CREDITS},3}}</strong> minutes
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
