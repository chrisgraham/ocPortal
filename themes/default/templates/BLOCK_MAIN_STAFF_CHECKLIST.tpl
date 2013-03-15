<section id="tray_{!CHECK_LIST|}" class="box box___block_main_staff_checklist">
	<h3 class="toggleable_tray_title">
		<a href="#" onclick="set_task_hiding(false); return false;" id="checklist_show_all_link" class="top_left_toggleicon" title="{!SHOW_ALL}: {!CHECK_LIST}">{!SHOW_ALL}</a>
		<a href="#" onclick="set_task_hiding(true); return false;" id="checklist_hide_done_link" class="top_left_toggleicon">{!HIDE_DONE}</a>

		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{!CHECK_LIST|}');"><img alt="{!CONTRACT}: {$STRIP_TAGS,{!CHECK_LIST}}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>

		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{!CHECK_LIST|}');">{!CHECK_LIST}</a>
	</h3>

	<div class="toggleable_tray">
		{+START,IF_NON_EMPTY,{DATES}}
			<h4 class="checklist_header">{!REGULAR_TASKS}</h4>

			{DATES}
		{+END}

		{+START,IF_NON_EMPTY,{TODO_COUNTS}}
			<h4 class="checklist_header">{!ONE_OFF_TASKS}</h4>

			{TODO_COUNTS}
		{+END}

		<h4 class="checklist_header">{!CUSTOM_TASKS}</h4>

		<div id="customtasksgohere">
			{CUSTOM_TASKS}
		</div>

		<form title="{!CUSTOM_TASKS}" action="{URL*}" method="post" class="add_custom_task" onsubmit="return submit_custom_task(this);">
			<div class="right">
				<label class="accessibility_hidden" for="recur">{!TASK_LENGTH}</label>
				<label class="accessibility_hidden" for="recurevery">{!TASK_LENGTH_UNITS}</label>
				{!RECUR_EVERY,<input maxlength="8" value="" type="text" id="recur" name="recur" size="3" />,<select id="recurevery" name="recurevery"><option value="mins">{!dates:_MINUTES}</option><option value="hours">{!dates:_HOURS}</option><option value="days">{!dates:_DAYS}</option><option value="months">{!dates:_MONTHS}</option></select>}
				<input class="button_micro" type="submit" name="save" title="{!ADD} ({!CUSTOM_TASKS})" value="{!ADD}" />
			</div>
			<div class="constrain_field">
				<a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{$PAGE_LINK*,_SEARCH:userguide_comcode}"><img class="comcode_supported_icon" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a>
				<label class="accessibility_hidden" for="newtask">{!DESCRIPTION}</label>
				<input maxlength="255" value="" type="text" id="newtask" name="newtask" size="32" />
			</div>
		</form>

		{+START,IF_NON_EMPTY,{NO_TIMES}}
			<h4 class="checklist_header">{!OTHER_MAINTENANCE}</h4>

			<div class="float_surrounder checklist_other_maintenance">
				{NO_TIMES}
			</div>
		{+END}
	</div>
</section>

{$REQUIRE_JAVASCRIPT,javascript_staff}

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		set_task_hiding(true);
		{+START,IF,{$JS_ON}}
			handle_tray_cookie_setting('{!CHECK_LIST|}');
		{+END}
	} );
//]]></script>
