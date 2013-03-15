{+START,IF_NON_EMPTY,{TEXT}}
	{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}</p>{+END}
{+END}

{$JAVASCRIPT_INCLUDE,javascript_validation}
<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_NON_PASSED,GET}method="post" action="{URL*}"{+START,IF,{$IN_STR,{FIELD_GROUPS},"file"}} enctype="multipart/form-data"{+END}{+END}{+START,IF_PASSED,GET}method="get" action="{$URL_FOR_GET_FORM*,{URL}}"{+END} target="_top" {+START,IF_PASSED,AUTOCOMPLETE}{+START,IF,{AUTOCOMPLETE}}class="autocomplete" {+END}{+END}>
	{+START,IF_PASSED,GET}{$HIDDENS_FOR_GET_FORM,{URL}}{+END}

	<div>
		{FIELD_GROUPS}
	</div>

	{+START,INCLUDE,FORM_STANDARD_END}{+END}
</form>

