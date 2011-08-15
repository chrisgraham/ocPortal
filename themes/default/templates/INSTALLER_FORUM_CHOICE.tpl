<label for="{CLASS*}">
	<input {EXTRA} {+START,IF,{$EQ,{CLASS},{REC}}}checked="checked" {+END}type="radio" name="forum" id="{CLASS*}" value="{CLASS*}" onclick="doForumChoose(this,'{VERSIONS*;~}');" />
	{TEXT*}
</label>
<br />
