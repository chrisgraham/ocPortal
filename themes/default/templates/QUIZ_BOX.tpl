<section class="box box___quiz_box"><div class="box_inner">
	<h3>
		{+START,IF,{GIVE_CONTEXT}}
			{!CONTENT_IS_OF_TYPE,{TYPE*},{NAME*}}
		{+END}

		{+START,IF,{$NOT,{GIVE_CONTEXT}}}
			{NAME*}
		{+END}
	</h3>

	<div class="meta_details" role="contentinfo">
		<dl class="meta_details_list">
			{+START,IF_NON_EMPTY,{TIMEOUT}}
				<dt class="field_name">{!TIMEOUT}:</dt> <dd>{TIMEOUT*}</dd>
			{+END}
			{+START,IF_NON_EMPTY,{REDO_TIME}}
				<dt class="field_name">{!REDO_TIME}:</dt> <dd>{REDO_TIME*}</dd>
			{+END}
			<dt class="field_name">{!ADDED}:</dt> <dd>{DATE*}</dd>
		</dl>
	</div>

	{+START,IF_NON_EMPTY,{START_TEXT}}
		<p>
			{START_TEXT}
		</p>
	{+END}

	<div class="shunted_button">
		<form title="{!START} {!QUIZ}: {NAME*}" method="post" action="{URL*}">
			<input class="button_pageitem" type="image" src="{$IMG*,pageitem/goto}" alt="{!START} {!QUIZ}: {NAME*}" />
		</form>
	</div>
</div></section>
