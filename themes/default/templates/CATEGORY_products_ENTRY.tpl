<li class="box box___category_products_entry"><div class="box_inner">
	<h2>{NAME_PLAIN}</h2>

	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{REP_IMAGE}}
			<div class="right float_separation"><a href="{URL*}">{REP_IMAGE}</a></div>
		{+END}
		{+START,IF_EMPTY,{REP_IMAGE}}
			<div class="right float_separation"><a href="{URL*}">{REP_IMAGE}</a></div>
		{+END}

		<p>&bull; <a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME_PLAIN},{NAME_FIELD},{AJAX_EDIT_URL},1}{NAME*}{+END}</a> &ndash; {CHILDREN}</p>

		{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<p>{DESCRIPTION}</p>
		{+END}{+END}
	</div>
</div></li>
