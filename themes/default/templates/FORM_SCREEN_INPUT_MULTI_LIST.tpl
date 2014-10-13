{$REQUIRE_CSS,widget_select2}
{$REQUIRE_JAVASCRIPT,javascript_jquery}
{$REQUIRE_JAVASCRIPT,javascript_select2}

<select multiple="multiple" size="{SIZE*}" tabindex="{TABINDEX*}" class="input_list wide_field" id="{NAME*}" name="{NAME*}[]">
	{CONTENT}
</select>

<script>// <![CDATA[
	add_event_listener_abstract(window,'load',function() {
		$("#{NAME#/}").select2({
			containerCssClass: 'wide_field'
		});
	});
//]]></script>
