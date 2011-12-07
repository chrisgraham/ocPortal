<div class="vcard"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ProfilePage"}>
	{TITLE}

	<div>
		<div class="float_surrounder"><div class="tabs">
			{+START,LOOP,TABS}
				<a href="#" id="t_{$LCASE,{TAB_TITLE|*}}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="select_tab('g','{$LCASE,{TAB_TITLE|*}}'); return false;">
					{TAB_TITLE*}
				</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div id="g_{$LCASE,{TAB_TITLE|*}}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a name="tab__{$LCASE,{TAB_TITLE|*}}" id="tab__{$LCASE,{TAB_TITLE|*}}"></a>

					{TAB_CONTENT}
				</div>
			{+END}
		</div>
	</div>
</div>
