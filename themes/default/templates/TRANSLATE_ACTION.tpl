{+START,IF,{$JS_ON}}
	<a href="#" onclick="event.returnValue=false; translate('{NAME;*}','{OLD;^*}{$,Intentionally no further escaping as it's implicit in lang string encodings}','{LANG_FROM;*}','{LANG_TO;*}'); return false;"><img src="{$IMG*,icons/14x14/translate}" title="{!AUTO_TRANSLATE}" alt="{!AUTO_TRANSLATE}" /></a>
{+END}
