<form title="{!EDIT}" action="{SUBMIT_URL*}" method="post" onsubmit="var command='write &quot;{FILE*}&quot; &quot;'+this.elements['edit_content'].value.replace(/\\/g,'\\\\').replace(/&lt;/g,'\\&lt;').replace(/&gt;/g,'\\&gt;').replace(/&quot;/g,'\\&quot;')+'&quot;'; return form_submission(command);">
	<div>
		<label for="edit_content{UNIQ_ID*}">{!EDIT}</label>:<br />
		<div class="constrain_field"><textarea class="textarea_scroll wide_field" cols="60" rows="10" id="edit_content{UNIQ_ID*}" name="edit_content">{FILE_CONTENTS*}</textarea></div>
		<input class="button_pageitem" type="submit" value="{!PROCEED}" />
	</div>
</form>
