<div class="search_option">
	<label for="{BLOCK_ID*}_filter_{NAME*}">{LABEL*}</label>

	{+START,IF_NON_EMPTY,{$CPF_LIST,{LABEL}}}
		<select class="wide_field search_option_value" id="{BLOCK_ID*}_filter_{NAME*}" name="{BLOCK_ID*}_filter_{NAME*}">
			<option value="">---</option>
			{+START,LOOP,{$CPF_LIST,{LABEL}}}
				<option{+START,IF,{$AND,{$NEQ,{_loop_key},},{$EQ,{$_GET,{BLOCK_ID}_filter_{NAME}},{_loop_key}}}} selected="selected"{+END} value="{_loop_key*}">{_loop_var*}</option>
			{+END}
		</select>
	{+END}
	{+START,IF_EMPTY,{$CPF_LIST,{LABEL}}}
		{+START,IF,{$EQ,{LABEL},{!USERNAME}}}<span class="invisible_ref_point"></span>{+END}
		<input class="wide_field search_option_value"{+START,IF,{$EQ,{LABEL},{!USERNAME}}} onkeyup="update_ajax_author_list(this,event);"{+END} type="text" value="{$_GET*,{BLOCK_ID}_filter_{NAME}}" id="{BLOCK_ID*}_filter_{NAME*}" name="{BLOCK_ID*}_filter_{NAME*}" />
	{+END}
</div>
