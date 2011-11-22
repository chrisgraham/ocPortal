{TITLE}

<p>
	{!ALREADY_MEMBER_LOGIN,{$PAGE_LINK*,:login:redirect_url={$SELF_URL&}},{HIDDEN}}
</p>

<hr />

<p>
	{!ENTER_PROFILE_DETAILS}
</p>

{FORM}

{+START,IF_PASSED,JAVASCRIPT}
	<script type="text/javascript">// <![CDATA[
		{JAVASCRIPT`}
	//]]></script>
{+END}
