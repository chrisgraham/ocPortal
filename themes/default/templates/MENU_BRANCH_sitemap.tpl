{+START,IF,{$NOT,{$JS_ON}}}
	<li class="{$?,{CURRENT},current,non_current} {$?,{$IS_EMPTY,{IMG}},has_no_img,has_img}">
		{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{IMG*}" srcset="{IMG_2X*} 2x" />{+END}
		{+START,IF_NON_EMPTY,{URL}}
			<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}>{CAPTION}</a>
		{+END}
		{+START,IF_EMPTY,{URL}}
			<span>{CAPTION}</span>
		{+END}
		{+START,IF_NON_EMPTY,{CHILDREN}}
			<ul>
				{CHILDREN}
			</ul>
		{+END}
	</li>
{+END}

{+START,IF,{$JS_ON}}
	{
		caption: '{CAPTION;^}',
		url: {URL;^}',
		img: {IMG;^}',
		img_2x: {IMG_2X;^}',
		children: [{CHILDREN}],
	},
{+END}
