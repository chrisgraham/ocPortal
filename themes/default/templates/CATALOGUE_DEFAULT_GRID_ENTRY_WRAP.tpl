<section class="box box___catalogue_default_grid_entry_wrap"><div class="box_inner">
	<h3><span class="name">{$TRUNCATE_LEFT,{FIELD_0},25,1,1}</h3>

	{+START,SET,TOOLTIP}
		<table class="map_table results_table">
			<tbody>
				{FIELDS_GRID}
			</tbody>
		</table>
	{+END}

	{+START,IF_PASSED,FIELD_1_THUMB}
		{+START,IF_NON_EMPTY,{FIELD_1_THUMB}}
			<div class="catalogue_entry_box_thumbnail">
				<a onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{$GET;^*,TOOLTIP}','500px');" href="{VIEW_URL*}">{FIELD_1_THUMB}</a>
			</div>
		{+END}

		{+START,IF_EMPTY,{FIELD_1_THUMB}}
			<p>
				<a title="{$STRIP_TAGS,{FIELD_0}}" href="{VIEW_URL*}">{!VIEW}</a>
			</p>
		{+END}
	{+END}

	{+START,IF_NON_PASSED,FIELD_1_THUMB}
		<p>
			<a title="{$STRIP_TAGS,{FIELD_0}}" href="{VIEW_URL*}">{!VIEW}</a>
		</p>
	{+END}

	<div class="ratings">
		{RATING}
	</div>
</div></section>
