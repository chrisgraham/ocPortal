<div class="standardbox_spaced">
	<div class="trackback_result">
		{+START,BOX}
			{TITLE*} &ndash; {TIME*} (<a href="{URL*}">{NAME*}</a>)
			{+START,IF_NON_EMPTY,{EXCERPT}}
				<p>{EXCERPT}</p>
			{+END}

			{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,_SEARCH:admin_trackbacks}}
				<p>
					<label for="trackback_{ID*}_0"><input checked="checked" type="radio" id="trackback_{ID*}_0" name="trackback_{ID*}" value="0" /> {!LEAVE_TRACKBACK}</label><br />
					<label for="trackback_{ID*}_1"><input type="radio" id="trackback_{ID*}_1" name="trackback_{ID*}" value="1" /> {!DELETE_TRACKBACK}</label><br />
					{+START,IF,{$ADDON_INSTALLED,securitylogging}}
						<label for="trackback_{ID*}_2"><input type="radio" id="trackback_{ID*}_2" name="trackback_{ID*}" value="2" /> {!DELETE_BAN_TRACKBACK}</label>
					{+END}
				</p>
			{+END}
		{+END}
	</div>
</div>

