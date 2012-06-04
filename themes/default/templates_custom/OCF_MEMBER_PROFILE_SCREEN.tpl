<div class="vcard" itemscope="itemscope" itemtype="http://schema.org/ProfilePage">
	{TITLE}

	<div>
		<div class="float_surrounder"><div class="tabs" role="tablist">
			{+START,LOOP,TABS}
				<a aria-controls="g_{TAB_CODE*}" role="tab" href="#" id="t_{TAB_CODE*}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}" onclick="select_tab('g','{TAB_CODE*}'); return false;">{TAB_TITLE*}</a>
			{+END}
			<a aria-controls="g_related" role="tab" href="#" id="t_related" class="tab tab_last" onclick="select_tab('g','related'); return false;">Related</a>
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div aria-labeledby="t_{TAB_CODE*}" role="tabpanel" id="g_{TAB_CODE*}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a id="tab__{TAB_CODE*}"></a>

					{TAB_CONTENT}
				</div>
			{+END}

			<div aria-labeledby="t_related" role="tabpanel" id="g_related" style="display: {$?,{$NOT,{$JS_ON}},block,none}">
				<a id="tab__related"></a>

				{$BLOCK,block=main_multi_content,param=member,select=test={$CPF_VALUE,test,{MEMBER_ID}}\,id<>{MEMBER_ID}}
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		find_url_tab();
	} );
//]]></script>
