{+START,IF,{ALLOW_REMOVE}}
	<form id="feed_remove_{LIID*}" class="activities_remove" action="{$PAGE_LINK*,:start}" method="post" onsubmit="return s_update_remove(event,{LIID*});">
		<input class="remove_cross" type="submit" value="{!REMOVE}" />
	</form>
{+END}

<div class="activities_avatar_box">
	{+START,IF_NON_EMPTY,{ADDON_ICON}}
		<img src="{$THUMBNAIL*,{ADDON_ICON},36x36,addon_icon_normalise,,,pad,both,#FFFFFF00}" />
	{+END}
	{+START,IF_EMPTY,{ADDON_ICON}}
		<img src="{$THUMBNAIL*,{$IMG,bigicons/{$?,{IS_PUBLIC},edit_this,edit_one}},36x36,addon_icon_normalise,,,pad,both,#FFFFFF00}" />
	{+END}

	{+START,SET,commented_out}
		{+START,IF_EMPTY,{AVATAR}}{+START,IF_NON_EMPTY,{$IMG,ocf_default_avatars/default_set/ocp_fanatic,0,,1}}
			<img src="{$THUMBNAIL*,{$IMG,ocf_default_avatars/default_set/ocp_fanatic,0,,1},36x36,addon_avatar_normalise,,,pad,both,#FFFFFF00}" />
		{+END}{+END}
		{+START,IF_NON_EMPTY,{AVATAR}}
			<img src="{$THUMBNAIL*,{AVATAR},36x36,addon_avatar_normalise,,,pad,both,#FFFFFF00}" />
		{+END}
	{+END}
</div>

<div class="activities_line">
	{+START,SET,commented_out}
		{+START,IF_PASSED,USERNAME}
			<div class="activity_name left">
				<a href="{MEMBER_URL*}">{USERNAME*}</a>
			</div>
		{+END}
	{+END}

	<div class="activity_time right">
		{$MAKE_RELATIVE_DATE*,{DATETIME},1} {!AGO}
	</div>

	<div class="activities_content">
		{$,The main message}
		{+START,IF,{$EQ,{LANG_STRING},RAW_DUMP}}
			{MESSAGE}
		{+END}
		{+START,IF,{$NEQ,{LANG_STRING},RAW_DUMP}}
			{!ACTIVITY_HAS,<a href="{MEMBER_URL*}">{USERNAME*}</a>,{$LCASE,{$SUBSTR,{MESSAGE},0,1}}{$SUBSTR,{MESSAGE},1}}
		{+END}
	</div>
</div>
