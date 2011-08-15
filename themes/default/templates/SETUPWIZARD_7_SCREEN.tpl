{TITLE}

{FORM}

<script type="text/javascript">// <![CDATA[
	document.getElementById('rules').onclick=function() { smoothScroll(findPosY(document.getElementById('rules_set'))); };
//]]></script>

<br />

{+START,BOX,{!PREVIEW},,med}
	<div id="rules_set">
		<div id="preview_box_balanced" style="display: block">
			{BALANCED}
		</div>
		<div id="preview_box_corporate" style="display: none">
			{CORPORATE}
		</div>
		<div id="preview_box_liberal" style="display: none">
			{LIBERAL}
		</div>
	</div>
{+END}

