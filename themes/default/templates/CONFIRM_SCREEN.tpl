{TITLE}

<p>
	{!CONFIRM_TEXT}
</p>

{+START,BOX,,,med}
	{PREVIEW}
{+END}

<form title="{!PROCEED}" method="post" action="{URL*}">
	{+START,IF_PASSED,HIDDEN}{HIDDEN}{+END}

	<div>
		<div class="confirm_area_wrap">
			{FIELDS}
		</div>

		<div class="proceed_button">
			<input onclick="disable_button_just_clicked(this);" accesskey="u" class="button_page" type="submit" value="{!PROCEED}" />
		</div>
	</div>
</form>

{+START,IF,{$JS_ON}}
<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
{+END}

