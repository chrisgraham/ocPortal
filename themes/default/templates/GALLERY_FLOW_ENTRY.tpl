<div class="flowmode_thumb">
	{+START,IF_NON_EMPTY,{_EDIT_URL}}
		<form onsubmit="return confirm_gallery_delete(this);" class="delete_cross_button" title="{!DELETE} #{ID*}" action="{_EDIT_URL*}" method="post">
			<div>
				<input type="hidden" name="delete" value="2" />
				<input type="image" alt="{!DELETE}" src="{$IMG*,results/delete}" />
			</div>
		</form>
	{+END}

	<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
</div>
