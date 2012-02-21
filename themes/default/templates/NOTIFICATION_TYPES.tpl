{+START,LOOP,NOTIFICATION_TYPES}
	<td>
		{+START,IF,{AVAILABLE}}
			<div>
				<label for="notification_{NOTIFICATION_CODE*}_{NTYPE*}">{LABEL*}</label>
				<input title="{LABEL*}" {+START,IF,{CHECKED}}checked="checked" {+END}id="notification_{NOTIFICATION_CODE*}_{NTYPE*}" name="notification_{NOTIFICATION_CODE*}_{NTYPE*}" type="checkbox" value="1" />
			</div>
		{+END}
	</td>
{+END}
