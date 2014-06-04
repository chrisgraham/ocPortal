/*

This file does a lot of stuff relating to overlays...

It provides callback-based *overlay*-driven substitutions for the standard browser windowing API...
 - alert
 - prompt
 - confirm
 - open (known as popups)
 - showModalDialog
A term we are using for these kinds of 'overlay' is '(faux) modal window'.

It provides a generic function to open a link as an overlay.

It provides a function to open an image link as a 'lightbox' (we use the term lightbox exclusively to refer to images in an overlay).

*/

window.overlay_zIndex=999999; // Has to be higher than plupload, which is 99999

function open_link_as_overlay(ob,width,height,target)
{
	{+START,IF,{$MOBILE}}
		if (typeof height=='undefined') return true; // Would probably not fit, and unfortunately cannot scroll
	{+END}

	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		if ((typeof width=='undefined') || (!width)) var width=800;
		if ((typeof height=='undefined') || (!height)) var height=520;
		var url=(typeof ob.href=='undefined')?ob.action:ob.href;
		if ((typeof target=='undefined') || (!target)) var target='_top';
		faux_open(url+((url.indexOf('?')==-1)?'?':'&')+'wide_high=1',null,'width='+width+';height='+height,target);
		return false;
	{+END}

	{+START,IF,{$NOT,{$CONFIG_OPTION,js_overlays}}}
		return true;
	{+END}
}

{+START,IF,{$CONFIG_OPTION,js_overlays}}
	function open_image_into_lightbox(a)
	{
		// Set up overlay for Lightbox
		var lightbox_code='<p class="ajax_tree_list_loading"><img id="lightbox_image" src="{$IMG*,loading}" /></p>';
		var has_full_button=(typeof a.childNodes[0]=='undefined') || (a.href!==a.childNodes[0].src);
		if (has_full_button)
			lightbox_code+='<p class="associated_link associated_links_block_group"><a href="'+escape_html(a.href)+'" target="_blank" title="{$STRIP_TAGS;,{!SEE_FULL_IMAGE}} {!LINK_NEW_WINDOW}">{!SEE_FULL_IMAGE;}</a></p>';

		// Show overlay
		var myLightbox={
			type: 'lightbox',
			text: lightbox_code,
			yes_button: '{!INPUTSYSTEM_CLOSE;^}',
			width: 450,
			height: 300
		};
		var modal=new ModalWindow();
		modal.open(myLightbox);

		// Load proper image
		window.setTimeout(function() { // Defer execution until the HTML was parsed
			var img=modal.topWindow.document.createElement('img');
			img.onload=function()
			{
				if (!modal.box) return; /* Overlay closed already */

				var real_width=img.width;
				var width=real_width;
				var real_height=img.height;
				var height=real_height;

				var dims_func=function()
				{
					// Might need to rescale using some maths, if natural size is too big
					var max_width=modal.topWindow.get_window_width()-20;
					var max_height=modal.topWindow.get_window_height()-(has_full_button?180:60);
					if (width>max_width)
					{
						width=max_width;
						height=window.parseInt(max_width*real_height/real_width-1);
					}
					if (height>max_height)
					{
						width=window.parseInt(max_height*real_width/real_height-1);
						height=max_height;
					}
					modal.resetDimensions(width,height);

					img.width=width;
					img.height=height;

					if (img.parentNode)
					{
						img.parentNode.parentNode.parentNode.style.width='auto';
						img.parentNode.parentNode.parentNode.style.height='auto';
					}
				};

				var lightbox_image=modal.topWindow.document.getElementById('lightbox_image');
				var sup=lightbox_image.parentNode.parentNode;
				sup.removeChild(lightbox_image.parentNode);
				if (sup.childNodes.length!=0)
				{
					sup.insertBefore(img,sup.childNodes[0]);
				} else
				{
					sup.appendChild(img);
				}
				sup.className='';
				sup.style.textAlign='center';
				sup.style.overflow='hidden';

				dims_func();
				modal.addEvent( window, 'resize', function() { dims_func(); } );
			}
			img.src=a.href;
		},0);
	}
{+END}

