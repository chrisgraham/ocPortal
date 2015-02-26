{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}
<div class="pagination comcode_section_controller">
	<a id="{$FIX_ID,{PASS_ID|*}}_has_previous_yes" href="#" onclick="return flip_page(-1,'{$FIX_ID,{PASS_ID|*;}}',a{$FIX_ID,{PASS_ID|*}}_sections);" class="light">&laquo;&nbsp;{!PREVIOUS}</a>{+START,IF,{$MOBILE}} {+END}<span id="{$FIX_ID,{PASS_ID|*}}_has_previous_no" style="display: none" class="light">&laquo;&nbsp;{!PREVIOUS}</span>{+START,LOOP,SECTIONS}<a id="{$FIX_ID,{PASS_ID|*}}_goto_{_loop_var|*}" href="#" onclick="return flip_page('{_loop_var|*;}','{$FIX_ID,{PASS_ID|*;}}',a{$FIX_ID,{PASS_ID|*}}_sections);" title="{$STRIP_TAGS,{_loop_var}}: {!RESULTS_LAUNCHER_JUMP,{$STRIP_TAGS,{_loop_var}},{!PAGE}}" class="results_continue">{_loop_var}</a>{+START,IF,{$MOBILE}} {+END}<span style="display: none" id="{$FIX_ID,{PASS_ID|*}}_isat_{_loop_var|*}" class="results_page_num">{_loop_var}</span>{+END}<a id="{$FIX_ID,{PASS_ID|*}}_has_next_yes" href="#" onclick="return flip_page(1,'{$FIX_ID,{PASS_ID|*;}}',a{$FIX_ID,{PASS_ID|*}}_sections);" class="light">{!NEXT}&nbsp;&raquo;</a>{+START,IF,{$MOBILE}} {+END}<span id="{$FIX_ID,{PASS_ID|*}}_has_next_no" style="display: none" class="light">{!NEXT}&nbsp;&raquo;</span>
</div>

<script type="text/javascript">// <![CDATA[
	var a{$FIX_ID,{PASS_ID|}}_sections=[];
	add_event_listener_abstract(window,'load',function () {
		{+START,LOOP,SECTIONS}
			a{$FIX_ID,{PASS_ID|}}_sections.push('{$FIX_ID,{_loop_var|;}}');
		{+END}
		flip_page(0,'{$FIX_ID,{PASS_ID|;}}',a{$FIX_ID,{PASS_ID|}}_sections);
	} );
//]]></script>

