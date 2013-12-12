{$REQUIRE_JAVASCRIPT,javascript_jquery,1}
{$REQUIRE_JAVASCRIPT,javascript_jquery_autocomplete,1}
{$REQUIRE_JAVASCRIPT,javascript_ajax,1}

{$REQUIRE_CSS,autocomplete}

add_event_listener_abstract(window,'load',function () {
	set_up_comcode_autocomplete('{NAME;/}');
} );
