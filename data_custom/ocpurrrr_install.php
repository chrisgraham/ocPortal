<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

// FIX PATH
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=str_replace('\\\\','\\',$FILE_BASE);
if (substr($FILE_BASE,-4)=='.php')
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
}
if (!is_file($FILE_BASE.'/sources/global.php'))
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$RELATIVE_PATH=substr($FILE_BASE,(($a>$b)?$a:$b)+1);
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.chr(10).'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

require_code('database_action');
require_code('config2');
require_code('menus2');

add_iotds('data_custom/lolcats/funny-pictures-cat-has-trophy-wife.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-has-trophy-wife.jpg','TROPHY WIFE','TROPHY WIFE','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-is-on-steroids.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-is-on-steroids.jpg','STREROIDS','STREROIDS','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-is-a-hoarder.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-is-a-hoarder.jpg','Tonight on A&E','Tonight on A&E','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-winks-at-you.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-winks-at-you.jpg','Hey there','Hey there','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-does-not-see-your-point.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-does-not-see-your-point.jpg','…your point?','…your point?','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-asks-you-to-pay-fine.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-asks-you-to-pay-fine.jpg','just pay the fine','just pay the fine','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-is-a-people-lady.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-is-a-people-lady.jpg','Walter never showed up ...','Walter never showed up ...','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-looks-like-a-vase.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-looks-like-a-vase.jpg','Feline Dynasty','Feline Dynasty','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-can-poop-rainbows.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-can-poop-rainbows.jpg','And I can poop dem too ...','And I can poop dem too ...','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-does-math.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-does-math.jpg','You and your wife have 16 kittens ...','You and your wife have 16 kittens ...','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-kittens-dispose-of-boyfriend.jpg','data_custom/lolcats/thumbs/funny-pictures-kittens-dispose-of-boyfriend.jpg','Itteh Bitteh Kitteh Boyfriend Disposal Committeh','Itteh Bitteh Kitteh Boyfriend Disposal Committeh','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-has-had-fun.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-has-had-fun.jpg','Now DAT','Now DAT','',0,0,0,1);
add_iotds('data_custom/lolcats/funny-pictures-kitten-tries-to-stay-neutral.jpg','data_custom/lolcats/thumbs/funny-pictures-kitten-tries-to-stay-neutral.jpg','Mah bottom is twyin to take ovuh','Mah bottom is twyin to take ovuh','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-decides-what-to-do.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-decides-what-to-do.jpg','Crap! Here he comes…!','Crap! Here he comes…!','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-looks-like-boots.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-looks-like-boots.jpg','GET GLASSES!','GET GLASSES!','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cats-have-war.jpg','data_custom/lolcats/thumbs/funny-pictures-cats-have-war.jpg','How wars start.','How wars start.','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-is-stuck-in-drawer.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-is-stuck-in-drawer.jpg','Dog can\'t take a joke.','Dog can\'t take a joke.','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-kitten-drops-a-nickel-under-couch.jpg','data_custom/lolcats/thumbs/funny-pictures-kitten-drops-a-nickel-under-couch.jpg','I drop a nikel under der.','I drop a nikel under der.','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-asks-you-for-a-favor.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-asks-you-for-a-favor.jpg','Do me a favor','Do me a favor','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-kitten-fixes-puppy.jpg','data_custom/lolcats/thumbs/funny-pictures-kitten-fixes-puppy.jpg','I fix puppy so now he listen.','I fix puppy so now he listen.','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-is-very-comfortable.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-is-very-comfortable.jpg','i is sooooooooo comfurbals…','i is sooooooooo comfurbals…','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-kitten-ends-meeting2.jpg','data_custom/lolcats/thumbs/funny-pictures-kitten-ends-meeting2.jpg','This meeting is over.','This meeting is over.','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cats-are-in-a-musical.jpg','data_custom/lolcats/thumbs/funny-pictures-cats-are-in-a-musical.jpg','When you\'re a cat ...','When you\'re a cat ...','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-hates-your-tablecloth.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-hates-your-tablecloth.jpg','No, thanks.','No, thanks.','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-eyes-steak.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-eyes-steak.jpg','is it dun yet?','is it dun yet?','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-basement-cat-has-pink-sheets.jpg','data_custom/lolcats/thumbs/funny-pictures-basement-cat-has-pink-sheets.jpg','PINK??!','PINK??!','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-kittens-yell-at-eachother.jpg','data_custom/lolcats/thumbs/funny-pictures-kittens-yell-at-eachother.jpg','WAIT YOUR TURN!','WAIT YOUR TURN!','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-sits-in-box.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-sits-in-box.jpg','Sittin in ur mails','Sittin in ur mails','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-has-a-beatle.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-has-a-beatle.jpg','GEORGE','GEORGE','',0,0,0,1);
add_iotds('data_custom/lolcats/funny-pictures-cat-sits-on-your-laptop.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-sits-on-your-laptop.jpg','Rebutting ...','Rebutting ...','',0,0,0,1);
add_iotds('data_custom/lolcats/funny-pictures-cat-has-a-close-encounter.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-has-a-close-encounter.jpg','CLOSE  ENCOUNTRES …','CLOSE  ENCOUNTRES …','',0,0,0,0);
add_iotds('data_custom/lolcats/ridiculous_poses_moddles.jpg','data_custom/lolcats/thumbs/ridiculous_poses_moddles.jpg','Ridiculous poses','Ridiculous poses','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-is-a-doctor.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-is-a-doctor.jpg','Dr. House cat…','Dr. House cat…','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-pounces-on-deer.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-pounces-on-deer.jpg','National Geographic','National Geographic','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-fish-and-cat-judge-your-outfit.jpg','data_custom/lolcats/thumbs/funny-pictures-fish-and-cat-judge-your-outfit.jpg','Bad outfit','Bad outfit','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-comes-to-save-day.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-comes-to-save-day.jpg','Here I come to save the day!!','Here I come to save the day!!','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-ok-captain-obvious.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-ok-captain-obvious.jpg','Okay, Captain Obvious','Okay, Captain Obvious','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-kermit-was-about.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-kermit-was-about.jpg','Kermit makes a discovery','Kermit makes a discovery','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-ai-calld-jenny-craig.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-ai-calld-jenny-craig.jpg','Jenny Craig','Jenny Craig','',0,0,0,0);
add_iotds('data_custom/lolcats/funny-pictures-cat-special-delivery.jpg','data_custom/lolcats/thumbs/funny-pictures-cat-special-delivery.jpg','Special Delivery','Special Delivery','',0,0,0,0);


function add_iotds($url='',$thumb_url='',$title='',$caption='',$notes='',$allow_rating=0,$allow_comments=0,$allow_trackbacks=0,$current=0)
{
	require_lang('iotds');
	require_code('iotds');
	require_css('iotds');
	require_code('uploads');
	require_code('images');

	add_iotd($url,$title,$caption,$thumb_url,$current,$allow_rating,$allow_comments,$allow_trackbacks,$notes);
}

echo 'Installed';
