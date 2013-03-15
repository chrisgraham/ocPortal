{TITLE}

{+START,INCLUDE,HANDLE_CONFLICT_RESOLUTION}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<p>
	{!POINTSTORE_PRICE_PAGE_TEXT}
</p>

<p>
	{!EDIT_PS_CONFIG,{$PAGE_LINK*,_SEARCH:admin_config:category:POINTSTORE}}
</p>

{+START,IF_NON_EMPTY,{EDIT_FORM}}
	<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
{+END}

<h2>{!EDIT}</h2>

{+START,IF_NON_EMPTY,{EDIT_FORM}}
	<p>
		{!THESE_PRODUCTS_DEFINED}
	</p>

	<div class="form_set_indent">
		{EDIT_FORM}
	</div>
{+END}
{+START,IF_EMPTY,{EDIT_FORM}}
	<p class="nothing_here">{!NO_EXTENDABLE_PRODUCTS_ENABLED}</p>
{+END}

{+START,IF_NON_EMPTY,{ADD_FORMS}}
	<h2>{!ADD}</h2>

	<p>{!ADD_ONE_AT_A_TIME}</p>

	<div class="form_set_indent">
		{ADD_FORMS}
	</div>
{+END}

