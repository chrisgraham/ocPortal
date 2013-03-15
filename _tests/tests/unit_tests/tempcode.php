<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unit_testing
 */

/**
 * ocPortal test case class (unit testing).
 */
class tempcode_test_set extends ocp_test_case
{
	function testTempcode()
	{
		$nonempty=paragraph('ignore');
		$tpl=do_template('tempcode_test',array('EMPTY1'=>'','EMPTY2'=>new ocp_tempcode(),'NONEMPTY'=>$nonempty,'PASSED'=>'This is a passed parameter','SIMPLE_ARRAY'=>array('1','2','3'),'ARRAY'=>array(array('a'=>'A1','b'=>'B1','c'=>'C1'),array('a'=>'A2','b'=>'B2','c'=>'C2'),array('a'=>'A3','b'=>'B3','c'=>'C3'),array('a'=>'A4','b'=>'B4','c'=>'C4'))));
		$got=$tpl->evaluate();
		$expected='<h1>Tempcode tests</h1>

<h2>Escaping</h2>

<p>
	\\\'Hello\\\'
</p>
<p>
	\"Hello\"
</p>
<p>
	Hello World
</p>
<p>
	Hello\n World
</p>
<p>
	\[html]
</p>
<p>
	foo%3Dbar
</p>
<!--
<p>
	<strong>Test<\/strong></strong>
</p>
-->
<h2>Environmental variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>$MOBILE</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$OCF</td>
		<td>1</td>
	</tr>
</tbody></table>

<h2>Computational variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>$CYCLE,my_cycle,1,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$CYCLE,my_cycle,1,2</td>
		<td>2</td>
	</tr>
	<tr>
		<td>$CYCLE,my_cycle,1,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$FROM_TIMESTAMP,Y-m-d,33424322</td>
		<td>1971-01-22</td>
	</tr>
	<tr>
		<td>$IS_NON_EMPTY,</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$IS_NON_EMPTY,a</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$IS_EMPTY,</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$IS_EMPTY,a</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$NEGATE,3</td>
		<td>-3</td>
	</tr>
	<tr>
		<td>$OBFUSCATE,chris@ocportal.com (check HTML source to see if it is obfuscated)</td>
		<td>&#99;&#x68;&#114;&#x69;&#115;&#x40;&#111;&#x63;&#112;&#x6f;&#114;&#x74;&#97;&#x6c;&#46;&#x63;&#111;&#x6d;</td>
	</tr>
	<tr>
		<td>$FIX_ID,3+2</td>
		<td>3_plus_2</td>
	</tr>
	<tr>
		<td>$GET,foobar</td>
		<td></td>
	</tr>
</tbody></table>

<h2>Array variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>+COUNT,SIMPLE_ARRAY</td>
		<td>3</td>
	</tr>
	<tr>
		<td>+IMPLODE, ,SIMPLE_ARRAY</td>
		<td>1 2 3</td>
	</tr>
	<tr>
		<td>+OF,SIMPLE_ARRAY,1</td>
		<td>2</td>
	</tr>
</tbody></table>

<h2>String variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>$WCASE,I am a Mushroom</td>
		<td>I Am A Mushroom</td>
	</tr>
	<tr>
		<td>$LCASE,I am a Mushroom</td>
		<td>i am a mushroom</td>
	</tr>
	<tr>
		<td>$UCASE,I am a Mushroom</td>
		<td>I AM A MUSHROOM</td>
	</tr>
	<tr>
		<td>$REPLACE,a,b,apple</td>
		<td>bpple</td>
	</tr>
	<tr>
		<td>$AT,apple,3</td>
		<td>l</td>
	</tr>
	<tr>
		<td>$SUBSTR,apple,1,2</td>
		<td>pp</td>
	</tr>
	<tr>
		<td>$LENGTH,apple</td>
		<td>5</td>
	</tr>
	<tr>
		<td>$WORDWRAP,i love to eat cheese,5</td>
		<td>i<br />love<br />to<br />eat<br />cheese</td>
	</tr>
	<tr>
		<td>$TRUNCATE_LEFT,i love to eat cheese,5</td>
		<td>i&hellip;</td>
	</tr>
	<tr>
		<td>$TRUNCATE_RIGHT,i love to eat cheese,5</td>
		<td>&hellip;t cheese</td>
	</tr>
	<tr>
		<td>$TRUNCATE_SPREAD,i love to eat cheese,5</td>
		<td>i&hellip;se</td>
	</tr>
	<tr>
		<td>$ESCAPE,Bill &amp; Julie,ENTITY_ESCAPED</td>
		<td>Bill &amp; Julie</td>
	</tr>
</tbody></table>

<h2>Arithmetical variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>$MULT,2,3</td>
		<td>6</td>
	</tr>
	<tr>
		<td>$ROUND,3.23,1</td>
		<td>3.2</td>
	</tr>
	<tr>
		<td>$MAX,3,2</td>
		<td>3</td>
	</tr>
	<tr>
		<td>$MIN,3,2</td>
		<td>2</td>
	</tr>
	<tr>
		<td>$MOD,-2</td>
		<td>2</td>
	</tr>
	<tr>
		<td>$MOD,2</td>
		<td>2</td>
	</tr>
	<tr>
		<td>$REM,3,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$DIV,3,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$SUBTRACT,3,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$ADD,3,2</td>
		<td>5</td>
	</tr>
</tbody></table>

<h2>Logical variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>$NOT,1</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$OR,1,0</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$OR,0,0</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$AND,1,0</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$AND,1,1</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$EQ,3,3</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$EQ,3,2</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$NEQ,3,3</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$NEQ,3,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$LT,1,2</td>
		<td>1</td>
	</tr>
	<tr>
		<td>$LT,2,1</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$GT,1,2</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$GT,2,1</td>
		<td>1</td>
	</tr>
</tbody></table>

<h2>Variable variables</h2>

<table summary="Table with headers in left column and values or settings in right column"><tbody>
	<tr>
		<td>$ISSET,test</td>
		<td>0</td>
	</tr>
	<tr>
		<td>$INIT,test,2</td>
		<td></td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>2</td>
	</tr>
	<tr>
		<td>$INIT,test,3</td>
		<td></td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>2</td>
	</tr>
	<tr>
		<td>$SET,test,3</td>
		<td></td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>3</td>
	</tr>
	<tr>
		<td>$INC,test</td>
		<td></td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>4</td>
	</tr>
	<tr>
		<td>$DEC,test</td>
		<td></td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>3</td>
	</tr>
	<tr>
		<td>$ISSET,test</td>
		<td>1</td>
	</tr>
</tbody></table>

<p>
	Putting #anchor onto URL should cause jump to here.<a id="anchor"></a>
</p>

<h2>Directives</h2>


	<p>
		IF_PASSED true positive (good)
	</p>




	<p>
		IF_PASSED true negative (good)
	</p>



	<p>
		IF_EMPTY true positive (string) (good)
	</p>




	<p>
		IF_EMPTY false negative (tempcode) (good)
	</p>




	<p>
		NOT Adjacent to own codenamed template (but adjacent/under something)
	</p>


bar


	<p>
		IF true positive (good)
	</p>



{$BASE_URL}







	<p>
		Should see this text 3 times.

	</p>

	<p>
		Should see this text 3 times.

	</p>

	<p>
		Should see this text 3 times.

	</p>


<table><tbody>
<tr>
	<td>
		  
	</td>

	<td>
		  
	</td>
</tr><tr>
	<td>
		  
	</td>

	<td>
		  
	</td>
</tr>
</tbody></table>';
		$ok=preg_replace('#\s#','',$got)==preg_replace('#\s#','',$expected);
		$this->assertTrue($ok);
		if (!$ok)
		{
			require_code('diff');
			echo diff_simple_2($got,$expected,true);
		}
	}
}
