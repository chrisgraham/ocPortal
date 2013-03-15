{+START,BOX,,{$?,{$GET,in_panel},100%,100%|230px},{$?,{$GET,in_panel},panel,curved},,,{$?,{$IS_NON_EMPTY,{RESULT_URL}},<form target="_self" class="inline" action="{VOTE_URL*}" method="post"><input onclick="var form=this.form; window.fauxmodal_confirm('{!VOTE_FORFEIGHT;}',function(answer) { if (answer) { form.submit(); } }); return false;" class="buttonhyperlink" type="submit" value="{!POLL_RESULTS}" /></form>|,}{$?,{$IS_NON_EMPTY,{SUBMIT_URL}},<a rel="add" target="_top" href="{SUBMIT_URL*}">{!ADD_POLL}</a>|,}<a rel="archives" target="_top" href="{ARCHIVE_URL*}" title="{!VIEW_ARCHIVE}: {!POLLS}">{!VIEW_ARCHIVE}</a>{$?,{$IS_NON_EMPTY,{FULL_URL}},|<a target="_top" href="{FULL_URL*}" title="{!VIEW}: {!POLL} #{PID*}">{!VIEW}</a>,}}
	<p class="poll_question">{+START,FRACTIONAL_EDITABLE,{QUESTION_PLAIN},question,_SEARCH:cms_polls:type=_edit_poll:id={PID},1}{QUESTION}{+END}</p>

	<a name="poll_jump" id="poll_jump" rel="dovote"></a>
	<form target="_self" action="{VOTE_URL*}" method="post" class="poll_form">
		<div>
			{CONTENT}
		</div>

		<p>
			<input disabled="disabled" id="poll{PID*}" onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" value="{!VOTE}" />
		</p>
	</form>
{+END}

