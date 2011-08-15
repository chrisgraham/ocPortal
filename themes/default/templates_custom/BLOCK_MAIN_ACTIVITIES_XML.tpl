{$,Load up any extra Javascript we may require for this post}
{$JS_TEMPCODE}

<div class="avatar-box">
	{+START,IF_EMPTY,{MEMPIC}}
		<img src="{$THUMBNAIL,{$IMG,ocf_default_avatars/default},36x36,avatar_normalise,default.png,{$IMG,ocf_default_avatars/default},pad,both,#FFFFFF00}" />
	{+END}
	{+START,IF_NON_EMPTY,{MEMPIC}}
		<img src="{$THUMBNAIL,{MEMPIC},36x36,avatar_normalise,{NAME}.{$PREG_REPLACE,^(.*)*\.,,{MEMPIC}},{$IMG,ocf_default_avatars/default},pad,both,#FFFFFF00}" />
	{+END}
</div>
<div class="newsline">
	<div class="float_surrounder" style="width: auto;">
		<div class="name left">
			<a href="{URL*}">
				{NAME}
			</a>
		</div>
		<div class="time right">
			{$MAKE_RELATIVE_DATE,{DATETIME}} {!AGO}
		</div>
				
		{+START,IF,{ALLOW_REMOVE}}
			<form id="feed_remove_{LIID}" class="remove" action="{$PAGE_LINK*,:start}" method="post">
				<input type="hidden" value="{LIID}" name="removal_id" />
				<input class="remove_cross" type="submit" value="Remove" name="feed_remove_{LIID}" />
			</form>
			<script type="text/javascript">
				jQuery('#feed_remove_{LIID}').submit(sUpdateRemove);
			</script>
		{+END}
	</div>
</div>
<div class="news-content">
	{BITS}
</div>