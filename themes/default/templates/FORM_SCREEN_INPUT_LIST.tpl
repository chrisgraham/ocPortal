{+START,IF,{INLINE_LIST}}
<select size="9" tabindex="{TABINDEX*}" class="input_list{REQUIRED*} wide_field" id="{NAME*}" name="{NAME*}">
{+END}
{+START,IF,{$NOT,{INLINE_LIST}}}
<select tabindex="{TABINDEX*}" class="input_list{REQUIRED*}" id="{NAME*}" name="{NAME*}">
{+END}
	{CONTENT}
</select>
