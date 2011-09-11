{TITLE}

<p>
	{!OCF_MEMBER_HOME_TEXT,{USERNAME*},{$MEMBER_PROFILE_LINK*,{MEMBER_ID}}}
</p>

<br />

{+START,BOX,{!PERSONAL_NOTES},,med}
	<p>
		<label for="m_notes">{!EXPLANATION_PERSONAL_NOTES}</label>
	</p>
	
	<form title="{!PERSONAL_NOTES}" action="{NOTES_URL*}" method="post">
		<div>
			<div class="constrain_field">
				<textarea onfocus="window.scrollTo(0,findPosY(this)-10); this.setAttribute('rows','23');" onblur="if (!this.form.disable_size_change) this.setAttribute('rows','10');" class="wide_field" id="m_notes" name="notes" cols="50" rows="10">{NOTES*}</textarea>
			</div>
			<div class="proceed_button">
				<input class="button_pageitem" type="submit" onclick="disable_button_just_clicked(this);" onmouseover="this.form.disable_size_change=true;" onmouseout="this.form.disable_size_change=false;" value="{!SAVE}" />
			</div>
		</div>
	</form>
{+END}

{+START,IF,{$ADDON_INSTALLED,filedump}}
	<br />
	{+START,BOX,{!filedump:FILE_DUMP}}
		{$BLOCK,block=myfiles}
		
		{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,filedump}}
			<p class="community_block_tagline">[ <a href="{$PAGE_LINK*,_SEARCH:filedump:misc:place=/{$USERNAME&}/}">{!MORE}</a> ]</p>
		{+END}
	{+END}
{+END}

{+START,IF_NON_EMPTY,{TOPICS}}
	<br />
	{TOPICS}
{+END}

{+START,IF_NON_EMPTY,{GALLERIES}}
	<br />
	{+START,BOX,{!galleries:GALLERIES}}
		<ul class="category_list">
			{GALLERIES}
		</ul>
	{+END}
{+END}

{+START,IF_NON_EMPTY,{WARNINGS}}
	<br />
	{+START,BOX,{!WARNINGS}}
		{WARNINGS}
	{+END}
{+END}

