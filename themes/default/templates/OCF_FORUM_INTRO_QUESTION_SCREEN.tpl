{TITLE}

<div class="site_special_message">
	<div class="site_special_message_alt_inner">
		{+START,BOX,{!BEFORE_ENTERING_FORUM},,curved}
			<p class="highlight_red">{$?,{$IS_NON_EMPTY,{ANSWER}},{!FORUM_INTRO_QUESTION_TEXT},{!FORUM_INTRO_QUESTION_TEXT_ALT}}</p>

			{QUESTION}
		{+END}

		<br />

		<form title="{!PROCEED}" action="{URL*}" method="post">
			{+START,IF_NON_EMPTY,{ANSWER}}
				<div class="ocf_intro_question_answer_box"><label for="answer">{!ANSWER}</label>: <input maxlength="255" id="answer" value="" type="text" name="answer" /> <input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" /></div>
			{+END}
			{+START,IF_EMPTY,{ANSWER}}
				<div>
					<input type="hidden" name="answer" value="" />
					<div class="proceed_button">
						 <input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" />
					</div>
				</div>
			{+END}
		</form>
	</div>
</div>
