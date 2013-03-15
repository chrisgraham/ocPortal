{TITLE}

{+START,IF_PASSED,PRICE}
	<p>
		{!COST}: <strong>{PRICE}</strong>
	</p>
{+END}
{+START,IF_PASSED,TEXT}
	{$PARAGRAPH,{TEXT}}
{+END}

<form method="post" enctype="multipart/form-data" action="{$PAGE_LINK*,_SELF:_SELF:uploading=1}">
	 <div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="autosized_table results_table wide_table"><tbody>
		  {+START,IF_PASSED,ITEMS}
			  <tr>
					<th>{!NAME}</th>
					<td>
						<label class="accessibility_hidden" for="name">{!NAME}</label>
						<select name="name" id="name">
							{ITEMS}
						</select>
					</td>
					<td>Select a pre-existing item to replicate</td>
			  </tr>
		  {+END}
		  <tr>
				<th>{!W_NOT_INFINITE}</th>
				<td>
					<label class="accessibility_hidden" for="not_infinite">{!W_NOT_INFINITE}</label>
					{+START,IF,{NOT_INFINITE}}
						<input type="checkbox" checked="checked" name="not_infinite" id="not_infinite" value="1" />
					{+END}
					{+START,IF,{$NOT,{NOT_INFINITE}}}
						<input type="checkbox" name="not_infinite" id="not_infinite" value="1" />
					{+END}
				</td>
				<td>{!W_EG_NOT_INFINITE}</td>
		  </tr>
		  <tr>
				<th>{!COST}</th>
				<td><label class="accessibility_hidden" for="cost">{!COST}</label><input type="text" name="cost" id="cost" value="{COST*}" /></td>
				<td>{!W_EG_ITEM_COPY_COST}</td>
		  </tr>
		  {+START,IF_PASSED,X}{+START,IF_PASSED,Y}{+START,IF_PASSED,REALM}
			  <tr>
					<th>X</th>
					<td><label class="accessibility_hidden" for="new_x">X</label><input type="text" size="20" id="new_x" name="new_x" value="{X*}" /></td>
					<td>{!W_EG_MOVE_X}</td>
			  </tr>
			  <tr>
					<th>Y</th>
					<td><label class="accessibility_hidden" for="new_y">Y</label><input type="text" size="20" id="new_y" name="new_y" value="{Y*}" /></td>
					<td>{!W_EG_MOVE_X}</td>
			  </tr>
			  <tr>
					<th>{!W_REALM}</th>
					<td><label class="accessibility_hidden" for="new_realm">{!W_REALM}</label><input type="text" size="20" id="new_realm" name="new_realm" value="{REALM*}" /></td>
					<td>{!W_EG_MOVE_X}</td>
			  </tr>
		  {+END}{+END}{+END}
		  {+START,IF_PASSED,OWNER}
			  <tr>
					<th>{!OWNER}</th>
					<td><label class="accessibility_hidden" for="new_owner">{!OWNER}</label><input type="text" size="20" id="new_owner" name="new_owner" value="{OWNER*}" /></td>
					<td>{!W_EG_OWNER}</td>
			  </tr>
		  {+END}
	 </tbody></table></div>

	 <input type="hidden" name="type" value="{PAGE_TYPE*}" />
	 {+START,IF_PASSED,ITEM}
		 <input type="hidden" name="item" value="{ITEM*}" />
	 {+END}
	 {+START,IF_PASSED,USER}
		 <input type="hidden" name="user" value="{USER*}" />
	 {+END}

	 <p class="proceed_button">
		 <input class="button_page" type="submit" value="{!PROCEED}" />
	 </p>
</form>

