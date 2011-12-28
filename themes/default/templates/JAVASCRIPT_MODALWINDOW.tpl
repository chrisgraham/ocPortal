var overlay_zIndex=1000;

function open_as_overlay(ob,width,height)
{
	if (!width) width=900;
	if (!height) height=700;
	faux_open(ob.href+((ob.href.indexOf('?')==-1)?'?':'&')+'wide_high=1',null,'width='+width+';height='+height,'_top');
	return false;
}

function fauxmodal_confirm(question,callback,title)
{
	if (!title) title='{!Q_SURE;}';

	{+START,IF,{$VALUE_OPTION,faux_popups}}
		var myConfirm = {
			type: "confirm",
			text: escape_html(question),
			yes_button: "{!YES#}",
			no_button: "{!NO#}",
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

	{+START,IF,{$NOT,{$VALUE_OPTION,faux_popups}}}
		callback(window.confirm(question));
	{+END}
}

function fauxmodal_alert(notice,callback,title)
{
	if (!callback) callback=function() {};
	
	if (!title) title='{!MESSAGE;}';

	{+START,IF,{$VALUE_OPTION,faux_popups}}
		var myAlert = {
			type: "alert",
			text: escape_html(notice),
			yes_button: "{!INPUTSYSTEM_OK#}",
			width: 600,
			yes: callback,
			title: title
		};
		new ModalWindow().open(myAlert);
	{+END}

	{+START,IF,{$NOT,{$VALUE_OPTION,faux_popups}}}
		window.alert(notice);
		callback();
	{+END}
}

function fauxmodal_prompt(question,defaultValue,callback,title,input_type)
{
	{+START,IF,{$VALUE_OPTION,faux_popups}}
		var myPrompt = {
			type: "prompt",
			text: escape_html(question),
			yes_button: "{!INPUTSYSTEM_OK#}",
			cancel_button: "{!INPUTSYSTEM_CANCEL#}",
			defaultValue: defaultValue,
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

	{+START,IF,{$NOT,{$VALUE_OPTION,faux_popups}}}
		callback(window.prompt(question,defaultValue));
	{+END}
}

function faux_showModalDialog(url,name,options,callback,target)
{
	if (!callback) callback=function() {};

	{+START,IF,{$VALUE_OPTION,faux_popups}}
		var width=null,height=null,scrollbars=null;

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
						height=window.parseInt(bits[1].replace(/px$/,''));
					if (((bits[0]=='resizable') || (bits[0]=='scrollbars')) && scrollbars!==true)
						scrollbars=((bits[1]=='yes') || (bits[1]=='1'))/*if either resizable or scrollbars set we go for scrollbars*/;
				}
			}
		}

		var myOverlay = {
			type: "overlay",
			cancel_button: "{!INPUTSYSTEM_CLOSE#}",
			finished: function(value) {
				callback(value);
			},
			name: name,
			width: width,
			height: height,
			scrollbars: scrollbars,
			href: url
		};
		if (target) myOverlay.target=target;
		new ModalWindow().open(myOverlay);
	{+END}

	{+START,IF,{$NOT,{$VALUE_OPTION,faux_popups}}}
		var timer=new Date().getTime();
		try
		{
			var result=window.showModalDialog(url,name,options);
		}
		catch (e) {}; // IE gives "Access is denied" if popup was blocked, due to var result assignment to non-real window
		var timer_now=new Date().getTime();
		if (timer_now-100>timer) // Not popup blocked
		{
			if ((typeof result=="undefined") || (result===null))
			{
				callback(null);
			} else
			{
				callback(result);
			}
		}
	{+END}
}

function faux_open(url,name,options,target)
{
	{+START,IF,{$VALUE_OPTION,faux_popups}}
		faux_showModalDialog(url,name,options,null,target);
	{+END}

	{+START,IF,{$NOT,{$VALUE_OPTION,faux_popups}}}
		window.open(url,name,options);
	{+END}
}

