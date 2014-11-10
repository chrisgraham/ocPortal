<div aria-labeledby="{$FIX_ID,{PASS_ID|*}}_{$GET%,big_tab_sets}_btgoto_{$FIX_ID,{NAME|*}}" role="tabpanel" class="comcode_big_tab" id="{$FIX_ID,{PASS_ID|*}}_{$GET%,big_tab_sets}_section_{$FIX_ID,{NAME|*}}" style="display: {$?,{$OR,{DEFAULT},{$NOT,{$JS_ON}}},block,none}">
	<div class="float_surrounder">
		{CONTENT}
	</div>
</div>
