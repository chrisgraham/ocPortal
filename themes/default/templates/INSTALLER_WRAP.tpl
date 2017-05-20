<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$LANG*}" lang="{$LANG*}">
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta name="GENERATOR" content="ocPortal" />
		<meta name="description" content="ocPortal installer" />
		<meta name="language" content="{$LANG*}" />
		<link rel="icon" href="http://ocportal.com/favicon.ico" type="image/x-icon" />
		<link href="{CSS_URL*}" rel="stylesheet" type="text/css" />
		<link href="{CSS_URL_2*}" rel="stylesheet" type="text/css" />
		<style type="text/css">
			{CSS_NOCACHE*}
		</style>
		<title>{!INSTALLER,ocPortal}</title>

		<meta name="robots" content="noindex, nofollow" />

		<script type="text/javascript">// <![CDATA[
			function installStageLoad()
			{
				//SetCookie('js_on',1,120);

				var none=document.getElementById('{DEFAULT_FORUM;}');
				if (none) none.checked=true;

				if (('{DEFAULT_FORUM;}'!='none') && ('{DEFAULT_FORUM;}'!='ocf'))
				{
					var d=document.getElementById('forum_path');
					if (d) d.style.display='block';
				}

				var forms=document.getElementsByTagName('form');
				if (typeof forms[0]!='undefined') forms[0].title='';
			}

			function submit_settings(form)
			{
				if ((form.elements['board_prefix']) && (form.elements['board_prefix'].type!='hidden') && (form.elements['board_prefix'].value==form.elements['base_url'].value))
				{
					window.alert('{!FORUM_BASE_URL_INVALID;}');
					return false;
				}
				if ((form.elements['board_prefix']) && (form.elements['board_prefix'].type!='hidden') && (form.elements['board_prefix'].value.substr(-7)=='/forums') && (!form.elements['board_prefix'].changed))
				{
					if (!window.confirm('{!FORUM_BASE_URL_UNCHANGED;}')) return false;
				}

				var i;
				for (i=0;i<form.elements.length;i++)
				{
					if ((form.elements[i].className.indexOf('required1')!=-1) && (form.elements[i].value==''))
					{
						window.alert('{!IMPROPERLY_FILLED_IN;}');
						return false;
					}
				}

				if (!checkPassword(form)) return false;

				if ((form.elements['db_site_password']) && (window.do_ajax_field_test))
				{
					var url='install.php?type=ajax_db_details';
					var post='db_type='+window.encodeURIComponent(form.elements['db_type'].value)+'&db_site_host='+window.encodeURIComponent(form.elements['db_site_host'].value)+'&db_site='+window.encodeURIComponent(form.elements['db_site'].value)+'&db_site_user='+window.encodeURIComponent(form.elements['db_site_user'].value)+'&db_site_password='+window.encodeURIComponent(form.elements['db_site_password'].value);
					if (!do_ajax_field_test(url,post)) return false;
				}

				if ((form.elements['db_forums_password']) && (window.do_ajax_field_test))
				{
					var url='install.php?type=ajax_db_details';
					var post='db_type='+window.encodeURIComponent(form.elements['db_type'].value)+'&db_forums_host='+window.encodeURIComponent(form.elements['db_forums_host'].value)+'&db_forums='+window.encodeURIComponent(form.elements['db_forums'].value)+'&db_forums_user='+window.encodeURIComponent(form.elements['db_forums_user'].value)+'&db_forums_password='+window.encodeURIComponent(form.elements['db_forums_password'].value);
					if (!do_ajax_field_test(url,post)) return false;
				}

				if ((form.elements['ftp_domain']) && (window.do_ajax_field_test))
				{
					var url='install.php?type=ajax_ftp_details';
					var post='ftp_domain='+window.encodeURIComponent(form.elements['ftp_domain'].value)+'&ftp_folder='+window.encodeURIComponent(form.elements['ftp_folder'].value)+'&ftp_username='+window.encodeURIComponent(form.elements['ftp_username'].value)+'&ftp_password='+window.encodeURIComponent(form.elements['ftp_password'].value);
					if (!do_ajax_field_test(url,post)) return false;
				}

				return true;
			}

			// By Netscape
			function SetCookie(cookieName,cookieValue,nDays)
			{
				var today=new Date();
				var expire=new Date();
				if (nDays==null || nDays==0) nDays=1;
				expire.setTime(today.getTime()+3600000*24*nDays);
				document.cookie=cookieName+"="+escape(cookieValue)+";expires="+expire.toUTCString();
			}

			function doForumChoose(object,versions)
			{
				setInnerHTML(document.getElementById('versions'),versions);

				var type='none';
				if ((object.id!='none') && (object.id!='ocf'))
				{
					type='block';
					var label=document.getElementById('sep_forum');
					if (label) setInnerHTML(label,object.nextSibling.nodeValue);
				}

				document.getElementById('forum_path').style.display=type;
			}

			function toggleSection(id)
			{
				// Try and grab our item
				var itm=document.getElementById(id);
				var img=document.getElementById('img_'+id);

				if (itm.style.display=='none')
				{
					itm.style.display='block';
					if (img) img.src='{$BASE_URL;}/install.php?type=contract';
				} else
				{
					itm.style.display='none';
					if (img) img.src='{$BASE_URL;}/install.php?type=expand';
				}
			}

			function checkPassword(form)
			{
				if ((typeof form.confirm!='undefined') && (form.confirm)) return true;

				if (typeof form.elements['ocf_admin_password_confirm']!='undefined')
				{
					if (form.elements['ocf_admin_password_confirm'].value!=form.elements['ocf_admin_password'].value)
					{
						window.alert('{!PASSWORDS_DO_NOT_MATCH;}');
						return false;
					}
				}
				if (typeof form.elements['admin_password_confirm']!='undefined')
				{
					if (form.elements['admin_password_confirm'].value!=form.elements['admin_password'].value)
					{
						window.alert('{!PASSWORDS_DO_NOT_MATCH;}');
						return false;
					}
				}

				window.alert('{PASSWORD_PROMPT;}','');

				if (form.elements['admin_password'].value.length<5)
				{
					return window.confirm('{!ADMIN_PASSWORD_INSECURE;}');
				}
				return true;
			}
		//]]></script>
	</head>

	<body id="installer_body" class="re_body" onload="installStageLoad();">
		<div class="installer_main">
			<img title="" alt="ocPortal" src="{LOGO_URL*}" />
		</div>
		<br class="tiny_linebreak" />

		<script type="text/javascript">// <![CDATA[
		window.setTimeout(function() {
			if (window.alert===null)
			{
				document.getElementById('extra_errors').innerHTML='<p><strong style="color: red">Your popup blocker is too aggressive<\/strong> (even error alerts cannot display). Please disable for the installer.<\/p>';
			}
		}, 0);
		//]]></script>

		<div class="installer_main_internal">
			{+START,BOX,{!INSTALLER,ocPortal}: {!INSTALLER_STEP,{STEP},10}}
				<div id="extra_errors"></div>

				{CONTENT}
			{+END}
		</div>

		<div class="installer_version">
			{!VERSION_NUM,{VERSION}}
			<br />
			ocPortal, {!CREATED_BY,ocProducts}<br /><br />
			<a href="http://ocportal.com">http://ocportal.com</a>
		</div>
		<br />
	</body>
</html>

