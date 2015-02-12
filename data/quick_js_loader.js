function loaded()
{
	var base=document.getElementsByTagName('base')[0].href;

	// Retrieve from localstorage cache
	var loc=(window.location+'').replace(/&js_cache=1&/,'&').replace(/&js_cache=1$/,'').replace(/\?js_cache=1&/,'?').replace(/\?js_cache=1$/,'');
	var html='';
	if ((typeof localStorage[loc]!='undefined') && (localStorage[loc]))
	{
		html=JSON.parse(localStorage[loc])[0];
		if (html.indexOf('<!DOCTYPE')==-1)
			html='<!DOCTYPE html>'+html;
		html=html.replace('<TITLE />','').replace(/<script([^>]*)\/>/ig,'<script$1></script>').replace(/<textarea([^>]*)\/>/ig,'<textarea$1></textarea>').replace(/<style([^>]*)\/>/ig,'<style$1></style>');
		document.close();
		document.open('text/html',true);
		document.write(html);
		document.close();
		window.setTimeout(function() {
			if (document.title=='Preloading')
				document.title=html.substring(html.indexOf('<TITLE>')+7,html.indexOf('</TITLE>'));

			var script="\
				var loc=(window.location+'').replace(/&js_cache=1&/,'&').replace(/&js_cache=1$/,'').replace(/\\?js_cache=1&/,'?').replace(/\\?js_cache=1$/,''); \
				var html=JSON.parse(localStorage[loc])[0]; \
				var base='"+base+"'; \
				 \
				// Show loading message\n \
				var img=document.createElement('img'); \
				img.style.position='absolute'; \
				img.style.right='6px'; \
				img.style.top='3px'; \
				img.id='quick_js_loader'; \
				img.title=img.alt='Refreshing from cache'; \
				img.src=base+'themes/default/images/loading.gif'.replace(/^https?:/,window.location.protocol); \
				document.body.appendChild(img); \
				var last_values=find_form_values(false); \
				 \
				// Request latest page version using AJAX\n \
				var req=new XMLHttpRequest(); \
				req.onreadystatechange=function() { \
					if (window.unloaded) return; /*Going anyway and this might break the outlink*/ \
					if (req.readyState==4) \
					{ \
						if ((req.responseText!='') && (req.responseText!=html)) \
						{ \
							// Try and preserve form data\n \
							values=find_form_values(last_values); \
							var values2=[]; \
							for (var i in values) \
							{ \
								if (i!='__proto__') values2.push(values[i]); \
							} \
							localStorage['form_values']=JSON.stringify(values2); \
							 \
							// Write out\n \
							html=req.responseText; \
							if (!browser_matches('ie')) \
							{ \
								document.close(); \
								document.open('text/html',true); \
							} \
							document.write(html.replace('<'+'/body>','<'+'script type=\"text/javascript\">window.setTimeout(function() { var values=JSON.parse(localStorage[\\'form_values\\']); for (i=0;i<values.length;i++) { var e=document.getElementById(values[i][1]); if (e) e[values[i][0]]=values[i][2]; } },10);</'+'script></'+'body>')); \
							document.close(); \
						} else \
						{ \
							img.parentNode.removeChild(img); \
						} \
					} \
				}; \
				req.open('GET',loc,true); \
				req.send(null); \
				 \
				function find_form_values(last_values) \
				{ \
					// Try and preserve form data\n \
					var e1=document.getElementsByTagName('input'); \
					var e2=document.getElementsByTagName('select'); \
					var e3=document.getElementsByTagName('textarea'); \
					var values={},i; \
					for (i=0;i<e1.length;i++) \
					{ \
						if (e1[i].id) \
						{ \
							if (e1[i].type=='radio' || e1[i].type=='checkbox') \
							{ \
								if ((!last_values) || (!last_values[e1[i].id]) || (last_values[e1[i].id][2]!=e1[i].checked)) \
								{ \
									values[e1[i].id]=(['checked',e1[i].id,e1[i].checked]); \
								} \
							} \
							else if (e1[i].type=='text' || e1[i].type=='password' || e1[i].type=='color' || e1[i].type=='email' || e1[i].type=='number' || e1[i].type=='range' || e1[i].type=='search' || e1[i].type=='tel' || e1[i].type=='url') \
							{ \
								if ((!last_values) || (!last_values[e1[i].id]) || (last_values[e1[i].id][2]!=e1[i].value)) \
								{ \
									values[e1[i].id]=(['value',e1[i].id,e1[i].value]); \
								} \
							} \
						} \
					} \
					for (i=0;i<e2.length;i++) \
					{ \
						if (e2[i].id) \
						{ \
							if ((!last_values) || (!last_values[e2[i].id]) || (last_values[e2[i].id][2]!=e2[i].selectedIndex)) \
							{ \
								values[e2[i].id]=(['selectedIndex',e2[i].id,e2[i].selectedIndex]); \
							} \
						} \
					} \
					for (i=0;i<e3.length;i++) \
					{ \
						if (e3[i].id) \
						{ \
							if ((!last_values) || (!last_values[e3[i].id]) || (last_values[e3[i].id][2]!=e3[i].value)) \
							{ \
								values[e3[i].id]=(['value',e3[i].id,e3[i].value]); \
							} \
						} \
					} \
					 \
					 \
					return values; \
				} \
			";
			var script_node=document.createTextNode(script);
			var script_element=document.createElement('script');
			script_element.type="text/javascript";
			script_element.appendChild(script_node);
			document.body.appendChild(script_element);
		},100);

		promotePageCaching();
	} else
	{
		window.location=loc; // Must have been lost after link generated
	}
}

function promotePageCaching()
{
	for (var i=0;i<document.links.length;i++)
	{
		if ((typeof document.links[i]!='undefined') && (typeof localStorage[document.links[i].href]!='undefined') && (localStorage[document.links[i].href]))
		{
			document.links[i].href+=((document.links[i].href.indexOf('?')==-1)?'?':'&')+'js_cache=1';
		}
	}
}
