<section class="box box___poll_box"><div class="box_inner">
	<h3>{!POLL}</h3>

	<p class="poll_question">{+START,FRACTIONAL_EDITABLE,{QUESTION_PLAIN},question,_SEARCH:cms_polls:type=__ed:id={PID},1}{QUESTION}{+END}</p>

	<a id="poll_jump" rel="dovote"></a>
	<form title="{!VOTE}" target="_self" action="{VOTE_URL*}" method="post" class="poll_form">
		{$INSERT_SPAMMER_BLACKHOLE}

		<div>
			{CONTENT}
		</div>

		<p>
			<input disabled="disabled" id="poll{PID*}" onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" value="{!VOTE}" />
		</p>
	</form>

	<ul class="horizontal_links associated_links_block_group">
		{+START,IF_NON_EMPTY,{FULL_URL}}<li><a target="_top" href="{FULL_URL*}" title="{!VIEW}: {!POLL} #{PID*}">{!VIEW}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview}}}{+START,IF_PASSED_AND_TRUE,COMMENT_COUNT} <span class="comment_count">{$COMMENT_COUNT,polls,{PID}}</span>{+END}{+END}{+END}</li>
		<li><a rel="archives" target="_top" href="{ARCHIVE_URL*}" title="{!VIEW_ARCHIVE}: {!POLLS}">{!VIEW_ARCHIVE}</a></li>
		{+START,IF_NON_EMPTY,{RESULT_URL}}<li><form title="{!POLL_RESULTS}" target="_self" class="inline" action="{VOTE_URL*}" method="post"><input onclick="var form=this.form; window.fauxmodal_confirm('{!VOTE_FORFEIGHT}'\,function(answer) \{ if (answer) form.submit(); \}); return false;" class="button_hyperlink" type="submit" value="{!POLL_RESULTS}" /></form></li>{+END}
		{+START,IF_NON_EMPTY,{SUBMIT_URL}}<li><a rel="add" target="_top" href="{SUBMIT_URL*}">{!ADD}</a></li>{+END}
	</ul>
</div></section>

