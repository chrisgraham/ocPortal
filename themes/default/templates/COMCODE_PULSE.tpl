{$SET,RAND_ID_PULSE,rand{$RAND}}

{$JAVASCRIPT_INCLUDE,javascript_pulse}<span class="pulse_wave" id="pulse_wave_{$GET%,RAND_ID_PULSE}">{CONTENT}</span><script type="text/javascript">// <![CDATA[
addEventListenerAbstract(window,'load',function () {
	window['pulse_wave_{$GET%,RAND_ID_PULSE}']=[0,'{MAX_COLOR;}','{MIN_COLOR;}',{SPEED%},[]];
	window.setInterval(function() { process_wave(document.getElementById('pulse_wave_{$GET%,RAND_ID_PULSE}')); },window[document.getElementById('pulse_wave_{$GET%,RAND_ID_PULSE}').id][3]);
} );
//]]></script>