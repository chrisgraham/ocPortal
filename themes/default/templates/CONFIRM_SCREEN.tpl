{TITLE}

{+START,IF_NON_PASSED,TEXT}
	<p>
		{!CONFIRM_TEXT}
	</p>

	<div class="box box___confirm_screen"><div class="box_inner">
		{PREVIEW}
	</div></div>
{+END}

{+START,IF_PASSED,TEXT}
	{TEXT}
{+END}

<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_NON_PASSED_OR_FALSE,GET}method="post" action="{URL*}"{+END}{+START,IF_PASSED_AND_TRUE,GET}method="get" action="{$URL_FOR_GET_FORM*,{URL}}"{+END}>
	{+START,IF_PASSED_AND_TRUE,GET}{$HIDDENS_FOR_GET_FORM,{URL}}{+END}

	{+START,IF_PASSED,HIDDEN}{HIDDEN}{+END}

	<div>
		{FIELDS}

		<p class="proceed_button">
			<input onclick="disable_button_just_clicked(this);" accesskey="u" class="button_page" type="submit" value="{!PROCEED}" />
		</p>
	</div>
</form>

{+START,IF_NON_PASSED,BACK_URL}
	{+START,IF,{$JS_ON}}
		<p class="back_button">
			<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
		</p>
	{+END}
{+END}

{+START,IF_PASSED,BACK_URL}
	<form class="back_button" title="{!_NEXT_ITEM_BACK}" action="{BACK_URL*}" method="post">
		<div>
			{FIELDS}
			<button class="button_icon" type="submit"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></button>
		</div>
	</form>
{+END}

{+START,IF_PASSED,JAVASCRIPT}
	<script type="text/javascript">// <![CDATA[
		{JAVASCRIPT}
	//]]></script>
{+END}

