<?php

function init__hooks__modules__search__ocf_members($in)
{
	return str_replace("render_member_box(\$row['id']);","render_member_box(\$row['id'],true);",$in);
}
