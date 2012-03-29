<tr>
	<th><a name="post_{ID*}" id="post_{ID*}"></a></th>
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
	</th>
</tr>
<tr>
	<td class="ocf_topic_post_member_details">
		<div class="ocf_topic_poster_name ocf_cedi_poster_name">
			{+START,IF_NON_EMPTY,{POSTER_URL}}
				{!SUBMITTED_BY,<a href="{POSTER_URL*}">{POSTER*}</a>}
			{+END}
			{+START,IF_EMPTY,{POSTER_URL}}
				{!SUBMITTED_BY,{POSTER*}}
			{+END}
		</div>
	</td>
	<td class="ocf_topic_post_area ocf_post1" id="pe_{ID*}">
		{+START,IF,{$AND,{$JS_ON},{STAFF_ACCESS}}}
			<div id="cell_mark_{ID*}" class="ocf_off ocf_topic_marker">
				<form title="{!MARKER}: {ID*}" method="post" action="index.php" id="form_mark_{ID*}">
					<div>
						{+START,IF,{$NOT,{$IS_GUEST}}}<div class="accessibility_hidden"><label for="mark_{ID*}">{!MARKER} #{ID*}</label></div>{+END}{$,Guests don't see this so search engines don't; hopefully people with screen-readers are logged in}
						<input {+START,IF,{$NOT,{$IS_GUEST}}}title="{!MARKER} #{ID*}" {+END}value="1" type="checkbox" id="mark_{ID*}" name="mark_{ID*}" onclick="changeClass(this,'cell_mark_{ID*}','ocf_on ocf_topic_marker','ocf_off ocf_topic_marker')" />
					</div>
				</form>
			</div>
		{+END}

		{POST}
	</td>
</tr>
{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,seedy_post,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry},1}{+END}
{+START,IF_NON_EMPTY,{BUTTONS}}
	<tr>
		<td class="cedi_post_expand_button">
		</td>
		<td class="ocf_post_buttons ocf_post1">
			<div class="cedi_buttons">
				{BUTTONS}
			</div>
			<!--{+START,IF,{$EQ,{$CONFIG_OPTION,is_on_rating},1}}
				<div class="cedi_post_below">
					<form title="{!RATING}" class="inline" action="{RATE_URL*}" method="post">
						{RATING}
					</form>
				</div>
			{+END}-->
		</td>
	</tr>
{+END}
<tr>
	<td colspan="2">&nbsp;</td>
</tr>

