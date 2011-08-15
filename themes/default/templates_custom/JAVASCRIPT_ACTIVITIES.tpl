{$,<script type="text/javascript">}
/**
 * Request data for the main_activities newsfeed
 */

// Assume that our activity feed needs updating to start with
window.latest_activity = 0;

function sUpdateGetData () {
	// Lock feed updates by setting ugdCanICant to 1
	if ((++ugdCanICant)>1) {
		ugdCanICant=1;
	} else {
		// First we check whether our feed is already up to date
		jQuery.ajax({
			url: "{$BASE_URL}/data_custom/latest_activity.txt?chrome_fix="+Math.floor(Math.random()*10000),
			data: {},
			success: function (data, status, requestObject) {
				if (parseInt(data) != window.latest_activity)
				{
					// If not then remember the new value
					window.latest_activity = parseInt(data);
					
					// Now grab whatever updates are available
					var addy="{$BASE_URL;,0}/data_custom/main_activities_updater.php"+keep_stub(true);
					var listels=jQuery('li','#news_feed');

					var postVal="lastid="+listels.attr('id')+"&mode="+jQuery('#newsfeed_info').attr('mode');
					var userId=jQuery('#newsfeed_info').attr('member_id')

					if ((userId!==null) && (userId!==''))
						postVal=postVal+"&member_id="+userId;

					jQuery.ajax({
								url: addy.replace(/^http:/,window.location.protocol),
								type: 'POST',
								data: postVal,
								cache: false,
								timeout: 5000,
								success: function(data, stat) { sUpdateShow(data, stat); },
								error: function(a, stat, err) { sUpdateShow(err,  stat); }
					});
				}
				else
				{
					// Allow feed updates
					ugdCanICant = 0;
				}
			},
			dataType: "text"
		});
	}
}

/**
 * Receive and parse data for the main_activities newsfeed
 */

function sUpdateShow(data, stat) {
	if (ugdCanICant>1) {
		ugdCanICant=1;
	} else {
		var succeeded = false;

		if (stat=='success') {
			if (jQuery('success', data).text()=='1') {
				var listels=jQuery('li','#news_feed');
				var feedLen=parseInt(jQuery('feedlen', data).text());
				var oldEndId=parseInt(listels.attr('id'));
				var listText='';
				var listitems=jQuery('listitem', data);
				var i=0;

				listels.removeAttr('toFade');

				var top_of_list = document.getElementById('news_holder').firstChild;

				jQuery.each(listitems, function () {
					var this_li = document.createElement('li');
					this_li.id = jQuery(this).attr('id');
					this_li.className = "news-box lightborder";
					this_li.setAttribute('toFade', 'yes');
					top_of_list.parentNode.insertBefore(this_li, top_of_list);
					setInnerHTML(this_li,Base64.decode(jQuery(this).text()));
				});

				listels=jQuery('li','#news_feed');

				if (!news_feed_grow && listels.length > news_feed_max)
				{
					for (;i<(listels.length-news_feed_max); i++)
					{
						listels.last().remove();
					}
				}

				jQuery('#newsfeed_info').text('');
				jQuery('li[toFade="yes"]', '#news_feed').hide().fadeIn(1200);
				succeeded = true;
			}
			else
			{
				if (jQuery('success', data).text()=='2') {
					jQuery('#newsfeed_info').text('');
					succeeded = true;
				}
			}
		}
		if ((succeeded===false)) {
			jQuery('#newsfeed_info').text('Error reading news feed');
		}
		ugdCanICant = 0;
	}
}

function sUpdateRemove (evt) {
	if (confirm('{!main_activities:DELETE_CONFIRM}')) {
		var addy="{$BASE_URL;,0}/data_custom/main_activities_removal.php"+keep_stub(true);
		jQuery.ajax({
				url: addy.replace(/^http:/,window.location.protocol),
				type: 'POST',
				data: jQuery(this).serialize(),
				cache: false,
				timeout: 5000,
				success: function(data, stat) { sUpdateRmShow(data, stat); },
				error: function(a, stat, err) { sUpdateRmShow(err,  stat); }
		});
	}
	evt.preventDefault();
}

function sUpdateRmShow(data, stat) {
	var succeeded = false;
	var status_id='';

	var velocifero=1600;

	if (stat=='success') {
		if (jQuery('success', data).text()=='1') {
			status_id = '#'+jQuery('status_id', data).text();
			jQuery('.news-content', status_id, '#news_feed').text(jQuery('feedback', data).text()).attr('style', 'color: #00CBF6;').hide().fadeIn(velocifero, function () {
				jQuery(status_id, '#news_feed').fadeOut(velocifero, function() {
					jQuery(status_id, '#news_feed').remove();
				});
			});
		} else {
			switch (jQuery('err', data).text()) {
				case 'perms':
					status_id = '#'+jQuery('status_id', data).text();
					var savetext=jQuery('news-content', status_id, '#news_feed').text();
					jQuery('.news-content', status_id, '#news_feed').text(jQuery('feedback', data).text()).attr('style', 'color: #FF0000;').hide().fadeIn(velocifero, function () {
						jQuery('.news-content', status_id, '#news_feed').fadeOut( velocifero, function () {
							jQuery('.news-content', status_id, '#news_feed').text(savetext).removeAttr('style').fadeIn(velocifero);
						});
					});
					break;
				case 'missing':
				default:
					break;
			}
		}
	} else {
	}
}

/*String.trim() is not native in all browsers*/
if (typeof String.prototype.trim !== 'function') {
	String.prototype.trim = function() {
		return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
}

if (typeof Array.prototype.indexOf !== 'function') {
	Array.prototype.indexOf = function(obj) {
		for(var i=0; i<this.length; i++) {
			if(this[i]==obj)
				return i;
		}
		return -1;
	}
}

{$,</script>}