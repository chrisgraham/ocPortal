<section class="box box___simple_preview_box"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h3>
			{TITLE`}
		</h3>
	{+END}

	{+START,IF_NON_EMPTY,{HTML}}
		{HTML`}
	{+END}

	<p class="shunted_button">
		<a href="{URL*}"><img class="button_pageitem" alt="{!VIEW}" title="{!VIEW}" src="{$IMG*,pageitem/goto}" /></a>
	</p>
</div></section>
