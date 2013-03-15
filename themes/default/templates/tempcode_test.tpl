<h1>Tempcode tests</h1>

<h2>Escaping</h2>

<p>
	{$ESCAPE,'Hello',SQ_ESCAPED}
</p>
<p>
	{$ESCAPE,"Hello",DQ_ESCAPED}
</p>
<p>
	{$ESCAPE,Hello
 World,NL_ESCAPED}
</p>
<p>
	{$ESCAPE,Hello
 World,NL2_ESCAPED}
</p>
<p>
	{$ESCAPE,[html],CC_ESCAPED}
</p>
<p>
	{$ESCAPE,foo=bar,UL_ESCAPED}
</p>
<!--
<p>
	{$ESCAPE,<strong>Test</strong>,JSHTML_ESCAPED}</strong>
</p>
-->
<h2>Environmental variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>$MOBILE</td>
		<td>{$MOBILE}</td>
	</tr>
	<tr>
		<td>$OCF</td>
		<td>{$OCF}</td>
	</tr>
</tbody></table>

<h2>Computational variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>$CYCLE,my_cycle,1,2</td>
		<td>{$CYCLE,my_cycle,1,2}</td>
	</tr>
	<tr>
		<td>$CYCLE,my_cycle,1,2</td>
		<td>{$CYCLE,my_cycle,1,2}</td>
	</tr>
	<tr>
		<td>$CYCLE,my_cycle,1,2</td>
		<td>{$CYCLE,my_cycle,1,2}</td>
	</tr>
	<tr>
		<td>$FROM_TIMESTAMP,Y-m-d,33424322</td>
		<td>{$FROM_TIMESTAMP,Y-m-d,33424322}</td>
	</tr>
	<tr>
		<td>$IS_NON_EMPTY,</td>
		<td>{$IS_NON_EMPTY,}</td>
	</tr>
	<tr>
		<td>$IS_NON_EMPTY,a</td>
		<td>{$IS_NON_EMPTY,a}</td>
	</tr>
	<tr>
		<td>$IS_EMPTY,</td>
		<td>{$IS_EMPTY,}</td>
	</tr>
	<tr>
		<td>$IS_EMPTY,a</td>
		<td>{$IS_EMPTY,a}</td>
	</tr>
	<tr>
		<td>$NEGATE,3</td>
		<td>{$NEGATE,3}</td>
	</tr>
	<tr>
		<td>$OBFUSCATE,chris@ocportal.com (check HTML source to see if it is obfuscated)</td>
		<td>{$OBFUSCATE,chris@ocportal.com}</td>
	</tr>
	<tr>
		<td>$FIX_ID,3+2</td>
		<td>{$FIX_ID,3+2}</td>
	</tr>
	<tr>
		<td>$GET,foobar</td>
		<td>{$GET,foobar}</td>
	</tr>
</tbody></table>

<h2>Array variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>+COUNT,SIMPLE_ARRAY</td>
		<td>{+COUNT,SIMPLE_ARRAY}</td>
	</tr>
	<tr>
		<td>+IMPLODE, ,SIMPLE_ARRAY</td>
		<td>{+IMPLODE, ,SIMPLE_ARRAY}</td>
	</tr>
	<tr>
		<td>+OF,SIMPLE_ARRAY,1</td>
		<td>{+OF,SIMPLE_ARRAY,1}</td>
	</tr>
</tbody></table>

<h2>String variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>$WCASE,I am a Mushroom</td>
		<td>{$WCASE,I am a Mushroom}</td>
	</tr>
	<tr>
		<td>$LCASE,I am a Mushroom</td>
		<td>{$LCASE,I am a Mushroom}</td>
	</tr>
	<tr>
		<td>$UCASE,I am a Mushroom</td>
		<td>{$UCASE,I am a Mushroom}</td>
	</tr>
	<tr>
		<td>$REPLACE,a,b,apple</td>
		<td>{$REPLACE,a,b,apple}</td>
	</tr>
	<tr>
		<td>$AT,apple,3</td>
		<td>{$AT,apple,3}</td>
	</tr>
	<tr>
		<td>$SUBSTR,apple,1,2</td>
		<td>{$SUBSTR,apple,1,2}</td>
	</tr>
	<tr>
		<td>$LENGTH,apple</td>
		<td>{$LENGTH,apple}</td>
	</tr>
	<tr>
		<td>$WORDWRAP,i love to eat cheese,5</td>
		<td>{$WORDWRAP,i love to eat cheese,5}</td>
	</tr>
	<tr>
		<td>$TRUNCATE_LEFT,i love to eat cheese,5</td>
		<td>{$TRUNCATE_LEFT,i love to eat cheese,5}</td>
	</tr>
	<tr>
		<td>$TRUNCATE_RIGHT,i love to eat cheese,5</td>
		<td>{$TRUNCATE_RIGHT,i love to eat cheese,5}</td>
	</tr>
	<tr>
		<td>$TRUNCATE_SPREAD,i love to eat cheese,5</td>
		<td>{$TRUNCATE_SPREAD,i love to eat cheese,5}</td>
	</tr>
	<tr>
		<td>$ESCAPE,Bill &amp; Julie,ENTITY_ESCAPED</td>
		<td>{$ESCAPE,Bill & Julie,ENTITY_ESCAPED}</td>
	</tr>
</tbody></table>

