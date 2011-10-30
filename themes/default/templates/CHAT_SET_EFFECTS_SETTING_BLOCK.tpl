{+START,IF_PASSED,USERNAME}{+START,IF_PASSED,MEMBER_ID}
	<p>
		{!OVERRIDES_FOR_FRIEND,{USERNAME*}}
		<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('user_{MEMBER_ID*;}','block'); return false;"><img id="e_user_{MEMBER_ID*;}" alt="{$?,{HAS_SOME},{!CONTRACT},{!EXPAND}}" title="{$?,{HAS_SOME},{!CONTRACT},{!EXPAND}}" src="{$?,{HAS_SOME},{$IMG*,contract},{$IMG*,expand}}" /></a>
	</p>
{+END}{+END}

<div{+START,IF_PASSED,MEMBER_ID} class="toggler_main" id="user_{MEMBER_ID*}"{+START,IF,{$NOT,{HAS_SOME}}} style="{$JS_ON,display: none,}{+END}"{+END}>
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table scrollable_inside">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 198px" />
				<col style="width: 100%" />
			</colgroup>
		{+END}

		<tbody>
			{+START,LOOP,EFFECTS}
				<tr class="field_input">
					<th id="requirea__select_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" class="de_th dottedborder_barrier_a_nonrequired">
						<span class="form_field_name field_name">{EFFECT_TITLE*}</span>
					</th>
	
					{+START,IF,{$MOBILE}}
						</tr>

						<tr class="field_input">
					{+END}

					<td id="required__select_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" class="dottedborder_barrier_b_nonrequired">
						<label class="accessibility_hidden" for="select_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}">{EFFECT_TITLE*}</label>
						<select name="select_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" id="select_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}">
							{+START,IF_PASSED,USERNAME}
								<option {+START,IF,{$EQ,-1,{VALUE}}}selected="selected" {+END}value="-1">{$STRIP_TAGS,{!_UNSET}}</option>
							{+END}
							<option {+START,IF,{$EQ,,{VALUE}}}selected="selected" {+END}value="">{!NONE}</option>
							{+START,LOOP,LIBRARY}
								<option {+START,IF,{$EQ,{EFFECT},{VALUE}}}selected="selected" {+END}value="{EFFECT*}">{EFFECT_SHORT*}</option>
							{+END}
							{+START,IF,{$EQ,{$SUBSTR,{VALUE},0,8},uploads/}}
								<option selected="selected" value="{VALUE*}">{!CUSTOM_UPLOAD}</option>
							{+END}
						</select>

						<input type="button" onclick="var ob=document.getElementById('select_{KEY*;}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}'); var val=ob.options[ob.selectedIndex].value; if (val=='') window.alert('{!PLEASE_SELECT_SOUND;}'); else play_sound_url(val); return false;" title="{EFFECT_TITLE*}" value="{!TEST_SOUND}" />
					</td>
				</tr>

				<tr class="field_input">
					<th id="requirea__upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" class="de_th dottedborder_barrier_a_nonrequired">
						<span class="form_field_name field_name">{!ALT_FIELD,{!UPLOAD}}</span>
					</th>

					{+START,IF,{$MOBILE}}
						</tr>

						<tr class="field_input">
					{+END}

					<td id="required__upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" class="dottedborder_barrier_b_nonrequired">
						<label class="accessibility_hidden" for="upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}">{!ALT_FIELD,{!UPLOAD}}</label>
						<input name="upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" id="upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" type="file" />

						<input type="hidden" name="clearBtn_upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" id="clearBtn_upload_{KEY*}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID*}{+END}" />
						{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
							<script type="text/javascript">
							// <![CDATA[
								addEventListenerAbstract(window,'load',function () {
									preinitFileInput('chat_effect_settings',"upload_{KEY}{+START,IF_PASSED,MEMBER_ID}_{MEMBER_ID}{+END}",null,null,'mp3');
								} );
							//]]>
							</script>
						{+END}
					</td>
				</tr>
			{+END}
		</tbody>
	</table></div>
</div>
