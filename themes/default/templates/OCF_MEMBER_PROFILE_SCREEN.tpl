{$SET,name_set_elsewhere,1}

<div class="vcard" itemscope="itemscope" itemtype="http://schema.org/ProfilePage">
	{TITLE}

	<div>
		<div class="float_surrounder"><div class="tabs" role="tablist">
			{+START,LOOP,TABS}
				<a aria-controls="g_{TAB_CODE*}" role="tab" href="#" id="t_{TAB_CODE*}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="event.returnValue=false; select_tab('g','{TAB_CODE;*}'); return false;">{TAB_TITLE*}</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div aria-labeledby="t_{TAB_CODE*}" role="tabpanel" id="g_{TAB_CODE*}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a id="tab__{TAB_CODE*}"></a>

					{+START,IF_PASSED,TAB_CONTENT}
						{TAB_CONTENT}
					{+END}

					{+START,IF_NON_PASSED,TAB_CONTENT}
						<p class="ajax_tree_list_loading"><img class="vertical_alignment" src="{$IMG*,loading}" /></p>

						<script type="text/javascript">// <![CDATA[
							function load_tab__{TAB_CODE%}(automated)
							{
								if (typeof window['load_tab__{TAB_CODE%}'].done!='undefined' && window['load_tab__{TAB_CODE%}'].done) return;

								if (automated)
								{
									try { window.scrollTo(0,0); } catch (e) {};
								}

								// Self destruct loader after this first run
								window['load_tab__{TAB_CODE%}'].done=true;

								load_snippet('profile_tab&tab={TAB_CODE%}&member_id={MEMBER_ID%}'+window.location.search.replace('?','&'),null,function(result) {
									set_inner_html(document.getElementById('g_{TAB_CODE%}'),result.responseText);

									find_url_tab();
								} );
							}
						//]]></script>
					{+END}
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
