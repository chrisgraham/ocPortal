{TITLE}

{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
		{DESCRIPTION}
	</div>
	<br />
	<br />
{+END}

{+START,IF_NON_EMPTY,{SUBCATEGORIES}}
	{+START,BOX,{!SUBCATEGORIES_HERE},,light}
		{SUBCATEGORIES}
	{+END}
	<br />
{+END}

{+START,IF_NON_EMPTY,{DOWNLOADS}}
	{DOWNLOADS}
	<br />
{+END}

{+START,IF_EMPTY,{DOWNLOADS}{SUBCATEGORIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={SUBMIT_URL*}
	1_TITLE={!ADD_DOWNLOAD}
	1_REL=add
	2_URL={ADD_CAT_URL*}
	2_TITLE={!ADD_DOWNLOAD_CATEGORY}
	2_REL=add
	3_ACCESSKEY=q
	3_URL={EDIT_CAT_URL*}
	3_TITLE={!EDIT_DOWNLOAD_CATEGORY}
	3_REL=edit
{+END}

{+START,IF_NON_EMPTY,{SUBDOWNLOADS}}
	<hr class="long_break" />
	{+START,BOX,{!RANDOM_20_DOWNLOADS},,light}
		{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

		{$SET,carousel_id,{$RAND}}

		<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
			<div class="move_left" onmousedown="carousel_move({$GET*,carousel_id},-100); return false;" onmouseover="this.className='move_left move_left_hover';" onmouseout="this.className='move_left';"></div>
			<div class="move_right" onmousedown="carousel_move({$GET*,carousel_id},+100); return false;" onmouseover="this.className='move_right move_right_hover';" onmouseout="this.className='move_right';"></div>

			<div class="main">
			</div>
		</div>

		<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
			{SUBDOWNLOADS}
		</div>

		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'load',function () {
				initialise_carousel({$GET,carousel_id});
			} );
		//]]></script>
	{+END}
{+END}

{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
