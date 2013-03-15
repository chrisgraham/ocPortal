{$,The line below is just a fudge - we need CHILDREN to evaluate first, so it doesn't interfere with our 'RAND' variable}
{$SET,HAS_CHILDREN,{$IS_NON_EMPTY,{CHILDREN}}}

{$SET,RAND,{$RAND}}

{+START,IF,{TOP_LEVEL}}
	<li {+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$OR,{$GET,HAS_CHILDREN},{$NOT,{LAST}}}}style="width: {$DIV_FLOAT',100,{BRETHREN_COUNT}}%" {+END}{+END}class="{$?,{CURRENT},current,non_current}{+START,IF,{$AND,{$NOT,{$GET,HAS_CHILDREN}},{LAST}}} last{+END} {+START,IF,{$AND,{$NOT,{$GET,HAS_CHILDREN}},{FIRST}}} first{+END} toplevel"{+START,IF,{$GET,HAS_CHILDREN}}{+START,IF,{$NOT,{$MOBILE}}} onmousemove="if (!this.timer) this.timer=window.setTimeout(function() { return pop_up_menu('{MENU|*;}_dexpand_{$GET*;,RAND}','below','{MENU|*;}_d');} , document.getElementById('quick_js_loader')?3000:200);" onmouseout="if (this.timer) { window.clearTimeout(this.timer); this.timer=null; }"{+END}{+END}>
		<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{$NOT,{POPUP}}} onkeypress="this.onclick(event);" onclick="cancel_bubbling(event); {+START,IF,{$GET,HAS_CHILDREN}}deset_active_menu(); {+END}{+START,IF_EMPTY,{URL}}return false;{+END}"{+END} class="{+START,IF_EMPTY,{URL}}non_link {+END}toplevel_link{+START,IF,{LAST}} last{+END}{+START,IF,{FIRST}} first{+END}"{+START,IF,{$GET,HAS_CHILDREN}} onfocus="return pop_up_menu('{MENU|*;}_dexpand_{$GET*;,RAND}','below','{MENU|*;}_d');"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" /> {+END}{CAPTION}</a>
		{+START,IF,{$GET,HAS_CHILDREN}}{+START,IF,{$NOT,{$MOBILE}}}
			<ul aria-haspopup="true" onmouseover="if (active_menu==null) return set_active_menu(this.id,'{MENU|*;}_d'); else return false;" onmouseout="return deset_active_menu();" class="nlevel" id="{MENU|*}_dexpand_{$GET*;,RAND}" style="display: none">{$PREG_REPLACE,[\n\t],,{CHILDREN}}</ul>
		{+END}{+END}
	</li>
{+END}

{+START,IF,{$NOT,{TOP_LEVEL}}}
	<li{+START,IF,{$GET,HAS_CHILDREN}} onmousemove="return pop_up_menu('{MENU|*;}_dexpand_{$GET*;,RAND}',null,'{MENU|*;}_d',event);"{+END} class="nlevel {$?,{CURRENT},current,non_current} {$?,{$IS_EMPTY,{IMG}},has_no_img,has_img}" onkeypress="this.onclick(event);" onclick="var as=this.getElementsByTagName('a'); if (!as[0]) return; var a=as[as.length-1]; click_link(a);">
		{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}
		{+START,IF_NON_EMPTY,{URL}}
			<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{$NOT,{POPUP}}} onkeypress="this.onclick(event);" onclick="cancel_bubbling(event);"{+END} {+START,IF,{$GET,HAS_CHILDREN}} class="drawer"{+END}>{CAPTION}</a>{+START,IF,{$GET,HAS_CHILDREN}} &rarr;{+END}
		{+END}
		{+START,IF_EMPTY,{URL}}
			<a onkeypress="this.onclick(event);" onclick="cancel_bubbling(event); return false;" class="non_link{+START,IF,{$GET,HAS_CHILDREN}} drawer{+END}" href="#">{CAPTION}</a>{+START,IF,{$GET,HAS_CHILDREN}} &rarr;{+END}
		{+END}
		{+START,IF,{$GET,HAS_CHILDREN}}
			<ul aria-haspopup="true" onmouseover="if (active_menu==null) return set_active_menu(this.id,'{MENU|*;}_d'); else return false;" onmouseout="return deset_active_menu();" class="nlevel" id="{MENU|*}_dexpand_{$GET*;,RAND}" style="display: none">{$PREG_REPLACE,[\n\t],,{CHILDREN}}</ul>
		{+END}
	</li>
{+END}
