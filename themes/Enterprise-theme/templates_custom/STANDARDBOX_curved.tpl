<div class="standardbox_wrap_curved">
{+START,IF,{$BROWSER_MATCHES,ie6}}
	{$,This IE-alternative is needed because IE can't handle the alpha blended background corners; ocProducts at one point had a CSS positioned alternative, but IE randomly misrendered it}

	<div class="wide_table_wrap"><table cellspacing="0" cellpadding="0" summary="" class="wide_table standardbox_curved" style="height: {HEIGHT'}; width: {WIDTH'}">
		<colgroup>
			<col width="6" />
			<col width="100%" />
			<col width="6" />
		</colgroup>
		<tbody>
			{+START,IF_NON_EMPTY,{TITLE}}
			<tr>
				<td><img alt="" src="{$IMG*,standardboxes/title_left}" /></td>
				<td><h3 class="standardbox_title_curved_iesucks dequirk_h">{TITLE}</h3></td>
				<td><img alt="" src="{$IMG*,standardboxes/title_right}" /></td>
			</tr>
			{+END}
			{+START,IF_EMPTY,{TITLE}}
			<tr>
				<td><img alt="" src="{$IMG*,standardboxes/nontitle_left}" /></td>
				<td class="standardbox_curved_nontitle_middle">&nbsp;</td>
				<td><img alt="" src="{$IMG*,standardboxes/nontitle_right}" /></td>
			</tr>
			{+END}
			<tr>
				<td class="standardbox_iesucks standardbox_iesucks_curved_left">&nbsp;</td>
				<td class="standardbox_iesucks">
					{+START,IF_NON_EMPTY,{META}}
						<div class="standardbox_meta_classic">
							{+START,LOOP,META}
								<div>{KEY}: {VALUE}</div>
							{+END}
						</div>
					{+END}
					<div style="{$,padding-bottom: {$?,{$IS_NON_EMPTY,{LINKS}},0px,18px};} height: {$CSS_DIMENSION_REDUCE,{HEIGHT'},29}" class="standardbox_main_classic">
						{CONTENT}{+START,IF_EMPTY,{LINKS}}<br class="standardbox_curved_ie_hack" />{+END}
					</div>

					{+START,IF_NON_EMPTY,{LINKS}}
						{$SET,linkbar,0}
						<div class="standardbox_iesucks_curved_rule standardbox_links_classic community_block_tagline"> [
							{+START,LOOP,LINKS}
								{+START,IF,{$GET,linkbar}} &middot; {+END}{_loop_var}{$SET,linkbar,1}
							{+END}
						] </div>
					{+END}
				</td>
				<td class="standardbox_iesucks standardbox_iesucks_curved_right">&nbsp;</td>
			</tr>
			<tr>
				<td><img alt="" src="{$IMG*,standardboxes/bottom_left}" /></td>
				<td class="standardbox_curved_bottom_middle">&nbsp;</td>
				<td><img alt="" src="{$IMG*,standardboxes/bottom_right}" /></td>
			</tr>
		</tbody>
	</table></div>
{+END}

{+START,IF,{$NOT,{$BROWSER_MATCHES,ie6}}}
	<div class="standardbox_curved" style="{+START,IF,{$NEQ,{HEIGHT},auto}}min-height: {HEIGHT'}; {+END}width: {WIDTH'}">
		{+START,IF_NON_EMPTY,{TITLE}}
			<div class="standardbox_curved_title_left">
			<div class="standardbox_curved_title_right">
				<h3 class="standardbox_title_curved">{TITLE}</h3>
			</div>
			</div>
		{+END}
		{+START,IF_EMPTY,{TITLE}}
			<div class="standardbox_curved_nontitle_left">
			<div class="standardbox_curved_nontitle_right">
				<div class="standardbox_curved_nontitle_middle">&nbsp;</div>
			</div>
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{META}}
			<div class="standardbox_inner_curved standardbox_meta_classic">
				{+START,LOOP,META}
					<div>{KEY}: {VALUE}</div>
				{+END}
			</div>
		{+END}
		<div style="{$,padding-bottom: {$?,{$IS_NON_EMPTY,{LINKS}},0px,18px};} {+START,IF,{$NEQ,{HEIGHT},auto}}min-height: {$CSS_DIMENSION_REDUCE,{HEIGHT'},29}{+END}" class="standardbox_inner_curved standardbox_main_classic"><div class="float_surrounder">
			{CONTENT}
		</div></div>

		{+START,IF_NON_EMPTY,{LINKS}}
			{$SET,linkbar,0}
			<div class="standardbox_inner_curved standardbox_links_classic community_block_tagline"> 
				{+START,LOOP,LINKS}
					{+START,IF,{$GET,linkbar}}  {+END}{_loop_var}{$SET,linkbar,1}
				{+END}
			 </div>
		{+END}

		<div class="standardbox_curved_bottom_left">
		<div class="standardbox_curved_bottom_right">
			<div class="standardbox_curved_bottom_middle">&nbsp;</div>
		</div>
		</div>
	</div>
{+END}
</div>
