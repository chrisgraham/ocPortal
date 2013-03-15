<div class="ocf_edit_forum_forum zebra_{$CYCLE,f_colour,0,1}">
	<div class="float_surrounder">
		<div class="ocf_edit_forum_type">
			<span class="horiz_field_sep associated_link"><a rel="edit" href="{EDIT_URL*}" title="{!EDIT}: {FORUM*} ({ID*})">{!EDIT}</a></span>
		</div>
		<div class="ocf_edit_forum_title">
			<a href="{VIEW_URL*}"><span class="{CLASS*}" title="#{ID*}">{FORUM*}</span></a>
		</div>
		{+START,IF_NON_EMPTY,{ORDERINGS}}
			<div>
				<div class="ocf_edit_forum_orderings_f">
					{ORDERINGS}
				</div>
			</div>
		{+END}
	</div>
</div>
{+START,IF_NON_EMPTY,{CATEGORIES}}
	<div class="ocf_edit_forum_under">
		{CATEGORIES}
	</div>
{+END}

