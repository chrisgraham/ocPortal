{$REQUIRE_CSS,widget_select2}
{$REQUIRE_JAVASCRIPT,javascript_jquery}
{$REQUIRE_JAVASCRIPT,javascript_select2}

{+START,IF,{INLINE_LIST}}
<select size="9" tabindex="{TABINDEX*}" class="input_list{REQUIRED*} wide_field" id="{NAME*}" name="{NAME*}">
{+END}
{+START,IF,{$NOT,{INLINE_LIST}}}
<select tabindex="{TABINDEX*}" class="input_list{REQUIRED*}" id="{NAME*}" name="{NAME*}">
{+END}
	{CONTENT}
</select>

<script>// <![CDATA[
	add_event_listener_abstract(window,'load',function() {
		var element=document.getElementById("{NAME#/}");
		if ((element.options.length>20)/*only for long lists*/ && (!element.options[0].value.match(/^\d+$/)/*not for lists of numbers*/))
		{
			$(element).select2({
				containerCssClass: 'wide_field'
			});
		}
	});
//]]></script>
