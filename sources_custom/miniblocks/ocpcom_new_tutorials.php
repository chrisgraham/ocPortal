<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

if (!function_exists('get_tutorial_info'))
{
function get_tutorial_info($tut)
{
	switch ($tut)
	{
		case 'designer_themes':
			$result=array(
				"Designer themes",
				"This tutorial is a deep-end introduction to ocPortal for web designers.",
				"Feb 2011",
				"orange",
				"Chris",
			); break;

		case 'v_google_map':
			$result=array(
				"Embedding a Google map",
				"We show you how to embed a Google map into a ocPortal-powered website.",
				"May 2009",
				"blue",
				"Allen",
			); break;

		case 'v_su':
			$result=array(
				"SU and the if_in_group tag",
				"We show you how to test your site against different users, and customise it for them.",
				"May 2009",
				"blue",
				"Allen",
			); break;

		case 'v_custom_comcode':
			$result=array(
				"Custom Comcode tags",
				"We show you how to make good use of Custom Comcode tags.",
				"May 2009",
				"blue",
				"Allen",
			); break;

		case 'v_themes101':
			$result=array(
				"Themes 101 - replacing the header",
				"We show you how to do some basic website themeing.",
				"May 2009",
				"blue",
				"Allen",
			); break;

		case 'v_themes201':
			$result=array(
				"Themes 201 - brand new themes",
				"Implement a totally fresh design.",
				"Aug 2009",
				"orange",
				"Allen",
			); break;

		case 'design':
			$result=array(
				"Introduction to web design",
				"This tutorial is an introduction to the artistic side of web design.",
				"May 2009",
				"orange",
				"Chris",
			); break;

		case 'markup':
			$result=array(
				"Intro to XHTML, CSS and Javascript",
				"This tutorial is an introduction to the main standard web technologies that ocPortal is built upon.",
				"May 2009",
				"orange",
				"Philip",
			); break;

		case 'tempcode':
			$result=array(
				"Tempcode programming",
				"You'll be shocked at how much themeing control you can muster using Tempcode. Learn all about it...",
				"Sep 2008",
				"orange",
				"Allen",
			); break;

		case 'comcode':
			$result=array(
				"Comcode and attachments",
				"Create dynamic effects and display rich media, without having to write any XHTML, CSS, or Javascript.",
				"Sep 2008",
				"blue",
			); break;

		case 'occle':
			$result=array(
				"OcCLE's True Potential",
				"Did you know you can reconfigure half your site’s systems in a few easy keystrokes? We explore this and more...",
				"Aug 2008",
				"red",
				"Philip",
			); break;

		case 'moving':
			$result=array(
				"Moving ocPortal to a new server",
				"It's really not hard if you know how to do it. In this tutorial we move a sample install from a Windows PC to a Linux server.",
				"Aug 2008",
				"blue",
			); break;

		case 'censor':
			$result=array(
				"Dealing with annoying users",
				"Little tricks: changing their permissions via usergroups, mandating prior post approval, and how to ban them.",
				"Aug 2008",
				"blue",
			); break;

		case 'webapp':
			$result=array(
				"Web-applications, ocPortal, and PHP",
				"Background into the different kinds of solutions that are out there for creating websites - and where ocPortal fits in.",
				"Aug 2008",
				"blue",
			); break;

		case 'drinking':
			$result=array(
				"Drinking from the feature pool",
				"The thought processes required to successfully design a complex and personalised website using ocPortal.",
				"Aug 2008",
				"blue",
			); break;

		case 'browsers':
			$result=array(
				"Browser version requirements",
				"This tutorial details the browser requirements for visitors to an ocPortal site, determined by the CSS/XHTML/Javascript in our default theme.",
				"Aug 2008",
				"blue",
			); break;

		case 'domain_names':
			$result=array(
				"How domain names work",
				"A full explanation of domain names, and DNS - for agencies who need to work with previously registered domain names.",
				"Aug 2008",
				"orange",
			); break;

		case 'how_internet_works':
			$result=array(
				"How the Internet works",
				"An explanation of how the Internet works, all the way from what goes through the wires, to how meaningful activities happen.",
				"Aug 2008",
				"blue",
			); break;

		case 'email':
			$result=array(
				"Understanding and configuring e-mail",
				"Setting up e-mail servers can be complex with all the protocols/standards out there. Let's cut through the confusion.",
				"Aug 2008",
				"orange",
			); break;

		case 'web_hosting':
			$result=array(
				"Web hosting for ocPortal",
				"An overview of how the web hosting industry works, and the general requirements and compatibility for ocPortal.",
				"Aug 2008",
				"blue",
			); break;

		case 'install':
			$result=array(
				"Basic Installation",
				"We explain what you need to do to install ocPortal. This tutorial is particularly important if you use the manual installer.",
				"Aug 2008",
				"blue",
				"Allen",
			); break;

		case 'adv_installation':
			$result=array(
				"Advanced installation",
				"This tutorial covers advanced installation issues which most users do not need to be concerned with.",
				"Aug 2008",
				"orange",
			); break;

		case 'windows':
			$result=array(
				"Using Windows as a server",
				"How to get an ocPortal installation running on your own Windows computer, if you choose to use that as your server.",
				"Aug 2008",
				"blue",
			); break;

		case 'configuration':
			$result=array(
				"Basic configuration",
				"Once ocPortal is installed, there is some basic configuration to do before your website is ready to open. We discuss it here.",
				"Aug 2008",
				"blue",
			); break;

		case 'importer':
			$result=array(
				"Importing data into ocPortal",
				"How to switch to ocPortal from other software. We discuss how it's done, and some specifics for various different products.",
				"Aug 2008",
				"blue",
			); break;

		case 'nuances':
			$result=array(
				"Nuances of forum integration",
				"ocPortal supports integration with a number of forum systems through our forum driver system. We discuss any issues here.",
				"Aug 2008",
				"blue",
			); break;

		case 'structure':
			$result=array(
				"ocPortal site structure",
				"An explanation of the ocPortal systems that together form the structure and navigation for ocPortal-powered websites.",
				"Aug 2008",
				"blue",
			); break;

		case 'adminzone':
			$result=array(
				"Admin Zone overview",
				"An explanation of how to use the Admin Zone, and the special features available from the Admin Zone front page.",
				"Aug 2008",
				"blue",
				"Allen",
			); break;

		case 'menus':
			$result=array(
				"Customising what's on the menus",
				"All about ocPortal's menu system. Did you know you can set up and configure as many different levels of navigation as you like?",
				"Aug 2008",
				"blue",
			); break;

		case 'wysiwyg':
			$result=array(
				"WYSIWYG editing",
				"This tutorial provides some advanced information on the WYSIWYG editor, for those wanting to push it to the limit.",
				"Aug 2008",
				"orange",
			); break;

		case 'adv_comcode_pages':
			$result=array(
				"Advanced Comcode pages",
				"How to add dynamism and inline content to your pages, using blocks; and multimedia, using attachments.",
				"Aug 2008",
				"blue",
			); break;

		case 'adv_comcode':
			$result=array(
				"Advanced Comcode",
				"Some of the more advanced aspects of the Comcode system explained, for those who already know the basics.",
				"Aug 2008",
				"orange",
			); break;

		case 'comcode_pages':
			$result=array(
				"Custom pages of information",
				"How to add new pages, using Comcode. It couldn't be simpler to do: Comcode pages almost look like plain text.",
				"Aug 2008",
				"blue",
			); break;

		case 'cleanup':
			$result=array(
				"Cleanup tools",
				"Been editing files manually, and need to force ocPortal to \"empty its caches\"? We show you how.",
				"Aug 2008",
				"orange",
			); break;

		case 'staff':
			$result=array(
				"The staff/member divide",
				"A discussion on the features ocPortal provides for members, and for staff - and how permissions divide them.",
				"Aug 2008",
				"blue",
			); break;

		case 'permissions':
			$result=array(
				"Access control and privileges",
				"A detailed explanation of how you can configure permissions, how to test them, and how to manage them.",
				"Aug 2008",
				"blue",
				"Philip",
			); break;

		case 'chmod':
			$result=array(
				"Linux file permissions",
				"The theory behind the permissions ocPortal needs on most web hosts, and practical guidance on setting them.",
				"Aug 2008",
				"blue",
			); break;

		case 'sql':
			$result=array(
				"Manually editing your database",
				"A primer on databases, and how SQL is used to connect to them - as well as practical advice on using phpMyAdmin.",
				"Aug 2008",
				"orange",
			); break;

		case 'seo':
			$result=array(
				"Improving your search engine rank",
				"For most web sites, it is important to draw in visitors. We discuss the process of Search Engine Optimisation (SEO).",
				"Aug 2008",
				"blue",
			); break;

		case 'subcom':
			$result=array(
				"Creating sub-communities/sub-sites",
				"A common features of the largest community sites is to have sub-communities within the larger community. See how.",
				"Aug 2008",
				"orange",
			); break;

		case 'backup':
			$result=array(
				"Backing up your site",
				"How to backup your website (be it using our backup module, or otherwise), and why it is so important to do it.",
				"Aug 2008",
				"blue",
				"Steven Gilson",
			); break;

		case 'featured':
			$result=array(
				"Providing featured content",
				"How to pull out content from your website, and put it in a featured spot. There are a number of methods available.",
				"Aug 2008",
				"blue",
			); break;

		case 'integration':
			$result=array(
				"Integrating other scripts/web-apps",
				"This tutorial will provide details on how to integrate ocPortal with another web system installed for your website.",
				"Aug 2008",
				"red",
			); break;

		case 'httpauth':
			$result=array(
				"Integrating HTTP authentication",
				"Sometimes, for integration reasons, you want users to login in to ocPortal via HTTP authentication. We show you how.",
				"Aug 2008",
				"red",
			); break;

		case 'ldap':
			$result=array(
				"Integrating with an LDAP network",
				"How to integrate ocPortal into a corporate network via LDAP (OpenLDAP, or Microsoft Active Directory).",
				"Aug 2008",
				"red",
			); break;

		case 'cookies':
			$result=array(
				"Cookie, sessions, and Javascript",
				"Want to know everything there is to know about cookies and sessions? You probably don't, but if you do, read this!",
				"Aug 2008",
				"red",
			); break;

		case 'adv_configuration':
			$result=array(
				"Advanced configuration",
				"Setting permissions. Search-Engine-Friendly URLs. Addons. Changing installation options.",
				"Aug 2008",
				"orange",
			); break;

		case 'optimisation':
			$result=array(
				"Optimising",
				"ocPortal is very heavily optimised for high performance out-of-the-box, but here are some advanced performance tips.",
				"Aug 2008",
				"red",
			); break;

		case 'intl':
			$result=array(
				"Localisation and internationalisation",
				"How to translate ocPortal into different languages, and how to configure your date/time settings.",
				"Aug 2008",
				"orange",
			); break;

		case 'intl_users':
			$result=array(
				"Translating ocPortal",
				"How to translate your (ocPortal-powered) website into different languages.",
				"Mar 2011",
				"blue",
				"Steve",
			); break;

		case 'msn':
			$result=array(
				"Advanced techniques for M.S.Ns",
				"You can link multiple installations, via a forum, into a 'multi-site-network'. Read more about it here.",
				"Aug 2008",
				"orange",
			); break;

		case 'security':
			$result=array(
				"Security",
				"Details and guidance on the advanced security protections available in ocPortal.",
				"Aug 2008",
				"red",
			); break;

		case 'filter':
			$result=array(
				"Filtering using ocFilter syntax",
				"ocFilter is our language for saying what content you would like to be matched/selected. Learn how to use it.",
				"Aug 2008",
				"orange",
			); break;

		case 'fields_filter':
			$result=array(
				"The form field filter system",
				"How power-users can apply sophisticated filters to the data that gets submitted to their website.",
				"Aug 2008",
				"red",
			); break;

		case 'uninstall':
			$result=array(
				"Uninstalling ocPortal from a server",
				"We don't want you to uninstall ocPortal, but we provide a script for you to do it with. We're that nice.",
				"Aug 2008",
				"blue",
			); break;

		case 'upgrade':
			$result=array(
				"Performing an upgrade",
				"Important background information that will help you keep your website up-to-date with the latest ocPortal.",
				"Aug 2008",
				"blue",
			); break;

		case 'disaster':
			$result=array(
				"Disaster recovery",
				"Some 'life saving' solutions to disasterous scenarios that can happen on an unstable web server configuration.",
				"Aug 2008",
				"blue",
			); break;

		case 'legal':
			$result=array(
				"Legal and social responsibilities",
				"Guidance on the legal and social issues that webmasters need to understood.",
				"Aug 2008",
				"blue",
			); break;

		case 'staff_advice':
			$result=array(
				"Advice for choosing/managing staff",
				"A short tutorial with tips for choosing staff, written for community websites run by volunteers.",
				"Aug 2008",
				"blue",
			); break;

		case 'information':
			$result=array(
				"Choosing how to publish",
				"Details on different publishing features available in ocPortal, and their advantages/disadvantages.",
				"Aug 2008",
				"blue",
			); break;

		case 'news':
			$result=array(
				"Releasing news & running a blog",
				"How to use the news system for website news, press releases, blogs, or any other kind of article.",
				"Aug 2008",
				"blue",
				"Allen",
			); break;

		case 'adv_news':
			$result=array(
				"Advanced News",
				"Details on some of the more complex features available for news, including blogging and syndication.",
				"Aug 2008",
				"orange",
			); break;

		case 'newsletter':
			$result=array(
				"Running a newsletter",
				"How to send out news bulletins to newsletter subscribers, and to members of your community.",
				"Aug 2008",
				"blue",
			); break;

		case 'downloads':
			$result=array(
				"Providing downloads",
				"You can make large files available to your visitors using the ocPortal downloads system. Read about it.",
				"Aug 2008",
				"blue",
			); break;

		case 'adv_downloads':
			$result=array(
				"Advanced provision of downloads",
				"We go through some of the advanced features in the downloads system, such as batch importing, and download selling.",
				"Aug 2008",
				"orange",
			); break;

		case 'galleries':
			$result=array(
				"Providing galleries",
				"A gallery system is provided for the storage, organisation and viewing of images and videos.  Read about it.",
				"Aug 2008",
				"blue",
			); break;

		case 'adv_galleries':
			$result=array(
				"Advanced galleries",
				"We go through some of the advanced features in the gallery system, such as batch importing, and personal galleries.",
				"Aug 2008",
				"orange",
			); break;

		case 'catalogues':
			$result=array(
				"Custom structured content",
				"The catalogue system is a bit like a visual database system such as Microsoft Access. The possibilities are endless.",
				"Aug 2008",
				"blue",
			); break;

		case 'wiki':
			$result=array(
				"Custom structured content - Wiki+",
				"The Wiki+ system is ocPortal's equivalent to a wiki, but extended with additional features.",
				"Aug 2008",
				"blue",
			); break;

		case 'calendar':
			$result=array(
				"Running a calendar/diary",
				"How to create a community calendar, or let your members maintain online diaries.",
				"Aug 2008",
				"blue",
			); break;

		case 'keymap':
			$result=array(
				"ocPortal keyboard shortcuts",
				"Many functions may be activated by key code, rather than clicking. Find out the key codes you can use in this tutorial.",
				"Aug 2008",
				"blue",
			); break;

		case 'search':
			$result=array(
				"Searching your website",
				"Find out how ocPortal's search engine can make it easy to search all the content on your website at once.",
				"Aug 2008",
				"blue",
				"Allen",
			); break;

		case 'banners':
			$result=array(
				"Running advertisements",
				"Use the banners system to run multiple advertising campaigns on your website, using multiple media profiles.",
				"Aug 2008",
				"blue",
			); break;

		case 'ecommerce':
			$result=array(
				"eCommerce",
				"Use the eCommerce system to sell things. Usergroup subscription and member invoicing are available out-of-the-box.",
				"Aug 2008",
				"red",
			); break;

		case 'feedback':
			$result=array(
				"Feedback, and user interaction",
				"ocPortal helps you create a highly interactive site, with features for user interaction/feedback at your disposal.",
				"Aug 2008",
				"blue",
			); break;

		case 'collaboration':
			$result=array(
				"Running a collaboration centre",
				"ocPortal includes many features that allow your website to function, in whole or in part, as an on-line collaboration tool.",
				"Aug 2008",
				"orange",
			); break;

		case 'chat':
			$result=array(
				"Running chatrooms",
				"ocPortal includes really cool AJAX-driven chat and instant messaging functionality. Read about the features, and see general advice.",
				"Aug 2008",
				"blue",
				"Philip",
			); break;

		case 'support_desk':
			$result=array(
				"Running a virtual support desk",
				"ocPortal can be used as an effective support desk tool. Find out what features to use for it.",
				"Aug 2008",
				"orange",
			); break;

		case 'points':
			$result=array(
				"Creating an economy/reward-system",
				"The points system allows members to earn and spend points, creating a great dynamic. Find out how it works.",
				"Aug 2008",
				"blue",
			); break;

		case 'authors':
			$result=array(
				"Authors",
				"Find out how authors are different to members, and the tools available to you to create and manage them.",
				"Aug 2008",
				"blue",
			); break;

		case 'users':
			$result=array(
				"People in their roles",
				"Find out the difference between the 12 terms we use for describing the people who interact with an ocPortal website.",
				"Aug 2008",
				"blue",
			); break;

		case 'trace':
			$result=array(
				"IP addresses and tracing users",
				"If you find a hacker, you may want to try and trace them back to a real world source. We introduce you to your toolkit.",
				"Aug 2008",
				"orange",
			); break;

		case 'statistics':
			$result=array(
				"Activity statistics for your site",
				"Find out about the different kinds of statistics/analytics that you can use to analyse your visitors.",
				"Aug 2008",
				"blue",
				"Philip",
			); break;

		case 'members':
			$result=array(
				"ocPortal member system",
				"This tutorial explains aspects of the OCF member system, including usergroups, profiles, and avatars.",
				"Aug 2008",
				"blue",
			); break;

		case 'correspondance':
			$result=array(
				"Correspondence between members",
				"How members may send each other messages (OCF only), using private topics and whispers.",
				"Aug 2008",
				"blue",
				"Philip",
			); break;

		case 'adv_members':
			$result=array(
				"Advanced ocPortal member system",
				"How to create custom profile fields, manually add members, and set up welcome emails for new members.",
				"Aug 2008",
				"orange",
			); break;

		case 'forums':
			$result=array(
				"Organising discussion forums",
				"This tutorial will explain how discussion forums work in OCF, and how best to organise them.",
				"Aug 2008",
				"blue",
			); break;

		case 'mod':
			$result=array(
				"Basic forum moderation",
				"This tutorial explains how to moderate topics and posts under OCF, and how post approval works.",
				"Aug 2008",
				"blue",
			); break;

		case 'forum_helpdesk':
			$result=array(
				"Running a forum-based helpdesk",
				"Multi-moderation, mass-moderation, and post templates - how to make your forum work for you.",
				"Aug 2008",
				"blue",
				"Philip",
			); break;

		case 'forum_tracking':
			$result=array(
				"Keeping on track of busy forums",
				"It can get hard to keep up with all the discussions if you've got an active community. See how OCF can help.",
				"Aug 2008",
				"blue",
				"Philip",
			); break;

		case 'emoticons':
			$result=array(
				"The ocPortal emoticon system",
				"Find out about all the funky-cool emoticons that come with ocPortal, and how to extinguish them or add more.",
				"Aug 2008",
				"blue",
			); break;

		case 'releasing_themes':
			$result=array(
				"Releasing a theme",
				"A short tutorial explaining how to share a theme with other ocPortal webmasters, by exporting it as an addon.",
				"Aug 2008",
				"orange",
			); break;

		case 'themes':
			$result=array(
				"Themeing your site",
				"Our key themeing tutorial - how to re-theme your site, by changing CSS, templates, and theme images.",
				"Aug 2008",
				"orange",
				"Allen",
			); break;

		case 'adv_themes':
			$result=array(
				"Specific templates and CSS classes",
				"This tutorial details some of the templates and CSS classes used by ocPortal. Learn how things work from these examples.",
				"Aug 2008",
				"orange",
				"Philip",
			); break;

		case 'fixed_width':
			$result=array(
				"How to create a fixed-width layout",
				"A very practical tutorial showing how to created a fixed-width layout, and how to change the site header.",
				"Aug 2008",
				"blue",
			); break;

		case 'accessibility':
			$result=array(
				"Helping improve site accessibility",
				"We discuss how to ensure your website remains accessible to people with disabilities (ocPortal meets WCAG out-of-the-box).",
				"Aug 2008",
				"orange",
			); break;

		case 'fringe':
			$result=array(
				"Favicons, Web fonts, Media files",
				"This tutorial will explain and detail some of the features of web technologies that are often forgotten.",
				"Aug 2008",
				"orange",
			); break;

		case 'framework':
			$result=array(
				"The ocPortal programming framework",
				"ocPortal is not just a web application, but also a programming framework. Find out how the puzzle pieces fit together.",
				"Aug 2008",
				"red",
			); break;

		case 'programming':
			$result=array(
				"Introduction to programming",
				"This huge tutorial serves as an introduction to programming, with a particular emphasis on PHP.",
				"Aug 2008",
				"red",
			); break;

		case 'hardcore_1':
			$result=array(
				"Making an addon (part 1)",
				"The first in a series of practical tutorials showing how to create addons.",
				"Aug 2008",
				"red",
			); break;

		case 'hardcore_2':
			$result=array(
				"Making an addon (part 2)",
				"The second in a series of practical tutorials showing how to create addons.",
				"Aug 2008",
				"red",
			); break;

		case 'hardcore_3':
			$result=array(
				"Making an addon (part 3)",
				"The third in a series of practical tutorials showing how to create addons.",
				"Aug 2008",
				"red",
			); break;
	}

	if (!isset($result[4])) $result[4]='Chris';

	return $result;
}
}