function fauxmodal_confirm(question,callback,title)
{
	if (typeof title=='undefined') var title='{!Q_SURE;}';

	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		var myConfirm={
			type: 'confirm',
			text: escape_html(question).replace(/\n/g,'<br />'),
			yes_button: '{!YES;^}',
			no_button: '{!NO;^}',
			title: title,
			yes: function() {
				callback(true);
			},
			no: function() {
				callback(false);
			},
			width: 450
		};
		new ModalWindow().open(myConfirm);
	{+END}

	{+START,IF,{$NOT,{$CONFIG_OPTION,js_overlays}}}
		callback(window.confirm(question));
	{+END}
}

function fauxmodal_alert(notice,callback,title)
{
	if ((typeof callback=='undefined') || (!callback)) var callback=function() {};

	if (typeof title=='undefined') var title='{!MESSAGE;}';

	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		var myAlert={
			type: 'alert',
			text: escape_html(notice).replace(/\n/g,'<br />'),
			yes_button: '{!INPUTSYSTEM_OK;^}',
			width: 600,
			yes: callback,
			title: title
		};
		new ModalWindow().open(myAlert);
	{+END}

	{+START,IF,{$NOT,{$CONFIG_OPTION,js_overlays}}}
		if ((typeof window.alert!='undefined') && (window.alert!=null))
		{
			window.alert(notice);
		} else
		{
			console.log(notice);
		}
		callback();
	{+END}
}

function fauxmodal_prompt(question,defaultValue,callback,title,input_type)
{
	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		var myPrompt={
			type: 'prompt',
			text: escape_html(question).replace(/\n/g,'<br />'),
			yes_button: '{!INPUTSYSTEM_OK;^}',
			cancel_button: '{!INPUTSYSTEM_CANCEL;^}',
			defaultValue: (defaultValue===null)?'':defaultValue,
			title: title,
			yes: function(value) {
				callback(value);
			},
			cancel: function() {
				callback(null);
			},
			width: 450
		};
		if (input_type) myPrompt.input_type=input_type;
		new ModalWindow().open(myPrompt);
	{+END}

	{+START,IF,{$NOT,{$CONFIG_OPTION,js_overlays}}}
		callback(window.prompt(question,defaultValue));
	{+END}
}

function faux_showModalDialog(url,name,options,callback,target,cancel_text)
{
	if ((typeof callback=='undefined') || (!callback)) var callback=function() {};

	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		var width=null,height=null,scrollbars=null,unadorned=null;

		if (typeof cancel_text=='undefined') var cancel_text='{!INPUTSYSTEM_CANCEL;^}';

		if (options)
		{
			var parts=options.split(/[;,]/g);
			for (var i=0;i<parts.length;i++)
			{
				var bits=parts[i].split('=');
				if (typeof bits[1]!='undefined')
				{
					if ((bits[0]=='dialogWidth') || (bits[0]=='width'))
						width=window.parseInt(bits[1].replace(/px$/,''));
					if ((bits[0]=='dialogHeight') || (bits[0]=='height'))
					{
						if (bits[1]=='100%')
						{
							height=get_window_height() - 200;
						} else
						{
							height=window.parseInt(bits[1].replace(/px$/,''));
						}
					}
					if (((bits[0]=='resizable') || (bits[0]=='scrollbars')) && scrollbars!==true)
						scrollbars=((bits[1]=='yes') || (bits[1]=='1'))/*if either resizable or scrollbars set we go for scrollbars*/;
					if (bits[0]=='unadorned') unadorned=((bits[1]=='yes') || (bits[1]=='1'));
				}
			}
		}

		if (url.indexOf(window.location.host)!=-1)
		{
			url+=((url.indexOf('?')==-1)?'?':'&')+'overlay=1';
		}

		var myFrame={
			type: 'iframe',
			finished: function(value) {
				callback(value);
			},
			name: name,
			width: width,
			height: height,
			scrollbars: scrollbars,
			href: url.replace(/^https?:/,window.location.protocol)
		};
		myFrame.cancel_button=(unadorned!==true)?cancel_text:null;
		if (target) myFrame.target=target;
		new ModalWindow().open(myFrame);
	{+END}

	{+START,IF,{$NOT,{$CONFIG_OPTION,js_overlays}}}
		var timer=new Date().getTime();
		try
		{
			var result=window.showModalDialog(url,name,options);
		}
		catch (e) {}; // IE gives "Access is denied" if popup was blocked, due to var result assignment to non-real window
		var timer_now=new Date().getTime();
		if (timer_now-100>timer) // Not popup blocked
		{
			if ((typeof result=='undefined') || (result===null))
			{
				callback(null);
			} else
			{
				callback(result);
			}
		}
	{+END}
}

