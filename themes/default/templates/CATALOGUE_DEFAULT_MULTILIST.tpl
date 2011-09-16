<div>
	{+START,LOOP,ALL}
		<p>
			{+START,IF,{HAS}}
				<!--<img alt="{!YES}" class="inline_image_2" src="{$IMG*,checklist/checklist1}" />--> &#10003;
			{+END}
			{+START,IF,{$NOT,{HAS}}}
				<!--<img alt="{!NO}" class="inline_image_2" src="{$IMG*,checklist/checklist0}" />--> &#10007;
			{+END}

			{OPTION*}
		</p>
	{+END}
</div>