{+START,IF,{$VALUE_OPTION,faux_popups}}
/*
Script: modalwindow.js
	ModalWindow - Simple javascript popup overlay to replace builtin alert, prompt and confirm.

License:
	PHP-style license.

Copyright:
	Copyright (c) 2009 [Kieron Wilson](http://kd3sign.co.uk/).

Code & Documentation:
	http://kd3sign.co.uk/examples/modalwindow/

Modified by ocProducts for ocPortal.

*/

function ModalWindow()
{
	return {

		box: null,
		overlay: null,
		returnValue: null,

		open: function() {
			var options = arguments[0] || {};
			var defaults = {
				'type': "alert",
				'opacity': "0.5",
				'width': null,
				'height': 'auto',
				'title': "",
				'text': "",
				'yes_button': "Yes",
				'no_button': "No",
				'cancel_button': "Cancel",
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

			for(var key in defaults) {
				this[key] = (typeof options[key] != "undefined") ? options[key] : defaults[key] ;
			}
		
			this.close(window.top);
			this.initOverlay();
			this.initBox();
		},
	
		close: function(win) {
			if(this.box && this.overlay) {
				this.remove(this.box, win);
				this.box = null;
				this.remove(this.overlay, win);
				this.overlay = null;
			}
			this.removeEvent(document, "keyup", this.keyup);
			this.opened = false;
		},
	
		option: function(method) {
			var win = window.top; // The below call may end up killing our window reference (for nested alerts), so we need to grab it first
			if(this[ method ]) {
				if(this.type == "prompt") {
					this[ method ](this.input.value);
				}
				else if(this.type == "overlay") {
					this[ method ](this.returnValue);
				}
				else this[ method ]();
			}
			this.close(win);
		},
	
		keyup: function(e,ob) {
			if(!e) e = window.event ;
			var keyCode = (e) ? (e.which || e.keyCode) : null ;

			if(keyCode == 13) {
				ob.option('yes');
			}
		},
	
		initBox: function() {
			var dim = this.getPageSize();
		
			var boxWidth = ((this.width) ? (this.width + 8) : (dim.pageWidth / 4))  + "px";
			var boxHeight = (typeof this.height == "string" || this.height === null || this.type == "overlay") ? "auto" : (this.height + 160) + "px" ;
		
			var boxPosVCentre = (typeof this.height == "string" || this.height === null || this.type == "overlay") ? ((this.type == "overlay") ? 20 : 150) : ((dim.windowHeight / 2.5) - (parseInt(boxHeight) / 2)) ;
			if (boxPosVCentre < 0) boxPosVCentre = 0;
			var boxPosHCentre = ((dim.pageWidth / 2) - (parseInt(boxWidth) / 2));
		
			var boxPosTop = (/*getWindowScrollY() + */boxPosVCentre) + "px" ;
			var boxPosLeft = boxPosHCentre + "px";
		
			this.box = this.element("div", {
				'class': 'medborder medborder_box overlay',
				'styles' : {
					'width': boxWidth,
					'height': boxHeight,
					'position': /*"absolute"*/"fixed",
					'top': boxPosTop,
					'left': boxPosLeft,
					'zIndex': window.top.overlay_zIndex++,
					'overflow': "auto",
					'borderRadius': "15px"
				}
			});
			this.inject(this.box);
		
			var container = this.element("div", {
				'class': "standardbox_main_classic"
			});

			var overlay_header = null;
			if (this.title != '' || this.type == "overlay") {
				overlay_header = this.element("h3", {
					'html': this.title,
					'styles' : {
						'display': (this.title == "") ? "none" : "block"
					}
				});
				container.appendChild(overlay_header);
			}

			if (this.text != '') {
				if (this.type == "prompt")
				{
					var p = this.element("p");
					p.appendChild(this.element("label", {
						'for': "overlay_prompt",
						'html': this.text
					}));
					container.appendChild(p);
				} else
				{
					container.appendChild(this.element("p", {
						'html': this.text
					}));
				}
			}
		
			var buttonContainer = this.element("div", {
				'class': "proceed_button"
			});

			var _this = this;

			switch(this.type) {
				case "overlay" :
					var iframe = this.element("iframe", {
						'frameBorder': "0",
						'scrolling': (this.scrollbars === false)?"no":"auto",
						'title': "",
						'name': "overlay_iframe",
						'id': "overlay_iframe",
						'src': this.href,
						'allowtransparency': "true",
						'styles' : {
							'width': this.width?(this.width+'px'):"100%",
							'height': this.height?(this.height+'px'):"50%",
						}
					});

					container.appendChild(iframe);

					var button=this.element("button", {
						'html': this.cancel_button,
						'class': "button_pageitem",
					});
					this.addEvent( button, "click", function() { _this.option('finished'); } );
					this.addEvent( this.overlay, "click", function() { _this.option('finished'); } );
					buttonContainer.appendChild(button);
					container.appendChild(this.element("hr", { 'class': 'spaced_rule' } ));
					container.appendChild(buttonContainer);

					this.addEvent( iframe, "load", function() {
						if (typeof iframe.contentWindow.document.getElementsByTagName('h1')[0] == 'undefined')
						{
							setInnerHTML(overlay_header,escape_html(iframe.contentWindow.document.title));
							overlay_header.style.display='block';
						}
					} );

					// Fiddle it, to behave like a popup would
					var name=this.name;
					var makeFrameLikePopup=function() {
						if ((iframe) && (iframe.contentWindow) && (iframe.contentWindow.document))
						{
							iframe.contentWindow.document.body.style.background='none !important';
							iframe.contentWindow.document.body.style.backgroundColor='transparent !important';

							// Remove fixed width
							var body_inner=iframe.contentWindow.document.getElementById('body_inner');
							if (body_inner) body_inner.id='';
							var fw=get_elements_by_class_name(iframe.contentWindow.document.body,'top_level_wrap_fixed');
							if (fw[0]) fw[0].className='top_level_wrap';

							iframe.contentWindow.opener = window;
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

							if (name && iframe.contentWindow.name != name) iframe.contentWindow.name=name;

							if (typeof iframe.contentWindow.faux_close=='undefined')
							{
								iframe.contentWindow.faux_close=function() {
									_this.returnValue=iframe.contentWindow.returnValue;
									_this.option('finished');
								};
							}
						}
					};
					window.setTimeout(function() { illustrateFrameLoad(iframe,'overlay_iframe'); makeFrameLikePopup(); },0);
					window.setInterval(makeFrameLikePopup,100); // In case internal nav changes
				break;

				case "alert" :
					if(this.yes != false) {
						var button=this.element("button", {
							'html': this.yes_button,
							'class': "button_pageitem",
						});
						this.addEvent( button, "click", function() { _this.option('yes'); } );
						this.addEvent( this.overlay, "click", function() { _this.option('yes'); } );
						buttonContainer.appendChild(button);
						container.appendChild(buttonContainer);
					}
				break;

				case "confirm" :
					var button=this.element("button", {
						'html': this.yes_button,
						'class': "button_pageitem",
						'style': "font-weight: bold;"
					});
					this.addEvent( button, "click", function() { _this.option('yes'); } );
					buttonContainer.appendChild(button);
					var button=this.element("button", {
						'html': this.no_button,
						'class': "button_pageitem"
					});
					this.addEvent( button, "click", function() { _this.option('no'); } );
					buttonContainer.appendChild(button);

					container.appendChild(buttonContainer);
				break;

				case "prompt" :
					this.input = this.element("input", {
						'name': "prompt",
						'id': "overlay_prompt",
						'type': this.input_type,
						'size': "40",
						'class': "wide_field",
						'value': this.defaultValue,
					});
					var input_wrap = this.element("div", {
						'class': "constrain_field"
					});
					input_wrap.appendChild(this.input);
					container.appendChild(input_wrap);

					if(this.yes) {
						var button=this.element("button", {
							'html': this.yes_button,
							'class': "button_pageitem",
							'style': "font-weight: bold;"
						});
						this.addEvent( button, "click", function() { _this.option('yes'); } );
						buttonContainer.appendChild(button);
					}
					var button=this.element("button", {
						'html': this.cancel_button,
						'class': "button_pageitem",
					});
					this.addEvent( button, "click", function() { _this.option('cancel'); } );
					this.addEvent( this.overlay, "click", function() { _this.option('cancel'); } );
					buttonContainer.appendChild(button);

					container.appendChild(buttonContainer);
				break;
			}
		
			this.box.appendChild(container);
		
			if(this.input) this.input.focus();
			else this.box.getElementsByTagName('button')[0].focus();
		
			if(this.yes || this.yes != false) this.addEvent(document, "keyup", function(e) { _this.keyup(e,_this); } );
		},
	
		initOverlay: function() {
			var dim = this.getPageSize();
			this.overlay = this.element("div", {
				'styles': {
					'backgroundColor': "black",
					'opacity': this.opacity,
					'position': "absolute",
					'top': "0px",
					'left': "0px",
					'width': dim.pageWidth + "px",
					'height': dim.pageHeight + "px",
					'zIndex': window.top.overlay_zIndex++
			
				}
			});
			this.inject(this.overlay);
		},
	
		inject: function(el) {
			window.top.document.body.appendChild(el);
		},
	
		remove: function(el, win) {
			if (!win) win = window.top;
			win.document.body.removeChild(el);
		},
	
		element: function() {
			var tag = arguments[0], options = arguments[1];
			var el = window.top.document.createElement(tag);
			var attributes = {
				'html': 'innerHTML',
				'class': 'className',
				'for': 'htmlFor',
				'text': 'innerText'
			};
			if(options) {
				if(typeof options == "object") {
					for(var name in options) {
						var value = options[name];
						if(name == "styles") {
							this.setStyles(el, value);
						} else if (attributes[name]) { 
							el[attributes[name]] = value; 
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
			if (p == 'opacity') {
				setOpacity(e,v);
			} else {
				e.style[p] = v;
			}
		},
		
		getPageSize: function() {
			var xScroll, yScroll;
		
			if (window.top.innerHeight && window.top.scrollMaxY) {	
				xScroll = window.top.innerWidth + window.top.scrollMaxX;
				yScroll = window.top.innerHeight + window.top.scrollMaxY;
			} else if (window.top.document.body.scrollHeight > window.top.document.body.offsetHeight) {
				xScroll = window.top.document.body.scrollWidth;
				yScroll = window.top.document.body.scrollHeight;
			} else {
				xScroll = window.top.document.body.offsetWidth;
				yScroll = window.top.document.body.offsetHeight;
			}
		
			var windowWidth, windowHeight;
	
			if (window.top.self.innerHeight) {
				if(window.top.document.documentElement.clientWidth){
					windowWidth = window.top.document.documentElement.clientWidth; 
				} else {
					windowWidth = window.top.self.innerWidth;
				}
				windowHeight = window.top.self.innerHeight;
			} else if (window.top.document.documentElement && window.top.document.documentElement.clientHeight) {
				windowWidth = window.top.document.documentElement.clientWidth;
				windowHeight = window.top.document.documentElement.clientHeight;
			} else if (window.top.document.body) {
				windowWidth = window.top.document.body.clientWidth;
				windowHeight = window.top.document.body.clientHeight;
			}	

			var pageHeight;
			if(yScroll < windowHeight){
				pageHeight = windowHeight;
			} else { 
				pageHeight = yScroll;
			}

			var pageWidth;
			if(xScroll < windowWidth){	
				pageWidth = xScroll;		
			} else {
				pageWidth = windowWidth;
			}
	
			return { 'pageWidth': pageWidth, 'pageHeight': pageHeight, 'windowWidth' : windowWidth, 'windowHeight': windowHeight };
		}
	};
}
{+END}