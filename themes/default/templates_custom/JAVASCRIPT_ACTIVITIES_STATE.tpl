"use strict";

{$,Parser hint: .innerHTML okay}

/*
This provides the Javascript necessary for the "status" part of activities

You can make use of it via require_javascript('javascript_activities_state')
*/

function s_update_focus(event)
{
	if (jQuery(this).val().trim()=='{!activities:TYPE_HERE;}')
	{
		jQuery(this).val('');
		this.className=this.className.replace(' field_input_non_filled',' field_input_filled');
	}
	jQuery(this).removeClass('fade_input');
}

function s_update_blur(event)
{
	if (jQuery(this).val().trim()=='')
	{
		jQuery(this).val('{!activities:TYPE_HERE;}');
	}
	jQuery(this).addClass('fade_input');
}

/**
 * Maintain feedback on how many characters are available in an update box.
 */
function s_maintain_char_count(event)
{
	var char_count=jQuery('#activity_status').val().length;

	if (char_count<255)
		jQuery('#activities_update_notify','#status_updates').attr('class','update_success').text((254-char_count)+' {!activities:CHARACTERS_LEFT;}');
	else
		jQuery('#activities_update_notify','#status_updates').attr('class','update_error').text((char_count-254)+' {!activities:CHARACTERS_TOO_MANY;}');
}

/**
 * Called on update submission
 */
function s_update_submit(event)
{
	var subject_text='';

	if (event)
	{
		event.preventDefault();
		subject_text=jQuery('textarea',this).val().trim();
	} else
	{
		subject_text=jQuery('textarea','#fp_status_form').val().trim();
	}

	if ((subject_text=='{!activities:TYPE_HERE;}') || (subject_text==''))
	{
		jQuery('#activities_update_notify','#status_updates').attr('class','update_error').text('{!activities:PLEASE_ENTER_STATUS;}');
	} else
	{
		var url='{$BASE_URL;,0}/data_custom/activities_handler.php'+keep_stub(true);

		jQuery.ajax({
			url: url.replace(/^http:/,window.location.protocol),
			type: 'POST',
			data: jQuery('#fp_status_form').serialize(),
			cache: false,
			timeout: 5000,
			success: function(data,stat) { s_update_retrieve(data,stat); },
			error: function(a,stat,err) { s_update_retrieve(err,stat); }
		});
	}
}

/**
 * Processes data retrieved for the activities feed and updates the list
 * If called by s_update_submit will also catch if you're logged out and redirect
 */
function s_update_retrieve(data,tStat)
{
	document.getElementById('button').disabled=false;

	var update_box=jQuery('#activities_update_notify','#status_updates');
	if (tStat=='success')
	{
		if (jQuery('success',data).text()=='0')
		{
			if (jQuery('feedback',data).text().substr(0,13)=='{!MUST_LOGIN;}')
			{ //if refusal is due to login expiry...
				window.fauxmodal_alert('{!MUST_LOGIN;}');
			} else
			{
				update_box.attr('class','update_error').html(jQuery('feedback',data).text());
			}
		}
		else if (jQuery('success',data).text()=='1')
		{
			update_box.attr('class','update_success').text(jQuery('feedback',data).text());
			if (jQuery('#activities_feed').length!=0) // The update box won't necessarily have a displayed feed to update
			{
				s_update_get_data();
			}
			update_box.fadeIn(1200,function() { update_box.fadeOut(1200,function() {
				var as=jQuery('#activity_status');
				update_box.attr('class','update_success').text('254 {!activities:CHARACTERS_LEFT;}');
				update_box.fadeIn(1200);
				as.parent().height(as.parent().height());
				as.val('{!activities:TYPE_HERE;}');
				as.fadeIn(1200,function() { as.parent().height(''); });
			}); });
		}
	} else
	{
		var errText='{!activities:WENT_WRONG;}';
		update_box.attr('class','').addClass('update_error').text(errText);
		update_box.hide();
		update_box.fadeIn(1200,function() { update_box.delay(2400).fadeOut(1200,function() {
			s_maintain_char_count(null);
			update_box.fadeIn(1200);
		}); });
	}
}
