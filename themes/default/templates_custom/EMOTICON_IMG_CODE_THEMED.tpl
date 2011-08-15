{+START,IF,{$NOT,{$IS_IN_GROUP,{$CONFIG_OPTION,ocjester_emoticon_magnet_shown_for}}}}
	<img class="inline_image" title="" alt="{EMOTICON*}" src="{$IMG*,{SRC},1}" />
{+END}
{+START,IF,{$IS_IN_GROUP,{$CONFIG_OPTION,ocjester_emoticon_magnet_shown_for}}}
	{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}
	<div id="smilecrazy{UNIQID%}">&nbsp;</div>
	<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		if (typeof window.crazy_criters=='undefined')
		{
			window.crazy_criters=[];
			window.setInterval('crazy_tick();',300);
		}

		var my_id=parseInt(Math.random()*10000),smilecrazy=document.getElementById('smilecrazy{UNIQID%}');
		setInnerHTML(smilecrazy,'<img id="'+my_id+'" class="inline_image" style="position: relative" title="" alt="{!EMOTICON;}" src="{$IMG*,{SRC},1}" />');
		crazy_criters.push(my_id);
	} );
	//]]></script>
	<noscript>
		<img class="inline_image" title="" alt="{EMOTICON*}" src="{$IMG*,{SRC},1}" />
	</noscript>
{+END}
