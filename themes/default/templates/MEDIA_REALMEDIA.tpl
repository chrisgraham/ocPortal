{+START,SET,media}
	{$SET,player_id,player_{$RAND}}

	{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}
		{+START,IF_EMPTY,{$META_DATA,video}}
			{$META_DATA,video,{URL}}
			{$META_DATA,video:height,{HEIGHT}}
			{$META_DATA,video:width,{WIDTH}}
			{$META_DATA,video:type,{MIME_TYPE}}
		{+END}
	{+END}

	<div class="xhtml_validator_off">
		<embed id="{$GET*,player_id}" name="{$GET*,player_id}" type="audio/x-pn-realaudio"
			src="{URL*}"
			autostart="false"
			controls="ImageWindow,ControlPanel"
			pluginspage="http://www.real.com"
			width="{WIDTH*}"
			height="{HEIGHT*}"
		/>
	</div>

	{$,Tie into callback event to see when finished, for our slideshows}
	{$,API: http://service.real.com/help/library/guides/realone/ScriptingGuide/PDF/ScriptingGuide.pdf}
	<script>// <![CDATA[
		add_event_listener_abstract(window,'real_load',function () {
			if (document.getElementById('next_slide'))
			{
				stop_slideshow_timer();
				window.setTimeout(function() {
					add_event_listener_abstract(document.getElementById('{$GET;,player_id}'),'stateChange',function(newState) { if (newState==0) { player_stopped(); } } );
					document.getElementById('{$GET;,player_id}').DoPlay();
				}, 1000);
			}
		} );
	//]]></script>

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<figcaption class="associated_details">
			{DESCRIPTION}
		</figcaption>
	{+END}

	{$,Uncomment for a download link <ul class="actions_list" role="navigation"><li class="actions_list_strong"><a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{ORIGINAL_FILENAME*}} {!LINK_NEW_WINDOW}" href="{URL*}">{!_DOWNLOAD,{ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}\{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE\}\{+START,IF,{$INLINE_STATS}\}\{+START,IF_PASSED,NUM_DOWNLOADS\}, {!DOWNLOADS_SO_FAR,{NUM_DOWNLOADS*}}\{+END\}\{+END\}\{+END\})</li></ul>}
{+END}
{+START,IF_PASSED_AND_TRUE,FRAMED}
	<figure>
		{$GET,media}
	</figure>
{+END}
{+START,IF_NON_PASSED_OR_TRUE,FRAMED}
	{$GET,media}
{+END}
