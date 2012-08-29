<div class="box box___iotd_box"><div class="box_inner">
	{+START,IF,{GIVE_CONTEXT}}
		<h3>{!IOTD}</h3>
	{+END}

	{+START,IF_NON_EMPTY,{THUMB_URL}}
		<div class="iotd_admin_preview_picture">
			 {+START,IF_NON_EMPTY,{VIEW_URL}}<a target="_blank" title="{TITLE*}" href="{VIEW_URL*}">{+END}<img alt="{!THUMBNAIL}" src="{THUMB_URL*}" />{+START,IF_NON_EMPTY,{VIEW_URL}}</a>{+END}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{USERNAME}}
		<div class="meta_details" role="contentinfo">
			<ul class="meta_details_list">
				<li>{!SUBMITTED_BY,<a href="{$MEMBER_PROFILE_URL,{SUBMITTER}}">{USERNAME*}</a>}</li>
			</ul>
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{I_TITLE}}
		<div class="associated_details">
			{$PARAGRAPH,{I_TITLE}}
		</div>
	{+END}

	{+START,IF_PASSED,CHOOSE_URL}{+START,IF_PASSED,EDIT_URL}{+START,IF_PASSED,IS_CURRENT}
		<div style="margin-right: {$CONFIG_OPTION,thumb_width}px" class="buttons_group">
			{+START,IF,{$NOT,{IS_CURRENT}}}<form title="{!CHOOSE} {!IOTD} #{ID*}" class="inline" action="{CHOOSE_URL*}" method="post"><input type="hidden" name="id" value="{ID*}" /><input type="image" class="button_pageitem" src="{$IMG*,pageitem/choose}" title="{!CHOOSE} {!IOTD} #{ID*}" alt="{!CHOOSE} {!IOTD} #{ID*}" /></form>{+END}
			<a rel="edit" href="{EDIT_URL*}" title="{!EDIT}: {!IOTD} #{ID*}"><img class="button_pageitem" src="{$IMG*,pageitem/edit}" alt="" /></a>
			<form title="{!DELETE} {!IOTD} #{ID*}" onsubmit="var t=this; window.fauxmodal_confirm('{!ARE_YOU_SURE_DELETE=;}',function(answer) { if (answer) t.submit(); }); return false;" class="inline" action="{DELETE_URL*}" method="post"><input type="hidden" name="id" value="{ID*}" /><input type="image" class="button_pageitem" src="{$IMG*,pageitem/delete}" title="{!DELETE} {!IOTD} #{ID*}" alt="{!DELETE} {!IOTD} #{ID*}" /></form>
		</div>
	{+END}{+END}{+END}
</div></div>

