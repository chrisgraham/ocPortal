{+START,IF_NON_EMPTY,{CONTENT}}
	<div class="float_surrounder_precise">
		<{$?,{$VALUE_OPTION,html5},nav,div} class="menu_type__top"{$?,{$VALUE_OPTION,html5}, role="navigation"}>
			<ul class="nl">
				{CONTENT}
			</ul>
		</{$?,{$VALUE_OPTION,html5},nav,div}>
	</div>
{+END}
