<div class="radio_list_picture">
	<img style="padding: 3px; margin: 1px" onkeypress="this.onclick(event);" id="{$FIX_ID*,j_{NAME}_{CODE}}_img" onclick="choose_picture('{$FIX_ID*;,j_{NAME}_{CODE}}',this,'{NAME*}');" src="{URL*}" title="" alt="{!SELECT_IMAGE}: {$STRIP_TAGS,{PRETTY*}}" /><br />
	
	{+START,IF,{$JS_ON}}<div class="accessibility_hidden">{+END}
	{+START,IF,{$NOT,{CHECKED}}}
		<label for="{$FIX_ID*,j_{NAME}_{CODE}}">{PRETTY*}</label> <input onclick="if (typeof window.deselectAltURL!='undefined') deselectAltURL(this.form);" class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{CODE}}" name="{NAME*}" value="{CODE*}" />
	{+END}
	{+START,IF,{CHECKED}}
		<label for="{$FIX_ID*,j_{NAME}_{CODE}}">{PRETTY*}</label> <input onclick="if (typeof window.deselectAltURL!='undefined') deselectAltURL(this.form);" class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{CODE}}" name="{NAME*}" value="{CODE*}" checked="checked" />
	{+END}
	{+START,IF,{$JS_ON}}</div>{+END}
</div>

