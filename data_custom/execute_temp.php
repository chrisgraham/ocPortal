<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	require_code('attachments');
	require_code('attachments2');
	$news_article='[semihtml][font param="verdana, geneva, sans-serif" size="1.8em"][b]MEMORIES[/b][/font]<br />
<br />
<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]History is a fascinating subject, made even more so when we apply it personally.<br />
<br />
History &amp; Mystery is generally devoted to odds and ends of the human drama spanning centuries and often millennia, but today I&rsquo;d like to take it to a more recent and personal level, for myself as well as my readers.<br />
<br />
If you will permit me to do a bit of reminiscing, possibly it may jog a few pleasant and nostalgic memories of your own.<br />
<br />
I was one of the fortunate ones to have had the privilege of hearing tales of history, first hand, from a Grandfather who lived through so much of it.<br />
<br />
Born in 1875, (just 10 years after Lincoln&rsquo;s assassination), he was already into his 60&rsquo;s when I was born, and those 60 years were filled with some of the most interesting times in human history. Remember, our nation was not yet even 100 years old.<br />
<br />
As a youngster, he began supporting himself at age 16 as a lumberjack in northern Michigan, Wisconsin and Minnesota. Wielding a sixteen-pound double-bit axe from sunup to sundown introduced him to the reality of adulthood.<br />
Over time he earned his living as a farmer, a dredge operator, a deck-hand on Great Lakes ore boats and even a real estate agent during the early years of Detroit&rsquo;s growth.<br />
<br />
I clearly recall the hours spent listening to him recount what life was like in those days and during one of those fascinating conversations he said something that has stuck with me through the years.<br />
<br />
After listening to him tell of what life was like in his youth, and recounting the advances and progress made during that period, I was moved to comment, [i]&ldquo;I hope that I live long enough to witness as many historic changes as you have seen.&rdquo;[/i]<br />
His reply still echoes in my mind every day as I read of incredible new discoveries and inventions.<br />
He said, [b]&ldquo;[i]You already have, you just don&rsquo;t realize it[/i].&rdquo;[/b]<br />
<br />
It wasn&rsquo;t until years later that I began to understand the wisdom of those words.<br />
<br />
In my Grandfather&rsquo;s youth, automobiles had yet to appear across America on roads that were yet to be built. He was but a year old when Alexander Graham Bell obtained the first patent for an &quot;apparatus for transmitting vocal or other sounds telegraphically&quot;.&nbsp; Indeed a far cry from today&rsquo;s cell phones and satellite technology.[/font]<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]He was just four years old when Thomas Edison filed for U.S. patent 223,898&nbsp; for an electric lamp using &quot;a carbon filament or strip coiled and connected to platina contact wires&quot;, (the light bulb).[/font]<span style="font-family: \'times new roman\'; font-size: 14pt; mso-ansi-language: en-us; mso-bidi-language: ar-sa; mso-fareast-font-family: \'times new roman\'; mso-fareast-language: en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="display: none">&nbsp;</span></span><span style="font-family: \'times new roman\'; font-size: 14pt; mso-ansi-language: en-us; mso-bidi-language: ar-sa; mso-fareast-font-family: \'times new roman\'; mso-fareast-language: en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br />
<br />
&nbsp;[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]1[/attachment_safe][/font][/center]<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]In those days, candles or kerosene lamps supplied light for everyone except the very wealthy, who could afford gas lights.<br />
<br />
When &lsquo;Grandpa&rsquo; was 16,an eight-foot wide section of Main Street in Bellfontaine, Ohio, was paved with concrete by engineer George Bartholomew. This was the first use of concrete as a road surface in North America. This experimental section not only proved to be sturdy, [i]it still exists[/i].<br />
<br />
As I grew older, the realization that closer in time, my father had experienced similar leaps of progress without really being aware of them. Born in March 1902, my Father was approaching his second birthday when Wilbur and Orville Wright became the first human beings to experience powered flight. The flight lasted 12 seconds and covered 120 feet.[/font]<br />
<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]Before his death he would witness, live via television, man landing on the moon.[/font]<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]2[/attachment_safe][/font][/center]<br />
<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]Then I recall the words of my Grandfather regarding historic change, and I come to realize how much I have witnessed.<br />
<br />
To some of you, these things may still fit the mold of &lsquo;ancient&rsquo; history, but I&rsquo;m willing to wager that for many they will trigger a realization of just how far and how fast we have progressed.[/font]<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]The year I was born, so was the legendary DC-3, fondly called &ldquo;The Gooney Bird&rdquo;.[/font]<br />
<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]3[/attachment_safe][/font][/center]<br />
<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]The &lsquo;workhorse&rsquo; of burgeoning air travel, the DC-3 ushered practical and economical air travel to the world and, today, 76 years later, they are still flying in regularly scheduled service in some parts of the world. Amazingly, it could carry up to 32 passengers<br />
<br />
Debuting in 2005, the Airbus A380-800, is able to carry 555 passengers in a three-class configuration or up to 800 passengers in a single-class economy configuration. The cabin accommodations are beyond imagination.[/font]<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]4[/attachment_safe][/font][/center]<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]Especially when compared to the DC-3.[/font]<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]5[/attachment_safe][/font][/center]<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]Most of us, perhaps, have not had the opportunity to experience all of these advancements, but what about those changes that affects us individually?[/font]<br />
<br />
<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]Remember when transistor radios became available?[/font]<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]6[/attachment_safe][/font][/center]<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]Compare that to today&rsquo;s breed, which are the size of a credit card.<br />
<br />
Our constant companion, television has grown from:[/font]<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"][attachment_safe thumb="0" type="inline" description=""]7[/attachment_safe][/font][/center]<br />
<br />
[center][font param="verdana, geneva, sans-serif" size="1.4em"]to:<br />
[attachment_safe thumb="0" type="inline" description=""]8[/attachment_safe][/font][/center]<br />
&nbsp;[font param="verdana, geneva, sans-serif" size="1.4em"](The Seiko [b][i]Wrist Watch[/i][/b] television introduced way back in [b][i][u]1982[/u][/i][/b].)[/font]<br />
<br />
<br />
[font param="verdana, geneva, sans-serif" size="1.4em"]We&rsquo;ve gone from bulky, unmanageable paper road maps (which by the way used to be free), to a GPS unit smaller than a wallet which will pinpoint our location and instantly give us directions to any destination within a matter of a couple of feet!<br />
<br />
Still think we haven&rsquo;t made a lot of progress in [i]your[/i] lifetime?<br />
<br />
Remember the first video games like &lsquo;Pong&rsquo;? Compare that to today&rsquo;s games which are often so realistic we cannot tell them apart from live television.<br />
<br />
Aside from the material advances, what about the simple human interactions of then and now?<br />
How many of you recall being told;<br />
[i]&ldquo;Be sure to refill the ice trays, we&#39;re going to have company.&rdquo;[/i]<br />
[i]&ldquo;Don&#39;t forget to wind the clock before you go to bed.&rdquo;[/i]<br />
[i]&ldquo;Be sure and pour the cream off the top of the milk when you open the new bottle.&rdquo;[/i]<br />
[i]&ldquo;Quit jumping on the floor! I have a cake in the oven and you are going to make it fall if you don&#39;t quit!&rdquo;[/i]<br />
Or that dreaded warning,[i]&ldquo;Hush your mouth! I don&#39;t want to hear words like that! I&#39;ll wash your mouth out with soap!&rdquo;[/i]<br />
<br />
Not only have times changed - - - but we&rsquo;ve changed also. Not always for the better.<br />
<br />
In truth, [b][i]&ldquo;We&rsquo;ve come a long way baby - - but we&rsquo;ve still got a long way to go.&rdquo;[/i][/b]<br />
<br />
[i]My thanks to the many friends and readers who, through their email communications and personal contributions, inspired this journey back through time . . . Ed.[/i][/font]<br />
<br />
[/semihtml]';
	insert_lang_comcode_attachments(2,$news_article,'news','123');
}
