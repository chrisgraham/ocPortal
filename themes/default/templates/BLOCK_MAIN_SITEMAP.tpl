<nav role="navigation">
	<ul class="sitemap" itemprop="significantLinks">
		{+START,LOOP,CHILDREN}
			<li>
				{_loop_var}
			</li>
		{+END}
	</ul>
</nav>
