<div class="box box___news_brief"><div class="box_inner">
	<span class="right float_separation">{DATE*}</span>

	<span class="horiz_field_sep"><a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{TITLE_PLAIN},title,_SEARCH:cms_news:type=__ed:id={ID},1}{TITLE}{+END}</a></span>
	{+START,IF_PASSED_AND_TRUE,COMMENT_COUNT} <span class="comment_count">{$COMMENT_COUNT,news,{ID}}</span>{+END}
</div></div>
