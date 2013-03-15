{+START,BOX,{!CHECK_LIST},,{$?,{$GET,in_panel},panel,classic},tray_open,,,1,<a href="#" onclick="set_task_hiding(false); return false;" id="checklist_show_all_link" class="topleftlink" title="{!SHOW_ALL}: {!CHECK_LIST}">{!SHOW_ALL}</a><a href="#" onclick="set_task_hiding(true); return false;" id="checklist_hide_done_link" class="topleftlink">{!HIDE_DONE}</a>}
	{+START,IF_NON_EMPTY,{DATES}}
		<h4 class="checklistheader">{!REGULAR_TASKS}</h4>

		{DATES}
	{+END}

	{+START,IF_NON_EMPTY,{TODO_COUNTS}}
		<h4 class="checklistheader">{!ONE_OFF_TASKS}</h4>

		{TODO_COUNTS}
	{+END}

	<h4 class="checklistheader">{!CUSTOM_TASKS}</h4>

	<div id="customtasksgohere">
		{CUSTOMTASKS}
	</div>

	<form title="{!CUSTOM_TASKS}" action="{URL*}" method="post" id="addcustomtask" onsubmit="return submit_custom_task(this);">
		<div class="right">
			<label class="accessibility_hidden" for="recur">{!TASK_LENGTH}</label>
			<label class="accessibility_hidden" for="recurevery">{!TASK_LENGTH_UNITS}</label>
			({!RECUR_EVERY,<input maxlength="8" value="" type="text" id="recur" name="recur" size="3" />,<select id="recurevery" name="recurevery"><option value="mins">{!dates:_MINUTES}</option><option value="hours">{!dates:_HOURS}</option><option value="days">{!dates:_DAYS}</option><option value="months">{!dates:_MONTHS}</option></select>} )
			<input class="button_micro" type="submit" name="save" title="{!ADD} ({!CUSTOM_TASKS})" value="{!ADD}" />
		</div>
		<div class="constrain_field">
			<a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{$PAGE_LINK*,_SEARCH:userguide_comcode}"><img class="comcode_button" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a>
			<label class="accessibility_hidden" for="newtask">{!DESCRIPTION}</label>
			<input maxlength="255" value="" type="text" id="newtask" name="newtask" size="32" />
		</div>
	</form>

	{+START,IF_NON_EMPTY,{NO_TIMES}}
		<h4 class="checklistheader">{!OTHER_MAINTENANCE}</h4>

		<div class="float_surrounder checklist_other_maintenance">
			{NO_TIMES}
		</div>
	{+END}
{+END}

<script type="text/javascript">// <![CDATA[
	function set_task_hiding(hide_done)
	{
		var checklist_rows=get_elements_by_class_name(document,'checklist_row'),row_imgs,src;
		for (var i=0;i<checklist_rows.length;i++)
		{
			row_imgs=checklist_rows[i].getElementsByTagName('img');
			if (hide_done)
			{
				src=row_imgs[row_imgs.length-1].getAttribute('src');
				if (row_imgs[row_imgs.length-1].origsrc) src=row_imgs[row_imgs.length-1].origsrc;
				if (src && src.indexOf('checklist1')!=-1)
					checklist_rows[i].style.display='none';
			} else
			{
				if ((typeof window.nereidFade!='undefined') && (checklist_rows[i].style.display=='none'))
				{
					setOpacity(checklist_rows[i],0.0);
					nereidFade(checklist_rows[i],100,30,4);
				}
				checklist_rows[i].style.display='block';
			}
		}

		if (hide_done)
		{
			document.getElementById('checklist_show_all_link').style.display='block';
			document.getElementById('checklist_hide_done_link').style.display='none';
		} else
		{
			document.getElementById('checklist_show_all_link').style.display='none';
			document.getElementById('checklist_hide_done_link').style.display='block';
		}
	}

	function submit_custom_task(form)
	{
		var new_task=load_snippet('checklist_task_manage&type=add&recurevery='+window.encodeURIComponent(form.elements['recurevery'].value)+'&recurinterval='+window.encodeURIComponent(form.elements['recur'].value)+'&tasktitle='+window.encodeURIComponent(form.elements['newtask'].value));

		form.elements['recurevery'].value='';
		form.elements['recur'].value='';
		form.elements['newtask'].value='';

		setInnerHTML(document.getElementById('customtasksgohere'),new_task,true);

		return false;
	}

	function delete_custom_task(ob,id)
	{
		load_snippet('checklist_task_manage&type=delete&id='+window.encodeURIComponent(id));
		ob.parentNode.parentNode.parentNode.style.display='none';

		return false;
	}

	function mark_done(ob,id)
	{
		load_snippet('checklist_task_manage&type=mark_done&id='+window.encodeURIComponent(id));
		ob.onclick=function() { mark_undone(ob,id); };
		ob.getElementsByTagName('img')[1].setAttribute('src','{$IMG;,checklist/checklist1}');
	}

	function mark_undone(ob,id)
	{
		load_snippet('checklist_task_manage&type=mark_undone&id='+window.encodeURIComponent(id));
		ob.onclick=function() { mark_done(ob,id); };
		ob.getElementsByTagName('img')[1].setAttribute('src','{$IMG;,checklist/not_completed}');
	}

	new Image().src='{$IMG;,checklist/cross2}';
	new Image().src='{$IMG;,checklist/toggleicon2}';
	set_task_hiding(true);
//]]></script>
