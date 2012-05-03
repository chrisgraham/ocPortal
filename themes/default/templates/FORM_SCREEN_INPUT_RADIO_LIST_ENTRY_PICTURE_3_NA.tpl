<div class="radio_list_picture">
	{+START,IF,{$JS_ON}}<div class="accessibility_hidden">{+END}
	<div class="accessibility_hidden"><label for="j_{NAME*}_">{!NA}</label></div><input class="input_radio" type="radio" id="j_{NAME*}_" name="{NAME*}" value="" />
	{+START,IF,{$JS_ON}}</div>{+END}
	<img style="margin: 1px" onkeypress="this.onclick(event);" id="{$FIX_ID*,j_{NAME}_}_img" onclick="choose_picture('{$FIX_ID*;,j_{NAME}_}',this,'{NAME*}',event);" class="inline_image" src="{$IMG*,ocf_emoticons/none}" alt="{!SELECT_IMAGE}: {!NA}" title="" />
</div>

