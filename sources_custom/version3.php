<?php

function get_version_dotted($main,$minor)
{
	$on_disk_release=float_to_raw_string($main);
	if ($minor!='') $on_disk_release.='.'.$minor;
}
