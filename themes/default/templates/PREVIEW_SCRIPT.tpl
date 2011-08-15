{+START,IF_NON_EMPTY,{SPELLING}}
	{+START,BOX,{!SPELLCHECK},100%,curved}
		{SPELLING}
	{+END}
	<br />
{+END}
{+START,IF_NON_EMPTY,{KEYWORD_DENSITY}}
	{+START,BOX,{!KEYWORDCHECK},100%,curved}
		{KEYWORD_DENSITY}
	{+END}
	<br />
{+END}
{+START,IF_NON_EMPTY,{VALIDATION}}
	{+START,BOX,{!VALIDATION},100%,curved}
		{VALIDATION}
	{+END}
	<br />
{+END}
{+START,IF_EMPTY,{VALIDATION}}
	{+START,BOX,{!PREVIEW},100%,curved}
		<div class="preview_box">
			<div id="preview_box_inner" class="preview_box_inner">
				{OUTPUT}
			</div>
		</div>
		
		{+START,IF,{$MOBILE}}
			<script type="text/javascript">// <![CDATA[
				var inner=document.getElementById('preview_box_inner');
				addEventListenerAbstract(inner,browser_matches('gecko')?'DOMMouseScroll':'mousewheel',function(event) { inner.scrollTop-=event.wheelDelta?event.wheelDelta:event.detail; cancelBubbling(event); if (typeof event.preventDefault!='undefined') event.preventDefault(); return false; } );
			//]]></script>
		{+END}
		
		{+START,IF,{$JS_ON}}
			<hr class="spaced_rule" />
		
			<form target="_self" action="{$FIND_SCRIPT*,preview}?page={$_GET&*,page}&amp;type={$_GET&*,type}&amp;utheme={$THEME&*}{$KEEP*}&amp;keep_mobile={$?,{$MOBILE},1,0}" method="post">
				{HIDDEN}

				{+START,IF,{$CONFIG_OPTION,mobile_support}}
					<p>
						<label for="mobile_version">{!MOBILE_VERSION;} <input {+START,IF,{$MOBILE}}checked="checked" {+END}onclick="this.form.action=this.form.action.replace(/keep_mobile=\d/g,'keep_mobile='+(this.checked?'1':'0')); if (window.parent) { window.parent.scrollTo(0,findPosY(window.parent.document.getElementById('preview_iframe'))); window.parent.mobile_version_for_preview=this.checked; window.parent.document.getElementById('preview_button').onclick(); return; } this.form.submit();" type="checkbox" id="mobile_version" name="_mobile_version" /></label>
						{+START,IF,{$MOBILE}}
							&ndash; <em>{!USE_MOUSE_WHEEL_SCROLL}</em>
						{+END}
					</p>
				{+END}
			</form>
		{+END}
	{+END}
{+END}
