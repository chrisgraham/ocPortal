<div class="accessibility_hidden"><label for="post_template">{!POST_TEMPLATE}</label></div>
<select tabindex="{TABINDEX*}" id="post_template" name="post_template">
	{LIST}
</select>
<input class="button_pageitem" type="submit" value="{!USE}" onclick="var element=form.elements['post']; var ins=form.elements['post_template'].value; else insertTextbox(form.elements['post'],ins,null,true); return false;" />

