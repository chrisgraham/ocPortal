<li>
	{+START,IF_PASSED,URL}
		{!VALIDATION_ERROR_AT,{ERROR},<a href="{URL*}#errorloc_{I*}">{LINE}</a>,{POS}}
	{+END}
	{+START,IF_NON_PASSED,URL}
		{!VALIDATION_ERROR_AT,{ERROR},<a href="#errorloc_{I*}">{LINE}</a>,{POS}}
	{+END}
</li>

