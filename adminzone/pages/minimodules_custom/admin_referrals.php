<?php

require_lang('referrals');

$title=get_screen_title('REFERRALS');

$title->evaluate_echo();

require_code('referrals');
$table=referrer_report_script(true);

$table->evaluate_echo();