function faux_open(url,name,options,target,cancel_text)
{
	if (typeof cancel_text=='undefined') var cancel_text='{!INPUTSYSTEM_CLOSE;^}';

	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		faux_showModalDialog(url,name,options,null,target,cancel_text);
	{+END}

	{+START,IF,{$NOT,{$CONFIG_OPTION,js_overlays}}}
		window.open(url,name,options);
	{+END}
}

{+START,IF,{$CONFIG_OPTION,js_overlays}}
/*
Originally...

Script: modalwindow.js
	ModalWindow - Simple javascript popup overlay to replace builtin alert, prompt and confirm, and more.

License:
	PHP-style license.

Copyright:
	Copyright (c) 2009 [Kieron Wilson](http://kd3sign.co.uk/).

Code & Documentation:
	http://kd3sign.co.uk/examples/modalwindow/

HEAVILY Modified by ocProducts for ocPortal.

*/

function ModalWindow()
{
	return {

		box: null,
		returnValue: null,
		topWindow: null,

		open: function() {
			var options=arguments[0] || {};
			var defaults={
				'type': 'alert',
				'opacity': '0.5',
				'width': null,
				'height': 'auto',
				'title': '',
				'text': '',
				'yes_button': '{!YES;^}',
				'no_button': '{!NO;^}',
				'cancel_button': '{!INPUTSYSTEM_CANCEL;^}',
				'yes': null,
				'no': null,
				'finished': null,
				'cancel': null,
				'href': null,
				'scrollbars': null,
				'defaultValue': null,
				'target': '_self',
				'input_type': 'text'
			};

			this.topWindow=window.top;
			this.topWindow=this.topWindow.top;

			for(var key in defaults) {
				this[key]=(typeof options[key] != 'undefined') ? options[key] : defaults[key] ;
			}

			this.close(this.topWindow);
			this.initBox();
		},

		close: function(win) {
			if(this.box) {
				this.remove(this.box, win);
				this.box=null;

				this.removeEvent(document, 'keyup', this.keyup);
			}
			this.opened=false;
		},

		option: function(method) {
			var win=this.topWindow; // The below call may end up killing our window reference (for nested alerts), so we need to grab it first
			if(this[ method ]) {
				if(this.type=='prompt') {
					this[ method ](this.input.value);
				}
				else if(this.type=='iframe') {
					this[ method ](this.returnValue);
				}
				else this[ method ]();
			}
			this.close(win);
		},

		resetDimensions: function(width, height) { // Don't re-call this for an iframe-based overlay, doesn't work retro-actively on the iframe size (but CSS sized inards are fine)
			if (!this.box) return;

			var dim=this.getPageSize();
			if (width>dim.pageWidth) width=dim.pageWidth-30;

			var boxWidth=((width) ? (width + 8) : (dim.pageWidth / 4))  + 'px';
			var extra_box_height=(this.type=='iframe') ? 160 : ((this.type=='lightbox')?26:120);

			if (this.cancel_button === null) extra_box_height=0;
			var boxHeight=(typeof height=='string' || height === null || this.type=='iframe') ? 'auto' : (height + extra_box_height) + 'px' ;

			var boxPosVCentre=(typeof height=='string' || height === null || this.type=='iframe') ? ((this.type=='iframe') ? 20 : 150) : ((dim.windowHeight / 2.5) - (parseInt(boxHeight) / 2)) ;
			if (boxPosVCentre < 20) boxPosVCentre=20;
			var boxPosHCentre=((dim.pageWidth / 2) - (parseInt(boxWidth) / 2));

			var boxPosTop=(/*get_window_scroll_y() + */boxPosVCentre) + 'px' ;
			var boxPosLeft=boxPosHCentre + 'px';

			this.width=width;
			this.height=height;

			this.box.childNodes[0].style.width=boxWidth;
			this.box.childNodes[0].style.height=boxHeight;

			this.box.childNodes[0].style.top=boxPosTop;
			this.box.childNodes[0].style.left=boxPosLeft;

			var iframe=this.box.getElementsByTagName('iframe');
			if (typeof iframe[0]!='undefined')
			{
				iframe[0].style.width=this.width?(this.width+'px'):'100%';
				iframe[0].style.height=this.width?(this.height+'px'):'50%';
			}

			if (((boxHeight=='auto') && ('{$MOBILE}'==1)) || (height>dim.windowHeight))
			{
				this.box.childNodes[0].style.position='absolute';
				this.box.childNodes[0].style.top='0';

				try
				{
					this.topWindow.scrollTo(0,0);
				}
				catch (e) {};
			}
		},

		initBox: function() {
			var dim=this.getPageSize();

			this.box=this.element('div', {
				'styles' : {
					'background': 'rgba(0,0,0,0.7)',
					'zIndex': this.topWindow.overlay_zIndex++,
					'overflow': 'hidden',
					'position': (browser_matches('android') || browser_matches('ios'))?'absolute':'fixed',
					'left': '0',
					'top': '0',
					'width': '100%',
					'height': ((dim.pageHeight>dim.windowHeight)?dim.pageHeight:dim.windowHeight)+'px'
				}
			});

			this.box.appendChild(this.element('div', {
				'class': 'box overlay',
				'role': 'dialog',
				'styles' : {
					'position': 'fixed'
				}
			}));

			var _this=this;
			var width=this.width;
			var height=this.height;
			this.resetDimensions(this.width,this.height);
			this.addEvent( window, 'resize', function() { _this.resetDimensions(width,height); } );

			this.inject(this.box);

			var container=this.element('div', {
				'class': 'box_inner',
				'styles' : {
					'width': 'auto',
					'height': 'auto'
				}
			});

			var overlay_header=null;
			if (this.title != '' || this.type=='iframe') {
				overlay_header=this.element('h3', {
					'html': this.title,
					'styles' : {
						'display': (this.title=='') ? 'none' : 'block'
					}
				});
				container.appendChild(overlay_header);
			}

			if (this.text != '') {
				if (this.type=='prompt')
				{
					var div=this.element('div');
					div.appendChild(this.element('label', {
						'for': 'overlay_prompt',
						'html': this.text
					}));
					container.appendChild(div);
				} else
				{
					container.appendChild(this.element('div', {
						'html': this.text
					}));
				}
			}

			var buttonContainer=this.element('div', {
				'class': 'proceed_button'
			});

			var _this=this;

			this.clickout_cancel=function() {
				_this.option('cancel');
			};

			this.clickout_finished=function() {
				_this.option('finished');
			};

			this.clickout_yes=function() {
				_this.option('yes');
			};

			this.keyup=function(e) {
				if(!e) e=window.event ;
				var keyCode=(e) ? (e.which || e.keyCode) : null ;

				if(keyCode==13) {
					_this.option('yes');
				}
			};

			this.addEvent( this.box.childNodes[0], 'click', function(e) { try { _this.topWindow.cancel_bubbling(e); } catch (e) {}; } );

			switch(this.type) {
				case 'iframe':
					var iframe=this.element('iframe', {
						'frameBorder': '0',
						'scrolling': (browser_matches('ie') || browser_matches('gecko'))?'auto':'no',
						'title': '',
						'name': 'overlay_iframe',
						'id': 'overlay_iframe',
						'allowTransparency': 'true',
						//'seamless': 'seamless',	Not supported, and therefore testable yet. Would be great for mobile browsing.
						'styles' : {
							'width': this.width?(this.width+'px'):'100%',
							'height': this.height?(this.height+'px'):'50%',
							'background': 'transparent'
						}
					});

					container.appendChild(iframe);

					if (this.cancel_button)
					{
						var button=this.element('button', {
							'html': this.cancel_button,
							'class': 'button_pageitem'
						});
						this.addEvent( button, 'click', function() { _this.option('finished'); } );
						buttonContainer.appendChild(button);
						container.appendChild(this.element('hr', { 'class': 'spaced_rule' } ));
						container.appendChild(buttonContainer);
					}
					window.setTimeout(function() { _this.addEvent( _this.box, 'click', _this.clickout_finished); }, 1000);

					this.addEvent( iframe, 'load', function() {
						if (typeof iframe.contentWindow.document.getElementsByTagName('h1')[0]=='undefined' && typeof iframe.contentWindow.document.getElementsByTagName('h2')[0]=='undefined')
						{
							if (iframe.contentWindow.document.title!='')
							{
								set_inner_html(overlay_header,escape_html(iframe.contentWindow.document.title));
								overlay_header.style.display='block';
							}
						}
					} );

					// Fiddle it, to behave like a popup would
					var name=this.name;
					var makeFrameLikePopup=function() {
						if ((iframe) && (iframe.contentWindow) && (iframe.contentWindow.document) && (iframe.contentWindow.document.body) && (typeof iframe.contentWindow.document.body.done_popup_trans=='undefined'))
						{
							iframe.contentWindow.document.body.style.background='transparent';

							if (iframe.contentWindow.document.body.className.indexOf('overlay')==-1)
								iframe.contentWindow.document.body.className+=' overlay';

							// Allow scrolling, if we want it
							iframe.scrolling=(_this.scrollbars === false)?'no':'auto';

							// Remove fixed width
							var main_website_inner=iframe.contentWindow.document.getElementById('main_website_inner');
							if (main_website_inner) main_website_inner.id='';

							// Remove main_website marker
							var main_website=iframe.contentWindow.document.getElementById('main_website');
							if (main_website) main_website.id='';

							// Remove popup spacing
							var popup_spacer=iframe.contentWindow.document.getElementById('popup_spacer');
							if (popup_spacer) popup_spacer.id='';

							var bases=iframe.contentWindow.document.getElementsByTagName('base');
							var baseElement;
							if (!bases[0])
							{
								baseElement=iframe.contentWindow.document.createElement('base');
								if (iframe.contentWindow.document)
								{
									var heads=iframe.contentWindow.document.getElementsByTagName('head');
									if (heads[0])
									{
										heads[0].appendChild(baseElement);
									}
								}
							} else
							{
								baseElement=bases[0];
							}
							baseElement.target=_this.target;

							// Firefox 3.6 does not respect <base> element put in via DOM manipulation :(
							var forms=iframe.contentWindow.document.getElementsByTagName('form');
							for (var i=0;i<forms.length;i++)
							{
								if (!forms[i].target) forms[i].target=_this.target;
							}
							var as=iframe.contentWindow.document.getElementsByTagName('a');
							for (var i=0;i<as.length;i++)
							{
								if (!as[i].target) as[i].target=_this.target;
							}

							if (name && iframe.contentWindow.name != name) iframe.contentWindow.name=name;

							if (typeof iframe.contentWindow.faux_close=='undefined')
							{
								iframe.contentWindow.faux_close=function() {
									if (iframe && iframe.contentWindow && typeof iframe.contentWindow.returnValue!='undefined')
										_this.returnValue=iframe.contentWindow.returnValue;
									_this.option('finished');
								};
							}

							if (get_inner_html(iframe.contentWindow.document.body).length>300) // Loaded now
								iframe.contentWindow.document.body.done_popup_trans=true;
						}
					};
					window.setTimeout(function() { illustrate_frame_load(iframe,'overlay_iframe'); iframe.src=_this.href; makeFrameLikePopup(); },0);
					window.setInterval(makeFrameLikePopup,100); // In case internal nav changes
					break;

				case 'lightbox':
				case 'alert':
					if(this.yes != false) {
						var button=this.element('button', {
							'html': this.yes_button,
							'class': 'button_pageitem'
						});
						this.addEvent( button, 'click', function() { _this.option('yes'); } );
						window.setTimeout(function() { _this.addEvent( _this.box, 'click', _this.clickout_yes); }, 1000);
						buttonContainer.appendChild(button);
						container.appendChild(buttonContainer);
					}
					break;

				case 'confirm':
					var button=this.element('button', {
						'html': this.yes_button,
						'class': 'button_pageitem',
						'style': 'font-weight: bold;'
					});
					this.addEvent( button, 'click', function() { _this.option('yes'); } );
					buttonContainer.appendChild(button);
					var button=this.element('button', {
						'html': this.no_button,
						'class': 'button_pageitem'
					});
					this.addEvent( button, 'click', function() { _this.option('no'); } );
					buttonContainer.appendChild(button);

					container.appendChild(buttonContainer);
					break;

				case 'prompt':
					this.input=this.element('input', {
						'name': 'prompt',
						'id': 'overlay_prompt',
						'type': this.input_type,
						'size': '40',
						'class': 'wide_field',
						'value': (this.defaultValue===null)?'':this.defaultValue
					});
					var input_wrap=this.element('div', {
						'class': 'constrain_field'
					});
					input_wrap.appendChild(this.input);
					container.appendChild(input_wrap);

					if(this.yes) {
						var button=this.element('button', {
							'html': this.yes_button,
							'class': 'button_pageitem',
							'style': 'font-weight: bold;'
						});
						this.addEvent( button, 'click', function() { _this.option('yes'); } );
						buttonContainer.appendChild(button);
					}
					var button=this.element('button', {
						'html': this.cancel_button,
						'class': 'button_pageitem'
					});
					this.addEvent( button, 'click', function() { _this.option('cancel'); } );
					window.setTimeout(function() { _this.addEvent( _this.box, 'click', _this.clickout_cancel); }, 1000);
					buttonContainer.appendChild(button);

					container.appendChild(buttonContainer);
					break;
			}

			this.box.childNodes[0].appendChild(container);

			if(this.input)
			{
				window.setTimeout(function() { _this.input.focus(); }, 0);
			}
			else if (typeof this.box.getElementsByTagName('button')[0]!='undefined')
			{
				this.box.getElementsByTagName('button')[0].focus();
			}

			if(this.yes || this.yes != false)
			{
				window.setTimeout(function() { // Timeout needed else keyboard activation of overlay opener may cause instant shutdown also
					_this.addEvent(document, 'keyup', _this.keyup );
				},100);
			}
		},

		inject: function(el) {
			this.topWindow.document.body.appendChild(el);
		},

		remove: function(el, win) {
			if (!win) win=this.topWindow;
			win.document.body.removeChild(el);
		},

		element: function() {
			var tag=arguments[0], options=arguments[1];
			var el=this.topWindow.document.createElement(tag);
			var attributes={
				'html': 'innerHTML',
				'class': 'className',
				'for': 'htmlFor',
				'text': 'innerText'
			};
			if(options) {
				if(typeof options=='object') {
					for(var name in options) {
						var value=options[name];
						if(name=='styles') {
							this.setStyles(el, value);
						} else if(name=='html') {
							set_inner_html(el, value);
						} else if (attributes[name]) {
							el[attributes[name]]=value;
						} else {
							el.setAttribute(name, value);
						}
					}
				}
			}
			return el;
		},

		addEvent: function(o, e, f) {
			if(o) {
				if(o.addEventListener) o.addEventListener(e, f, false);
				else if(o.attachEvent) o.attachEvent( 'on'+e , f);
			}
		},

		removeEvent: function(o, e, f) {
			if(o) {
				if(o.removeEventListener) o.removeEventListener(e, f, false);
				else if(o.detachEvent) o.detachEvent('on'+e, f);
			}
		},

		setStyles: function(e, o) {
			for(var k in o) {
				this.setStyle(e, k, o[k]);
			}
		},

		setStyle: function(e, p, v) {
			if (p=='opacity') {
				this.topWindow.set_opacity(e,v);
			} else {
				try
				{
					e.style[p]=v;
				}
				catch (e){};
			}
		},

		getPageSize: function() {
			return { 'pageWidth': this.topWindow.get_window_width(this.topWindow)/*intentionally not scroll width, we don't want overlays over horizontal scrolling*/, 'pageHeight': this.topWindow.get_window_scroll_height(this.topWindow), 'windowWidth' : this.topWindow.get_window_width(), 'windowHeight': this.topWindow.get_window_height() };
		}
	};
}
{+END}
