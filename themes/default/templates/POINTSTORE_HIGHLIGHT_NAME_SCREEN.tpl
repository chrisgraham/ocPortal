{TITLE}

<p>
	{!HIGHLIGHT_NAME_A,{COST},{REMAINING}}
</p>

<ul role="navigation" class="actions_list">
	<li class="actions_list_strong">
		<form title="{!PRIMARY_PAGE_FORM}" class="inline" method="post" action="{NEXT_URL*}">
			<div class="inline">
				<input type="hidden" name="confirm" value="1" />
				<input class="button_hyperlink" type="submit" value="{!PROCEED}" />
			</div>
		</form>
	</li>
</ul>
