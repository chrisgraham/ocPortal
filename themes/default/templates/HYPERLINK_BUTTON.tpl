<form title="{$STRIP_TAGS,{CAPTION}}" action="{URL*}" method="post" class="inline"{+START,IF_PASSED,NEW_WINDOW}{+START,IF,{NEW_WINDOW}} target="_blank"{+END}{+END}>
	{POST_DATA}
	<div class="inline">
		<input {+START,IF_PASSED,ACCESSKEY}accesskey="{ACCESSKEY*}" {+END}class="buttonhyperlink" {+START,IF_PASSED,NEW_WINDOW}{+START,IF,{NEW_WINDOW}}title="{+START,IF_NON_EMPTY,{TITLE}}title="{$STRIP_TAGS*,{TITLE},1}" {+END}{!NEW_WINDOW}" {+END}{+END}type="submit" value="{CAPTION}" />
	</div>
</form>

