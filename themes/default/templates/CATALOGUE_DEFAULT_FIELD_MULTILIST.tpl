<div>
	{+START,LOOP,ALL}
		<p>
			{+START,IF,{HAS}}
				<span class="multilist_mark yes">&#10003;</span>	{$,Checkmark entity}
			{+END}
			{+START,IF,{$NOT,{HAS}}}
				<span class="multilist_mark no">&#10007;</span> {$,Cross entity}
			{+END}

			{OPTION*}
		</p>
	{+END}
</div>
