"use strict";

function load_occle()
{
	// (Still?) loading
	if ((typeof window.occle_command_response=='undefined') || (!window.ajax_supported))
	{
		if (document.getElementById('occle_img_loader'))
		{
			setTimeout(load_occle,200);
			return false;
		}

		var img=document.getElementById('occle_img');
		setOpacity(img,0.4);
		var tmp_element=document.createElement('img');
		tmp_element.src="{$IMG,bottom/loading}".replace(/^http:/,window.location.protocol);
		tmp_element.style.position='absolute';
		tmp_element.style.left=findPosX(img)+'px';
		tmp_element.style.top=findPosY(img)+'px';
		tmp_element.id='occle_img_loader';
		img.parentNode.appendChild(tmp_element);
		fixImage(img);

		require_javascript("javascript_ajax");
		require_javascript("javascript_occle","occle");
		require_css("occle");
		window.setTimeout(load_occle,200);
		return false;
	}

	// Loaded
	if ((window.ajax_supported) && (ajax_supported()) && (typeof window.occle_command_response!='undefined'))
	{
		confirm_session(
			true,
			function()
			{
				// Set up OcCLE window
				var occle_box=document.getElementById('occle_box');
				if (!occle_box)
				{
					occle_box=document.createElement('div');
					occle_box.setAttribute('id','occle_box');
					occle_box.style.position='absolute';
					occle_box.style.zIndex=2000;
					occle_box.style.left=(getWindowWidth()-800)/2+"px";
					var top_temp=(getWindowHeight()-600)/2;
					if (top_temp<100) top_temp=100;
					occle_box.style.top=top_temp+"px";
					occle_box.style.display='none';
					occle_box.style.width='800px';
					occle_box.style.height='500px';
					document.body.appendChild(occle_box);
					setInnerHTML(occle_box,load_snippet("occle"));
				}

				// Remove "loading" indicator from button
				var img=document.getElementById('occle_img');
				var tmp_element=document.getElementById('occle_img_loader');
				if (tmp_element) tmp_element.parentNode.removeChild(tmp_element);

				if (occle_box.style.display=='none') // Showing OcCLE again
				{
					occle_box.style.display='block';

					if (img)
					{
						img.src="{$IMG,bottom/occle_off}".replace(/^http:/,window.location.protocol);
						fixImage(img);
						setOpacity(img,1.0);
					}

					smoothScroll(0,null,null,function() { document.getElementById("occle_command").focus(); } );
					if (typeof window.nereidFade!='undefined')
					{
						setOpacity(document.getElementById('command_line'),0.0);
						nereidFade(document.getElementById('command_line'),80,30,5);
					}

					var bi=document.getElementById('body_inner');
					if (bi)
					{
						if (typeof window.nereidFade!='undefined')
						{
							setOpacity(bi,1.0);
							nereidFade(bi,30,30,-5);
						} else
						{
							setOpacity(bi,0.3);
						}
					}
			
					document.getElementById("occle_command").focus();
				}
				else // Hiding OcCLE
				{
					if (img)
					{
						img.src="{$IMG,bottom/occle}".replace(/^http:/,window.location.protocol);
						fixImage(img);
						setOpacity(img,1.0);
					}

					occle_box.style.display='none';
					var bi=document.getElementById('body_inner');
					if (bi)
					{
						if (typeof window.nereidFade!='undefined')
						{
							nereidFade(bi,100,30,5);
						} else
						{
							setOpacity(bi,1.0);
						}
					}
				}
			}
		);

		return false;
	}

	// Fallback to link to module
	var btn=document.getElementById('occle_button');
	if (btn)
		window.location.href=btn.href;
	return false;
}
