{+START,LOOP,NOTIFICATION_TYPES}
	<td>
		{+START,IF,{AVAILABLE}}
			<label class="accessibility_hidden" for="notification_{NOTIFICATION_CODE*}_{NTYPE*}">{LABEL*}</label>
			<input title="{LABEL*}" {+START,IF,{CHECKED}}checked="checked" {+END}id="notification_{NOTIFICATION_CODE*}_{NTYPE*}" name="notification_{NOTIFICATION_CODE*}_{NTYPE*}" type="checkbox" value="1" />
		{+END}
	</td>
{+END}