<h2>Arithmetical variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>$MULT,2,3</td>
		<td>{$MULT,2,3}</td>
	</tr>
	<tr>
		<td>$ROUND,3.23,1</td>
		<td>{$ROUND,3.23,1}</td>
	</tr>
	<tr>
		<td>$MAX,3,2</td>
		<td>{$MAX,3,2}</td>
	</tr>
	<tr>
		<td>$MIN,3,2</td>
		<td>{$MIN,3,2}</td>
	</tr>
	<tr>
		<td>$MOD,-2</td>
		<td>{$MOD,-2}</td>
	</tr>
	<tr>
		<td>$MOD,2</td>
		<td>{$MOD,2}</td>
	</tr>
	<tr>
		<td>$REM,3,2</td>
		<td>{$REM,3,2}</td>
	</tr>
	<tr>
		<td>$DIV,3,2</td>
		<td>{$DIV,3,2}</td>
	</tr>
	<tr>
		<td>$SUBTRACT,3,2</td>
		<td>{$SUBTRACT,3,2}</td>
	</tr>
	<tr>
		<td>$ADD,3,2</td>
		<td>{$ADD,3,2}</td>
	</tr>
</tbody></table>

<h2>Logical variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>$NOT,1</td>
		<td>{$NOT,1}</td>
	</tr>
	<tr>
		<td>$OR,1,0</td>
		<td>{$OR,1,0}</td>
	</tr>
	<tr>
		<td>$OR,0,0</td>
		<td>{$OR,0,0}</td>
	</tr>
	<tr>
		<td>$AND,1,0</td>
		<td>{$AND,1,0}</td>
	</tr>
	<tr>
		<td>$AND,1,1</td>
		<td>{$AND,1,1}</td>
	</tr>
	<tr>
		<td>$EQ,3,3</td>
		<td>{$EQ,3,3}</td>
	</tr>
	<tr>
		<td>$EQ,3,2</td>
		<td>{$EQ,3,2}</td>
	</tr>
	<tr>
		<td>$NEQ,3,3</td>
		<td>{$NEQ,3,3}</td>
	</tr>
	<tr>
		<td>$NEQ,3,2</td>
		<td>{$NEQ,3,2}</td>
	</tr>
	<tr>
		<td>$LT,1,2</td>
		<td>{$LT,1,2}</td>
	</tr>
	<tr>
		<td>$LT,2,1</td>
		<td>{$LT,2,1}</td>
	</tr>
	<tr>
		<td>$GT,1,2</td>
		<td>{$GT,1,2}</td>
	</tr>
	<tr>
		<td>$GT,2,1</td>
		<td>{$GT,2,1}</td>
	</tr>
</tbody></table>

<h2>Variable variables</h2>

<table summary="{!MAP_TABLE}"><tbody>
	<tr>
		<td>$ISSET,test</td>
		<td>{$ISSET,test}</td>
	</tr>
	<tr>
		<td>$INIT,test,2</td>
		<td>{$INIT,test,2}</td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>{$GET,test}</td>
	</tr>
	<tr>
		<td>$INIT,test,3</td>
		<td>{$INIT,test,3}</td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>{$GET,test}</td>
	</tr>
	<tr>
		<td>$SET,test,3</td>
		<td>{$SET,test,3}</td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>{$GET,test}</td>
	</tr>
	<tr>
		<td>$INC,test</td>
		<td>{$INC,test}</td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>{$GET,test}</td>
	</tr>
	<tr>
		<td>$DEC,test</td>
		<td>{$DEC,test}</td>
	</tr>
	<tr>
		<td>$GET,test</td>
		<td>{$GET,test}</td>
	</tr>
	<tr>
		<td>$ISSET,test</td>
		<td>{$ISSET,test}</td>
	</tr>
</tbody></table>

<p>
	Putting #anchor onto URL should cause jump to here.{$ANCHOR,anchor}
</p>

<h2>Directives</h2>

{+START,IF_PASSED,PASSED}
	<p>
		IF_PASSED true positive (good)
	</p>
{+END}
{+START,IF_PASSED,PASSED_FAKE}
	<p>
		IF_PASSED false positive (bad)
	</p>
{+END}
{+START,IF_NON_PASSED,PASSED}
	<p>
		IF_PASSED false negative (bad)
	</p>
{+END}
{+START,IF_NON_PASSED,PASSED_FAKE}
	<p>
		IF_PASSED true negative (good)
	</p>
{+END}

{+START,IF_EMPTY,{EMPTY1}}
	<p>
		IF_EMPTY true positive (string) (good)
	</p>
{+END}
{+START,IF_EMPTY,{PASSED}}
	<p>
		IF_EMPTY false positive (string) (bad)
	</p>
{+END}
{+START,IF_NON_EMPTY,{EMPTY2}}
	<p>
		IF_EMPTY true negative (tempcode) (bad)
	</p>
{+END}
{+START,IF_NON_EMPTY,{NONEMPTY}}
	<p>
		IF_EMPTY false negative (tempcode) (good)
	</p>
{+END}

{+START,IF_ADJACENT}
	<p>
		Adjacent to own codenamed template
	</p>
{+END}
{+START,IF_NON_ADJACENT}
	<p>
		NOT Adjacent to own codenamed template (but adjacent/under something)
	</p>
{+END}

{+START,SET,foo}bar{+END}{$GET,foo}

{+START,IF,1}
	<p>
		IF true positive (good)
	</p>
{+END}
{+START,IF,0}
	<p>
		IF false positive (bad)
	</p>
{+END}

\{$BASE_URL}

{+START,IF,{$IN_STR,x,<a }}
{+END}

{+START,SET,foobar}
	Move contents towards end of first template showing.
{+END}

{$INIT,i,0}
{+START,WHILE,{$NEQ,{$GET,i},3}}
	<p>
		Should see this text 3 times.
{$INC,i}
	</p>
{+END}

<table><tbody>
{+START,LOOP,ARRAY,2,<tr>,</tr>,a,DESC}
	<td>
		{A} {B} {C}
	</td>
{+END}
</tbody></table>

