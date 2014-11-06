{+START,IF_PASSED,SUBMITTER}{+START,IF_NON_EMPTY,{SUBMITTER}}
	{+START,IF,{$OCF}}
		{+START,IF,{$OR,{$ADDON_INSTALLED,ocf_avatars},{$IS_NON_EMPTY,{$AVATAR,{SUBMITTER}}}}}
			{$REQUIRE_JAVASCRIPT,javascript_ajax}

			<img class="embedded_mini_avatar" src="{$THUMBNAIL*,{$?,{$IS_EMPTY,{$AVATAR,{SUBMITTER}}},{$IMG,ocf_default_avatars/default},{$AVATAR,{SUBMITTER}}},50}" alt="" onmouseover="load_snippet('member_tooltip&member_id={SUBMITTER%}',null,function(result) { if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,result.responseText,'auto',null,null,false,true); });" />
		{+END}
	{+END}
{+END}{+END}