$tutorials=explode(',',$map['param']);
$full_mode=(@$map['view']=='full');
if ($full_mode)
{
echo <<<END
<div class="float_surrounder tutorials">
END;
}
foreach ($tutorials as $i=>$tut)
{
	if (file_exists(get_custom_file_base().'/docs/pages/comcode_custom/EN/tut_'.$tut.'.txt'))
	{
		$linktitle='Read';
		$link=static_evaluate_tempcode(build_url(array('page'=>'tut_'.$tut),'docs'));
		$javascript='';
	} elseif (file_exists(get_custom_file_base().'/uploads/website_specific/ocportal.com/video_tutorials/'.$tut.'.flv'))
	{
		$linktitle='Watch';
		$link=get_base_url().'/uploads/website_specific/ocportal.com/swf_play.php?file=video_tutorials/'.$tut.'.flv&width=1024&height=788';
		$javascript="window.open(this.href,'','width=1024,height=820,location=no,resizable=no,scrollbars=no,status=yes'); return false;";
	} elseif (file_exists(get_custom_file_base().'/uploads/website_specific/ocportal.com/video_tutorials/'.$tut.'.swf'))
	{
		$linktitle='Watch';
		$link=get_base_url().'/uploads/website_specific/ocportal.com/swf_play.php?file=video_tutorials/'.$tut.'.swf&width=1024&height=788';
		$javascript="window.open(this.href,'','width=1024,height=768,location=no,resizable=no,scrollbars=no,status=yes'); return false;";
	} else/*if (file_exists(get_custom_file_base().'/uploads/website_specific/ocportal.com/video_tutorials/'.$tut.'.mov'))*/
	{
		$linktitle='Watch';
		$link=get_base_url().'/uploads/website_specific/ocportal.com/mov_play.php?file=video_tutorials/'.$tut.'.mov';
		$javascript="window.open(this.href,'','width=1024,height=768,location=no,resizable=no,scrollbars=no,status=yes'); return false;";
	}
	list($title,$summary,$date,$colour,$author)=get_tutorial_info($tut);
	$title=escape_html($title);
	$summary=escape_html($summary);
	$date=escape_html($date);
	$img=find_theme_image('tutorial_icons/'.$tut,true);
	if (($img=='') && ($linktitle=='Watch'))
	{
		$img=find_theme_image('tutorial_icons/video',true);
	}
	if ($img=='')
	{
		$img=find_theme_image('tutorial_icons/default');
	}
	$_img=escape_html($img);

$a=($i%2==0)?'standardbox_links_panel_right':'standardbox_inner_panel_right';
$b=($i%2==0)?'standardbox_links_panel':'standardbox_inner_panel';
$_link=escape_html(is_object($link)?$link->evaluate():$link);
$_javascript=($javascript=='')?'':(' onclick="'.$javascript.'"');
$_date=escape_html($date);
$_author=escape_html($author);

if ($full_mode)
{
	$side=($i%2==0)?'l':'r';
echo <<<END
	<div class="{$side} {$colour}">
		<div class="b">
			<img src="{$_img}" alt="" />

			<div class="wt"><h4>{$title}</h4></div>

			<p class="s">{$summary}</p>
		</div>

		<p class="author">
			by {$_author}
		</p>
		<div class="wlink"><p class="link">&raquo; <a{$_javascript} title="{$title}" href="{$_link}">{$linktitle} Now</a></p></div>
	</div>
END;
} else
{
echo <<<END
	</div></div>
	<div class="{$a}"><div class="{$b}">
		<div class="tutorial"><div class="float_surrounder">
			<div style="float: right; margin-left: 5px">
				<p class="d">{$_date}</p>

				<a href="{$_link}"{$_javascript}><img src="{$_img}" alt="" /></a>
			</div>

			<p><strong>{$title}</strong></p>
			<p class="s">{$summary}</p>

			<p class="r">[ <a title="{$title}" href="{$_link}"{$_javascript}>{$linktitle}</a> ]</p>
		</div></div>
END;
}
}
if ($full_mode)
{
echo <<<END
</div>
END;
}

if (!$full_mode)
{
$i++;
$a=($i%2==0)?'standardbox_links_panel_right':'standardbox_inner_panel_right';
$b=($i%2==0)?'standardbox_links_panel':'standardbox_inner_panel';
$docs_link=build_url(array('page'=>'tutorials'),'docs');
$_docs_link=escape_html(is_object($docs_link)?$docs_link->evaluate():$docs_link);
$_seemore_img=escape_html(find_theme_image('start_button_seemore'));
echo <<<END
	</div></div>
	<div class="{$a}"><div class="{$b}">
		<div class="side_button"><a href="{$_docs_link}"><img alt="See more tutorials" src="{$_seemore_img}" /></a></div>
END;
}
