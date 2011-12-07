<div class="vcard"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ProfilePage"}>
	{TITLE}

	<div>
		<div class="float_surrounder"><div class="tabs">
			{+START,LOOP,TABS}
				<a href="#" id="t_{TAB_CODE*}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="select_tab('g','{TAB_CODE*}'); return false;">
					{TAB_TITLE*}
				</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div id="g_{TAB_CODE*}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a name="tab__{TAB_CODE*}" id="tab__{TAB_CODE*}"></a>

					{TAB_CONTENT}
				</div>
			{+END}
		</div>
	</div>
</div>

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		{$,Expand the correct tab}
		if (window.location.hash.replace(/^#/,'')!='')
		{
			if (document.getElementById('g_'+window.location.hash.replace(/^#/,'').replace(/^tab\_\_/,'')))
				select_tab('g',window.location.hash.replace(/^#/,'').replace(/^tab\_\_/,''));
		}
	} );
//]]></script>
