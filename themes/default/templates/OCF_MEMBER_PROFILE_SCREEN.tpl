{$SET,name_set_elsewhere,1}

<div class="vcard"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ProfilePage"}>
	{TITLE}

	<div>
		<div class="float_surrounder"><div class="tabs"{$?,{$VALUE_OPTION,html5}, role="tablist"}>
			{+START,LOOP,TABS}
				<a{$?,{$VALUE_OPTION,html5}, aria-controls="g_{TAB_CODE*}" role="tab"} href="#" id="t_{TAB_CODE*}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="event.returnValue=false; select_tab('g','{TAB_CODE*;}'); return false;">
					{TAB_TITLE*}
				</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div{$?,{$VALUE_OPTION,html5}, aria-labeledby="t_{TAB_CODE*}" role="tabpanel"} id="g_{TAB_CODE*}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a name="tab__{TAB_CODE*}" id="tab__{TAB_CODE*}"></a>

					{+START,IF_PASSED,TAB_CONTENT}
						{TAB_CONTENT}
					{+END}

					{+START,IF_NON_PASSED,TAB_CONTENT}
						<p class="ajax_tree_list_loading"><img class="inline_image_2" src="{$IMG*,bottom/loading}" /></p>

						<script type="text/javascript">// <![CDATA[
							function load_tab__{TAB_CODE%}()
							{
								try { window.scrollTo(0,0); } catch (e) {};

								load_snippet('profile_tab&tab={TAB_CODE%}&member_id={MEMBER_ID%}'+window.location.search.replace('?','&'),null,function(result) {
									setInnerHTML(document.getElementById('g_{TAB_CODE*}'),result.responseText);
								} );

								// Self destruct loader after this first run
								delete window['load_tab__{TAB_CODE*}'];
							}
						//]]></script>
					{+END}
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
			var tab=window.location.hash.replace(/^#/,'').replace(/^tab\_\_/,'');

			if (tab.indexOf('__')!=-1)
			{
				if (document.getElementById('g_'+tab.substr(0,tab.indexOf('__'))))
					select_tab('g',tab.substr(0,tab.indexOf('__')));
			}
			if (document.getElementById('g_'+tab))
				select_tab('g',tab);
		}
	} );
//]]></script>
