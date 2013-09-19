<section class="box box___block_side_users_online"><div class="box_inner">
	<h3>{!USERS_ONLINE}</h3>

	<p>{CONTENT} <span class="associated_details">{!NUM_GUESTS,{GUESTS*}}</span></p>

	{+START,IF_NON_EMPTY,{NEWEST}}
		<p>{NEWEST}</p>
	{+END}

	{+START,IF_NON_EMPTY,{BIRTHDAYS}}
		<div>{BIRTHDAYS}</div>
	{+END}

	{+START,IF,{$AND,{$HAS_ACTUAL_PAGE_ACCESS,onlinemembers},{$OCF}}}
		<ul class="horizontal_links associated_links_block_group force_margin">
			<li><a href="{$PAGE_LINK*,_SEARCH:onlinemembers}" title="{!USERS_ONLINE}">{!DETAILS}</a></li>
		</ul>
	{+END}
</div></section>
