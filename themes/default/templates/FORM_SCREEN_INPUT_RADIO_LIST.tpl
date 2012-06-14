{+START,IF_PASSED,NAME}
	<div id="error_{NAME*}" style="display: none" class="input_error_here"></div>
{+END}

{CONTENT}

{+START,IF_PASSED,NAME}
	<input type="hidden" name="require__{NAME*}" value="1" />

	{+START,IF_PASSED,CODE}
		<script type="text/javascript">// <![CDATA[
			choose_picture('{$FIX_ID;,j_{NAME}_{CODE}}',document.getElementById('{$FIX_ID;,j_{NAME}_{CODE}}_img'),'{NAME;}',null);
		//]]></script>
	{+END}

	{+START,IF,{$EQ,{NAME},delete}}
		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'load',function () {
				for (var i=1;i<3;i++)
				{
					var e=document.getElementById('j_{NAME;}_'+i);
					if (e)
					{
						e.onchange=function()
						{
							if (this.checked)
							{
								window.fauxmodal_confirm(
									"{!ARE_YOU_SURE_DELETE^#}",
									function(result)
									{
										if (!result)
										{
											var e=document.getElementById('j_{NAME;}_0');
											if (e e.checked=true;
										}
									}
								);
							}
						}
					}
				}
			} );
		//]]></script>
	{+END}
{+END}
