{+START,IF,{SYSTEM_MESSAGE}}
	<p>{MESSAGE}</p>
{+END}
{+START,IF,{$NOT,{SYSTEM_MESSAGE}}}
	{+START,BOX}
		<div><span class="chat_message_by">{USER*}</span></div>
		<p class="chat_private_message">{MESSAGE}</p>
	{+END}
{+END}
