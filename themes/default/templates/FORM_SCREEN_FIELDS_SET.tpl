<fieldset id="set_wrapper_{SET_NAME*}" class="innocuous_fieldset">
	<legend class="accessibility_hidden">{PRETTY_NAME*}</legend>

	{FIELDS}
</fieldset>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		standard_alternate_fields_within('{SET_NAME;}',{$?,{REQUIRED},true,false});
	} );
//]]></script>
