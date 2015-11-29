<div class="points_boxes">
	<div class="points_box box">
		{+START,IF,{$HAS_PRIVILEGE,use_points,{MEMBER}}}
			<p class="intro">{!CURRENT_POINTS}:</p>
			<p>{!POINTS_TO_SPEND,<span class="figure">{REMAINING*}</span>}</p>
		{+END}
		{+START,IF,{$NOT,{$HAS_PRIVILEGE,use_points,{MEMBER}}}}
			{!NO_PERMISSION_TO_USE_POINTS}
		{+END}
	</div>

	<div class="points_box box">
		<p class="intro">{!COUNT_GIFT_POINTS_LEFT}:</p>
		<p>{!POINTS_TO_GIVE,<span class="figure">{GIFT_POINTS_AVAILABLE*}</span>}</p>
	</div>
</div>

<div class="points_earned">
	<h2>{!POINTS_EARNED}</h2>

	<p>
		{!VIEWING_POINTS_PROFILE_OF,<a href="{PROFILE_URL*}">{NAME*}</a>}
	</p>

	<table summary="{!COLUMNED_TABLE}" class="autosized_table points_summary_table">
		<thead>
			<tr>
				<th>{!ACTIVITY}</th>
				<th>{!AMOUNT}</th>
				<th>{!COUNT_TOTAL}</th>
			</tr>
		</thead>

		<tbody>
			{+START,IF,{$NEQ,{POINTS_JOINING},0}}
				<tr>
					<td>&bull; {!JOINING}:</td>
					<td class="equation">1 &times; {POINTS_JOINING*} {!POINTS_UNIT}</td>
					<td class="answer">= {POINTS_JOINING*} {!POINTS_UNIT}</td>
				</tr>
			{+END}
			{+START,IF,{$NEQ,{POINTS_PER_DAY},0}}
				<tr>
					<td>&bull; {!MEMBERSHIP_LENGTH}</td>
					<td class="equation">{DAYS_JOINED*} &times; {POINTS_PER_DAY*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_PER_DAY*} {!POINTS_UNIT}</td>
				</tr>
			{+END}
			{+START,IF,{$NEQ,{POINTS_POSTING},0}}{+START,IF,{$HAS_FORUM}}
				<tr>
					<td>&bull; {!COUNT_POSTS}:</td>
					<td class="equation">{POST_COUNT*} &times; {POINTS_POSTING*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_POSTING*} {!POINTS_UNIT}</td>
				</tr>
			{+END}{+END}
			{+START,IF,{$NEQ,{POINTS_WIKI_POSTING},0}}{+START,IF,{$ADDON_INSTALLED,cedi}}
				<tr>
					<td>&bull; {!cedi:CEDI_POSTS}:</td>
					<td class="equation">{WIKI_POST_COUNT*} &times; {POINTS_WIKI_POSTING*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_WIKI_POSTING*} {!POINTS_UNIT}</td>
				</tr>
			{+END}{+END}
			{+START,IF,{$NEQ,{POINTS_CHAT_POSTING},0}}{+START,IF,{$ADDON_INSTALLED,chat}}
				<tr>
					<td>&bull; {!chat:COUNT_CHATPOSTS}:</td>
					<td class="equation">{CHAT_POST_COUNT*} &times; {POINTS_CHAT_POSTING*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_CHAT_POSTING*} {!POINTS_UNIT}</td>
				</tr>
			{+END}{+END}
			{+START,IF,{$NEQ,{POINTS_VOTING},0}}{+START,IF,{$ADDON_INSTALLED,polls}}
				<tr>
					<td>&bull; {!COUNT_VOTINGS}:</td>
					<td class="equation">{POINTS_GAINED_VOTING*} &times; {POINTS_VOTING*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_VOTING*} {!POINTS_UNIT}</td>
				</tr>
			{+END}{+END}
			{+START,IF,{$NEQ,{POINTS_RATING},0}}
				<tr>
					<td>&bull; {!RATING_CONTENT}:</td>
					<td class="equation">{POINTS_GAINED_RATING*} &times; {POINTS_RATING*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_RATING*} {!POINTS_UNIT}</td>
				</tr>
			{+END}
			{+START,IF,{$NEQ,{POINTS_CREDITS},0}}{+START,IF,{$ADDON_INSTALLED,support_credits}}
				<tr>
					<td>&bull; {!SPECIAL_CPF__ocp_support_credits}:</td>
					<td class="equation">{POINTS_GAINED_CREDITS*} &times; {POINTS_CREDITS*} {!POINTS_UNIT}</td>
					<td class="answer">= {MULT_POINTS_CREDITS*} {!POINTS_UNIT}</td>
				</tr>
			{+END}{+END}
		</tbody>
	</table>
</div>

<p>{!POINTS_IN_ADDITION,{NAME*},{POINTS_GAINED_GIVEN*}}</p>

<h2>{!POINTS_RECEIVED}</h2>

{+START,IF_NON_EMPTY,{TO}}
	{TO}
{+END}
{+START,IF_EMPTY,{TO}}
	<p class="nothing_here">{!NONE}</p>
{+END}

{+START,IF_NON_EMPTY,{GIVE}}
	<div class="box box___points_profile"><div class="box_inner">
		{GIVE}
	</div></div>
{+END}

{+START,IF_NON_EMPTY,{FROM}}
	<h2>{!POINTS_GIFTED}</h2>

	<p>{!_POINTS_GIFTED,{NAME*},{GIFT_POINTS_USED*}}</p>

	{FROM}
{+END}

{+START,IF_NON_EMPTY,{CHARGELOG_DETAILS}}
	<h2>{!POINTS_SPENT}</h2>

	<p>{!_POINTS_SPENT,{NAME*},{POINTS_USED*}}</p>

	{CHARGELOG_DETAILS}
{+END}
