<div class="box box___message"><div class="box_inner">
	<div class="global_message" role="alert">
		<img width="{$IMG_WIDTH*,{$IMG,messageicons/{TYPE}}}" height="{$IMG_HEIGHT*,{$IMG,messageicons/{TYPE}}}" src="{$IMG*,messageicons/{TYPE}}" alt="" />
		{+START,IF,{$IN_STR,{MESSAGE},<p}}
			{MESSAGE}
		{+END}
		{+START,IF,{$NOT,{$IN_STR,{MESSAGE},<p}}}
			<span>{MESSAGE}</span>
		{+END}
	</div>
</div></div>
