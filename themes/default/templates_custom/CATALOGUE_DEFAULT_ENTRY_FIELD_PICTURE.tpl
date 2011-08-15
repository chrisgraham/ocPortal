{$CSS_INCLUDE,lightbox}
{$JAVASCRIPT_INCLUDE,javascript_prototype}
{$JAVASCRIPT_INCLUDE,javascript_scriptaculous}
{$JAVASCRIPT_INCLUDE,javascript_scriptaculous_builder}
{$JAVASCRIPT_INCLUDE,javascript_scriptaculous_effects}
{$JAVASCRIPT_INCLUDE,javascript_lightbox}

{+START,IF,{$NEQ,{I},0}}<a rel="lightbox" href="{URL*}">{+END}<img src="{THUMB_URL*}" title="" alt="{!IMAGE}" />{+START,IF,{$NEQ,{I},0}}</a>{+END}
