<div class="accessibility_hidden"><label for="{STUB%}_day">{!DAY}</label></div>
<div class="accessibility_hidden"><label for="{STUB%}_month">{!MONTH}</label></div>
<div class="accessibility_hidden"><label for="{STUB%}_year">{!YEAR}</label></div>
{+START,IF,{$NOT,{NULL_OK}}}
	<input type="hidden" name="{STUB%}" value="1" />
{+END}

<span class="vertical_alignment">
	<select onchange="if (typeof window.match_calendar_from_to!='undefined') match_calendar_from_to('{STUB%}');" {+START,IF_PASSED,TABINDEX}tabindex="{TABINDEX*}" {+END}id="{STUB%}_day" name="{STUB%}_day"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required date"{+END}>
		<option value="">-</option>
		{DAYS}
	</select>
	<select onchange="if (typeof window.match_calendar_from_to!='undefined') match_calendar_from_to('{STUB%}');" {+START,IF_PASSED,TABINDEX}tabindex="{TABINDEX*}" {+END}id="{STUB%}_month" name="{STUB%}_month"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required date"{+END}>
		<option value="">-</option>
		{MONTHS}
	</select>
	<select onchange="if (typeof window.match_calendar_from_to!='undefined') match_calendar_from_to('{STUB%}');" {+START,IF_PASSED,TABINDEX}tabindex="{TABINDEX*}" {+END}id="{STUB%}_year" name="{STUB%}_year"{+START,IF,{$NOT,{NULL_OK}}} class="input_list_required date"{+END}>
		<option value="">-</option>
		{YEARS}
	</select>

	{TIME}

	{+START,IF,{$JS_ON}}
		<img id="cal{STUB#}Button" title="{!SHOW_DATE_CHOOSER}" alt="{!SHOW_DATE_CHOOSER}" src="{$IMG*,date_chooser/pdate}" />
	{+END}
</span>

<div id="cal{STUB#}Container" class="inline"></div>

<script type="text/javascript">// <![CDATA[
	var mindate=null,maxdate=null;

	{+START,IF_PASSED,MIN_DATE_DAY}{+START,IF_PASSED,MIN_DATE_MONTH}{+START,IF_PASSED,MIN_DATE_YEAR}
		minDate=new Date();
		minDate.setDate({MIN_DATE_DAY%});
		minDate.setMonth({MIN_DATE_MONTH%}-1);
		minDate.setFullYear({MIN_DATE_YEAR%});
	{+END}{+END}{+END}

	{+START,IF_PASSED,MAX_DATE_DAY}{+START,IF_PASSED,MAX_DATE_MONTH}{+START,IF_PASSED,MAX_DATE_YEAR}
		maxDate=new Date();
		maxDate.setDate({MAX_DATE_DAY%});
		maxDate.setMonth({MAX_DATE_MONTH%}-1);
		maxDate.setFullYear({MAX_DATE_YEAR%});
	{+END}{+END}{+END}

	var cal{STUB%}=null;
	var link{STUB%}=document.getElementById('cal{STUB;}Button');
	if (link{STUB%}) link{STUB%}.onclick=function() { initialise_date_field('{STUB%}','cal{STUB%}','link{STUB%}', {$?,{UNLIMITED},true,false}, mindate, maxdate); };

	{+START,IF,{UNLIMITED}}
		var year_field=document.getElementById('{STUB%}_year');
		var special_option=document.createElement('option');
		special_option.value='-';
		set_inner_html(special_option,'&hellip;');
		year_field.onchange=function() {
			if (this.options[this.selectedIndex].value=='-')
			{
				var _this=this;
				window.fauxmodal_prompt(
					'{!CHOOSE_YEAR;}',
					'',
					function(year)
					{
						if ((!year) || (!year.match(/\-?\d+/)))
						{
							_this.selectedIndex=0;
						} else
						{
							year=year.replace(/^0+/,'');
							var custom_option=document.createElement('option');
							custom_option.value=year;
							set_inner_html(custom_option,year);
							_this.appendChild(custom_option);
							_this.selectedIndex=_this.options.length-1;
						}
					}
				);
			}
		}
		year_field.appendChild(special_option);
	{+END}
//]]></script>

