{TITLE}

{+START,IF_PASSED,PRICE}
	<p>
		{!COST}: <strong>{PRICE}</strong>
	</p>
{+END}
{+START,IF_PASSED,TEXT}
	<div>
		{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}</p>{+END}
	</div>
{+END}

<p>{!W_ABOUT_PORTALS}</p>

<form method="post" enctype="multipart/form-data" action="{$PAGE_LINK*,_SELF:_SELF}">
	 <input type="hidden" name="type" value="{PAGE_TYPE*}" />
	 {+START,IF_PASSED,PARAM}
		 <input type="hidden" name="param" value="{PARAM*}" />
	 {+END}

	 <div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="variable_table solidborder wide_table"><tbody>
		  <tr>
				<th>{!NAME}</th>
				<td><label class="accessibility_hidden" for="name">{!NAME}</label><input type="text" size="20" name="name" id="name" value="{NAME*}" /></td>
				<td>{!W_EG_PORTAL_NAME}</td>
		  </tr>
		  <tr>
				<th>{!W_PORTAL_TEXT}</th>
				<td><label class="accessibility_hidden" for="text">{!W_PORTAL_TEXT}</label><input type="text" size="20" name="text" id="text" value="{PORTAL_TEXT*}" /></td>
				<td>{!W_EG_PORTAL_TEXT}</td>
		  </tr>
		  <tr>
				<th>{!W_DESTINATION_REALM}</th>
				<td><label class="accessibility_hidden" for="end_location_realm">{!W_DESTINATION_REALM}</label><input type="text" size="20" name="end_location_realm" id="end_location_realm" value="{END_LOCATION_REALM*}" /></td>
				<td>{!W_EG_DESTINATION_REALM}</td>
		  </tr>
		  <tr>
				<th>{!W_DESTINATION_X}</th>
				<td><label class="accessibility_hidden" for="end_location_x">{!W_DESTINATION_X}</label><input type="text" size="20" name="end_location_x" id="end_location_x" value="{END_LOCATION_X*}" /></td>
				<td>{!W_EG_DESTINATION_X}</td>
		  </tr>
		  <tr>
				<th>{!W_DESTINATION_Y}</th>
				<td><label class="accessibility_hidden" for="end_location_y">{!W_DESTINATION_Y}</label><input type="text" size="20" name="end_location_y" id="end_location_y" value="{END_LOCATION_Y*}" /></td>
				<td>{!W_EG_AND_Y}</td>
		  </tr>
		  {+START,IF_PASSED,OWNER}
		  <tr>
				<th>{!OWNER}</th>
				<td><label class="accessibility_hidden" for="new_owner">{!OWNER}</label><input type="text" size="20" name="new_owner" id="new_owner" value="{OWNER*}" /></td>
				<td>{!W_EG_OWNER}</td>
		  </tr>
		  {+END}
		  {+START,IF_PASSED,X}{+START,IF_PASSED,Y}{+START,IF_PASSED,REALM}
			  <tr>
					<th>X</th>
					<td><label class="accessibility_hidden" for="new_x">X</label><input type="text" size="20" name="new_x" id="new_x" value="{X*}" /></td>
					<td>{!W_EG_MOVE_X}</td>
			  </tr>
			  <tr>
					<th>Y</th>
					<td><label class="accessibility_hidden" for="new_y">Y</label><input type="text" size="20" name="new_y" id="new_y" value="{Y*}" /></td>
					<td>{!W_EG_MOVE_X}</td>
			  </tr>
			  <tr>
					<th>{!W_REALM}</th>
					<td><label class="accessibility_hidden" for="new_realm">{!W_REALM}</label><input type="text" size="20" name="new_realm" id="new_realm" value="{REALM*}" /></td>
					<td>{!W_EG_MOVE_X}</td>
			  </tr>
		  {+END}{+END}{+END}
	 </tbody></table></div>

	 <p class="proceed_button">
		 <input class="button_page" type="submit" value="{!PROCEED}" />
	 </p>
</form>

