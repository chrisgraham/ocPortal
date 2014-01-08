{TITLE}

{+START,IF_PASSED,GENERATED}
	<div class="filedump_generated">
		{+START,IF_PASSED,RENDERED}
			<div class="filedump_generated_preview">
				<span for="generated_comcode" class="lonely_label">{!PREVIEW}:</span>
				{RENDERED}
			</div>
		{+END}

		<div class="filedump_generated_comcode">
			<label for="generated_comcode" class="lonely_label">{!_COMCODE}:</label>
			<form action="#">
				<div>
					<textarea id="generated_comcode" name="generated_comcode" cols="50" rows="10">{GENERATED*}</textarea>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			var e=document.getElementById('generated_comcode');
			try
			{
				e.focus();
			}
			catch (e) {};
			e.select();
		} );
	//]]></script>
{+END}

{FORM}
