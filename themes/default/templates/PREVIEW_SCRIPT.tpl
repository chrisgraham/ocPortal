{+START,IF_NON_EMPTY,{SPELLING}}
	<div class="box box___preview_script"><div class="box_inner">
		<h2>{!SPELLCHECK}</h2>

		<div>
			{SPELLING}
		</div>
	</div></div>
{+END}
{+START,IF_NON_EMPTY,{KEYWORD_DENSITY}}
	<div class="box box___preview_script"><div class="box_inner">
		<h2>{!KEYWORDCHECK}</h2>

		<div>
			{KEYWORD_DENSITY}
		</div>
	</div></div>
{+END}
{+START,IF_NON_EMPTY,{VALIDATION}}
	<div class="box box___preview_script"><div class="box_inner">
		<h2>{!VALIDATION}</h2>

		<div>
			{VALIDATION}
		</div>
	</div></div>
{+END}
{+START,IF_EMPTY,{VALIDATION}}
	<section class="box box___preview_script global_middle_faux"><div class="box_inner">
		<h2>{!PREVIEW}</h2>

		<div class="preview_box">
			<div id="preview_box_inner" class="preview_box_inner">
				{$TRIM,{OUTPUT}}
			</div>
		</div>

		{+START,IF,{$MOBILE}}
			<script type="text/javascript">// <![CDATA[
				var inner=document.getElementById('preview_box_inner');
				add_event_listener_abstract(inner,browser_matches('gecko')?'DOMMouseScroll':'mousewheel',function(event) { inner.scrollTop-=event.wheelDelta?event.wheelDelta:event.detail; cancel_bubbling(event); if (typeof event.preventDefault!='undefined') event.preventDefault(); return false; } );
			//]]></script>
		{+END}

		{+START,IF,{$JS_ON}}
			<hr class="spaced_rule" />

			<form target="_self" action="{$FIND_SCRIPT*,preview}?page={$_GET&*,page}&amp;type={$_GET&*,type}&amp;utheme={$THEME&*}{$KEEP*}&amp;keep_mobile={$?,{$MOBILE},1,0}" method="post">
				{HIDDEN}

				{+START,IF,{$CONFIG_OPTION,mobile_support}}
					<p>
						<label for="mobile_version">{!MOBILE_VERSION}: <input {+START,IF,{$MOBILE}}checked="checked" {+END}onclick="this.form.action=this.form.action.replace(/keep_mobile=\d/g,'keep_mobile='+(this.checked?'1':'0')); if (window.parent) { try { window.parent.scrollTo(0,find_pos_y(window.parent.document.getElementById('preview_iframe'))); } catch(e) {}; window.parent.mobile_version_for_preview=this.checked; window.parent.document.getElementById('preview_button').onclick(event); return; } this.form.submit();" type="checkbox" id="mobile_version" name="_mobile_version" /></label>
						{+START,IF,{$MOBILE}}
							&ndash; <em>{!USE_MOUSE_WHEEL_SCROLL}</em>
						{+END}
					</p>
				{+END}
			</form>
		{+END}
	</div></section>
{+END}
