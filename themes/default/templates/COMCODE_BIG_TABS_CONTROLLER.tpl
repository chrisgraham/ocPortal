{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}
{$CSS_INCLUDE,big_tabs}

<div class="comcode_big_tab_controller"{$?,{$VALUE_OPTION,html5}, role="tablist"}>
	{+START,LOOP,TABS}
		<div class="{$?,{$EQ,{_loop_key},0},big_tab_active big_tab_first,big_tab_inactive}" id="{$FIX_ID,{PASS_ID|*}}_btgoto_{$FIX_ID,{_loop_var|*}}">
			<a{$?,{$VALUE_OPTION,html5}, aria-controls="{$FIX_ID,{PASS_ID|*}}_section_{$FIX_ID,{NAME|*}}" role="tab"} href="#" onclick="return flip_page('{$FIX_ID,{_loop_var|*;}}','{$FIX_ID,{PASS_ID|*;}}',a{$FIX_ID,{PASS_ID|*}}_big_tab);">{_loop_var*}</a>
		</div>
	{+END}
</div>

<script type="text/javascript">// <![CDATA[
function move_between_big_tabs_{$FIX_ID,{PASS_ID|}}()
{
	var next_page=0,i,x;
	for (i=0;i<a{$FIX_ID,{PASS_ID|}}_big_tab.length;i++)
	{
		x=document.getElementById('{$FIX_ID,{PASS_ID|*}}_section_'+a{$FIX_ID,{PASS_ID|}}_big_tab[i]);
		if ((x.style.display=='block') && (x.style.position!='absolute'))
		{
			next_page=i+1;
		}
	}
	if (next_page==a{$FIX_ID,{PASS_ID|}}_big_tab.length) next_page=0;
	flip_page(a{$FIX_ID,{PASS_ID|}}_big_tab[next_page],'{$FIX_ID,{PASS_ID|;}}',a{$FIX_ID,{PASS_ID|}}_big_tab);
}

addEventListenerAbstract(window,'load',function () {
	big_tabs_init();

	window.a{$FIX_ID,{PASS_ID|}}_big_tab=[];
	{+START,LOOP,TABS}
		a{$FIX_ID,{PASS_ID|}}_big_tab.push('{$FIX_ID,{_loop_var|;}}');
	{+END}
	window.big_tabs_auto_cycler_{$FIX_ID,{PASS_ID|}}=null;
	window.big_tabs_switch_time_{$FIX_ID,{PASS_ID|}}={SWITCH_TIME%};
	flip_page(0,'{$FIX_ID,{PASS_ID|;}}',a{$FIX_ID,{PASS_ID|}}_big_tab);
} );
//]]></script>
