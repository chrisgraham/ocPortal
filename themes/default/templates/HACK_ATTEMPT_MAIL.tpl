{!HACK_ATTACK_INFO}

{!REASON@}: [tt]{REASON@}[/tt]
{!IP_ADDRESS@}: [page="adminzone:admin_lookup:misc:{IP@}"]{IP@}[/page]
{!MEMBER_ID@}: [tt]{ID@}[/tt]
{!USERNAME@}: [tt]{USERNAME@}[/tt]
{!USER_AGENT}: [tt]{USER_AGENT@}[/tt]
{!REFERER}: {REFERER@}
{!USER_OS}: [tt]{USER_OS@}[/tt]
{!DATE_TIME@}: [tt]{TIME@}[/tt]
{!URL@}: {URL@}
{+START,IF_NON_EMPTY,{POST}}
{!POST_DATA@}...

[code]
{POST*}
[/code]
{+END}

{+START,IF_NON_EMPTY,{STACK_TRACE}}
[i]{!SD_WARNING_BELOW}[/i]

[html]
{STACK_TRACE}
[/html]
{+END}

