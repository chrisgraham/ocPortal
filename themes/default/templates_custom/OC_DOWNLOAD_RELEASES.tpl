{+START,IF_PASSED,QUICK_VERSION}{+START,IF_PASSED,QUICK_FILESIZE}{+START,IF_PASSED,QUICK_URL}
<div class="automatic option left blue">
	<div class="s_wrap"><p class="s">
		This package (&ldquo;quick installer&rdquo;) will self-extract on your server and automatically set all permissions.<br /><br />
		Needs <span class="comcode_concept_inline" onmouseout="if (window.deactivateTooltip) deactivateTooltip(this,event);" onmousemove="if (window.activateTooltip) repositionTooltip(this,event);" onmouseover="if (window.activateTooltip) activateTooltip(this,event,'Either your server must support FTP and you have the PHP FTP extension, or you need a &ldquo;SuExec&rdquo; server (ocPortal 5.1+ only)','auto');">FTP</span> or suEXEC on your server.
	</p></div>
	<div class="go_wrap"><p class="go">
		<span class="details">v{QUICK_VERSION*} | {QUICK_FILESIZE*}</span>
		&raquo; <a title="Download automatic extractor" href="{QUICK_URL*}">Download</a>
	</p></div>
</div>
{+END}{+END}{+END}

{+START,IF_PASSED,MANUAL_VERSION}{+START,IF_PASSED,MANUAL_FILESIZE}{+START,IF_PASSED,MANUAL_URL}
<div class="manual option right yellow">
	<div class="s_wrap"><p class="s">
		This is a zip containing all ocPortal files (several thousand). It is much slower, and only recommended if you do not have FTP access.
		Some <span class="comcode_concept_inline" onmouseout="if (window.deactivateTooltip) deactivateTooltip(this,event);" onmousemove="if (window.activateTooltip) repositionTooltip(this,event);" onmouseover="if (window.activateTooltip) activateTooltip(this,event,'Setting of file permissions','auto');">chmodding</span> is required.<br />
		<strong>Do not use this for upgrading.</strong>
	</p></div>
	<div class="go_wrap"><p class="go">
		<span class="details">v{MANUAL_VERSION*} | {MANUAL_FILESIZE*}</span>
		&raquo; <a title="Download manual extractor" href="{MANUAL_URL*}">Download</a>
	</p></div>
</div>
{+END}{+END}{+END}

{+START,IF,{$NOT,{$BROWSER_MATCHES,ie_old}}}
{+START,IF_PASSED,BLEEDINGMANUAL_VERSION}{+START,IF_PASSED,BLEEDINGMANUAL_FILESIZE}{+START,IF_PASSED,BLEEDINGMANUAL_URL}
{+START,IF_PASSED,BLEEDINGQUICK_VERSION}{+START,IF_PASSED,BLEEDINGQUICK_FILESIZE}{+START,IF_PASSED,BLEEDINGQUICK_URL}
<div class="bleeding option left red">
	<div class="s_wrap"><p class="s">
		Are you able to {$?,{$IN_STR,{BLEEDINGQUICK_VERSION},alpha},alpha,beta}-test the new version: v{BLEEDINGQUICK_VERSION*}?<br />
		It <strong>{$?,{$IN_STR,{BLEEDINGQUICK_VERSION},alpha},will not be stable like,may not be as stable as}</strong> our main version{+START,IF_PASSED,QUICK_VERSION} (v{QUICK_VERSION*}){+END}.
	</p></div>
	<div class="go_wrap"><p class="go">
		<span class="gs1">&raquo; <a title="Download automatic extractor" href="{BLEEDINGQUICK_URL*}">Auto</a><br />{BLEEDINGQUICK_FILESIZE*}</span>
		<span class="gs2">&raquo; <a title="Download manual extractor" href="{BLEEDINGMANUAL_URL*}">Manual</a><br />{BLEEDINGMANUAL_FILESIZE*}</span>
	</p></div>
</div>
{+END}{+END}{+END}
{+END}{+END}{+END}
{+END}