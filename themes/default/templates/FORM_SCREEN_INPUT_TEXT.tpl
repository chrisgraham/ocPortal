{$REQUIRE_JAVASCRIPT,javascript_editing}

<div id="container_for_{NAME*}" class="constrain_field">
	<textarea{+START,IF,{$NOT,{$MOBILE}}} onkeyup="manage_scroll_height(this);"{+END} tabindex="{TABINDEX*}" class="input_text{REQUIRED*}{+START,IF,{SCROLLS}} textarea_scroll{+END} wide_field" cols="70" rows="{+START,IF_PASSED,ROWS}{ROWS*}{+END}{+START,IF_NON_PASSED,ROWS}7{+END}" id="{NAME*}" name="{NAME*}">{DEFAULT*}</textarea>
	{+START,IF,{$IN_STR,{REQUIRED},wysiwyg}}
		<script type="text/javascript">// <![CDATA[
			if ((window.wysiwyg_on) && (wysiwyg_on())) document.getElementById('{NAME*;}').readOnly=true;
		//]]></script>
	{+END}
	{+START,IF_PASSED,DEFAULT_PARSED}
	<textarea aria-hidden="true" cols="1" rows="1" style="display: none" readonly="readonly" name="{NAME*}_parsed">{DEFAULT_PARSED*}</textarea>
	{+END}

	{+START,IF_PASSED_AND_TRUE,RAW}<input type="hidden" name="pre_f_{NAME*}" value="1" />{+END}
</div>
