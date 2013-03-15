<td class="form_table_field_input sp_cell">
	<div class="accessibility_hidden"><label for="access_{GROUP_ID*}_sp_{SP*}">{!OVERRIDE} ({GROUP_NAME*}, {TITLE*})</label></div>
	<select onclick="this.onchange(event);" onchange="permissions_overridden('access_{GROUP_ID%}');" onmouseover="if (this.options[this.selectedIndex].value=='-1') show_permission_setting(this,event);" tabindex="{TABINDEX*}" title="{TITLE*}" id="access_{GROUP_ID*}_sp_{SP*}" name="access_{GROUP_ID*}_sp_{SP*}">
		{$,The order of options here should not be changed with unless Javascript is also recoded}
		{+START,IF,{$EQ,{CODE},-1}}
			<option selected="selected" value="-1">/</option>
		{+END}
		{+START,IF,{$NEQ,{CODE},-1}}
			<option value="-1">{!USE_DEFAULT}</option>
		{+END}
		{+START,IF,{$EQ,{CODE},0}}
			<option selected="selected" value="0">{!NO_COMPACT}</option>
		{+END}
		{+START,IF,{$NEQ,{CODE},0}}
			<option value="0">{!NO_COMPACT}</option>
		{+END}
		{+START,IF,{$EQ,{CODE},1}}
			<option selected="selected" value="1">{!YES_COMPACT}</option>
		{+END}
		{+START,IF,{$NEQ,{CODE},1}}
			<option value="1">{!YES_COMPACT}</option>
		{+END}
	</select>

	<script type="text/javascript">// <![CDATA[
		setup_sp_override_selector('access_{GROUP_ID%}',{DEFAULT_ACCESS%},'{SP%}','{TITLE;}',{$?,{ALL_GLOBAL},true,false});
	//]]></script>

	{+START,IF,{$NOT,{ALL_GLOBAL}}}
		<script type="text/javascript">// <![CDATA[
			var list=document.getElementById('access_{GROUP_ID*;}_presets');
			// Test to see what we wouldn't have to make a change to get - and that is what we're set at
			if (!copy_permission_presets('access_{GROUP_ID*;}','0',true)) list.selectedIndex=list.options.length-4;
			else if (!copy_permission_presets('access_{GROUP_ID*;}','1',true)) list.selectedIndex=list.options.length-3;
			else if (!copy_permission_presets('access_{GROUP_ID*;}','2',true)) list.selectedIndex=list.options.length-2;
			else if (!copy_permission_presets('access_{GROUP_ID*;}','3',true)) list.selectedIndex=list.options.length-1;
		//]]></script>
	{+END}
</td>
