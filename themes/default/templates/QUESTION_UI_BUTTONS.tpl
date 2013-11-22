<h2>{TITLE*}</h2>

{MESSAGE}

<div class="question_ui_buttons">
	{+START,LOOP,BUTTONS}
		{+START,SET,IMG}{+OF,IMAGES,{_loop_key}}{+END}
		<a class="button__{$GET*,IMG} button_page" href="#" onclick="window.returnValue='{_loop_var;*}'; if (typeof window.faux_close!='undefined') window.faux_close(); else { try { window.get_main_ocp_window().focus(); } catch (e) {}; window.close(); }"><span>{_loop_var*}</span></a>
	{+END}
</div>
