{+START,IF_NON_PASSED,GET}
<form title="{!DELETE}: {NAME*}" onsubmit="disable_button_just_clicked(this);" class="inline" action="{URL*}" method="post"><input name="submit" type="image" src="{$IMG*,tableitem/delete}" title="{!DELETE}: {NAME*}" alt="{!DELETE}: {NAME*}" />{+START,IF_PASSED,HIDDEN}{HIDDEN}{+END}</form>
{+END}
{+START,IF_PASSED,GET}
<a class="link_exempt" href="{URL*}"><img src="{$IMG*,tableitem/delete}" title="{!DELETE}: {NAME*}" alt="{!DELETE}: {NAME*}" /></a>
{+END}
