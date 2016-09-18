{$SET,player_id,player_{$RAND}}

<div id="{$GET*,player_id}"></div>

<script>
	if (typeof window.done_youtube_player_init=='undefined')
	{
		var tag=document.createElement('script');
		tag.src="https://www.youtube.com/iframe_api";
		var first_script_tag=document.getElementsByTagName('script')[0];
		first_script_tag.parentNode.insertBefore(tag,first_script_tag);
		window.done_youtube_player_init=true;
	}

	var slideshow_mode=document.getElementById('next_slide');

	{$,Tie into callback event to see when finished, for our slideshows}
	{$,API: https://developers.google.com/youtube/iframe_api_reference}
	var {$GET%,player_id};
	function onYouTubeIframeAPIReady()
	{
		{$GET%,player_id}=new YT.Player('{$GET%,player_id}', {
			width: '560',
			height: '315',
			videoId: '{URL;}',
			events: {
				'onReady': function() {
					if (slideshow_mode) {
						{$GET%,player_id}.playVideo();
					}
				},
				'onStateChange': function(newState) {
					if (slideshow_mode) {
						if (newState==0) player_stopped();
					}
				}
			}
		});
	}
</script>
