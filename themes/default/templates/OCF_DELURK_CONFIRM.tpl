{TITLE}

<p>
	{!DELURK_CONFIRM}
</p>

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}">
	<div>
		<ul>
		{+START,LOOP,LURKERS}
			<li>
				<label for="lurker_{ID*}"><input type="checkbox" name="lurker_{ID*}" id="lurker_{ID*}" value="1" checked="checked" /> <a title="{USERNAME*}: {!LINK_NEW_WINDOW}" target="_blank" href="{PROFILE_URL*}">{USERNAME*}</a></label>
			</li>
		{+END}
		</ul>

		<br />
		<div class="proceed_button">
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" />
		</div>
	</div>
</form>

{+START,IF,{$JS_ON}}
<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
{+END}

