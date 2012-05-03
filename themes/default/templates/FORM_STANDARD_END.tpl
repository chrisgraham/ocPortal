{+START,IF_PASSED,PREVIEW}{+START,IF,{$JS_ON}}{+START,IF,{$CONFIG_OPTION,enable_previews}}
	{+START,IF_NON_PASSED,SKIP_VALIDATION}{+START,IF,{$OR,{$CONFIG_OPTION,enable_markup_validation},{$CONFIG_OPTION,enable_spell_check},{$AND,{$HAS_SPECIFIC_PERMISSION,perform_keyword_check},{$CONFIG_OPTION,enable_keyword_density_check}}}}
		<div class="preview_validation_box">
			{+START,BOX,{!PERFORM_CHECKS_ON_PREVIEW},,med}
				{+START,IF,{$CONFIG_OPTION,enable_markup_validation}}
					<div>{!VALIDATION}:
						<label for="perform_validation_no"><input title="{!DESCRIPTION_VALIDATION_ON_PREVIEW_0}" {+START,IF,{$NOT,{$HAS_SPECIFIC_PERMISSION,perform_markup_validation_by_default}}}checked="checked" {+END}type="radio" name="perform_validation" value="0" id="perform_validation_no" />{!NO}</label>
						<label for="perform_validation_yes"><input title="{!DESCRIPTION_VALIDATION_ON_PREVIEW_1}" {+START,IF,{$HAS_SPECIFIC_PERMISSION,perform_markup_validation_by_default}}checked="checked" {+END}type="radio" name="perform_validation" value="1" id="perform_validation_yes" />{!YES}</label>
						<label for="perform_validation_more"><input title="{!DESCRIPTION_VALIDATION_ON_PREVIEW_2}" type="radio" name="perform_validation" value="2" id="perform_validation_more" />{!MANUAL_CHECKS_TOO}</label>
					</div>
					<br />
				{+END}
				{+START,IF,{$CONFIG_OPTION,enable_spell_check}}
					<div><label for="perform_spellcheck">{!SPELLCHECK}: <input title="{$STRIP_TAGS`,{!SPELLCHECK}}" type="checkbox" checked="checked" name="perform_spellcheck" value="1" id="perform_spellcheck" /></label></div><br />
				{+END}
				{+START,IF,{$CONFIG_OPTION,enable_keyword_density_check}}{+START,IF,{$HAS_SPECIFIC_PERMISSION,perform_keyword_check}}
					<div><label for="perform_keywordcheck">{!KEYWORDCHECK}: <input title="{$STRIP_TAGS`,{!KEYWORDCHECK}}" type="checkbox" name="perform_keywordcheck" value="1" id="perform_keywordcheck" /></label></div>
				{+END}{+END}
			{+END}
		</div>
	{+END}{+END}
{+END}{+END}{+END}

<p class="proceed_button{+START,IF_PASSED,SUBMIT_BUTTON_CLASS} {SUBMIT_BUTTON_CLASS*}{+END}">
	{+START,IF_PASSED,PREVIEW}{+START,IF,{$JS_ON}}{+START,IF,{$CONFIG_OPTION,enable_previews}}
		<input class="button_page" onclick="if (typeof this.form=='undefined') var form=window.form_submitting; else var form=this.form; if (form.onsubmit) { var test=form.onsubmit(event); if (!test) return; } if (do_form_preview(form,'{$PREVIEW_URL*;}{$KEEP*;}{+START,IF_PASSED,THEME}&amp;utheme={THEME*}{+END}'+((typeof window.mobile_version_for_preview=='undefined')?'':('&amp;keep_mobile='+(window.mobile_version_for_preview?'1':'0'))){+START,IF_PASSED,SEPARATE_PREVIEW}{+START,IF,{SEPARATE_PREVIEW}},true{+END}{+END})) form.submit(); return;" id="preview_button" accesskey="p" tabindex="{+START,IF_PASSED,TABINDEX}{TABINDEX}{+END}{+START,IF_NON_PASSED,TABINDEX}250{+END}" type="button" value="{!PREVIEW}" />
	{+END}{+END}{+END}
	<input class="button_page" onclick="if (typeof this.form=='undefined') var form=window.form_submitting; else var form=this.form; return do_form_submit(form,event);" {+START,IF_NON_PASSED,SECONDARY_FORM}id="submit_button" accesskey="u" {+END}tabindex="{+START,IF_PASSED,TABINDEX}{TABINDEX}{+END}{+START,IF_NON_PASSED,TABINDEX}250{+END}" {+START,IF,{$JS_ON}}type="button"{+END}{+START,IF,{$NOT,{$JS_ON}}}type="submit"{+END} value="{SUBMIT_NAME*}" />
</p>

{+START,IF_PASSED,PREVIEW}{+START,IF,{$JS_ON}}{+START,IF,{$CONFIG_OPTION,enable_previews}}
	{+START,IF,{$FORCE_PREVIEWS}}
		<script type="text/javascript">// <![CDATA[
			document.getElementById('submit_button').style.display='none';
		//]]></script>
	{+END}

	<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} title="{!PREVIEW}" name="preview_iframe" id="preview_iframe" src="{$BASE_URL*}/uploads/index.html" class="preview_iframe">{!PREVIEW}</iframe>
{+END}{+END}{+END}

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,"load",function() {
		{+START,IF_PASSED,JAVASCRIPT}
			{JAVASCRIPT`}
		{+END}
		{+START,IF_NON_PASSED,SECONDARY_FORM}
			if (typeof window.fix_form_enter_key!='undefined') fix_form_enter_key(document.getElementById('submit_button').form);
		{+END}
	} );
//]]></script>

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,IF,{$HAS_SPECIFIC_PERMISSION,see_software_docs}}{+START,IF_PASSED,STAFF_HELP_URL}{+START,IF,{$SHOW_DOCS}}
	{+START,INCLUDE,STAFF_ACTIONS}
		STAFF_ACTIONS_TITLE={!STAFF_ACTIONS}
		1_URL={STAFF_HELP_URL}
		1_TITLE={!HELP}
		1_REL=help
	{+END}
{+END}{+END}{+END}

