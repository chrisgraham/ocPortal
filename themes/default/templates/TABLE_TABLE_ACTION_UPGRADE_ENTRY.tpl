{+START,IF_NON_PASSED,GET}
<form title="{!UPGRADE}: {NAME*}" onsubmit="disable_button_just_clicked(this);" class="inline" action="{URL*}" method="post"><input name="submit" type="image" src="{$IMG*,tableitem/upgrade}" title="{!UPGRADE}: {NAME*}" alt="{!UPGRADE}: {NAME*}" />{HIDDEN}</form>
{+END}
{+START,IF_PASSED,GET}
<a class="link_exempt" href="{URL*}"><img src="{$IMG*,tableitem/upgrade}" title="{!UPGRADE}: {NAME*}" alt="{!UPGRADE}: {NAME*}" /></a>
{+END}
