{+START,BOX,,,med}
	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{THUMB_URL}}
			<div class="iotd_admin_preview_picture">
				 <a target="_blank" title="{!IOTD}: {!LINK_NEW_WINDOW}" href="{FULL_URL*}"><img title="" alt="{!THUMBNAIL}" src="{THUMB_URL*}" /></a>
			</div>
		{+END}

		<div style="margin-right: {$CONFIG_OPTION,thumb_width}px">
			<div>
				{CAPTION}
			</div>

			<p class="standard_meta_block">
				<img alt="" title="" src="{$IMG*,edited}" /> {!SUBMITTED_BY,{USERNAME_LINK}}
			</p>
		</div>
	</div>

	<div style="margin-right: {$CONFIG_OPTION,thumb_width}px" class="button_panel_left">
		{+START,IF,{$NOT,{IS_CURRENT}}}<form title="{!ACTIONS}: #{ID*}" class="inline" action="{CHOOSE_URL*}" method="post"><input type="hidden" name="id" value="{ID*}" /><input type="image" class="button_pageitem page_icon" src="{$IMG*,pageitem/choose}" title="{!CHOOSE} #{ID*}" alt="{!CHOOSE} #{ID*}" /></form>{+END}
		<a rel="edit" href="{EDIT_URL*}" title="{!EDIT}: {!IOTD} #{ID*}"><img class="button_pageitem page_icon" src="{$IMG*,pageitem/edit}" title="{!EDIT}" alt="{!EDIT}" /></a>
		<form title="{!DELETE} #{ID*}" onsubmit="var t=this; window.fauxmodal_confirm('{!ARE_YOU_SURE_DELETE=;}',function(answer) { if (answer) t.submit(); }); return false;" class="inline" action="{DELETE_URL*}" method="post"><input type="hidden" name="id" value="{ID*}" /><input type="image" class="button_pageitem page_icon" src="{$IMG*,pageitem/delete}" title="{!DELETE} #{ID*}" alt="{!DELETE} #{ID*}" /></form>
	</div>
{+END}

