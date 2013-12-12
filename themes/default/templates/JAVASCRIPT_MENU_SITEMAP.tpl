"use strict";

// ==============================
// DYNAMIC TREE CREATION FUNCTION
// ==============================

// Creates a tree from a compressed format
//  This function is recursive in two dimensions. It iterates linearly along lists, and it iterates down through depth.
//  Both kinds of iterates are modelled as recursions to this function call.
function generate_menu_sitemap(save_to,key_name,range_a,range_b,level,data,chain,not_first)
{
	if (range_b==-1) range_b=data.length;
	if ((range_b-range_a)<2) return '';

	var to=data.indexOf(',',range_a);
	if ((to==-1) || (to>range_b)) to=range_b;
	var next_title=data.substring(range_a,to);
	var anchor_reference;
	var i;
	for (i=0;i<next_title.length;i++)
	{
		if (next_title.charAt(i+1)=='!')
		{
			anchor_reference=next_title.substring(0,i+1);
			next_title=next_title.substring(i+2,next_title.length);
			break;
		}
	}

	// Render our item
	var contents='';
	contents+='<li>\n';
	contents+='<a href=\"'+escape_html(anchor_reference)+'\">'+next_title+'</a>\n';

	if (to+1<data.length)
	{
		var a=to+1,b=range_b,scanner_for,to,under;
		if (data.charAt(to+1)=='[') // Child level exists next in list, requiring recursion
		{
			// Find where this level's data starts and ends
			var scanner_for_b=to+1;
			var balance=0;
			do
			{
				if (data.charAt(scanner_for_b)=='[') balance++;
				if (data.charAt(scanner_for_b)==']') balance--;
				scanner_for_b++;
			}
			while (balance!=0);
			a=to+2;
			b=scanner_for_b-1;

			// Render level
			under=generate_menu_sitemap(save_to,key_name,url_stub,a,b,level+1,data,chain+'~'+anchor_reference,true);
			if (under!='')
			{
				contents+='<a class=\"toggleable_tray_button\" href=\"#\" onclick=\"return toggleable_tray(this.parentNode);\"><img title=\"\" alt=\"{!EXPAND^#}/{!CONTRACT^#}\" src=\"'+"{$IMG*#,1x/trays/contract}".replace(/^http:/,window.location.protocol)+'\" srcset=\"'+"{$IMG*#,2x/trays/contract}".replace(/^http:/,window.location.protocol)+' 2x\" /></a>\n';
				contents+='<ul class=\"toggleable_tray\">\n';
				contents+=under;
				contents+='</ul>\n';
			}

			// This will restore the positions back so as to the next one on our own level
			a=b+2;
			b=range_b;
		}
		contents+='</li>';
		contents+=generate_menu_sitemap(save_to,key_name,url_stub,a,b,level,data,chain,true); // Next iteration in list, handled by recursion
	} else
	{
		contents+='</li>';
	}

	if (!not_first)
	{
		var menu_sitemap_element=document.getElementById(save_to);
		set_inner_html(menu_sitemap_element,'<ul>'+contents+'</ul>\n');
	} else return contents;
}

