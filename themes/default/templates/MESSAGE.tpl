<div class="box box___message"><div class="box_inner">
	<div class="global_message" role="alert">
		<img width="{$IMG_WIDTH*,{$IMG,icons/24x24/status/{TYPE}}}" height="{$IMG_HEIGHT*,{$IMG,icons/24x24/status/{TYPE}}}" src="{$IMG*,icons/24x24/status/{TYPE}}" srcset="{$IMG*,icons/48x48/status/{TYPE}} 2x" alt="" />
		{+START,IF,{$IN_STR,{MESSAGE},<p}}
			{MESSAGE}
		{+END}
		{+START,IF,{$NOT,{$IN_STR,{MESSAGE},<p}}}
			<span>{MESSAGE}</span>
		{+END}
	</div>
</div></div>
