<div class="checklist_row" onkeypress="this.onclick(event);" onclick="{$?,{$EQ,{TASKDONE},not_completed},mark_done,mark_undone}(this,{ID%});" onmouseover="this.getElementsByTagName('img')[0].setAttribute('src','{$IMG;*,checklist/cross2}'); this.className='checklist_row_highlight';" onmouseout="this.getElementsByTagName('img')[0].setAttribute('src','{$IMG;*,checklist/cross}'); this.className='checklist_row';">
	<div class="float_surrounder">
		<p class="checklist_task_status">
			{!ADDED,<strong>{ADD_TIME*}</strong>}{+START,IF_NON_EMPTY,{RECURINTERVAL}}, {!RECUR_EVERY,{RECURINTERVAL*},{RECUREVERY*}}{+END}
			{+START,IF,{$JS_ON}}
				<a onclick="cancelBubbling(event,this); var t=this; window.fauxmodal_confirm('{!CONFIRM_DELETE;*,{$STRIP_TAGS,{TASKTITLE}}}',function(result) { if (result) { delete_custom_task(t,'{ID%}'); } }); return false;" href="#"><img src="{$IMG*,checklist/cross}" title="{!DELETE}" alt="{!DELETE}: {$STRIP_TAGS,{TASKTITLE}}" /></a>
			{+END}
		</p>
		<p class="checklist_task"><img src="{$IMG*,checklist/{TASKDONE}}" title="{!MARK_TASK_DONE}" alt="" /> {TASKTITLE}</p>
	</div>
</div>
