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

	<form method="post" action="{URL*}"><input class="button_pageitem" type="image" src="{$IMG*,pageitem/goto}" alt="{!VIEW}" /></form>

	{+START,IF,{$EQ,{_TYPE},TEST}}{+START,IF,{$NEQ,{POINTS},0}}{+START,IF,{$ADDON_INSTALLED,points}}
		<p>You will win <strong>{$NUMBER_FORMAT*,{POINTS}}</strong> points if you pass this test. You will spend <strong>{$NUMBER_FORMAT*,{$DIV,{POINTS},2}}</strong> points to enter this test.<br />Put your points on the line and your knowledge to the test!</p>
	{+END}{+END}{+END}
{+END}

<br />
