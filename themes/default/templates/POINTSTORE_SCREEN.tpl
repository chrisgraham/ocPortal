{TITLE}

<div class="pointstore_welcome medborder">
	{!POINTS_LEFT,{$USERNAME},{POINTS_LEFT*}}
</div>

<p>
	{!POINTSTORE_INTRO}
</p>

<p>
	{!POINTSTORE_ITEMS}
</p>

<div{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
	{ITEMS}
</div>
