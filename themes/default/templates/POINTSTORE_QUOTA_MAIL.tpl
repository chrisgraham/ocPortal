{!MAIL_QUOTA_A#,[b]{$USERNAME@}[/b]}

{!EMAIL_ADDRESS@}: {EMAIL@}

{!QUOTA_INCREASE@}: {QUOTA@} megabytes

{!CHANGE_HERE,[url="{!HERE#}"]{QUOTA_URL@}[/url]}

{!WILL_COST_THEM@,{PRICE}}
{!COST_THEM_LINK,[url="{!HERE#}"]{$PAGE_LINK,adminzone:admin_points:charge:user={$USER}:amount={PRICE}:reason={ENCODED_REASON&},0,1}
{$BASE_URL}/adminzone/index.php?page=admin_points&type=charge&user={$USER@}&amount={PRICE@}&reason={ENCODED_REASON@}
[/url]}

