{TITLE}

<p>
	{!CONFIRM_TEXT}
</p>

<div>
	{PREVIEW}
</div>
<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_NON_PASSED,GET}method="post" action="{URL*}"{+END}{+START,IF_PASSED,GET}method="get" action="{$URL_FOR_GET_FORM*,{URL}}"{+END}>
	{+START,IF_PASSED,GET}{$HIDDENS_FOR_GET_FORM,{URL}}{+END}

	<div>
		{FIELDS}

		<div class="proceed_button">
			<input onclick="disable_button_just_clicked(this);" accesskey="u" class="button_page" type="submit" value="{!PROCEED}" />
		</div>
	</div>
</form>

<form title="{!_NEXT_ITEM_BACK}" action="{BACK_URL*}" method="post">
	<div>
		{FIELDS}
		<button class="button_icon" type="submit"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></button>
	</div>
</form>

{+START,IF_PASSED,JAVASCRIPT}
	<script type="text/javascript">// <![CDATA[
		{JAVASCRIPT}
	//]]></script>
{+END}

