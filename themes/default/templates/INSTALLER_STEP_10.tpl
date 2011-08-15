<div class="installer_main_min">
	<p>
		{!INSTALL_LOG_BELOW,{PREVIOUS_STEP*}}:
	</p>

	<div><div class="install_log_table">
		<span class="install_log_table_title">{!INSTALL_LOG}:</span>
		<ul class="actions_list">
			{LOG}
		</ul>
	</div></div>

	<p>
		{FINAL}
	</p>

	<p>
		{!FINAL_INSTRUCTIONS_B}
	</p>

	<p>
		{!FINAL_INSTRUCTIONS_C}
	</p>

	<{$?,{$VALUE_OPTION,html5},nav,div}>
		<ul class="actions_list">
			<li>&raquo; <span class="actions_list_strong"><a href="{$BASE_URL*}/adminzone/index.php?page=admin_setupwizard&amp;type=misc">{!CONFIGURE}</a> ({!RECOMMENDED})</span></li>
			<li>&raquo; <span class="actions_list_strong"><a href="{$BASE_URL*}/index.php">{!GO}</a></span></li>
		</ul>
	</{$?,{$VALUE_OPTION,html5},nav,div}>

	<p>
		{!THANKS}
	</p>
</div>
