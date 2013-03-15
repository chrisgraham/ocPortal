{+START,IF_EMPTY,{ERROR}}
	{+START,IF,{$OR,{$JS_ON},{$NOT,{$GET,block_embedded_forms}}}}
		{+START,IF,{$NOT,{$GET,block_embedded_forms}}}
		<form title="{!RATE}" onsubmit="if (this.elements[0].selectedIndex==0) { window.fauxmodal_alert('{!IMPROPERLY_FILLED_IN=;}'); return false; } else return true;" action="{URL*}" method="post">
			{$INSERT_SPAMMER_BLACKHOLE}
		{+END}
			{+START,LOOP,ALL_RATING_CRITERIA}
				<div class="rating_outer">
					<div class="rating_type_title">
						<a id="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}_jump" rel="dorating"></a>
						{+START,IF,{$NOT,{$JS_ON}}}{+START,IF_EMPTY,{TITLE}}<div class="accessibility_hidden">{+END}<label {+START,IF_EMPTY,{TYPE}}accesskey="r" {+END}for="rating__{CONTENT_TYPE*}__{TYPE*}__{ID*}"><strong>{+START,IF_EMPTY,{TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{TITLE}}{TITLE*}:{+END}</strong></label>{+START,IF_EMPTY,{TITLE}}</div>{+END}{+END}
						{+START,IF,{$JS_ON}}{+START,IF_EMPTY,{TITLE}}<div class="accessibility_hidden">{+END}<strong>{+START,IF_EMPTY,{TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{TITLE}}{TITLE*}:{+END}</strong>{+START,IF_EMPTY,{TITLE}}</div>{+END}{+END}
					</div>

					<div class="rating_inner">
						{+START,IF,{$JS_ON}}
							{$REQUIRE_JAVASCRIPT,javascript_ajax}

							{$,Like/dislike}
							{+START,IF,{LIKES}}
								<img id="rating_bar_1__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,dislike}" /><img id="rating_bar_10__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,like}" />
							{+END}

							{$,Star ratings}
							{+START,IF,{$NOT,{LIKES}}}
								<img id="rating_bar_2__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_4__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_6__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_8__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_10__{CONTENT_TYPE*}__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" />
							{+END}

							<script type="text/javascript">// <![CDATA[
								apply_rating_highlight_and_ajax_code({LIKES}==1,{RATING%},'{CONTENT_TYPE%}','{ID%}','{TYPE%}',{RATING%},'{CONTENT_URL;/}','{CONTENT_TITLE;/}',true);
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
				</div>
			{+END}
			{+START,IF,{$NOT,{SIMPLISTIC}}}
				{+START,IF,{$NOT,{$JS_ON}}}
					<div>
						<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!RATE}" />
					</div>
				{+END}
			{+END}
		{+START,IF,{$NOT,{$GET,block_embedded_forms}}}
		</form>
		{+END}
	{+END}
{+END}
