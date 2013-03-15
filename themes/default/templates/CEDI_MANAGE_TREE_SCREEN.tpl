{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<h2>{!HELP}</h2>

{!CEDI_MANAGE_TREE_TEXT}

<h2>{!SETTINGS}</h2>

{FORM}

<h2>{!ID_ASSISTANCE_TOOL}</h2>

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="index.php">
	<p><label for="mtp_tree">{!BROWSE_ID_INSERT}</label></p>

	<div>
		{+START,IF,{$JS_ON}}
			<input style="display: none" type="text" id="mtp_tree" name="tree" value="" onchange="if (this.form.elements['tree'].value!='') document.getElementById('children').value+=this.value+'!'+this.selected_title+'\n';" />
			<div id="tree_list__root_mtp_tree">
				<!-- List put in here -->
			</div>
			<script type="text/javascript">// <![CDATA[
				{$JAVASCRIPT_INCLUDE,javascript_ajax}
				{$JAVASCRIPT_INCLUDE,javascript_tree_list}
				{$JAVASCRIPT_INCLUDE,javascript_more}
				new tree_list('mtp_tree','data/ajax_tree.php?hook=choose_cedi_page{$KEEP;}','','');
			//]]></script>
		{+END}

		{+START,IF,{$NOT,{$JS_ON}}}
			<select id="mtp_tree" name="tree">
				{CEDI_TREE}
			</select>

			<input type="button" value="{!ADD}" onclick="if (this.form.elements['tree'].value!='') document.getElementById('children').value+=this.form.elements['tree'].value+'\n'" />
		{+END}
	</div>
</form>

