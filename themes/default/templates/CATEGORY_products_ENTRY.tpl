{+START,BOX,{NAME_PLAIN},,curved}
	<div class="category_entry">
		<div class="float_surrounder">
			{+START,IF_NON_EMPTY,{REP_IMAGE}}
				<div class="right"><a href="{URL*}">{REP_IMAGE}</a></div>
			{+END}
			{+START,IF_EMPTY,{REP_IMAGE}}
				<div class="right"><a href="{URL*}">{REP_IMAGE}</a></div>
			{+END}
			&bull; <a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME_PLAIN},{NAME_FIELD},{AJAX_EDIT_URL},1}{NAME*}{+END}</a> &ndash; {CHILDREN}
			<br />
			<p>{DESCRIPTION}</p>
		</div>
	</div>
{+END}
<br />