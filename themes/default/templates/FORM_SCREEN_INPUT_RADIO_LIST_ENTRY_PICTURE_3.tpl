<div class="radio_list_picture">
	{+START,IF,{$JS_ON}}<div class="accessibility_hidden">{+END}
	<div class="accessibility_hidden"><label for="{$FIX_ID*,j_{NAME}_{CODE}}">{!IMAGE}</label></div><input {+START,IF,{CHECKED}}checked="checked" {+END}class="input_radio" type="radio" id="{$FIX_ID*,j_{NAME}_{CODE}}" name="{NAME*}" value="{CODE*}" />
	{+START,IF,{$JS_ON}}</div>{+END}
	<img style="margin: 1px" onkeypress="this.onclick(event);" id="{$FIX_ID*,j_{NAME}_{CODE}}_img" onclick="choose_picture('{$FIX_ID*;,j_{NAME}_{CODE}}',this,'{NAME*}');" class="inline_image" src="{URL*}" alt="{!SELECT_IMAGE}: {$STRIP_TAGS,{CODE*}}" title="" />
</div>

