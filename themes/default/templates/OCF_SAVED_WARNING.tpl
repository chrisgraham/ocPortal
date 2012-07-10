<div>
	<h3>
		{TITLE*}
	</h3>
	<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list">
		<li>
			&raquo;
			<form title="{!LOAD} {$STRIP_TAGS,{TITLE|}}" action="#" method="post" class="inline" onsubmit="var explanation=get_main_ocp_window().document.getElementById('explanation'); var message=opener.document.getElementById('message'); explanation.value='{EXPLANATION*^;}'; message.value='{MESSAGE*^;}'; if (typeof window.faux_close!='undefined') window.faux_close(); else window.close();">
				<div class="inline">
					<input class="buttonhyperlink" type="submit" value="{!LOAD} {$STRIP_TAGS,{TITLE|}}" />
				</div>
			</form>
		</li>
		<li id="saved__{TITLE|}">&raquo; {DELETE_LINK}</li>
	</ul>
</div>
<br />

<script type="text/javascript">// <![CDATA[
	document.getElementById('saved__{TITLE|}').getElementsByTagName('input')[1].onclick=function()
	{
		window.fauxmodal_confirm('{!CONFIRM_DELETE;/,{TITLE}}',function(answer) { if (answer) form.submit(); });
		return false;
	};
//]]></script>
