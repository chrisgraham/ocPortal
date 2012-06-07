<section class="box box___block_side_google_search"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}<h3>{TITLE}</h3>{+END}

	<div id="cse-search-form" style="width: 100%;">Loading</div>

	<script src="http://www.google.com/jsapi" type="text/javascript"></script>
	<script type="text/javascript">// <![CDATA[
		var google_uid='{USER_SEARCH_ID}';
		google.load('search', '1', {language : 'en'});
		google.setOnLoadCallback(function(){
			var customSearchControl=new google.search.CustomSearchControl(google_uid);
			customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
			var options=new google.search.DrawOptions();
			options.setSearchFormRoot('cse-search-form');
			customSearchControl.draw('cse', options);

			var cse_form=document.getElementById('cse-search-form');

			if (!document.getElementById('cse'))
			{
					get_elements_by_class_name(cse_form,'gsc-search-box')[0].action='{$PAGE_LINK;,_SEARCH:{PAGE_ID}}';
					get_elements_by_class_name(cse_form,'gsc-search-box')[0].method='post';
					get_elements_by_class_name(cse_form,'gsc-search-button')[0].onclick=function() { get_elements_by_class_name(cse_form,'gsc-search-box')[0].submit() ; };
			} else
			{
				 cse_form.getElementsByTagName('input')[0].value='{$_POST;,search}';
				 cse_form.getElementsByTagName('input')[0].onfocus();
				 cse_form.getElementsByTagName('input')[1].onclick();
			}

		}, true);
	//]]></script>

	<link rel="stylesheet" href="http://www.google.com/cse/style/look/default.css" type="text/css" />
	<style type="text/css">
		.gsc-clear-button {
			 display: none;
		}
		.gsc-control-cse {
			font-family: Arial, sans-serif;
			border-color: #FFFFFF;
			background-color: #FFFFFF;
		}
		input.gsc-input {
			border-color: #BCCDF0;
			width: 95%;
		}
		input.gsc-search-button {
			border-color: #666666;
			background-color: #CECECE;
			font-size: 0.85em;
		}
		.gsc-tabHeader.gsc-tabhInactive {
			border-color: #E9E9E9;
			background-color: #E9E9E9;
		}
		.gsc-tabHeader.gsc-tabhActive {
			border-top-color: #FF9900;
			border-left-color: #E9E9E9;
			border-right-color: #E9E9E9;
			background-color: #FFFFFF;
		}
		.gsc-tabsArea {
			border-color: #E9E9E9;
		}
		.gsc-webResult.gsc-result {
			border-color: #FFFFFF;
			background-color: #FFFFFF;
		}
		.gsc-webResult.gsc-result:hover {
			border-color: #FFFFFF;
			background-color: #FFFFFF;
		}
		.gs-webResult.gs-result a.gs-title:link,
		.gs-webResult.gs-result a.gs-title:link b {
			color: #0000CC;
		}
		.gs-webResult.gs-result a.gs-title:visited,
		.gs-webResult.gs-result a.gs-title:visited b {
			color: #0000CC;
		}
		.gs-webResult.gs-result a.gs-title:hover,
		.gs-webResult.gs-result a.gs-title:hover b {
			color: #0000CC;
		}
		.gs-webResult.gs-result a.gs-title:active,
		.gs-webResult.gs-result a.gs-title:active b {
			color: #0000CC;
		}
		.gsc-cursor-page {
			color: #0000CC;
		}
		a.gsc-trailing-more-results:link {
			color: #0000CC;
		}
		.gs-webResult.gs-result .gs-snippet {
			color: #000000;
		}
		.gs-webResult.gs-result .gs-visibleUrl {
			color: #008000;
		}
		.gs-webResult.gs-result .gs-visibleUrl-short {
			color: #008000;
		}
		.gsc-cursor-box {
			border-color: #FFFFFF;
		}
		.gsc-results .gsc-cursor-page {
			border-color: #E9E9E9;
			background-color: #FFFFFF;
		}
		.gsc-results .gsc-cursor-page.gsc-cursor-current-page {
			border-color: #FF9900;
			background-color: #FFFFFF;
		}
		.gs-promotion.gs-result {
			border-color: #336699;
			background-color: #FFFFFF;
		}
		.gs-promotion.gs-result a.gs-title:link {
			color: #0000CC;
		}
		.gs-promotion.gs-result a.gs-title:visited {
			color: #0000CC;
		}
		.gs-promotion.gs-result a.gs-title:hover {
			color: #0000CC;
		}
		.gs-promotion.gs-result a.gs-title:active {
			color: #0000CC;
		}
		.gs-promotion.gs-result .gs-snippet {
			color: #000000;
		}
		.gs-promotion.gs-result .gs-visibleUrl,
		.gs-promotion.gs-result .gs-visibleUrl-short {
			color: #008000;
		}
	</style>
</div></section>
