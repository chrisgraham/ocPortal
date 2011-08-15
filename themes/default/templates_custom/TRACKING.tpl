<div>
	TRACKING
</div>
<div>
	<form method="post" action="{ACTION}" onsubmit="return track_children();" >
		<p>
			<label for="sms">{!TRACK_SMS}</label>
			<input type="checkbox" name="sms" id="sms" value="1" />
		</p>

		<p>
			<label for="email">{!TRACK_EMAIL}</label>
			<input type="checkbox" name="email" id="email" value="1" />
		</p>

		<input type="hidden" name="t_cat_id" id="t_cat_id" value="{ID}" />
		<input type="hidden" name="t_cat_type" id="t_cat_type" value="{TYPE}" />
		<input type="hidden" name="track_child" id="track_child" value="{T_CHILD}" />

		<p>
			<input type="submit" value="Submit" name="btn_submit" />
		</p>
	</form>
</div>
