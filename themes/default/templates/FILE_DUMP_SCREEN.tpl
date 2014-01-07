{TITLE}

{+START,SET,search}
	<div class="float_surrounder">
		{+START,IF,{$ADDON_INSTALLED,search}}
			{$SET,search_url,{$SELF_URL}}
			<form role="search" title="{!SEARCH}" onsubmit="disable_button_just_clicked(this); action.href+=window.location.hash; if (this.elements['search'].value=='{!SEARCH;*}') this.elements['search'].value='';" action="{$URL_FOR_GET_FORM*,{$GET,search_url},search,type_filter}" method="get">
				{$HIDDENS_FOR_GET_FORM,{$GET,search_url},search,type_filter}

				<p class="left">
					<label class="accessibility_hidden" for="search_filedump">{!SEARCH}</label>
					<input {+START,IF,{$MOBILE}}autocorrect="off" {+END}autocomplete="off" maxlength="255" size="25" type="search" id="search_filedump" name="search" style="color: gray" onblur="if (this.value=='') { this.value='{!SEARCH;}'; this.style.color='gray'; }" onfocus="if (this.value=='{!SEARCH;}') this.value=''; this.style.color='black';" value="{$?,{$IS_EMPTY,{SEARCH}},{!SEARCH},{SEARCH}}" />

					<label class="accessibility_hidden" for="type_filter_filedump">{!FILTER}</label>
					<select id="type_filter_filedump" name="type_filter">
						<option{+START,IF,{$EQ,{TYPE_FILTER},}} selected="selected"{+END} value="">{!ALL}</option>
						<option{+START,IF,{$EQ,{TYPE_FILTER},images}} selected="selected"{+END} value="images">{!IMAGES}</option>
						<option{+START,IF,{$EQ,{TYPE_FILTER},videos}} selected="selected"{+END} value="videos">{!VIDEOS}</option>
						<!--<option{+START,IF,{$EQ,{TYPE_FILTER},audio}} selected="selected"{+END} value="audios">{!AUDIOS}</option>-->
					</select>

					<input class="button_micro" type="submit" value="{!FILTER}" />
				</p>
			</form>
		{+END}
	</div>
{+END}

<div>
	<div class="float_surrounder"><div class="tabs" role="tablist">
		<a aria-controls="g_thumbnails" role="tab" href="#" id="t_thumbnails" class="tab tab_active tab_first" onclick="event.returnValue=false; select_tab('g','thumbnails'); return false;">{!VIEW_THUMBNAILS}</a>

		<a aria-controls="g_listing" role="tab" href="#" id="t_listing" class="tab{+START,IF_EMPTY,{CREATE_FOLDER_FORM}{UPLOAD_FORM}} tab_last{+END}" onclick="event.returnValue=false; select_tab('g','listing'); return false;">{!VIEW_LISTING}</a>

		{+START,IF_NON_EMPTY,{CREATE_FOLDER_FORM}}
			<a aria-controls="g_create_folder" role="tab" href="#" id="t_create_folder" class="tab{+START,IF_EMPTY,{UPLOAD_FORM}} tab_last{+END}" onclick="event.returnValue=false; select_tab('g','create_folder'); return false;">{!FILEDUMP_CREATE_FOLDER}</a>
		{+END}

		{+START,IF_NON_EMPTY,{UPLOAD_FORM}}
			<a aria-controls="g_upload" role="tab" href="#" id="t_upload" class="tab tab_last" onclick="event.returnValue=false; select_tab('g','upload'); return false;">{!UPLOAD}</a>
		{+END}
	</div></div>
	<div class="tab_surround">
		<div aria-labeledby="t_thumbnails" role="tabpanel" id="g_thumbnails" style="display: block">
			<a id="tab__thumbnails"></a>

			{$GET,search}

			{+START,IF_NON_EMPTY,{THUMBNAILS}}
				<div class="float_surrounder filedump_thumbnails">
					{+START,LOOP,THUMBNAILS}
						<div class="box"><div class="box_inner">
							<p><a{+START,IF,{IS_IMAGE}} rel="lightbox"{+END} href="{URL*}">{THUMBNAIL}</a></p>
							<p>
								<strong>{FILENAME*}</strong><br />
								({+START,IF_NON_EMPTY,{_SIZE}}{SIZE*}{+END}{+START,IF_NON_EMPTY,{TIME}}{+START,IF_NON_EMPTY,{_SIZE}}, {+END}{TIME*}{+END})
								<!-- {DELETABLE*} -->
							</p>
						</div></div>
					{+END}
				</div>
			{+END}
			{+START,IF_EMPTY,{THUMBNAILS}}
				<p class="nothing_here">{!NO_ENTRIES}</p>
			{+END}
		</div>

		<div aria-labeledby="t_listing" role="tabpanel" id="g_listing" style="display: {$?,{$JS_ON},none,block}">
			<a id="tab__listing"></a>

			{$GET,search}

			{+START,IF_NON_EMPTY,{LISTING}}
				{LISTING}
			{+END}
			{+START,IF_EMPTY,{LISTING}}
				<p class="nothing_here">{!NO_ENTRIES}</p>
			{+END}
		</div>

		{+START,IF_NON_EMPTY,{CREATE_FOLDER_FORM}}
			<div aria-labeledby="t_create_folder" role="tabpanel" id="g_create_folder" style="display: {$?,{$JS_ON},none,block}">
				<a id="tab__create_folder"></a>

				<p class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</p>

				{CREATE_FOLDER_FORM}
			</div>
		{+END}

		{+START,IF_NON_EMPTY,{UPLOAD_FORM}}
			<div aria-labeledby="t_upload" role="tabpanel" id="g_upload" style="display: {$?,{$JS_ON},none,block}">
				<a id="tab__upload"></a>

				<p class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</p>

				{UPLOAD_FORM}
			</div>
		{+END}
	</div>
</div>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		find_url_tab();
	} );
//]]></script>

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=filedump
	NOTIFICATIONS_ID={PLACE}
	BREAK=1
	RIGHT=1
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,IF,{$AND,{$SHOW_DOCS},{$HAS_PRIVILEGE,see_software_docs}}}
	{+START,INCLUDE,STAFF_ACTIONS}
		STAFF_ACTIONS_TITLE={!STAFF_ACTIONS}
		1_URL={$BRAND_BASE_URL*}/docs{$VERSION*}/pg/tut_collaboration
		1_TITLE={!HELP}
		1_REL=help
	{+END}
{+END}
