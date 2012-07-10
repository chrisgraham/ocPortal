<div class="search_option">
	<label for="filter_{NAME*}">{LABEL*}</label>

	{+START,IF_NON_EMPTY,{$CPF_LIST,{NAME}}}
		<select class="wide_field search_option_value" id="filter_{NAME*}" name="filter_{NAME*}">
			<option value="">---</option>
			{+START,LOOP,{$CPF_LIST,{NAME}}}
				<option{+START,IF,{$EQ,{$_POST,filter_{NAME}},{_loop_var}}} selected="selected"{+END} value="{_loop_key*}">{_loop_var*}</option>
			{+END}
		</select>
	{+END}
	{+START,IF_EMPTY,{$CPF_LIST,{NAME}}}
		{+START,IF,{$EQ,{LABEL},{!USERNAME}}}<span class="invisible_ref_point"></span>{+END}
		<input class="wide_field search_option_value"{+START,IF,{$EQ,{LABEL},{!USERNAME}}} onkeyup="update_ajax_author_list(this,event);"{+END} type="text" value="{$_POST*,filter_{NAME}}" id="filter_{NAME*}" name="filter_{NAME*}" />
	{+END}
</div>
