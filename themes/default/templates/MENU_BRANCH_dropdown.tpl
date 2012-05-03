{+START,IF,{TOP_LEVEL}}
	<li {+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$NOT,{LAST}}}style="width: {$DIV_FLOAT',99.5,{BRETHREN_COUNT}}%" {+END}{+END}class="{$?,{CURRENT},current,non_current}{+START,IF,{$AND,{$IS_EMPTY,{CHILDREN}},{LAST}}} last{+END} toplevel"{+START,IF_NON_EMPTY,{CHILDREN}}{+START,IF,{$NOT,{$MOBILE}}} onmousemove="if (!this.timer) this.timer=window.setTimeout(function() { return popUpMenu('{MENU|*;}_dexpand_{RANDOM*;}','below','{MENU|*;}_d');} , document.getElementById('quick_js_loader')?3000:200);" onmouseout="if (this.timer) { window.clearTimeout(this.timer); this.timer=null; }"{+END}{+END}>
		<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{$NOT,{POPUP}}} onkeypress="this.onclick(event);" onclick="cancelBubbling(event); {+START,IF_NON_EMPTY,{CHILDREN}}{$,Touch screen device handling}if (typeof this.ontouchstart!='undefined') { if (this.fake_focus=='undefined' || !this.fake_focus) { this.fake_focus=true; this.onfocus(event); } else { this.fake_focus=false; desetActiveMenu(); } return false; }{+END}{+START,IF_EMPTY,{URL}}return false;{+END}"{+END} class="{+START,IF_EMPTY,{URL}}non_link {+END}toplevel_link{+START,IF,{LAST}} last{+END}"{+START,IF_NON_EMPTY,{CHILDREN}} onfocus="return popUpMenu('{MENU|*;}_dexpand_{RANDOM*;}','below','{MENU|*;}_d');"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}{+START,IF_EMPTY,{IMG}}&raquo; {+END}{CAPTION}</a>
		{+START,IF_NON_EMPTY,{CHILDREN}}{+START,IF,{$NOT,{$MOBILE}}}
			<ul{$?,{$VALUE_OPTION,html5}, aria-haspopup="true"} onmouseover="if (activeMenu==null) return setActiveMenu(this.id,'{MENU|*;}_d'); else return false;" onmouseout="return desetActiveMenu();" class="nlevel" id="{MENU|*}_dexpand_{RANDOM*}" style="display: none">{$PREG_REPLACE,[\n\t],,{CHILDREN}}</ul>
		{+END}{+END}
	</li>
{+END}
{+START,IF,{$NOT,{TOP_LEVEL}}}
	<li{+START,IF_NON_EMPTY,{CHILDREN}} onmousemove="return popUpMenu('{MENU|*;}_dexpand_{RANDOM*;}',null,'{MENU|*;}_d',event);"{+END} class="nlevel {$?,{CURRENT},current,non_current} {$?,{$IS_EMPTY,{IMG}},has_no_img,has_img}" onkeypress="this.onclick(event);" onclick="var as=this.getElementsByTagName('a'); if (!as[0]) return; var a=as[as.length-1]; click_link(a);">
		{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}
		{+START,IF_NON_EMPTY,{URL}}
			<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{$NOT,{POPUP}}} onkeypress="this.onclick(event);" onclick="cancelBubbling(event);"{+END} {+START,IF_NON_EMPTY,{CHILDREN}} class="drawer"{+END}>{CAPTION}</a>{+START,IF_NON_EMPTY,{CHILDREN}} &rarr;{+END}
		{+END}
		{+START,IF_EMPTY,{URL}}
			<a onkeypress="this.onclick(event);" onclick="cancelBubbling(event); return false;" class="non_link{+START,IF_NON_EMPTY,{CHILDREN}} drawer{+END}" href="#">{CAPTION}</a>{+START,IF_NON_EMPTY,{CHILDREN}} &rarr;{+END}
		{+END}
		{+START,IF_NON_EMPTY,{CHILDREN}}
			<ul{$?,{$VALUE_OPTION,html5}, aria-haspopup="true"} onmouseover="if (activeMenu==null) return setActiveMenu(this.id,'{MENU|*;}_d'); else return false;" onmouseout="return desetActiveMenu();" class="nlevel" id="{MENU|*}_dexpand_{RANDOM*}" style="display: none">{$PREG_REPLACE,[\n\t],,{CHILDREN}}</ul>
		{+END}
	</li>
{+END}
