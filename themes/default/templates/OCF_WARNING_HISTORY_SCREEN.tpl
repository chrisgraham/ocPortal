{TITLE}

{RESULTS_TABLE}

<br />

<p>{!ACTIONS}:</p>
<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list">
	<li class="actions_list_strong">
		&raquo; <a href="{ADD_WARNING_URL*}">{!ADD_WARNING}</a>
	</li>
	<li class="actions_list_strong">
		&raquo; <a href="{VIEW_PROFILE_URL*}">{!VIEW_PROFILE}</a>
	</li>
	<li class="actions_list_strong">
		&raquo; <a href="{EDIT_PROFILE_URL*}">{!EDIT_PROFILE}</a>
	</li>
	<li class="actions_list_strong">
		&raquo; <a href="{$PAGE_LINK*,_SEARCH:rules}">{!RULES}</a>
	</li>
</ul>

