{+START,IF,{$NOT,{$VALUE_OPTION,likes}}}
	{+START,IF_NON_EMPTY,{ERROR}}
		{ERROR}
	{+END}
{+END}

{+START,IF_EMPTY,{ERROR}}
	<a name="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}_jump" id="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}_jump" rel="dorating"></a>
	<form title="{!RATE}" onsubmit="if (this.elements[0].selectedIndex==0) { window.fauxmodal_alert('{!IMPROPERLY_FILLED_IN=;}'); return false; } else return true;" action="{URL*}" method="post">
		{+START,LOOP,TITLES}
			{+START,IF,{$NOT,{$JS_ON}}}{+START,IF_EMPTY,{TITLE}}<div class="accessibility_hidden">{+END}<label accesskey="r" for="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}"><strong>{+START,IF_EMPTY,{TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{TITLE}}{TITLE*}:{+END}</strong></label>{+START,IF_EMPTY,{TITLE}}</div>{+END}{+END}
			<div class="rating_inner">
				{+START,IF,{$JS_ON}}
					{$JAVASCRIPT_INCLUDE,javascript_ajax}

					{$,Like/dislike}
					{+START,IF,{$VALUE_OPTION,likes}}
						<img id="rating_bar_1__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,dislike}" /><img id="rating_bar_10__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,like}" />
					{+END}

					{$,Star ratings}
					{+START,IF,{$NOT,{$VALUE_OPTION,likes}}}
						<img id="rating_bar_2__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_4__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_6__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_8__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_10__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" />
					{+END}

					<script type="text/javascript">// <![CDATA[
						apply_rating_highlight_and_ajax_code({_RATING%},'{CONTENT_TYPE%}','{ID%}','{TYPE%}',{_RATING%},'{CONTENT_URL;/}','{CONTENT_TITLE;/}',true);
					//]]></script>
				{+END}

				{$,Choose from list (non-JS fallback)}
				{+START,IF,{$NOT,{$JS_ON}}}
					<select id="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}" name="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}">
						<option value="">&mdash;</option>
						<option value="10">5</option>
						<option value="8">4</option>
						<option value="6">3</option>
						<option value="4">2</option>
						<option value="2">1</option>
					</select>
					{+START,IF,{SIMPLISTIC}}
						<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!RATE}" />
					{+END}
				{+END}
			</div>
		{+END}
		{+START,IF,{$NOT,{SIMPLISTIC}}}
			{+START,IF,{$NOT,{$JS_ON}}}
				<div>
					<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!RATE}" />
				</div>
			{+END}
		{+END}
	</form>
{+END}
