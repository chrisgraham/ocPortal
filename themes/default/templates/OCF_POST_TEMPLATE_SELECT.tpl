<div class="accessibility_hidden"><label for="post_template">{!POST_TEMPLATE}</label></div>
<select tabindex="{TABINDEX*}" id="post_template" name="post_template">
	{LIST}
</select>
<input class="button_pageitem" type="submit" value="{!USE}" onclick="var element=form.elements['post']; var ins=form.elements['post_template'].value; insert_textbox(form.elements['post'],ins.replace(/\\n/g,'\n'),null,true,escape_html(ins).replace(/\\n/g,'&lt;br /&gt;')); return false;" />

