"use strict";

{$,Parser hint: .innerHTML okay}

{$,This provides the Javascript necessary for the "status" part of activities}
{$,You can make use of it via require_javascript('javascript_activities_state')}

function sUpdateF(evt) {
	if (jQuery(this).val().trim()=='{!activities:TYPE_HERE;}') {
		jQuery(this).val('');
	}
	jQuery(this).removeClass('fade_input');
}

function sUpdateB(evt) {
	if (jQuery(this).val().trim()=='') {
		jQuery(this).val('{!activities:TYPE_HERE;}');
	}
	jQuery(this).addClass('fade_input');
}

/**
 * Maintain feedback on how many characters are available in an update box.
 */
function sUpdateCount(evt) {
	var charCount=jQuery('#activity_status').val().length;

	if (charCount < 255)
		jQuery('#notify', '#status_updates').attr('class', 'update_success').text((254-charCount)+" {!activities:CHARACTERS_LEFT#}");
	else
		jQuery('#notify', '#status_updates').attr('class', 'update_error').text((charCount-254)+" {!activities:CHARACTERS_TOO_MANY#}");
}

/**
 * Called on update submission
 */
function sUpdateSubmit(evt) {

	var subjectText='';

	if (evt!==null)
	{
		evt.preventDefault();
		subjectText=jQuery('textarea', this).val().trim();
	}
	else
	{
		subjectText=jQuery('textarea', '#fp_status_form').val().trim();
	}

	if ((subjectText=='{!activities:TYPE_HERE;}') || (subjectText=='')) {
		jQuery('#notify', '#status_updates').attr('class', 'update_error').text("{!activities:PLEASE_ENTER_STATUS#}");
	} else {
		var addy="{$BASE_URL;,0}/data_custom/activities_handler.php"+keep_stub(true);

		jQuery.ajax({
					url: addy.replace(/^http:/,window.location.protocol),
					type: 'POST',
					data: jQuery('#fp_status_form').serialize(),
					cache: false,
					timeout: 5000,
					success: function(data, stat) { sUpdateRetrieve(data, stat); },
					error: function(a, stat, err) { sUpdateRetrieve(err,  stat); }
		});
	}
}

/**
 * Processes data retrieved for the activities feed and updates the list
 * If called by sUpdateSubmit will also catch if you're logged out and redirect
 */
function sUpdateRetrieve(data, tStat) {
	document.getElementById('button').disabled=false;

	var updateBox=jQuery('#notify', '#status_updates');
	if (tStat=='success') {
		if (jQuery('success', data).text()=='0') {

			if (jQuery('feedback', data).text().substr(0,13)=='{!MUST_LOGIN;}') { //if refusal is due to login expiry...
				window.fauxmodal_alert('{!MUST_LOGIN;}');
			} else
				updateBox.attr('class', 'update_error').html(jQuery('feedback', data).text());
		}
		else if (jQuery('success', data).text()=='1') {
			updateBox.attr('class', 'update_success').text(jQuery('feedback', data).text());
			if (jQuery('#activities_feed').length != 0) { //The update box won't necessarily have a feed update to call
				if (ugdRefresh !== false) {
					sUpdateGetData();
				}
			}
			updateBox.fadeIn(1200, function () { updateBox.fadeOut(1200, function () {
				var as=jQuery('#activity_status');
				updateBox.attr('class', 'update_success').text("254 {!activities:CHARACTERS_LEFT#}");
				updateBox.fadeIn(1200);
				as.parent().height(as.parent().height());
				as.val('{!activities:TYPE_HERE;}');
				as.fadeIn(1200, function () { as.parent().height(''); });

			}); });
		}
	} else {
		var errText="{!activities:WENT_WRONG#}";
		updateBox.attr('class', '').addClass('update_error').text(errText);
		updateBox.hide();
		updateBox.fadeIn(1200, function () { updateBox.delay(2400).fadeOut(1200, function () {
			sUpdateCount(null);
			updateBox.fadeIn(1200);
		}); });
	}
}
