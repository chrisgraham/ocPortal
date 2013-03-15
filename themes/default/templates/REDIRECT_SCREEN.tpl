{TITLE}

<div class="site_special_message">
	<div class="site_special_message_inner">
		{+START,BOX,,,curved}
			<p>{TEXT}</p>
			{+START,IF_PASSED,REDIRECT_TEXT_NO_COMPLETE}
				<p>{!REDIRECT_TEXT_NO_COMPLETE,{URL*}}</p>
			{+END}

			{+START,IF_NON_PASSED,REDIRECT_TEXT_NO_COMPLETE}
				<p>{!REDIRECT_TEXT,{URL*}}</p>
			{+END}
		{+END}
	</div>
</div>

