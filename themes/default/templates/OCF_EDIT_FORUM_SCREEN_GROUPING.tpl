<div class="ocf_edit_forum_category">
	<div class="float_surrounder">
		<div class="ocf_edit_forum_type">
			{!FORUM_GROUPING}
		</div>
		<div class="ocf_edit_forum_title">
			<h3>{GROUPING*}</h3>
		</div>
		{+START,IF_NON_EMPTY,{ORDERINGS}}
			<div class="ocf_edit_forum_orderings">
				{ORDERINGS}
			</div>
		{+END}
	</div>
</div>

{SUBFORUMS}

