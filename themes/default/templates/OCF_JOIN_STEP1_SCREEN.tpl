{TITLE}

<p>
	{!DESCRIPTION_I_AGREE_RULES}
</p>

<div class="box box___ocf_join_step1_screen"><div class="box_inner"><div>
	{RULES}
</div></div></div>

<form title="{!PRIMARY_PAGE_FORM}" class="ocf_join_1" method="post" action="{URL*}">
	<p>
		<input type="checkbox" id="confirm" name="confirm" value="1" onclick="document.getElementById('proceed_button').disabled=!this.checked;" /><label for="confirm">{!I_AGREE_RULES}</label>
	</p>

	{+START,IF_NON_EMPTY,{GROUP_SELECT}}
		<p>
			<label for="primary_group">{!CHOOSE_JOIN_USERGROUP}
				<select id="primary_group" name="primary_group">
					{GROUP_SELECT}
				</select>
			</label>
		</p>
	{+END}

	<p>
		{+START,IF,{$JS_ON}}
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" disabled="disabled" id="proceed_button" />
		{+END}
		{+START,IF,{$NOT,{$JS_ON}}}
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" id="proceed_button" />
		{+END}
	</p>
</form>

{+START,IF_NON_EMPTY,{GENERATE_HOST}}
	<div class="box box___ocf_join_step1_screen"><div class="box_inner">
		<h2>{!REMOTE_MEMBERS}</h2>

		{!DESCRIPTION_IS_REMOTE_MEMBER,{GENERATE_HOST}}
	</div></div>
{+END}

