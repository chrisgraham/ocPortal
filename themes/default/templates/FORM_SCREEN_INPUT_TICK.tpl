{+START,IF,{$NOT,{CHECKED}}}
	<input tabindex="{TABINDEX*}" class="input_tick" type="checkbox" id="{NAME*}" name="{NAME*}" value="{+START,IF_PASSED,VALUE}{VALUE*}{+END}{+START,IF_NON_PASSED,VALUE}1{+END}" />
{+END}
{+START,IF,{CHECKED}}
	<input tabindex="{TABINDEX*}" class="input_tick" type="checkbox" id="{NAME*}" name="{NAME*}" value="{+START,IF_PASSED,VALUE}{VALUE*}{+END}{+START,IF_NON_PASSED,VALUE}1{+END}" checked="checked" />
{+END}
<input name="tick_on_form__{NAME*}" value="0" type="hidden" />

{+START,IF,{$EQ,{NAME},delete}}
	<script type="text/javascript">// <![CDATA[
		addEventListenerAbstract(window,'load',function () {
			document.getElementById('{NAME;}').onchange=function()
			{
				if (this.checked)
				{
					window.fauxmodal_confirm(
						"{!ARE_YOU_SURE_DELETE^#}",
						function(result)
						{
							if (!result) document.getElementById('{NAME;}').checked=false;
						}
					);
				}
			}
		} );
	//]]></script>
{+END}
