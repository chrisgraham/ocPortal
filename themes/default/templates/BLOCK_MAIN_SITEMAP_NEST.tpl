{+START,IF_NON_EMPTY,{URL}}
	<a href="{URL*}__keep{+START,IF,{$NOT,{$IN_STR,{URL},?}}}1{+END}__">{NAME*}</a>
{+END}
{+START,IF_EMPTY,{URL}}
	{NAME*}
{+END}
{+START,IF_ARRAY_NON_EMPTY,CHILDREN}
	<ul aria-haspopup="true">
		{+START,LOOP,CHILDREN}
			<li>
				{_loop_var}
			</li>
		{+END}
	</ul>
{+END}
