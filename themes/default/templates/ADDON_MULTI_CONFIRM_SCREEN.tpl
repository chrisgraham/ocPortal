{TITLE}

{WARNINGS}

{+START,IF_NON_EMPTY,{INSTALL_FILES}}
	{!ADDON_FILES}
	<ul>
		{INSTALL_FILES}
	</ul>
{+END}

{+START,IF_NON_EMPTY,{UNINSTALL_FILES}}
	{!WARNING_UNINSTALL}
	<ul>
		{UNINSTALL_FILES}
	</ul>
{+END}

<div class="float_surrounder">
	<div class="right">
		<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
			<div class="inline_block">
				<p>
					<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" />
					{HIDDEN}
				</p>
			</div>
		</form>
	</div>

	{+START,IF,{$JS_ON}}
	<p>
		<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
	</p>
	{+END}
</div>
