<h2>{TITLE*}</h2>

{MESSAGE}

<div class="question_ui_buttons">
	{+START,LOOP,BUTTONS}
		{+START,SET,IMG}{+OF,IMAGES,{_loop_key}}{+END}
		{+START,IF_NON_EMPTY,{$GET,IMG}}
			<a href="#" onclick="window.returnValue='{_loop_var*;}'; if (typeof window.faux_close!='undefined') window.faux_close(); else { try { window.get_main_ocp_window().focus(); } catch (e) {}; window.close(); }"><img class="button_page" src="{$IMG*,page/{$GET,IMG}}" alt="{_loop_var*}" /></a>
		{+END}
		{+START,IF_EMPTY,{$GET,IMG}}
			<button class="button_page" type="submit" onclick="window.returnValue='{_loop_var*;}'; if (typeof window.faux_close!='undefined') window.faux_close(); else { try { window.get_main_ocp_window().focus(); } catch (e) {}; window.close(); }">{_loop_var*}</button>
		{+END}
	{+END}
</div>
