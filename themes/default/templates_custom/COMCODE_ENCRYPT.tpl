{$REQUIRE_JAVASCRIPT,javascript_profile}

<div class="box"><div class="box_inner">
	<h3>Encrypted text</h3>

	{+START,IF,{$JS_ON}}
		<a href="javascript:decrypt_data('{CONTENT;^*}');" title="{!DECRYPT_DATA}: {!DESCRIPTION_DECRYPT_DATA=}">{!DECRYPT_DATA}</a>
	{+END}
</div></div>
