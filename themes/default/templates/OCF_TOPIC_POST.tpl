<div>
	<div class="ocf_forum_box_left{+START,IF_NON_EMPTY,{CLASS}} {CLASS*}{+END}">
		<h2 class="accessibility_hidden">
			{!FORUM_POST}
		</h2>

		{EMPHASIS*}

		{+START,IF_NON_EMPTY,{ID}}<a id="post_{ID*}"></a>{+END}

		{FIRST_UNREAD}
	</div>

	<div class="ocf_forum_box_right ocf_post_details" role="contentinfo">
		<div class="ocf_post_details_date">
			{!POST_DATE,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{POST_DATE_RAW}}">{POST_DATE*}</time>}
		</div>

		{+START,IF_NON_EMPTY,{POSTER}}
			{+START,IF_PASSED,RATING}
				<div class="ocf_post_details_rating">
					{RATING}
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{UNVALIDATED}}
				<div class="ocf_post_details_unvalidated">
					{UNVALIDATED*}
				</div>
			{+END}
		{+END}

		<div class="ocf_post_details_grapple">
			{+START,IF_NON_EMPTY,{URL}}
				{+START,IF_NON_EMPTY,{POST_ID*}}
					<a href="{URL*}">#{POST_ID*}</a>
				{+END}
			{+END}
			{+START,IF,{$EQ,{ID},{TOPIC_FIRST_POST_ID},}}{+START,IF_NON_EMPTY,{TOPIC_ID}}
				{+START,IF_NON_EMPTY,{POST_ID}}({!IN,{!FORUM_TOPIC_NUMBERED,{TOPIC_ID*}}}){+END}
				{+START,IF_EMPTY,{POST_ID}}{!FORUM_TOPIC_NUMBERED,{TOPIC_ID*}}{+END}
			{+END}{+END}
		</div>
	</div>
</div>

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,post,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}
	{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry},1}
{+END}

<div>
	<div class="ocf_topic_post_member_details" role="contentinfo">
		{+START,IF_NON_EMPTY,{POSTER}}
			<div class="ocf_topic_poster_name">
				{POSTER}
			</div>

			<div class="ocf_topic_poster_more">
				{POST_AVATAR}
				{+START,IF_NON_EMPTY,{POSTER_TITLE}}<div class="ocf_topic_poster_title">{POSTER_TITLE*}</div>{+END}
				{+START,IF_NON_EMPTY,{RANK_IMAGES}}<div class="ocf_topic_poster_rank_images">{RANK_IMAGES}</div>{+END}
			</div>
		{+END}
	</div>

	<div class="ocf_topic_post_area ocf_post_main_column">
		{+START,IF_NON_EMPTY,{POST_TITLE}}{+START,IF,{$NEQ,{TOPIC_FIRST_POST_ID},{ID}}}
			<h3>
				{POST_TITLE*}
			</h3>
		{+END}{+END}

		{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<h3>
				{DESCRIPTION*}
			</h3>
		{+END}{+END}

		<div class="float_surrounder">
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$JS_ON}}{+START,IF_NON_EMPTY,{ID}}{+START,IF_NON_PASSED_OR_FALSE,PREVIEWING}
					<div id="cell_mark_{ID*}" class="ocf_off ocf_topic_marker">
						<form title="{!MARKER} #{ID*}" method="post" action="index.php" id="form_mark_{ID*}">
							<div>
								{+START,IF,{$NOT,{$IS_GUEST}}}<div class="accessibility_hidden"><label for="mark_{ID*}">{!MARKER} #{ID*}</label></div>{+END}{$,Guests don't see this so search engines don't; hopefully people with screen-readers are logged in}
								<input {+START,IF,{$NOT,{$IS_GUEST}}}title="{!MARKER} #{ID*}" {+END}value="1" type="checkbox" id="mark_{ID*}" name="mark_{ID*}" onclick="change_class(this,'cell_mark_{ID*}','ocf_on ocf_topic_marker','ocf_off ocf_topic_marker')" />
							</div>
						</form>
					</div>
				{+END}{+END}{+END}
			{+END}

			{POST}
		</div>

		{LAST_EDITED}

		{+START,IF_NON_EMPTY,{SIGNATURE}}
			<div>
				<hr class="ocf_sig_barrier" />

				<div class="ocf_member_signature">
					{SIGNATURE}
				</div>
			</div>
		{+END}
	</div>
</div>

<div>
	<div class="ocf_left_post_buttons {CLASS*}">
		{EMPHASIS*}

		{+START,IF_EMPTY,{EMPHASIS}}{+START,IF_NON_EMPTY,{ID}}
			<div class="ocf_post_back_to_top">
				<a href="#"><img title="{!BACK_TO_TOP}" alt="{!BACK_TO_TOP}" src="{$IMG*,top}" /></a>
			</div>
		{+END}{+END}
	</div>

	<div class="buttons_group post_buttons ocf_post_main_column">
		{BUTTONS}
	</div>
</div>

