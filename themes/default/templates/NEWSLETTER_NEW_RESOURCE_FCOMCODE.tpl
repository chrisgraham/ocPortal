[title="3"]{NAME@}[/title]

[surround]{+START,IF_PASSED,THUMBNAIL}[img float="right"]{$THUMBNAIL,{THUMBNAIL},170,,,,,,,1}[/img]{+END}{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}{DESCRIPTION}

{+END}{+END}[url="{!VIEW#}"]{URL@}[/url][/surround]

