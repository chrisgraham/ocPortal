{$,Make sure the system knows we haven't rendered our primary title for this output yet}
{$SET,done_first_title,_false}


{+START,IF,{$GET,show_top}}{+START,IF_NON_EMPTY,{$GET,panel_top}}
    <div id="panel_top">
        {$GET,panel_top}
    </div>
{+END}{+END}


{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
    <div class="global_message">
        {MESSAGE_TOP}
    </div>
{+END}{+END}

{+START,IF,{$NEQ,{$GET,left_width},0,auto}}
    <div id="panel_left" class="global_side">
        {$GET,panel_left}
    </div>
{+END}

{+START,IF,{$NEQ,{$GET,right_width},0,auto}}
    <div id="panel_right" class="global_side">
        {$GET,panel_right}

    </div>
{+END}

<div class="global_middle">

        {+START,IF,{$GET,show_top}}{+START,IF,{$IN_STR,{BREADCRUMBS},<a }}
        <div class="breadcrumbs breadcrumbs_always">
            <img class="breadcrumbs_img" src="{$IMG*,treenav}" title="" alt="&gt; " />
            {BREADCRUMBS}
        </div>
        {+END}{+END}

        <a accesskey="s" class="accessibility_hidden">{!SKIP_NAVIGATION}</a>

        {MIDDLE}{$SET,interlock,_false}
</div>

{+START,IF_NON_EMPTY,{MESSAGE}}
    <div id="global_message" class="global_message">
        {MESSAGE}
    </div>
{+END}


{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}

