<div>
	<h3>
		{TITLE*}
	</h3>
	<ul role="navigation" class="actions_list">
		<li>
			<form title="{!LOAD} {$STRIP_TAGS,{TITLE|}}" action="#" method="post" class="inline" onsubmit="var explanation=get_main_ocp_window().document.getElementById('explanation'); var message=get_main_ocp_window().document.getElementById('message'); explanation.value='{EXPLANATION*;^}'; message.value='{MESSAGE*;^}'; if (typeof window.faux_close!='undefined') window.faux_close(); else window.close();">
				<div class="inline">
					<input class="button_hyperlink" type="submit" value="{!LOAD} {$STRIP_TAGS,{TITLE|}}" />
				</div>
			</form>
		</li>
		<li id="saved__{TITLE|}">{DELETE_LINK}</li>
	</ul>
</div>

<script type="text/javascript">// <![CDATA[
	document.getElementById('saved__{TITLE|}').getElementsByTagName('input')[1].onclick=function()
	{
		var form=this.form;
		window.fauxmodal_confirm('{!CONFIRM_DELETE;/,{TITLE}}',function(answer) { if (answer) form.submit(); });
		return false;
	};
//]]></script>
