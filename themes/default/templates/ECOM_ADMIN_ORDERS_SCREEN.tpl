{TITLE}

<div class="wide_table_wrap">
	{RESULT_TABLE}

	{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
		<div class="results_browser_spacing float_surrounder">
			{RESULTS_BROWSER}
		</div>
	{+END}
</div>

<h2>{!SEARCH}</h2>

<form target="_self" method="get" action="{SEARCH_URL*}" onsubmit="window.scrollTo(0,0);">
	<div>
		{HIDDEN}

		<label for="order_filter">
			<span class="invisible_ref_point">&nbsp;</span>
			<input maxlength="255" type="text" id="order_filter" name="search" value="{SEARCH_VAL*}" />
			<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SEARCH}" /> ({!SEARCH_ORDERS})
		</label>
	</div>
</form>

<h2>{!MORE} / {!ADVANCED}</h2>

<p>
	{!ACTIONS}:
</p>
<ul class="actions_list">
	<li class="actions_list_strong">
		&raquo; <a href="{$PAGE_LINK*,_SELF:_SELF:type=order_export}">{!EXPORT_ORDER_LIST}</a>
	</li>
</ul>