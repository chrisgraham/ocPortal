<div class="radio_list_picture" onclick="this.getElementsByTagName('img')[0].onclick();">
	<img style="padding: 3px; margin: 1px" onkeypress="this.onclick(event);" id="{$FIX_ID*,j_{NAME}_{CODE}}_img" onclick="var form=document.getElementById('{$FIX_ID*,j_{NAME}_{CODE}}').form; var ob=document.getElementById('{$FIX_ID*,j_{NAME}_{CODE}}_img'); choose_picture('{$FIX_ID*;,j_{NAME}_{CODE}}',ob,'{NAME*}'); if (typeof window.main_form_very_simple!='undefined') form.submit(); cancelBubbling(event);" src="{URL*}" title="" alt="{!SELECT_IMAGE}: {$STRIP_TAGS,{PRETTY*}}" /><br />
	
	{+START,IF,{$AND,{$NOT,{$JS_ON}},{$MATCH_KEY_MATCH,adminzone:admin_themes}}}<div class="accessibility_hidden">{+END}
	{+START,IF,{$NOT,{CHECKED}}}
		<label for="{$FIX_ID*,j_{NAME}_{CODE}}"><input onclick="if (typeof window.deselectAltURL!='undefined') deselectAltURL(this.form); if (typeof window.main_form_very_simple!='undefined') this.form.submit(); cancelBubbling(event);" class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{CODE}}" name="{NAME*}" value="{CODE*}" /> {PRETTY*}</label>
	{+END}
	{+START,IF,{CHECKED}}
		<label for="{$FIX_ID*,j_{NAME}_{CODE}}"><input onclick="if (typeof window.deselectAltURL!='undefined') deselectAltURL(this.form); if (typeof window.main_form_very_simple!='undefined') this.form.submit(); cancelBubbling(event);" class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{CODE}}" name="{NAME*}" value="{CODE*}" checked="checked" /> {PRETTY*}</label>
	{+END}
	{+START,IF,{$AND,{$NOT,{$JS_ON}},{$MATCH_KEY_MATCH,adminzone:admin_themes}}}</div>{+END}
</div>

