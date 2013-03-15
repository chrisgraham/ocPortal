{+START,BOX,{!VERSION_ABOUT,{VERSION*}},,{$?,{$GET,in_panel},panel,classic}}
	<div class="staff_new_versions">
		{VERSION_TABLE}

		{+START,IF,{$NOT,{$BROWSER_MATCHES,ie6}}}
			<div class="img_wrap">
				<img src="{$IMG*,pagepics/ocp-logo}" alt="" />
			</div>
		{+END}
	</div>
{+END}
