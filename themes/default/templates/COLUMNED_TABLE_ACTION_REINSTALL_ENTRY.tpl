{+START,IF_NON_PASSED_OR_FALSE,GET}
<form title="{!REINSTALL}: {NAME*}" onsubmit="disable_button_just_clicked(this);" class="inline vertical_alignment" action="{URL*}" method="post"><input name="submit" type="image" src="{$IMG*,tableitem/reinstall}" title="{!REINSTALL}: {NAME*}" alt="{!REINSTALL}: {NAME*}" />{HIDDEN}</form>
{+END}
{+START,IF_PASSED_AND_TRUE,GET}
<a class="link_exempt vertical_alignment" href="{URL*}"><img src="{$IMG*,tableitem/reinstall}" title="{!REINSTALL}: {NAME*}" alt="{!REINSTALL}: {NAME*}" /></a>
{+END}
