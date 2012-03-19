{TITLE}
<div class="float_surrounder">
	<div class="top_navigation">
		<div class="calendar_date_span_link"><div class="calendar_date_span_link_inner">
			{+START,IF_NON_EMPTY,{YEAR_URL}}
				<a href="{YEAR_URL*}">{!YEARLY}</a>
			{+END}
			{+START,IF_EMPTY,{YEAR_URL}}
				{!YEARLY}
			{+END}
		</div></div>
		<div class="calendar_date_span_link"><div class="calendar_date_span_link_inner">
			{+START,IF_NON_EMPTY,{MONTH_URL}}
				<a href="{MONTH_URL*}">{!MONTHLY}</a>
			{+END}
			{+START,IF_EMPTY,{MONTH_URL}}
				{!MONTHLY}
			{+END}
		</div></div>
		<div class="calendar_date_span_link"><div class="calendar_date_span_link_inner">
			{+START,IF_NON_EMPTY,{WEEK_URL}}
				<a href="{WEEK_URL*}">{!WEEKLY}</a>
			{+END}
			{+START,IF_EMPTY,{WEEK_URL}}
				{!WEEKLY}
			{+END}
		</div></div>
		<div class="calendar_date_span_link"><div class="calendar_date_span_link_inner">
			{+START,IF_NON_EMPTY,{DAY_URL}}
				<a href="{DAY_URL*}">{!DAILY}</a>
			{+END}
			{+START,IF_EMPTY,{DAY_URL}}
				{!DAILY}
			{+END}
		</div></div>
	</div>
</div>

<br />

<div class="float_surrounder">
	<div class="trinav_left">
		<a href="{PREVIOUS_URL*}" rel="{+START,IF,{PREVIOUS_NO_FOLLOW}}nofollow {+END}prev" accesskey="j"><img class="button_page" src="{$IMG*,page/previous}" title="{!PREVIOUS}" alt="{!PREVIOUS}" /></a>
	</div>
	{+START,IF,{$NOT,{$MOBILE}}}
		<div class="trinav_mid">
			{+START,IF_NON_EMPTY,{ADD_URL}}
				<a rel="add" href="{ADD_URL*}"><img class="button_page" src="{$IMG*,page/add_event}" title="{!ADD_CALENDAR_EVENT}" alt="{!ADD_CALENDAR_EVENT}" /></a>
			{+END}
		</div>
	{+END}
	<div class="trinav_right">
		<a href="{NEXT_URL*}" rel="{+START,IF,{NEXT_NO_FOLLOW}}nofollow {+END}next" accesskey="k"><img class="button_page" src="{$IMG*,page/next}" title="{!NEXT}" alt="{!NEXT}" /></a>
	</div>
</div>

<br />

{MAIN}

<br />

{+START,IF_NON_EMPTY,{ADD_URL}}
	<p class="button_panel">
		<a rel="add" href="{ADD_URL*}"><img class="button_page" src="{$IMG*,page/add_event}" title="{!ADD_CALENDAR_EVENT}" alt="{!ADD_CALENDAR_EVENT}" /></a>
	</p>
{+END}

<br />

<div class="standardbox_wrap_classic solidborder">
	<div class="standardbox_classic">
		<div class="standardbox_title_classic toggle_div_title">
			{!INTERESTS}
			<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('interests','block'); return false;"><img id="e_interests" alt="{!EXPAND}: {!INTERESTS}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
		</div>
	</div>

	<div class="toggler_main" id="interests" style="{$JS_ON,display: none,}">
		<div class="float_surrounder">
			<div class="medborder_box">
				{+START,IF_NON_EMPTY,{EVENT_TYPES_1}}
					<div class="right medborder event_interest_box">
						<form title="{!INTERESTS}" method="post" action="{INTERESTS_URL*}">
							<p><strong>{!DESCRIPTION_INTERESTS}</strong></p>

							<div class="calendar_main_page_hidden_data">
								{EVENT_TYPES_1}
							</div>

							<div class="proceed_button">
								<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!INTERESTS}" />
							</div>
						</form>
					</div>
				{+END}
				{+START,IF_NON_EMPTY,{EVENT_TYPES_2}}
					<div class="medborder event_interest_box">
						<form title="{!FILTER}" action="{$URL_FOR_GET_FORM*,{FILTER_URL}}" method="get">
							{$HIDDENS_FOR_GET_FORM,{FILTER_URL}}

							<p><strong>{!DESCRIPTION_INTERESTS_2}</strong></p>

							<div class="calendar_main_page_hidden_data">
								{EVENT_TYPES_2}
							</div>
		
							<div class="proceed_button">
								<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!FILTER}" />
							</div>
						</form>
					</div>
				{+END}
			</div>
		</div>
	</div>
</div>

<br />

{$, Commented out... bloat
{+START,IF,{$ADDON_INSTALLED,syndication_blocks}}
	<div class="standardbox_wrap_classic solidborder">
		<div class="standardbox_classic">
			<div class="standardbox_title_classic toggle_div_title">
				{!FEEDS_TO_OVERLAY}
				<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('rss','block'); return false;"><img id="e_rss" alt="{!EXPAND}: {!FEEDS_TO_OVERLAY}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			</div>
		</div>

		<div class="toggler_main standardbox_main_classic" id="rss" style="{$JS_ON,display: none,}">
			{RSS_FORM}
		</div>
	</div>
{+END}
}
