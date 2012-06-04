<div aria-labeledby="{$FIX_ID,{PASS_ID|*}}_btgoto_{$FIX_ID,{NAME|*}}" role="tabpanel" class="comcode_big_tab" id="{$FIX_ID,{PASS_ID|*}}_section_{$FIX_ID,{NAME|*}}" style="display: {$?,{$OR,{DEFAULT},{$NOT,{$JS_ON}}},block,none}">
	<div class="float_surrounder">
		{CONTENT}
	</div>
</div>
