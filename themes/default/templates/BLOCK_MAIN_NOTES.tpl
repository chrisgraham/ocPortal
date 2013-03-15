<div class="form_ajax_target">
	{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic}}
		<form title="{$STRIP_TAGS,{TITLE}}" method="post" action="{URL*}">
			<div class="accessibility_hidden"><label for="n_block_{TITLE|}">{!NOTES}</label></div>
			<div class="constrain_field">
				<textarea onfocus="this.setAttribute('rows','23');" onblur="if (!this.form.disable_size_change) this.setAttribute('rows','10');" class="wide_field{+START,IF,{SCROLLS}} textarea_scroll{+END}" cols="80" id="n_block_{TITLE|}" rows="10" name="new">{CONTENTS*}</textarea>
			</div>
			<div class="button_panel">
				<input onclick="disable_button_just_clicked(this);{+START,IF,{$HAS_SPECIFIC_PERMISSION,comcode_dangerous}} return ajax_form_submit(event,this.form,'{BLOCK_NAME~;*}','{MAP~;*}');{+END}" class="button_pageitem" type="submit" onmouseover="this.form.disable_size_change=true;" onmouseout="this.form.disable_size_change=false;" value="{!SAVE}" />
			</div>
		</form>

		<script type="text/javascript">// <![CDATA[
			require_javascript('javascript_ajax');
			require_javascript('javascript_validation');
		//]]></script>
	{+END}
</div>
