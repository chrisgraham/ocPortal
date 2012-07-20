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

			{+START,IF_PASSED_AND_TRUE,IS_OTHER}
				<span class="associated_details">({!fields:ADDITIONAL_CUSTOM})</span>
			{+END}
		</p>
	{+END}
</div>
