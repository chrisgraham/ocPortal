<li>
	{+START,LOOP,LEVEL_HAS_ADJACENT_SIBLING}
		{+START,IF,{$NEQ,{_loop_key},0}} {$,Skip first level}
            {+START,IF,{$NEQ,{_loop_key},{POST_LEVEL}}}
                {$?,{_loop_var},<img src="{$IMG,middle_mesg_level}">,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
            {+END}

            {+START,IF,{$EQ,{_loop_key},{POST_LEVEL}}}
                <img src="{$IMG,{$?,{_loop_var},mesg_level,last_mesg_level}}">
            {+END}
		{+END}
	{+END}

    <a href="{URL*}">Re: {TITLE*}</a> by

	{+START,IF,{POSTER_IS_GUEST}}
		<span>{POSTER_NAME*},</span>
	{+END}

	{+START,IF,{$NOT,{POSTER_IS_GUEST}}}
		<a href="{POSTER_URL*}">{POSTER_NAME*},</a>
	{+END}

	{TIME*}
</li>