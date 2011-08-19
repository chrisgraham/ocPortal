function accordion(e)
{
	var i,nodes=get_elements_by_class_name(e.parentNode.parentNode,'hide_tag');
	for (i=0;i<nodes.length;i++)
	{
		if ((nodes[i].parentNode!=e) && (nodes[i].style.display!='none') && (nodes[i].className.indexOf('medborder_box')!=-1))
		{
			hideTag(nodes[i].parentNode,true);
		}
	}
	hideTag(e);
}

// =======
// COMCODE
// =======

function big_tabs_init()
{
	/* Precache images */
	new Image().src='{$IMG;,big_tabs_controller_button}';
	new Image().src='{$IMG;,big_tabs_controller_button_active}';
	new Image().src='{$IMG;,big_tabs_controller_button_top_active}';
	new Image().src='{$IMG;,big_tabs_controller_button_top}';
}

function countdown(id,direction,tailing)
{
	var countdown=document.getElementById(id);
	var inside=getInnerHTML(countdown);
	var multiples=[];
	if (tailing>=4) multiples.push(365);
	if (tailing>=3) multiples.push(24);
	if (tailing>=2) multiples.push(60);
	if (tailing>=1) multiples.push(60);
	multiples.push(1);
	var us=inside.match(/\d+/g);
	var total=0,multiplier=1;
	while (multiples.length>us.length)
	{
		us.push('0');
	}
	for (var i=us.length-1;i>=0;i--)
	{
		multiplier*=multiples[i];
		total+=window.parseInt(us[i])*multiplier;
	}
	
	if (total>0)
	{
		total+=direction;
		inside=inside.replace(/\d+/g,'!!!');
		if (total==0)
		{
			countdown.className='important_notification';
			//countdown.style.textDecoration='blink';
		}
		for (var i=0;i<us.length;i++)
		{
			us[i]=Math.floor(total/multiplier);
			total-=us[i]*multiplier;
			multiplier/=multiples[i];
			inside=inside.replace('!!!',us[i]);
		}
		setInnerHTML(countdown,inside);
	}
}

function initialise_carousel(id)
{
	var carousel=document.getElementById('carousel_'+id);
	var main=get_elements_by_class_name(carousel,'main')[0];
	var carousel_ns=document.getElementById('carousel_ns_'+id);
	carousel_ns.parentNode.removeChild(carousel_ns);
	main.appendChild(carousel_ns);
	carousel.style.display='block';
	carousel.refresh_func=function() {
		addEventListenerAbstract(window,'real_load',function() {
			var h=findHeight(main)+'px';
			get_elements_by_class_name(carousel,'move_left')[0].style.height=h;
			get_elements_by_class_name(carousel,'move_right')[0].style.height=h;
		} );
		if (browser_matches('ie6')) main.style.width=(findWidth(main.parentNode)-92)+'px';
		_create_faders(main);
		_update_faders(main);
	};
	window.setTimeout(carousel.refresh_func, 20);
}

function carousel_move(id,amount)
{
	var carousel=document.getElementById('carousel_'+id);

	window.setTimeout(function() { _carousel_move(carousel,amount); },10);
}

function _carousel_move(carousel,amount)
{
	var main=get_elements_by_class_name(carousel,'main')[0];
	
	if (amount>0)
	{
		main.scrollLeft+=3;
		amount--;
		if (amount<0) amount=0;
	} else
	{
		main.scrollLeft-=3;
		amount++;
		if (amount>0) amount=0;
	}

	_update_faders(main);

	if (amount!=0)
		window.setTimeout(function() { _carousel_move(carousel,amount); },10);
}

function _create_faders(main)
{
	var left=document.createElement('img');
	left.setAttribute('src','{$IMG;,carousel/fade_left}');
	left.style.position='absolute';
	left.style.left='43px';
	left.style.top='0';
	fixImage(left);
	main.parentNode.appendChild(left);

	var right=document.createElement('img');
	right.setAttribute('src','{$IMG;,carousel/fade_right}');
	right.style.position='absolute';
	right.style.right='43px';
	right.style.top='0';
	fixImage(right);
	main.parentNode.appendChild(right);
}

function _update_faders(main)
{
	var imgs=main.parentNode.getElementsByTagName('img');

	var left=imgs[imgs.length-2];
	var right=imgs[imgs.length-1];
	
	left.style.visibility=(main.scrollLeft==0)?'hidden':'visible';
	right.style.visibility=(main.scrollLeft+findWidth(main)>=main.scrollWidth-1)?'hidden':'visible';
}

