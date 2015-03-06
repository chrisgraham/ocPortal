<div class="form_ajax_target">
	{+START,BOX,{!EXTERNAL_LINKS},,,tray_open,,,1,<a title="{!EDIT}: {!EXTERNAL_LINKS}" href="#" class="topleftlink" id="editlinks" onclick="var linkslist=document.getElementById('stafflinkslist'); var editlinksform=next(linkslist); return switcheroo(linkslist\,editlinksform);">{!EDIT}</a>}
		<div class="wide_table_wrap">
			{+START,IF,{$JS_ON}}
				<ol id="stafflinkslist">
					{+START,LOOP,FORMATTEDLINKS}
						<li><a target="_blank" title="{TITLE*}: {!LINK_NEW_WINDOW}" href="{URL*}">{TITLE*}</a>{+START,IF_NON_EMPTY,{DESC}}<br />{DESC*}{+END}</li>
					{+END}
				</ol>
			{+END}
			<form title="{!EDIT}: {!LINKS}" action="{URL*}" method="post" {+START,IF,{$JS_ON}} style="display: none"{$?,{$VALUE_OPTION,html5}, aria-hidden="true"}{+END}>
				<div class="constrain_field"><label for="stafflinksedit" class="accessibility_hidden">{!EDIT}</label><textarea cols="100" rows="30" id="stafflinksedit" name="stafflinksedit" class="wide_field">{+START,LOOP,UNFORMATTEDLINKS}{LINKS*}

{+END}</textarea></div>
				<div class="button_panel">
					<input onclick="disable_button_just_clicked(this);{+START,IF,{$HAS_SPECIFIC_PERMISSION,comcode_dangerous}} return ajax_form_submit(event,this.form,'{BLOCK_NAME~;*}','{MAP~;*}');{+END}" class="button_pageitem" type="submit" value="{!SAVE}" />
				</div>
			</form>
		</div>

		<script type="text/javascript">// <![CDATA[
			require_javascript('javascript_ajax');
			require_javascript('javascript_validation');

			function next(elem)
			{
				do
				{
					elem=elem.nextSibling;
				}
				while (elem && elem.nodeType!=1);

				return elem;
			};

			function switcheroo(hide, show)
			{
				if (hide.style.display=='none')
				{
					set_display_with_aria(hide,'block');
					set_display_with_aria(show,'none');
				} else
				{
					set_display_with_aria(hide,'none');
					set_display_with_aria(show,'block');
				}

				return false;
			};
		//]]></script>
	{+END}
</div>
