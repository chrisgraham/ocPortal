<div class="box box___download_box"><div class="box_inner">
	{+START,SET,BOX_TITLE}
		<h3><a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME},name,_SEARCH:cms_downloads:type=__ed:id={ID}}{NAME*}{+END}</a> {!BY_SIMPLE_LOWER,{AUTHOR*}}</h3>
	{+END}

	<div class="meta_details" role="contentinfo">
		<dl class="meta_details_list">
			{+START,IF,{$INLINE_STATS}}
				<dt class="field_name">{!COUNT_DOWNLOADS}:</dt> <dd>{DOWNLOADS*}</dd>
			{+END}
			<dt class="field_name">{!_ADDED}:</dt> <dd>{DATE*}</dd>
			{+START,IF_PASSED,RATING}{+START,IF_NON_EMPTY,{RATING}}
				<dt class="field_name">{!RATING}:</dt> <dd>{RATING}</dd>
			{+END}{+END}
		</dl>
	</div>

	<div class="hide_if_not_in_panel">
		<p class="tiny_paragraph"><a title="{NAME*}: {!BY_SIMPLE,{AUTHOR*}}" href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME},name,_SEARCH:cms_downloads:type=__ed:id={ID}}{NAME*}{+END}</a></p>

		<p class="tiny_paragraph associated_details">
			{+START,IF_PASSED,RATING}<span class="right">{RATING}</span>{+END}

			{+START,IF,{$INLINE_STATS}}{DOWNLOADS*} {!COUNT_DOWNLOADS}{+END}
		</p>

		<p class="tiny_paragraph associated_details">
			{!_ADDED} {DATE*}
		</p>
	</div>

	<div class="hide_if_in_panel">
		{+START,IF_NON_EMPTY,{IMGCODE}}
			<div class="download_box_pic"><a href="{URL*}">{IMGCODE}</a></div>
		{+END}

		<div class="download_box_description {+START,IF_NON_EMPTY,{IMGCODE}}pic{+END}">
			{$PARAGRAPH,{$TRUNCATE_LEFT,{DESCRIPTION},460,0,1}}
		</div>

		{+START,IF_NON_EMPTY,{BREADCRUMBS}}
			<p>{!LOCATED_IN,{BREADCRUMBS}}</p>
		{+END}
	</div>

	<ul class="horizontal_links associated_links_block_group">
		{+START,IF_PASSED,LICENCE}
			<li><a href="{URL*}">{!VIEW}</a></li>
		{+END}
		{+START,IF_NON_PASSED,LICENCE}
			<li><a href="{URL*}">{!MORE_INFO}</a></li>
			<li><a title="{!DOWNLOAD_NOW}: {$CLEAN_FILE_SIZE*,{FILE_SIZE}}" href="{$FIND_SCRIPT*,dload}?id={ID*}{$KEEP*}&amp;for_session={$SESSION_HASHED}">{!DOWNLOAD_NOW}</a></li>
		{+END}
	</ul>
</div></div>
