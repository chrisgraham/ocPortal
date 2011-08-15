<a name="rating__{TYPE*}__{ID*}_jump" id="rating__{TYPE*}__{ID*}_jump" rel="dorating"></a>
<form title="{!RATE}" onsubmit="if (this.elements[0].selectedIndex==0) { window.alert('{!IMPROPERLY_FILLED_IN*;}'); return false; } else return true;" action="{URL*}" method="post">
	{+START,LOOP,TITLES}
		{+START,IF,{$NOT,{$JS_ON}}}{+START,IF_EMPTY,{TITLE}}<div class="accessibility_hidden">{+END}<label accesskey="r" for="rating__{TYPE*}__{ID*}"><strong>{+START,IF_EMPTY,{TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{TITLE}}{TITLE*}:{+END}</strong></label>{+START,IF_EMPTY,{TITLE}}</div>{+END}{+END}
		<div class="rating_inner">
			{+START,IF,{$JS_ON}}
				{$JAVASCRIPT_INCLUDE,javascript_ajax}
				<img id="rating_bar_1__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_2__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_3__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_4__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="rating_bar_5__{TYPE*}__{ID*}" alt="" src="{$IMG*,rating}" />
				<script type="text/javascript">// <![CDATA[
					function rating_highlight__{TYPE%}__{ID%}(rating,first_time)
					{
						var i,bit;
						for (i=1;i<=5;i++)
						{
							bit=document.getElementById('rating_bar_'+i+'__{TYPE%}__{ID%}');
							setOpacity(bit,(rating/2>=i)?1.0:0.2);
							if (first_time) bit.onmouseover=function(i) { return function()
							{
								rating_highlight__{TYPE%}__{ID%}(i*2,false);
							} }(i);
							if (first_time) bit.onclick=function(i) { return function()
							{
								var message=load_snippet('rating&type={TYPE%}&id={ID%}&root_type={ROOT_TYPE%}','rating='+(i*2));
								setInnerHTML(bit.parentNode.parentNode.parentNode.parentNode,'<strong>'+message+'<\/strong>');
							} }(i);
						}
					}
					rating_highlight__{TYPE%}__{ID%}(0,true);
				//]]></script>
			{+END}
			{+START,IF,{$NOT,{$JS_ON}}}
				<select id="rating__{TYPE*}__{ID*}" name="rating__{TYPE*}__{ID*}">
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
