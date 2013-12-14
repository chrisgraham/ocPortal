{TITLE}

<div class="ocf_whisper_lead_in">
	<img src="{$IMG*,bigicons/addmember}" alt="" class="right" />

	{+START,IF,{$HAS_SPECIFIC_PERMISSION,use_pt}}<p>{!WHISPER_TEXT}</p>{+END}
</div>


<div class="float_surrounder">
	{+START,IF,{$HAS_SPECIFIC_PERMISSION,use_pt}}
		<div class="ocf_whisper_choose_box right">
			{+START,BOX,{!PERSONAL_TOPIC}}
				<form title="{!PERSONAL_TOPIC}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
					{$HIDDENS_FOR_GET_FORM,{URL}}

					<div>
						<p>{!WHISPER_PT,{USERNAME*}}</p>

						<input type="hidden" name="type" value="new_pt" />
						<div class="proceed_button"><input class="button_page" type="submit" onclick="disable_button_just_clicked(this);" value="{!QUOTE_TO_PT}" /></div>
					</div>
				</form>
			{+END}
		</div>
	{+END}

	<div class="ocf_whisper_choose_box">
		{+START,BOX,{!PERSONAL_POST}}
			<form title="{!PERSONAL_POST}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{URL}}

				<div>
					<p>{!WHISPER_PP,{USERNAME*}}</p>

					<input type="hidden" name="type" value="new_post" />
					<div class="proceed_button"><input class="button_page" type="submit" onclick="disable_button_just_clicked(this);" value="{!IN_TOPIC_PP}" /></div>
				</div>
			</form>
		{+END}
	</div>
</div>

{+START,IF,{$JS_ON}}
<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
{+END}

