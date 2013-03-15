{TITLE}

<div class="ocf_whisper_lead_in">
	<img src="{$IMG*,bigicons/subscribers}" alt="" class="right" />

	{+START,IF,{$HAS_PRIVILEGE,use_pt}}<p>{!WHISPER_TEXT}</p>{+END}
</div>


<div class="float_surrounder">
	{+START,IF,{$HAS_PRIVILEGE,use_pt}}
		<div class="ocf_whisper_choose_box right">
			<div class="box box___ocf_whisper_choice_screen"><div class="box_inner">
				<h2>{!PRIVATE_TOPIC}</h2>

				<form title="{!PRIVATE_TOPIC}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
					{$HIDDENS_FOR_GET_FORM,{URL}}

					<div>
						<p>{!WHISPER_PT,{USERNAME*}}</p>

						<input type="hidden" name="type" value="new_pt" />

						<p class="proceed_button">
							<input class="button_page" type="submit" onclick="disable_button_just_clicked(this);" value="{!QUOTE_TO_PT}" />
						</p>
					</div>
				</form>
			</div></div>
		</div>
	{+END}

	<div class="ocf_whisper_choose_box">
		<div class="box box___ocf_whisper_choice_screen"><div class="box_inner">
			<h2>{!PERSONAL_POST}</h2>

			<form title="{!PERSONAL_POST}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{URL}}

				<div>
					<p>{!WHISPER_PP,{USERNAME*}}</p>

					<input type="hidden" name="type" value="new_post" />

					<p class="proceed_button">
						<input class="button_page" type="submit" onclick="disable_button_just_clicked(this);" value="{!IN_TOPIC_PP}" />
					</p>
				</div>
			</form>
		</div></div>
	</div>
</div>

{+START,IF,{$JS_ON}}
	<p class="back_button">
		<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
	</p>
{+END}

