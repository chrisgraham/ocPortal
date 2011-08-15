{+START,IF_NON_EMPTY,{CONTENTS}}
	<div>
		<span class="side_galleries_block_exp"><a href="#" onclick="event.returnValue=false; toggleSectionInline('gg_{ID*;}','block'); return false;"><img id="e_gg_{ID*;}" class="inline_image" alt="{!EXPAND}: {CAPTION*}" title="{!EXPAND}" src="{$IMG*,expand}" /></a> <a href="#" onclick="event.returnValue=false; toggleSectionInline('gg_{ID*;}','block'); return false;">{CAPTION*}</a></span>
		<ul id="gg_{ID*}" style="display: {$JS_ON,none,block}" class="compact_list">
			{CONTENTS}
		</ul>
	</div>
{+END}
