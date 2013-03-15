<?php

function init__hooks__modules__search__ocf_members($in)
{
	return str_replace("ocf_show_member_box(\$row['id']);","ocf_show_member_box(\$row['id'],true);",$in);
}
