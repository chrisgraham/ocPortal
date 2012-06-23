<div class="search_option">
	<label for="filter_{NAME*}">{LABEL*}</label>
	{+START,IF,{$EQ,{LABEL},{!USERNAME}}}<span class="invisible_ref_point"></span>{+END}
	<input class="wide_field search_option_value"{+START,IF,{$EQ,{LABEL},{!USERNAME}}} onkeyup="update_ajax_author_list(this,event);"{+END} type="text" value="{$_POST*,filter_{NAME}}" id="filter_{NAME*}" name="filter_{NAME*}" />
</div>
