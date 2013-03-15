{$JAVASCRIPT_INCLUDE,javascript_jquery}
{$JAVASCRIPT_INCLUDE,javascript_jquery_ui_core}
{$JAVASCRIPT_INCLUDE,javascript_jquery_effects_core}
{$JAVASCRIPT_INCLUDE,javascript_jquery_flip}
{$CSS_INCLUDE,flip}

<div class="flipbox" id="flipbox_{RAND%}">
	{$COMCODE,{PARAM}}
</div>

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		var _e=document.getElementById("flipbox_{RAND%}");
		_e.onclick=function() {
			var e=$("#flipbox_{RAND%}");
			if (typeof _e.flipped=='undefined') _e.flipped=false;
			if (_e.flipped)
			{
				e.revertFlip();
			} else
			{
				e.flip({
					color:'{+START,IF,{$NOT,{$IN_STR,{FINAL_COLOR},#}}}#{+END}{FINAL_COLOR/^;}',
					speed:{SPEED%},
					direction:'tb',
					content:'{CONTENT/^;}'
				})
			};
			_e.flipped=!_e.flipped;
		}
	} );
//]]></script>
