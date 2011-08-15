{+START,IF,{$NOT,{$VALUE_OPTION,xhtml_strict}}}
	{+START,BOX,{SUBJECT*} &ndash; {!HTML_VERSION}}
		<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} id="preview_frame" name="preview_frame" title="{!PREVIEW}" style="width: 100%; height: 0px" src="{$BASE_URL*}/uploads/index.html">{!PREVIEW}</iframe>

		<noscript>
			{PREVIEW*}
		</noscript>
	
		<script type="text/javascript">// <![CDATA[
			window.setTimeout(function() {
				var adjustedPreview='{PREVIEW^/;}'.replace(/<!DOCTYPE[^>]*>/i,'').replace(/<html[^>]*>/i,'').replace(/<\/html>/i,'');
				var de=window.frames['preview_frame'].document.documentElement;
				var body=de.getElementsByTagName('body');
				if (body.length==0)
				{
					setInnerHTML(de,adjustedPreview);
				} else
				{
					var head_element=de.getElementsByTagName('head')[0];
					if (!head_element)
					{
						head_element=document.createElement('head');
						de.appendChild(head_element);
					}
					if (de.getElementsByTagName('style').length==0 && adjustedPreview.indexOf('<head')!=-1) {$,The conditional is needed for Firefox - for some odd reason it is unable to parse any head tags twice}
						setInnerHTML(head_element,adjustedPreview.replace(/^(.|\n)*<head[^>]*>((.|\n)*)<\/head>(.|\n)*$/i,'$2'));
					setInnerHTML(body[0],adjustedPreview.replace(/^(.|\n)*<body[^>]*>((.|\n)*)<\/body>(.|\n)*$/i,'$2'));
				}

				resizeFrame('preview_frame',300);
			}, 500);
		//]]></script>
	{+END}

	{+START,IF_NON_EMPTY,{TEXT_PREVIEW}}
		<br />

		{+START,BOX,{SUBJECT*} &ndash; {!TEXT_VERSION}}
			<div class="whitespace">{TEXT_PREVIEW*}</div>
		{+END}
	{+END}
{+END}

<p>
	{!NEWSLETTER_CONFIRM_MESSAGE}
</p>
