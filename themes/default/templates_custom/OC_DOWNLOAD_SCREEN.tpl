{TITLE}

<p style="font-size:.85em; color: #6f757d; text-align:center">Looking for addons and themes? Go to our <a href="{$PAGE_LINK*,site:community}">community section</a>.</p>

<p>If you don't already have hosting, we recommend <a href="http://www.arvixe.com/5256-223-3-122.html" target="_blank">Arvixe</a>.<br />Arvixe hosting comes with ocPortal pre-installed.</p>

<p>If you do already have hosting, the next step is to transfer the installation files to your server. We can do this automatically with our &ldquo;instant transfer&rdquo; option, or you can save the files and upload them yourself.</p>

<div class="downloadoptions">
	<div class="float_surrounder_downloads" id="s_choice">
		<div id="instant" class="instant option left blue">
			<div class="s_wrap"><p class="s">
				We will ask for your FTP credentials and automatically transfer the latest stable ocPortal to your server over an encrypted connection.<br />
				(We never store your login details)
			</p></div>
			<div class="go_wrap"><p class="go">
				&darr; <a title="Instant transfer" href="#transferj" onclick="show_s_transfer(); return false;">Go</a> &darr;
			</p></div>
		</div>

		<div id="download" class="download option right yellow">
			<div class="s_wrap"><p class="s">
				If you want to transfer the files yourself, <em>or</em>, if you do not have FTP access, use this option.
			</p></div>
			<div class="go_wrap"><p class="go">
				&darr; <a title="Download package" href="#downloadj" onclick="show_s_download(); return false;">Go</a> &darr;
			</p></div>
		</div>
	</div>

	<a id="downloadj"></a>

	<div class="float_surrounder_downloads" id="s_download">
		{RELEASES}
	</div>

	<a id="transferj"></a>

	<div class="float_surrounder" id="s_transfer">
		<br />

		{HOSTINGCOPY_FORM}
	</div>
</div>

<p style="margin-top: 3em"><a class="link_exempt" href="http://www.arvixe.com/5256-223-3-122.html" target="_blank" title="ocPortal hosting (this link will open in a new window)"><img src="{$IMG*,468.60.ocportal}" alt="" /></a></p>

<script>// <![CDATA[
	document.getElementById('s_download').style.display='none';
	document.getElementById('s_transfer').style.display='none';

	function show_s_download()
	{
		var e=document.getElementById('s_download');
		e.style.display='block';
		setOpacity(e,0.0);
		nereidFade(e,100,50,6);

		var e2=document.getElementById('instant');
		setOpacity(e2,1.0);
		nereidFade(e2,50,50,-3);

		var e3=document.getElementById('download');
		setOpacity(e3,1.0);

		document.getElementById('s_transfer').style.display='none';
	}

	function show_s_transfer()
	{
		var e=document.getElementById('s_transfer');
		e.style.display='block';
		setOpacity(e,0.0);
		nereidFade(e,100,50,6);

		var e2=document.getElementById('download');
		setOpacity(e2,1.0);
		nereidFade(e2,50,50,-3);

		var e3=document.getElementById('instant');
		setOpacity(e3,1.0);

		document.getElementById('s_download').style.display='none';
	}
//]]></script>

{$REQUIRE_JAVASCRIPT,thumbnails}
