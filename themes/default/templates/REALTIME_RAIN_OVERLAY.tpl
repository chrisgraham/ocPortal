<div class="xhtml_validator_off">
	<div id="real-time-surround">
		<div id="real-time">
			<div id="news_ticker" onmouseover="setOpacity(this,1.0); if (!window.paused) { this.pausing=true; window.paused=true; }" onmouseout="setOpacity(this,0.5); if (this.pausing) { this.pausing=false; window.paused=false; }">
				<h1>{!NEWS_FLASHES}</h1>

				<div class="news-inside">
					<div class="news-content">
						<p id="news_go_here"><em>{!NEWS_WILL_APPEAR_HERE}</em></p>
					</div>
				</div>

				<div class="news-footer"></div>
			</div>

			<div id="bubbles_go_here">
			</div>

			<div id="loading_icon" class="ajax_tree_list_loading"><img src="{$IMG*,bottom/loading}" alt="{!LOADING}" title="{!LOADING}" /></div>
		</div>

		<div id="timer-outer"><div id="timer-inner" onmouseover="setOpacity(this,1.0);" onmouseout="setOpacity(this,0.7);">
			<div id="real-time-indicator">
				<span id="real-time-date">{!LOADING}</span> <span id="real-time-time"></span>
			</div>

			<div id="timer">
				<div id="pause-but"><img onmouseover="setOpacity(this,0.7);" onmouseout="if (!window.paused) setOpacity(this,1.0);" onclick="toggle_window_pausing(this);" src="{$IMG*,realtime_rain/pause-but}" alt="{!PAUSE}" title="{!PAUSE}" /></div>

				<div id="pre-but"><img onmouseover="setOpacity(this,0.7);" onmouseout="setOpacity(this,1.0);" onclick="window.time_window=window.time_window/1.2;" src="{$IMG*,realtime_rain/pre}" alt="{!SLOW_DOWN}" title="{!SLOW_DOWN}" /></div>

				<div onmouseover="setOpacity(this,0.5); window.disable_real_time_indicator=true;" onmouseout="setOpacity(this,1.0); window.disable_real_time_indicator=false; set_time_line_position(window.current_time);" onmousemove="timeline_click(this,true);" onclick="timeline_click(this);" id="time-line"><img id="time-line-image" src="{$IMG*,realtime_rain/time-line}" alt="" /></div>

				<div id="next-but"><img onmouseover="setOpacity(this,0.7);" onmouseout="setOpacity(this,1.0);" onclick="window.time_window=window.time_window*1.2;" src="{$IMG*,realtime_rain/next}" alt="{!SPEED_UP}" title="{!SPEED_UP}" /></div>
			</div>
		</div></div>
	</div>

	<!-- Don't use CDATA, or setInnerHTML won't run it -->
	<script type="text/javascript">
		addEventListenerAbstract(window,'load',function () {
			start_realtime_rain();
		} );
		window.min_time={MIN_TIME%};
		window.paused=false;
		window.bubble_groups={};
		window.total_lines=0;
		window.bubble_timer_1=null;
		window.bubble_timer_2=null;
	</script>
</div>
