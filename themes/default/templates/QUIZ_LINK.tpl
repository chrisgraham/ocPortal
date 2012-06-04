{+START,BOX,{NAME*},,med}
	{+START,IF_NON_EMPTY,{START_TEXT}}
		<p>
			{START_TEXT}
		</p>
	{+END}

	{+START,IF_NON_EMPTY,{TIMEOUT}}
		<p><span class="field_name">{!TIMEOUT}</span>: {TIMEOUT*}</p>
	{+END}

	{+START,IF_NON_EMPTY,{REDO_TIME}}
		<p><span class="field_name">{!REDO_TIME}</span>: {REDO_TIME*}</p>
	{+END}

	<!--<p class="associated_details">{!ADDED,{DATE*}}</p>-->

	<form title="{!START} {!QUIZ}: {NAME*}" method="post" action="{URL*}"><input class="button_pageitem" type="image" src="{$IMG*,pageitem/goto}" alt="{!START} {!QUIZ}: {NAME*}" /></form>
{+END}

<br />
