{+START,IF,{$EQ,{MEMBER_ID},{$USER}}}
	{$BLOCK,block=main_activities_state,member={MEMBER_ID},mode=some_members,param=}
{+END}

{$BLOCK,block=main_activities,member={MEMBER_ID},mode=some_members,param=}

<hr />

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=activity
	NOTIFICATIONS_ID={MEMBER_ID}
	RIGHT=1
{+END}

{+START,IF_NON_EMPTY,{SYNDICATIONS}}
	<p>{!CREATE_SYNDICATION_LINK}</p>

	<form action="{$PAGE_LINK*,_SEARCH:members:view:{MEMBER_ID}}#tab__activities" method="post">
		<p>
			{+START,LOOP,SYNDICATIONS}
				{+START,IF,{SYNDICATION_IS_SET}}
					<input class="button_pageitem" onclick="disable_button_just_clicked(this);" type="submit" id="syndicate_stop__{_loop_key*}" name="syndicate_stop__{_loop_key*}" value="{!STOP_SYNDICATING_TO,{SYNDICATION_SERVICE_NAME*}}" />
				{+END}
				{+START,IF,{$NOT,{SYNDICATION_IS_SET}}}
					<input class="button_pageitem" onclick="disable_button_just_clicked(this);" type="submit" id="syndicate_start__{_loop_key*}" name="syndicate_start__{_loop_key*}" value="{!START_SYNDICATING_TO,{SYNDICATION_SERVICE_NAME*}}" />
				{+END}
			{+END}
		</p>
	</form>

	{+START,LOOP,SYNDICATIONS}
		{+START,IF_NON_EMPTY,{SYNDICATION_JAVASCRIPT}}
			<script type="text/javascript">// <![CDATA[
				{SYNDICATION_JAVASCRIPT/}
			//]]></script>
		{+END}
	{+END}
{+END}
