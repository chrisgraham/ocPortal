var slideshow_timer=null;

var slideshow_slides={};

var slideshow_time=null;

function initialise_slideshow()
{
	reset_slideshow_countdown();
	start_slideshow_timer();
	
	addEventListenerAbstract(window,'keypress',toggle_slideshow_timer);
	addEventListenerAbstract(window,'click',toggle_slideshow_timer);

	slideshow_show_slide(slideshow_current_position); // To ensure next is preloaded
}

function start_slideshow_timer()
{
	if (!slideshow_timer)
	{
		slideshow_timer=window.setInterval(function() {
			slideshow_time--;
			show_current_slideshow_time();
	
			if (slideshow_time==0)
			{
				slideshow_forward();
			}
		} ,1000);
	}

	if (slideshow_current_position!=slideshow_total_slides-1)
		document.getElementsByTagName('body')[0].style.cursor='progress';
}

function show_current_slideshow_time()
{
	var changer=document.getElementById('changer_wrap');
	if (changer) setInnerHTML(changer,'{!CHANGING_IN,xxx}'.replace('xxx',(slideshow_time<0)?0:slideshow_time));
}

function reset_slideshow_countdown()
{
	var slideshow_from=document.getElementById('slideshow_from');
	slideshow_time=slideshow_from?window.parseInt(slideshow_from.value):5;

	show_current_slideshow_time();

	if (slideshow_current_position==slideshow_total_slides-1)
		slideshow_time=0;
}

function toggle_slideshow_timer()
{
	if (slideshow_timer)
	{
		stop_slideshow_timer('{!STOPPED;}');
	} else
	{
		show_current_slideshow_time();
		start_slideshow_timer();
	}
}

function stop_slideshow_timer(message)
{
	var changer=document.getElementById('changer_wrap');
	if (changer) setInnerHTML(changer,message);
	window.clearInterval(slideshow_timer);
	slideshow_timer=null;
	document.getElementsByTagName('body')[0].style.cursor='';
}

function slideshow_backward()
{
	if (slideshow_current_position==0) return false;

	slideshow_show_slide(slideshow_current_position-1);

	return false;
}

function playerStopped()
{
	slideshow_forward();
}

function slideshow_forward()
{
	if (slideshow_current_position==slideshow_total_slides-1)
	{
		stop_slideshow_timer('{!LAST_SLIDE;}');
		return false;
	}

	slideshow_show_slide(slideshow_current_position+1);

	return false;
}

function slideshow_ensure_loaded(slide,immediate)
{
	if (typeof slideshow_slides[slide]!='undefined') return; // Already have it
	
	if (slideshow_current_position==slide) // Ah, it's where we are, so save that in
	{
		slideshow_slides[slide]=getInnerHTML(document.getElementsByTagName('body')[0]);
		return;
	}
	
	if (slide==slideshow_current_position+1)
	{
		var url=document.getElementById('next_slide').value;
		
		if (immediate)
		{
			_slideshow_read_in_slide(load_XML_doc(url,null,null),slide);
		} else
		{
			var func=function(ajax_result_raw) { _slideshow_read_in_slide(ajax_result_raw,slide) };
			func.accept_raw_response=true;
			load_XML_doc(url,func,null);
		}
	} else
	{
		window.alert('Internal error: should not be preloading more than one step ahead');
	}
}

function _slideshow_read_in_slide(ajax_result_raw,slide)
{
	slideshow_slides[slide]=ajax_result_raw.responseText.replace(/(.|\n)*<body[^>]*>/i,'').replace(/<\/body>(.|\n)*/i,'');
}

function slideshow_show_slide(slide)
{
	slideshow_ensure_loaded(slide,true);

	if (slideshow_current_position!=slide) // If not already here
	{
		var slideshow_from=document.getElementById('slideshow_from');

		setInnerHTML(document.getElementsByTagName('body')[0],slideshow_slides[slide].replace(/<script[^>]*>(.|\n)*?<\/script>/gi,''));

		document.getElementById('slideshow_from').value=slideshow_from.value; // Make sure stays the same

		slideshow_current_position=slide;
	}
	
	start_slideshow_timer();
	reset_slideshow_countdown();

	if (slideshow_current_position!=slideshow_total_slides-1)
		slideshow_ensure_loaded(slide+1,false);
	else
		document.getElementsByTagName('body')[0].style.cursor='';
}
