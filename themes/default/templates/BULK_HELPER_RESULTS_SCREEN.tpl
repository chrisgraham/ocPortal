{TITLE}

<p>{!BULK_COPY_PASTE_AS_NEEDED}</p>

<form title="{!_RESULTS}" method="post" action="index.php">
	<p class="lonely_label"><label for="bulk_help">{!_RESULTS}:</label></p>

	<div class="constrain_field">
		<textarea readonly="readonly" name="bulk_help" id="bulk_help" cols="70" rows="30" class="wide_field textarea_scroll">{RESULTS*}</textarea>
	</div>
</form>
