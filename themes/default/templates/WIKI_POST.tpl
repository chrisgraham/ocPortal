<div>
	<div class="ocf_forum_box_left"><a id="post_{ID*}"></a></div>
	<div class="ocf_forum_box_right ocf_post_details" role="contentinfo">
		<div class="ocf_post_details_date">
			{!POST_DATE,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{POST_DATE_RAW}}">{POST_DATE*}</time>}
		</div>
		{+START,IF_NON_EMPTY,{UNVALIDATED}}
			<div class="ocf_post_details_unvalidated">
				{UNVALIDATED*}
			</div>
		{+END}
	</div>
</div>
<div>
	<div class="ocf_topic_post_member_details" role="contentinfo">
		<div class="ocf_topic_poster_name wiki_poster_name">
			{+START,IF_NON_EMPTY,{POSTER_URL}}
				{!SUBMITTED_BY,<a href="{POSTER_URL*}">{POSTER*}</a>}
			{+END}
			{+START,IF_EMPTY,{POSTER_URL}}
				{!SUBMITTED_BY,{POSTER*}}
			{+END}
		</div>
	</div>
	<div class="ocf_topic_post_area ocf_post_main_column" id="pe_{ID*}">
		{+START,IF,{$AND,{$JS_ON},{STAFF_ACCESS}}}
			<div id="cell_mark_{ID*}" class="ocf_off ocf_topic_marker">
				<form title="{!MARKER}: {ID*}" method="post" action="index.php" id="form_mark_{ID*}">
					<div>
						{+START,IF,{$NOT,{$IS_GUEST}}}<div class="accessibility_hidden"><label for="mark_{ID*}">{!MARKER} #{ID*}</label></div>{+END}{$,Guests don't see this so search engines don't; hopefully people with screen-readers are logged in}
						<input {+START,IF,{$NOT,{$IS_GUEST}}}title="{!MARKER} #{ID*}" {+END}value="1" type="checkbox" id="mark_{ID*}" name="mark_{ID*}" onclick="change_class(this,'cell_mark_{ID*}','ocf_on ocf_topic_marker','ocf_off ocf_topic_marker')" />
					</div>
				</form>
			</div>
		{+END}

		{POST}
	</div>
</div>
{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,seedy_post,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry},1}{+END}
{+START,IF_NON_EMPTY,{BUTTONS}}
	<div>
		<div class="ocf_left_post_buttons wiki_post_expand_button">
		</div>
		<div class="ocf_post_main_column">
			<div class="buttons_group post_buttons ocf_post_main_column">
				{BUTTONS}
			</div>

			{+START,SET,commented_out}
				{+START,IF,{$EQ,{$CONFIG_OPTION,is_on_rating},1}}
					<div class="wiki_post_below">
						<form title="{!RATING}" class="inline" action="{RATE_URL*}" method="post">
							{RATING}
						</form>
					</div>
				{+END}
			{+END}
		</div>
	</div>
{+END}
