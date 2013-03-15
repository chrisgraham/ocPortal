<div class="box box___iotd_admin_choose_screen_iotd"><div class="box_inner">
	{+START,IF_NON_EMPTY,{THUMB_URL}}
		<div class="iotd_admin_preview_picture">
			 <a target="_blank" title="{!IOTD}: {!LINK_NEW_WINDOW}" href="{FULL_URL*}"><img alt="{!THUMBNAIL}" src="{THUMB_URL*}" /></a>
		</div>
	{+END}

	<div class="meta_details" role="contentinfo">
		<ul class="meta_details_list">
			<li>{!SUBMITTED_BY,{USERNAME_LINK}}</li>
		</ul>
	</div>

	<p>{CAPTION}</p>

	<div style="margin-right: {$CONFIG_OPTION,thumb_width}px" class="buttons_group">
		{+START,IF,{$NOT,{IS_CURRENT}}}<form title="{!CHOOSE} {!IOTD} #{ID*}" class="inline" action="{CHOOSE_URL*}" method="post"><input type="hidden" name="id" value="{ID*}" /><input type="image" class="button_pageitem" src="{$IMG*,pageitem/choose}" title="{!CHOOSE} {!IOTD} #{ID*}" alt="{!CHOOSE} {!IOTD} #{ID*}" /></form>{+END}
		<a rel="edit" href="{EDIT_URL*}" title="{!EDIT}: {!IOTD} #{ID*}"><img class="button_pageitem" src="{$IMG*,pageitem/edit}" alt="" /></a>
		<form title="{!DELETE} {!IOTD} #{ID*}" onsubmit="var t=this; window.fauxmodal_confirm('{!ARE_YOU_SURE_DELETE=;}',function(answer) { if (answer) t.submit(); }); return false;" class="inline" action="{DELETE_URL*}" method="post"><input type="hidden" name="id" value="{ID*}" /><input type="image" class="button_pageitem" src="{$IMG*,pageitem/delete}" title="{!DELETE} {!IOTD} #{ID*}" alt="{!DELETE} {!IOTD} #{ID*}" /></form>
	</div>
</div></div>

