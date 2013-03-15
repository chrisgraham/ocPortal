{TITLE}

<form title="{!PRIMARY_PAGE_FORM}" onkeypress="if (enter_pressed(event)) { add_test(); return false; }" method="post" onsubmit="return check_form(this);" action="{URL*}">
	<div>
		<h2>{!SETTINGS}</h2>

		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="autosized_table form_table wide_table"><tbody>
			{FIELDS}
		</tbody></table></div>

		<h2>{!TESTS}</h2>
		<script type="text/javascript">// <![CDATA[
			var add_template='{ADD_TEMPLATE;~/}';
			var next_id=1;

			function add_test()
			{
				var t=document.getElementById('tests_container');
				t.id='';
				set_inner_html(t,add_template.replace(/\-REPLACEME\-/g,next_id));
				next_id++;
			}
		//]]></script>

		{+START,IF_NON_EMPTY,{TESTS}}
			<div>
				{TESTS}
			</div>
		{+END}

		<div id="tests_container">
			 <span style="display: none"></span>
		</div>

		<ul class="actions_list force_margin">
			<li><a rel="add" href="#" onclick="add_test(); return false;">{!ADD}</a></li>
		</ul>

		<h2>{!PROCEED}</h2>

		<p class="proceed_button">
			<input accesskey="u" class="button_page" type="submit" value="{SUBMIT_NAME*}" />
		</p>
	</div>
</form>

