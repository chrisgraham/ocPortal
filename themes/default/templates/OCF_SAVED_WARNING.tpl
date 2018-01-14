<div>
	<h3>
		{TITLE*}
	</h3>
	<ul role="navigation" class="actions_list">
		<li>
			<form title="{!LOAD} {TITLE*}" action="#" method="post" class="inline" id="saved_use__{TITLE|}">
				<div class="inline">
					<input class="button_hyperlink" type="submit" value="{!LOAD} {TITLE*}" />
				</div>
			</form>
		</li>
		<li id="saved_delete__{TITLE|}">{DELETE_LINK}</li>
	</ul>
</div>

<script type="text/javascript">// <![CDATA[
	document.getElementById('saved_use__{TITLE|}').onsubmit=function() {
		var win=get_main_ocp_window();

		var explanation=win.document.getElementById('explanation');
		explanation.value='{EXPLANATION*;^}';

		var message=win.document.getElementById('message');
		win.insert_textbox(message,'{MESSAGE*;^}',null,false,'{MESSAGE_HTML*;^}');

		if (typeof window.faux_close!='undefined') window.faux_close(); else window.close();

		return false;
	};

	document.getElementById('saved_delete__{TITLE|}').getElementsByTagName('input')[1].onclick=function() {
		var form=this.form;
		window.fauxmodal_confirm('{!CONFIRM_DELETE;/,{TITLE}}',function(answer) { if (answer) form.submit(); });
		return false;
	};
//]]></script>
