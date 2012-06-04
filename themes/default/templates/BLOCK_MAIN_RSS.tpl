{+START,BOX,{$?,{$IS_NON_EMPTY,{TITLE}},{!NEWS_FROM}: {TITLE}},,{$?,{$GET,in_panel},panel,classic}}
	<div class="xhtml_validator_off">
		{+START,IF_NON_EMPTY,{AUTHOR}}
		<p>{AUTHOR`}</p>
		{+END}

		{CONTENT`}

		{+START,IF_NON_EMPTY,{COPYRIGHT}}
			<p>{COPYRIGHT`}</p>
		{+END}
	</div>
{+END}

