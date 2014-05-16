<!DOCTYPE html>

<html lang="{$LCASE*,{$LANG}}" dir="{!dir}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset={$CHARSET*}" />
		<meta name="GENERATOR" content="ocPortal" />
		<meta name="description" content="ocPortal installer" />
		<link rel="icon" href="http://ocportal.com/favicon.ico" type="image/x-icon" />
		<link href="{CSS_URL*}" rel="stylesheet" type="text/css" />
		<link href="{CSS_URL_2*}" rel="stylesheet" type="text/css" />
		<style type="text/css">
			{CSS_NOCACHE*}
		</style>
		<title>{!INSTALLER,ocPortal}</title>

		<meta name="robots" content="noindex, nofollow" />

		<script type="text/javascript">// <![CDATA[
			function install_stage_load()
			{
				//set_cookie('js_on',1,120);

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

				if (!check_password(form)) return false;

				if ((form.elements['db_site_password']) && (window.do_ajax_field_test))
				{
					var url='install.php?type=ajax_db_details&db_type='+form.elements['db_type'].value+'&db_site_host='+form.elements['db_site_host'].value+'&db_site='+form.elements['db_site'].value+'&db_site_user='+form.elements['db_site_user'].value+'&db_site_password='+form.elements['db_site_password'].value;
					if (!do_ajax_field_test(url)) return false;
				}

				if ((form.elements['db_forums_password']) && (window.do_ajax_field_test))
				{
					var url='install.php?type=ajax_db_details&db_type='+form.elements['db_type'].value+'&db_forums_host='+form.elements['db_forums_host'].value+'&db_forums='+form.elements['db_forums'].value+'&db_forums_user='+form.elements['db_forums_user'].value+'&db_forums_password='+form.elements['db_forums_password'].value;
					if (!do_ajax_field_test(url)) return false;
				}

				if ((form.elements['ftp_domain']) && (window.do_ajax_field_test))
				{
					var url='install.php?type=ajax_ftp_details&ftp_domain='+form.elements['ftp_domain'].value+'&ftp_folder='+form.elements['ftp_folder'].value+'&ftp_username='+form.elements['ftp_username'].value+'&ftp_password='+form.elements['ftp_password'].value;
					if (!do_ajax_field_test(url)) return false;
				}

				return true;
			}

			// By Netscape
			function set_cookie(cookieName,cookieValue,nDays)
			{
				var today=new Date();
				var expire=new Date();
				if (nDays==null || nDays==0) nDays=1;
				expire.setTime(today.getTime()+3600000*24*nDays);
				document.cookie=cookieName+"="+escape(cookieValue)+";expires="+expire.toUTCString();
			}

			function do_forum_choose(object,versions)
			{
				set_inner_html(document.getElementById('versions'),versions);

				var type='none';
				if ((object.id!='none') && (object.id!='ocf'))
				{
					type='block';
					var label=document.getElementById('sep_forum');
					if (label) set_inner_html(label,object.nextSibling.nodeValue);
				}

				document.getElementById('forum_path').style.display=type;
			}

			function toggle_section(id)
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

			function check_password(form)
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

	<body id="installer_body" class="website_body" onload="install_stage_load();">
		<div class="installer_main">
			<img alt="ocPortal" src="{LOGO_URL*}" width="324" height="89" />
		</div>

		<script type="text/javascript">// <![CDATA[
			window.setTimeout(function() {
				if (window.alert===null)
				{
					/* Parser hint: .innerHTML okay */
					document.getElementById('extra_errors').innerHTML='<p class="installer_warning"><strong class="popup_blocker_warning">Your popup blocker is too aggressive<\/strong> (even error alerts cannot display). Please disable for the installer.<\/p>';
				}
			}, 0);
		//]]></script>

		<div class="installer_main_inner">
			<div class="box box___installer_html_wrap"><div class="box_inner">
				<h1>{!INSTALLER,ocPortal}: {!INSTALLER_STEP,{STEP},10}</h1>

				<div id="extra_errors"></div>

				{CONTENT}
			</div></div>
		</div>

		<div class="installer_version">
			<p>
				{!VERSION_NUM,{VERSION}}
				<br />
				ocPortal, {!CREATED_BY,ocProducts}
			</p>
			<p>
				<a target="_blank" title="ocPortal.com {!LINK_NEW_WINDOW}" href="http://ocportal.com">http://ocportal.com</a>
			</p>
		</div>
	</body>
</html>

