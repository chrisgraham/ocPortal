{TITLE}

<div class="float_surrounder">
	<div class="theme_wizard_info_box">
		{+START,BOX,{!SEED_COLOUR}}
			#<span class="theme_wizard_info_box_label">{SEED*}</span><br />
				({!RED}: <span class="theme_wizard_colour">{RED*}</span>, {!GREEN}: <span class="theme_wizard_colour">{GREEN*}</span>, {!BLUE}: <span class="theme_wizard_colour">{BLUE*}</span>)<br />
				<span class="theme_wizard_change_colour">[ <a href="{CHANGE_LINK*}">{!CHANGE}</a> ]</span>
		{+END}
	</div>
	
	<p>{!THEMEWIZARD_2_DOMINANT,{DOMINANT*}}</p>
	
	<p>{!THEMEWIZARD_2_LIGHT_DARK,{LD*}}</p>
</div>

{+START,IF,{$NOT,{$VALUE_OPTION,xhtml_strict}}}
	<div class="theme_wizard_preview_wrap">
		{+START,BOX,{!PREVIEW}}
			<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} title="{!PREVIEW}" class="theme_wizard_preview" src="{$PAGE_LINK*,::keep_theme_seed={SEED#}:keep_theme_dark={DARK#}:keep_theme_source={SOURCE_THEME#}:keep_theme_algorithm={ALGORITHM#}:wide=1:keep_theme=default}">{!PREVIEW}</iframe>
		{+END}
	</div>
{+END}

<p class="theme_wizard_use_colour">[ <a href="{STAGE3_LINK*}">{!THEMEWIZARD_2_USE}</a> ]</p>

<p class="theme_wizard_use_colour">[ <a target="_blank" title="{!PREVIEW}: {!LINK_NEW_WINDOW}" href="{$PAGE_LINK*,::keep_theme_seed={SEED#}:keep_theme_dark={DARK#}:keep_theme_source={SOURCE_THEME#}:keep_theme_algorithm={ALGORITHM#}}">{!PREVIEW}</a> ]</p>
