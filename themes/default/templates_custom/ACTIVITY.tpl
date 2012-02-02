{+START,IF,{ALLOW_REMOVE}}
	<form id="feed_remove_{LIID*}" class="remove" action="{$PAGE_LINK*,:start}" method="post">
		<input type="hidden" value="{LIID*}" name="removal_id" />
		<input class="remove_cross" type="submit" value="{!REMOVE}" name="feed_remove_{LIID*}" />
	</form>
{+END}

<div class="avatar-box">
	{+START,IF_NON_EMPTY,{ADDON_ICON}}
		<img src="{$THUMBNAIL*,{ADDON_ICON},36x36,addon_icon_normalise,,,pad,both,#FFFFFF00}" />
	{+END}
	{+START,IF_EMPTY,{ADDON_ICON}}
		<img src="{$THUMBNAIL*,{$IMG,bigicons/edit_one},36x36,addon_icon_normalise,,,pad,both,#FFFFFF00}" />
	{+END}

	<!--
	{+START,IF_EMPTY,{MEMPIC}}
		<img src="{$THUMBNAIL*,{$IMG,ocf_default_avatars/default_set/ocp_fanatic},36x36,avatar_normalise,,,pad,both,#FFFFFF00}" />
	{+END}
	{+START,IF_NON_EMPTY,{MEMPIC}}
		<img src="{$THUMBNAIL*,{MEMPIC},36x36,avatar_normalise,,,pad,both,#FFFFFF00}" />
	{+END}
	-->
</div>

<div class="activities_line">
	<!--
		{+START,IF_PASSED,USERNAME}
			<div class="name left">
				<a href="{MEMBER_URL*}">{USERNAME*}</a>
			</div>
		{+END}
	-->

	<div class="time right">
		{$MAKE_RELATIVE_DATE*,{DATETIME}} {!AGO}
	</div>

	<div class="activities-content">
		{$,The main message}
		{BITS}
	</div>
</div>
