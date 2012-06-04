<section class="box box___quiz_box"><div class="box_inner">
	<h3>{NAME*}</h3>

	<div class="meta_details" role="contentinfo">
		<dl class="meta_details_list">
			{+START,IF_NON_EMPTY,{TIMEOUT}}
				<dt class="field_name">{!TIMEOUT}:</dt> <dd>{TIMEOUT*}</dd>
			{+END}
			{+START,IF_NON_EMPTY,{REDO_TIME}}
				<dt class="field_name">{!REDO_TIME}:</dt> <dd>{REDO_TIME*}</dd>
			{+END}
			<dt class="field_name">{!_ADDED}:</dt> <dd>{DATE*}</dd>
		</dl>
	</div>

	{+START,IF_NON_EMPTY,{START_TEXT}}
		<p>
			{START_TEXT}
		</p>
	{+END}

	<form  title="{!START} {!QUIZ}: {NAME*}" method="post" action="{URL*}">
		<input class="button_pageitem" type="image" src="{$IMG*,pageitem/goto}" alt="{!VIEW}" />
	</form>

	{+START,IF,{$EQ,{_TYPE},TEST}}{+START,IF,{$NEQ,{POINTS},0}}{+START,IF,{$ADDON_INSTALLED,points}}
		<p>You will win <strong>{$NUMBER_FORMAT*,{POINTS}}</strong> points if you pass this test. You will spend <strong>{$NUMBER_FORMAT*,{$DIV,{POINTS},2}}</strong> points to enter this test.<br />Put your points on the line and your knowledge to the test!</p>
	{+END}{+END}{+END}
</div></section>
