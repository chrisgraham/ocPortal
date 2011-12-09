{+START,IF_NON_EMPTY,{POST_TITLE}}
	<tr>
		<td colspan="2" class="tabletitle_internal">
			{POST_TITLE*}
		</td>
	</tr>
{+END}
{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<tr>
		<th colspan="2" class="ocf_post_details">
			{DESCRIPTION*}
		</th>
	</tr>
{+END}{+END}

{+START,IF_NON_EMPTY,{POSTER}}
	<tr>
		<th class="{CLASS*}">{EMPHASIS*}{+START,IF_NON_EMPTY,{ID}}<a name="post_{ID*}" id="post_{ID*}"></a>{+END}{FIRST_UNREAD}</th>
		<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="#{ID*}"{+END} class="ocf_post_details">
			<div class="ocf_post_details_date">
				{+START,IF,{$VALUE_OPTION,html5}}
					{!POST_DATE,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{POST_DATE_RAW}}">{POST_DATE*}</time>}
				{+END}
				{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
					{!POST_DATE,{POST_DATE*}}
				{+END}
			</div>
			{+START,IF_NON_EMPTY,{UNVALIDATED}}
				<div class="ocf_post_details_unvalidated">
					{UNVALIDATED*}
				</div>
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
		</th>
	</tr>
{+END}
{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,post,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}
	{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry},1}
{+END}
<tr>
	{+START,IF_NON_EMPTY,{POSTER}}
		<td class="ocf_topic_post_member_details">
			<div class="ocf_topic_poster_name">
				{POSTER}
			</div>
			<div class="ocf_topic_poster_more">
				{POST_AVATAR}
				{+START,IF_NON_EMPTY,{POSTER_TITLE}}<div class="ocf_topic_poster_title">{POSTER_TITLE*}</div>{+END}
				{+START,IF_NON_EMPTY,{RANK_IMAGES}}<br /><div>{RANK_IMAGES}</div>{+END}
			</div>
		</td>
	{+END}
	<td class="ocf_topic_post_area ocf_post1"{+START,IF_EMPTY,{POSTER}} colspan="2"{+END}>
		<div class="ocf_post_inner">
			<div class="float_surrounder">
				{+START,IF,{$NOT,{$MOBILE}}}
					{+START,IF,{$JS_ON}}{+START,IF_NON_EMPTY,{ID}}{+START,IF_NON_PASSED,PREVIEWING}
						<div id="cell_mark_{ID*}" class="ocf_off ocf_topic_marker">
							<form title="{!MARKER} #{ID*}" method="post" action="index.php" id="form_mark_{ID*}">
								<div>
									<p class="accessibility_hidden"><label for="mark_{ID*}">{!MARKER} #{ID*}</label></p>
									<input value="1" type="checkbox" id="mark_{ID*}" name="mark_{ID*}" onclick="changeClass(this,'cell_mark_{ID*}','ocf_on ocf_topic_marker','ocf_off ocf_topic_marker')" />
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
	</td>
</tr>
{+START,IF,{$NEQ,{ID},{TOPIC_FIRST_POST_ID},}}
	<tr>
		<td class="{CLASS*}">
			{EMPHASIS*} {+START,IF_EMPTY,{EMPHASIS}}
				<div class="ocf_post_empty">
					<a href="#"><img title="{!BACK_TO_TOP}" alt="{!BACK_TO_TOP}" src="{$IMG*,top}" /></a>
				</div>
			{+END}
		</td>
		<td class="ocf_post_buttons ocf_post1">
			{BUTTONS}
		</td>
	</tr>
{+END}
<tr>
	<td colspan="2">&nbsp;</td>
</tr>

