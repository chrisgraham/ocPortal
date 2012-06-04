<section class="box box___block_side_news_archive"><div class="box_inner">
	<h3>{TITLE*}</h3>

	<ul class="compact_list">
		{+START,LOOP,YEARS}
			<li>{YEAR}
				<ul class="compact_list associated_details">
					{+START,LOOP,TIMES}
						<li>
							<a href="{URL*}">{MONTH_STRING}</a>
						</li>
					{+END}
				</ul>
			</li>
		{+END}
	</ul>
</div></section>
