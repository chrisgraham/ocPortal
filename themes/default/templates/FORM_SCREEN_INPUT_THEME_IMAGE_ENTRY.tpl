<div class="radio_list_picture{+START,IF_PASSED_AND_TRUE,LINEAR} linear{+END}" onkeypress="if (entered_pressed(event)) return this.onclick.call([event]); else return null;" onclick="this.getElementsByTagName('img')[0].onclick(event);">
	<img class="selectable_theme_image" onkeypress="this.onclick(event);" id="{$FIX_ID*,j_{NAME}_{CODE}}_img" onclick="var form=document.getElementById('{$FIX_ID;*,j_{NAME;*}_{CODE;*}}').form; var ob=document.getElementById('{$FIX_ID;*,j_{NAME;*}_{CODE;*}}_img'); choose_picture('{$FIX_ID*;,j_{NAME;*}_{CODE;*}}',ob,'{NAME;*}',event); if (typeof window.main_form_very_simple!='undefined') form.submit(); cancel_bubbling(event);" src="{URL*}" alt="{!SELECT_IMAGE}: {$STRIP_TAGS,{PRETTY*}}" />

	<div{+START,IF,{$AND,{$NEQ,{$PAGE},admin_themes,admin_zones},{$JS_ON}}} class="accessibility_hidden"{+END}>
		<label for="{$FIX_ID*,j_{NAME}_{CODE}}">
			<input onclick="if (this.disabled) return; if (typeof window.deselect_alt_url!='undefined') deselect_alt_url(this.form); if (typeof window.main_form_very_simple!='undefined') this.form.submit(); cancel_bubbling(event);" class="input_radio{+START,IF,{$JS_ON}} accessibility_hidden{+END}" type="radio" id="{$FIX_ID*,j_{NAME}_{CODE}}" name="{NAME*}" value="{CODE*}"{+START,IF,{CHECKED}} checked="checked"{+END} />
			{PRETTY*}
		</label>
	</div>
</div>

