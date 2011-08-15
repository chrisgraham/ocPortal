{$SET,RAND_ID_OVERLAY,rand{$RAND}}

<script type="text/javascript">// <![CDATA[
addEventListenerAbstract(window,'load',function () {
	{+START,IF_NON_EMPTY,{ID}}
	if (ReadCookie('og_{ID;}')!='1')
	{
	{+END}
		window.setTimeout(function() { smoothScroll(0); var element=document.getElementById('{$GET%,RAND_ID_OVERLAY}'); element.style.display='block'; element.parentNode.removeChild(element); document.body.appendChild(element); var bi=document.getElementById('body_inner'); if (bi) setOpacity(bi,0.4); if (typeof window.nereidFade!='undefined') { setOpacity(element,0.0); nereidFade(element,100,30,3); } if ({TIMEOUT}!=-1) window.setTimeout(function() { var bi=document.getElementById('body_inner'); if (bi) setOpacity(bi,1.0); if (element) element.style.display='none'; } , {TIMEOUT}); } , {TIMEIN}+100);
	{+START,IF_NON_EMPTY,{ID}}
	}
	{+END}
} );
//]]></script>

<div class="comcode_overlay" id="{$GET%,RAND_ID_OVERLAY}" style="display: none; position: absolute; left: {X*}px; top: {Y*}px; width: {WIDTH*}px; height: {HEIGHT*}px">
	<div class="comcode_overlay_main">
		{EMBED}
	</div>

	<div class="comcode_overlay_dismiss">
		<hr class="spaced_rule" />

		<p class="community_block_tagline">[ <a href="#" onclick="var bi=document.getElementById('body_inner'); if (bi) setOpacity(bi,1.0); document.getElementById('{$GET%,RAND_ID_OVERLAY}').style.display='none'; if ('{ID;}'!='') SetCookie('og_{ID*;}','1',365); return false;">{!DISMISS}</a> ]</p>
	</div>
</div>
