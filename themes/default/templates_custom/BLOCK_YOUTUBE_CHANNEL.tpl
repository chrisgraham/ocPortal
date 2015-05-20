{+START,IF_EMPTY,{CHANNEL_ERROR}}
    <div class="xhtml_validator_off">
        {CONTENT`}
    </div>
{+END}
{+START,IF_NON_EMPTY,{CHANNEL_ERROR}}
    <div class="xhtml_validator_off">
        <b>Channel Name:</b> <a href='{CHANNEL_URL}' target='_blank'>{CHANNEL_NAME}</a> <br>
        {CHANNEL_ERROR} <br>
    </div>
{+END}