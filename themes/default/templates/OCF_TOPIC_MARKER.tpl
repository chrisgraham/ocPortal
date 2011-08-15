{+START,IF,{$JS_ON}}
<td id="cell_mark_{ID*}" class="ocf_row8">
	<form title="{!MARKER} #{ID*}" class="inline" method="post" action="index.php" id="form_mark_{ID*}">
		<div class="inline">
			<div class="accessibility_hidden"><label for="mark_{ID*}">{!MARKER} #{ID*}</label></div>
			<input value="1" type="checkbox" id="mark_{ID*}" name="mark_{ID*}" onclick="changeClass(this,this.parentNode.parentNode.parentNode.parentNode,'ocf_on','ocf_off')" />
		</div>
	</form>
</td>
{+END}
