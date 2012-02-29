<{$?,{$VALUE_OPTION,html5},nav,div}{$?,{$VALUE_OPTION,html5}, role="navigation"}>
	<ul class="sitemap"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
		{+START,LOOP,CHILDREN}
			<li>
				{_loop_var}
			</li>
		{+END}
	</ul>
</{$?,{$VALUE_OPTION,html5},nav,div}>
