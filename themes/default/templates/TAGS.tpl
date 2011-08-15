{+START,IF_NON_EMPTY,{TAGS}}
	<br />
	<div class="associated_link_to_small">
		{+START,BOX,,,light}
			<span class="field_name">{!search:TAGS}:</span>
			{$SET,done_one_tag,_false}
			<span{$?,{$VALUE_OPTION,html5}, itemprop="keywords"}>{+START,LOOP,TAGS}{+START,IF,{$GET,done_one_tag}}, {+END}<a href="{LINK_FULLSCOPE*}">{TAG*}</a>{$SET,done_one_tag,_true}{+END}</span>
		{+END}
	</div>
{+END}
