{TITLE}

<div class="whos_read">
	{+START,IF_NON_EMPTY,{WHOS_READ}}
		{+START,BOX,{!THIS_HAS_BEEN_READ_BY}}
			{+START,LOOP,WHOS_READ}
				<a href="{MEMBER_LINK*}">{USERNAME*}</a> &ndash; <span class="associated_details">{DATE*}</span><br />
			{+END}
		{+END}
	{+END}
</div>

<div class="message_main">
	{+START,BOX,{MESSAGE_TITLE} ({!BY_SIMPLE,{BY*}})}
		{MESSAGE}
	{+END}
</div>

{+START,IF_NON_PASSED,RESPONSIBLE}
	<p class="responsibility_bit">{!PLEASE_TAKE_RESPONSIBILITY,<a href="{TAKE_RESPONSIBILITY_URL*}">{!TAKE_RESPONSIBILITY}</a>}</p>
{+END}
{+START,IF_PASSED,RESPONSIBLE}
	<p class="responsibility_bit">{!CANT_TAKE_RESPONSIBILITY,<strong>{RESPONSIBLE*}</strong>}</p>
{+END}

<hr class="spaced_rule" />

<p>
	{!DISCUSS_BELOW}
</p>

{COMMENT_DETAILS}

