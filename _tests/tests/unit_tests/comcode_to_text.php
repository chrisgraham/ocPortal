<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class comcode_to_text_test_set extends ocp_test_case
{
	function testComcodeToText()
	{
		$text='
[title]header 1[/title]

under header 1

[title="2"]header 2[/title]

under header 2

[box="box title"]
box contents
[/box]

[b]test bold[/b]

[b]test italics[/b]

[highlight]test highlight[/highlight]

[staff_note]secret do not want[/staff_note]

[indent]blah
blah
blah[/indent]

[random a="Want" b="Do not want"]1233[/random]

[abbr="Cascading Style Sheets"]CSS[/abbr]
';
		$got=strip_comcode($text);

		$expected='
header 1
========

under header 1

header 2
========

under header 2

box title
---------

box contents

**test bold**

**test italics**

***test highlight***

      blah
      blah
      blah

Want

Cascading Style Sheets
			';
		$this->assertTrue(trim($got)==trim($expected));
	}
}
