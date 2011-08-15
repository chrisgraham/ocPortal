{+START,BOX,{!LANGUAGE},,{$?,{$GET,in_panel},panel,classic},tray_closed}
	<form title="{!LANGUAGE} ({!FORM_AUTO_SUBMITS})" class="side_block_form" method="get" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}">
		{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},keep_lang}
		<div>
			<p class="accessibility_hidden"><label for="keep_lang">{!LANGUAGE}</label></p>
			<select{+START,IF,{$JS_ON}} onchange="this.form.submit();"{+END} id="keep_lang" name="keep_lang" class="wide_field">
				{LANGS}
			</select><br />
			{+START,IF,{$NOT,{$JS_ON}}}
				<input onclick="disable_button_just_clicked(this);" type="submit" value="{!PROCEED}" class="wide_button" />
			{+END}
		</div>
	</form>
{+END}