function flip_page(to,pass_id,sections)
{
	var i,current_pos=0,section;

	if (window['big_tabs_auto_cycler_'+pass_id])
	{
		window.clearTimeout(window['big_tabs_auto_cycler_'+pass_id]);
		window['big_tabs_auto_cycler_'+pass_id]=null;
	}

	if (typeof to=='number')
	{
		for (i=0;i<sections.length;i++)
		{
			section=document.getElementById(pass_id+'_section_'+sections[i]);
			if (section)
			{
				if ((section.style.display=='block') && (section.style.position!='absolute'))
				{
					current_pos=i;
					break;
				}
			}
		}

		current_pos+=to;
	} else
	{
		for (i=0;i<sections.length;i++)
		{
			if (sections[i]==to)
			{
				current_pos=i;
				break;
			}
		}
	}

	// Previous/next updates
	var x;
	x=document.getElementById(pass_id+'_has_next_yes');
	if (x) x.style.display=(current_pos==sections.length-1)?'none':'inline-block';
	x=document.getElementById(pass_id+'_has_next_no');
	if (x) x.style.display=(current_pos==sections.length-1)?'inline-block':'none';
	x=document.getElementById(pass_id+'_has_previous_yes');
	if (x) x.style.display=(current_pos==0)?'none':'inline-block';
	x=document.getElementById(pass_id+'_has_previous_no');
	if (x) x.style.display=(current_pos==0)?'inline-block':'none';

	// We make our forthcoming one instantly visible to stop Google Chrome possibly scrolling up if there is a tiny time interval when none are visible
	x=document.getElementById(pass_id+'_section_'+sections[i]);
	if (x) x.style.display='block';

	for (i=0;i<sections.length;i++)
	{
		x=document.getElementById(pass_id+'_goto_'+sections[i]);
		if (x) x.style.display=(i==current_pos)?'none':'inline-block';
		x=document.getElementById(pass_id+'_btgoto_'+sections[i]);
		if (x) x.className=x.className.replace(/big\_tab\_(in)?active/,(i==current_pos)?'big_tab_active':'big_tab_inactive');
		x=document.getElementById(pass_id+'_isat_'+sections[i]);
		if (x) x.style.display=(i==current_pos)?'inline-block':'none';
		x=document.getElementById(pass_id+'_section_'+sections[i]);
		var current_place=document.getElementById(pass_id+'_section_'+sections[current_pos]);
		//var width=current_place?'100%':null;
		var width=current_place?findWidth(current_place,true,true,true):null;
		if (x)
		{
			if (x.className=='comcode_big_tab')
			{
				if (i==current_pos)
				{
					if ((typeof x.faderKey!='undefined') && (thumbFadeTimers[x.faderKey]))
					{
						window.clearTimeout(thumbFadeTimers[x.faderKey]);
						thumbFadeTimers[x.faderKey]=null;
					}

					x.style.position='static';
					setOpacity(x,1.0);
				} else
				{
					if (x.style.position!='static') setOpacity(x,0.0); else setOpacity(x,1.0);
					if ((typeof x.faderKey=='undefined') || (!thumbFadeTimers[x.faderKey]))
						nereidFade(x,0,30,-5);
					x.style.position='absolute';
					x.style.top='0';
					x.parentNode.style.position='relative';
				}
				x.style.display='block';
				//x.style.width=width+'px';
			} else
			{
				x.style.display=(i==current_pos)?'block':'none';

				if ((typeof window.nereidFade!='undefined') && (i==current_pos))
				{
					setOpacity(x,0.0);
					nereidFade(x,100,30,4);
				}
			}
		}
	}

	if (window['move_between_big_tabs_'+pass_id])
	{
		window['big_tabs_auto_cycler_'+pass_id]=window.setInterval(window['move_between_big_tabs_'+pass_id], window['big_tabs_switch_time_'+pass_id]);
	}

	return false;
}

function shocker_tick(id,time,min_color,max_color)
{
	if (shocker_pos[id]==shocker_parts[id].length-1) shocker_pos[id]=0;
	var e_left=document.getElementById('comcodeshocker'+id+'_left');
	if (!e_left) return;
	setInnerHTML(e_left,shocker_parts[id][shocker_pos[id]][0]);
	setOpacity(e_left,0.6);
	if (typeof window.nereidFade!='undefined')
	{
		setOpacity(e_left,0.0);
		nereidFade(e_left,100,time/40,5);
	}
	var e_right=document.getElementById('comcodeshocker'+id+'_right');
	if (!e_right) return;
	setInnerHTML(e_right,shocker_parts[id][shocker_pos[id]][1]);
	setOpacity(e_right,0);
	if (typeof window.nereidFade!='undefined')
	{
		setOpacity(e_right,0.0);
		nereidFade(e_right,100,time/20,5);
	}
	shocker_pos[id]++;

	window['comcodeshocker'+id+'_left']=[0,min_color,max_color,time/13,[]];
	window.setInterval(function() { process_wave(e_left); },window['comcodeshocker'+id+'_left'][3]);
}

var tick_pos=[];
function ticker_tick(id,width)
{
	if (!window.focused) return;
	
	var e=document.getElementById(id);
	if (!e) return;
	if (e.mouseisover) return;
	e.style.textIndent=tick_pos[id]+'px';
	tick_pos[id]--;
	if (tick_pos[id]<-1.1*findWidth(e.childNodes[0])) tick_pos[id]=width;
}

var jumper_pos=[],jumper_parts=[];
function jumper_tick(id)
{
	if (jumper_pos[id]==jumper_parts[id].length-1) jumper_pos[id]=0;
	var e=document.getElementById(id);
	if (!e) return;
	setInnerHTML(e,jumper_parts[id][jumper_pos[id]]);
	jumper_pos[id]++;
}

function crazy_tick()
{
	if (typeof window.mouseX=='undefined') return;
	if (typeof window.mouseY=='undefined') return;

	var e,i,s_width,biasx,biasy;
	for (i=0;i<window.crazy_criters.length;i++)
	{
		e=document.getElementById(window.crazy_criters[i]);
		s_width=e.clientWidth;

		biasx=window.mouseX-e.offsetLeft;
		if (biasx>0) biasx=2; else biasx=-1;
		if (Math.random()*4<1) biasx=0;
		biasy=window.mouseY-e.offsetTop;
		if (biasy>0) biasy=2; else biasy=-1;
		if (Math.random()*4<1) biasy=0;

		if (s_width<100)
			e.style.width=(s_width+1)+'px';
		e.style.left=(e.offsetLeft+(Math.random()*2-1+biasx)*30)+"px";
		e.style.top=(e.offsetTop+(Math.random()*2-1+biasy)*30)+"px";
		e.style.position='absolute';
	}
}

