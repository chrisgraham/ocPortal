{$SET,name_set_elsewhere,1}

<div class="vcard" itemscope="itemscope" itemtype="http://schema.org/ProfilePage">
	{TITLE}

	<div>
		<div class="float_surrounder"><div class="tabs" role="tablist">
			{+START,LOOP,TABS}
				<a aria-controls="g_{TAB_CODE*}" role="tab" href="#" id="t_{TAB_CODE*}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="select_tab('g','{TAB_CODE*}'); return false;">{TAB_TITLE*}</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div aria-labeledby="t_{TAB_CODE*}" role="tabpanel" id="g_{TAB_CODE*}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a id="tab__{TAB_CODE*}"></a>

					{TAB_CONTENT}
				</div>
			{+END}
		</div>
	</div>
</div>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		find_url_tab();
	} );
//]]></script>
