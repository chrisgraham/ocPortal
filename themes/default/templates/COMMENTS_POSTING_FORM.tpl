{+START,IF_NON_EMPTY,{COMMENT_URL}}
<form role="form" title="{TITLE*}" class="comments_form" id="comments_form" onsubmit="return ({+START,IF_PASSED,MORE_URL}(this.getAttribute('action')=='{MORE_URL*}') || {+END}(check_field_for_blankness(this.elements['post'],event)){+START,IF,{$AND,{GET_EMAIL},{$NOT,{EMAIL_OPTIONAL}}}} &amp;&amp; (check_field_for_blankness(this.elements['email'],event)){+END});" action="{COMMENT_URL*}{+START,IF_PASSED_AND_TRUE,COMMENTS}#last_comment{+END}" method="post" enctype="multipart/form-data">
	{$INSERT_SPAMMER_BLACKHOLE}
	<input type="hidden" name="_comment_form_post" value="1" />
{+END}

	<input type="hidden" name="_validated" value="1" />
	<input type="hidden" name="comcode__post" value="1" />
	<input type="hidden" name="stub" value="" />

	<div class="box box___comments_posting_form">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h3 class="toggleable_tray_title">
				{+START,IF_NON_PASSED,EXPAND_TYPE}
					{TITLE*}
				{+END}
				{+START,IF_PASSED,EXPAND_TYPE}
					<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{$?,{$EQ,{EXPAND_TYPE},contract},{!CONTRACT},{!EXPAND}}" title="{$?,{$EQ,{EXPAND_TYPE},contract},{!CONTRACT},{!EXPAND}}" src="{$IMG*,{EXPAND_TYPE*}}" /></a>
					<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{TITLE*}</a>
				{+END}
			</h3>
		{+END}
		<div class="comments_posting_form_outer {+START,IF_PASSED,EXPAND_TYPE} toggleable_tray{+END}" {+START,IF_PASSED,EXPAND_TYPE}aria-expanded="false" {+END}id="comments_posting_form_outer" style="{$JS_ON,display: {DISPLAY*},}">
			<div class="comments_posting_form_inner">
				<div class="wide_table_wrap"><table class="wide_table" summary="{!MAP_TABLE}">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col class="comments_field_name_column" />
							<col class="comments_field_input_column" />
						</colgroup>
					{+END}

					<tbody>
						{+START,IF,{$AND,{$IS_GUEST},{$OCF}}}
							<tr>
								<th class="de_th">
									<label for="poster_name_if_guest">{!ocf:GUEST_NAME}:</label>
								</th>

								<td>
									<input maxlength="255" size="{$?,{$MOBILE},16,24}" value="" type="text" tabindex="1" id="poster_name_if_guest" name="poster_name_if_guest" />
									{+START,IF_PASSED,JOIN_BITS}{+START,IF_NON_EMPTY,{JOIN_BITS}}
										<span class="horiz_field_sep">{JOIN_BITS}</span>
									{+END}{+END}
								</td>
							</tr>
						{+END}

						{+START,IF,{GET_TITLE}}
							<tr>
								<th class="de_th">
									<label for="title">{!POST_TITLE}:</label>
								</th>

								<td>
									<div class="constrain_field">
										<input maxlength="255" class="wide_field" value="" type="text" tabindex="1" id="title" name="title" />
									</div>

									<div id="error_title" style="display: none" class="input_error_here"></div>
								</td>
							</tr>
						{+END}

						{+START,IF,{GET_EMAIL}}
							<tr>
								<th class="de_th">
									<label for="email">{!EMAIL_ADDRESS}:</label>{+START,IF,{EMAIL_OPTIONAL}} <span class="associated_details">({!OPTIONAL})</span>{+END}
								</th>

								<td>
									<div class="constrain_field">
										<input maxlength="255" class="wide_field{+START,IF,{$NOT,{EMAIL_OPTIONAL}}} input_text_required{+END}" id="email" type="text" tabindex="2" value="{$MEMBER_EMAIL*}" name="email" />
									</div>

									<div id="error_email" style="display: none" class="input_error_here"></div>
								</td>
							</tr>
						{+END}

						{+START,IF_PASSED,REVIEW_RATING_CRITERIA}{+START,IF_PASSED,TYPE}{+START,IF_PASSED,ID}
							{+START,LOOP,REVIEW_RATING_CRITERIA}
								<tr>
									<th class="de_th">
										<label for="review_rating__{TYPE*|}__{$FIX_ID,{REVIEW_TITLE}}__{ID*|}">{+START,IF_EMPTY,{REVIEW_TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{REVIEW_TITLE}}{REVIEW_TITLE*}:{+END}</label>
									</th>

									<td>
										{+START,IF,{$JS_ON}}
											<img id="review_bar_1__{TYPE*}__{$FIX_ID,{REVIEW_TITLE}}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="review_bar_2__{TYPE*}__{$FIX_ID,{REVIEW_TITLE}}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="review_bar_3__{TYPE*}__{$FIX_ID,{REVIEW_TITLE}}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="review_bar_4__{TYPE*}__{$FIX_ID,{REVIEW_TITLE}}__{ID*}" alt="" src="{$IMG*,rating}" /><img id="review_bar_5__{TYPE*}__{$FIX_ID,{REVIEW_TITLE}}__{ID*}" alt="" src="{$IMG*,rating}" />
											<script type="text/javascript">// <![CDATA[
												function new_review_highlight__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}(review,first_time)
												{
													var i,bit;
													for (i=1;i<=5;i++)
													{
														bit=document.getElementById('review_bar_'+i+'__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}');
														bit.className=((review!=0) && (review/2>=i))?'rating_star_highlight':'rating_star';
														if (first_time) bit.onmouseover=function(i) { return function()
														{
															new_review_highlight__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}(i*2,false);
														} }(i);
														if (first_time) bit.onmouseout=function(i) { return function()
														{
															new_review_highlight__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}(window.parseInt(document.getElementById('review_rating__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}').value),false);
														} }(i);
														if (first_time) bit.onclick=function(i) { return function()
														{
															document.getElementById('review_rating__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}').value=i*2;
														} }(i);
													}
												}
												new_review_highlight__{TYPE%}__{$FIX_ID,{REVIEW_TITLE}}__{ID%}(0,true);
											//]]></script>
											<input id="review_rating__{TYPE*|}__{$FIX_ID,{REVIEW_TITLE}}__{ID*|}" type="hidden" name="review_rating__{$FIX_ID,{REVIEW_TITLE}}" value="" />
										{+END}

										{+START,IF,{$NOT,{$JS_ON}}}
											<select id="review_rating__{TYPE*|}__{$FIX_ID,{REVIEW_TITLE}}__{ID*|}" name="review_rating">
												<option value="">{!NA}</option>
												<option value="10">*****</option>
												<option value="8">****</option>
												<option value="6">***</option>
												<option value="4">**</option>
												<option value="2">*</option>
											</select>
										{+END}
									</td>
								</tr>
							{+END}
						{+END}{+END}{+END}

						<tr>
							<th class="de_th">
								<img class="comcode_supported_icon" alt="" src="{$IMG*,comcode}" />
								<label for="post">{!POST_COMMENT}:</label>

								{+START,IF_NON_EMPTY,{FIRST_POST}{COMMENT_TEXT}}
									<ul class="associated_links_block_group">
										{+START,IF_NON_EMPTY,{FIRST_POST}}
											<li><a class="non_link" title="{!ocf:FIRST_POST}: {!LINK_NEW_WINDOW}" target="_blank" href="{FIRST_POST_URL*}" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{FIRST_POST*~;^}','30%',null,null,false,true);">{!ocf:FIRST_POST}</a></li>
										{+END}

										{+START,IF_NON_EMPTY,{COMMENT_TEXT}}
											<li><a class="non_link" href="{$PAGE_LINK*,:rules}" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{$TRUNCATE_LEFT,{COMMENT_TEXT*~;^},1000,0,1}','30%',null,null,false,true);">{!HOVER_MOUSE_IMPORTANT}</a></li>
										{+END}
									</ul>
								{+END}

								{+START,IF,{$NOT,{$MOBILE}}}
									{+START,IF,{$JS_ON}}
										{+START,IF,{$CONFIG_OPTION,is_on_emoticon_choosers}}
											<div class="comments_posting_form_emoticons">
												<div class="box box___comments_posting_form"><div class="box_inner">
													{EM}

													{+START,IF,{$OCF}}
														<p class="associated_link associated_links_block_group"><a rel="nofollow" tabindex="6" href="#" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name=post{$KEEP*;}'),'site_emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;">{!EMOTICONS_POPUP}</a></p>
													{+END}
												</div>
											</div></div>
										{+END}
									{+END}
								{+END}
							</th>

							<td>
								<div class="constrain_field">
									<textarea{+START,IF,{$NOT,{$MOBILE}}} onkeyup="manage_scroll_height(this);"{+END} accesskey="x" class="wide_field" onfocus="if ((this.value.replace(/\s/g,'')=='{POST_WARNING;^*}'.replace(/\s/g,'') &amp;&amp; '{POST_WARNING;^*}'!='') || (typeof this.strip_on_focus!='undefined' &amp;&amp; this.value==this.strip_on_focus)) this.value=''; this.style.color='black';" cols="42" rows="11" name="post" id="post">{POST_WARNING*}</textarea>
								</div>

								<div id="error_post" style="display: none" class="input_error_here"></div>
							</td>
						</tr>

						{$GET,EXTRA_COMMENTS_FIELDS_1}
						{$GET,EXTRA_COMMENTS_FIELDS_2}
					</tbody>
				</table></div>

				<div class="comments_posting_form_end">
					{+START,IF_PASSED,USE_CAPTCHA}
						{+START,IF,{USE_CAPTCHA}}
							<div class="comments_captcha">
								<div class="box box___comments_posting_form__captcha"><div class="box_inner">
									<p><label for="captcha">{!DESCRIPTION_CAPTCHA_2,<a target="_blank" title="{!AUDIO_VERSION}: {!LINK_NEW_WINDOW}" href="{$FIND_SCRIPT*,captcha,1}?mode=audio{$KEEP*,0,1}">{!AUDIO_VERSION}</a>}</label></p>
									{+START,IF,{$CONFIG_OPTION,css_captcha}}
										<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} id="captcha_frame" class="captcha_frame" title="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" src="{$FIND_SCRIPT*,captcha}{$KEEP*,1,1}">{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}</iframe>
									{+END}
									{+START,IF,{$NOT,{$CONFIG_OPTION,css_captcha}}}
										<img id="captcha_image" title="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" alt="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" src="{$FIND_SCRIPT*,captcha}{$KEEP*,1,1}" />
									{+END}
									<input maxlength="6" size="6" class="input_text_required" value="" type="text" id="captcha" name="captcha" />
								</div></div>
							</div>
						{+END}
					{+END}

					<div class="proceed_button buttons_group">
						{+START,IF,{$JS_ON}}{+START,IF,{$CONFIG_OPTION,enable_previews}}{+START,IF,{$NOT,{$VALUE_OPTION,xhtml_strict}}}
							<button onclick="if (typeof this.form=='undefined') var form=window.form_submitting; else var form=this.form; if (do_form_preview(form,maintain_theme_in_link('{$PREVIEW_URL*;}{$KEEP*;}'))) form.submit();" id="preview_button" accesskey="p" tabindex="250" class="{$?,{$IS_EMPTY,{COMMENT_URL}},button_page,button_pageitem}" type="button">{!PREVIEW}</button>
						{+END}{+END}{+END}
						{+START,IF_PASSED,MORE_URL}
							{+START,IF,{$JS_ON}}
								<button tabindex="5" accesskey="y" onclick="move_to_full_editor(this,'{MORE_URL*;}');" class="{$?,{$IS_EMPTY,{COMMENT_URL}},button_page,button_pageitem}" type="button">{!FULL_EDITOR}</button>
							{+END}
						{+END}
						<button onclick="handle_comments_posting_form_submit(this,event);" tabindex="4" accesskey="u" id="submit_button" class="{$?,{$IS_EMPTY,{COMMENT_URL}},button_page,button_pageitem}" {+START,IF,{$JS_ON}}type="button"{+END}{+START,IF,{$NOT,{$JS_ON}}}type="submit"{+END}><strong>{+START,IF_PASSED,SUBMIT_NAME}{SUBMIT_NAME*}{+END}{+START,IF_NON_PASSED,SUBMIT_NAME}{+START,IF_NON_EMPTY,{TITLE}}{TITLE*}{+END}{+START,IF_EMPTY,{TITLE}}{!SEND}{+END}{+END}</strong></button>
					</div>
				</div>
			</div>

			{+START,IF_PASSED,ATTACHMENTS}
				<div class="attachments">
					{+START,IF_PASSED,ATTACH_SIZE_FIELD}
						{ATTACH_SIZE_FIELD}
					{+END}
					<input type="hidden" name="posting_ref_id" value="{$RAND,1,2147483646}" />
					{ATTACHMENTS}
				</div>
			{+END}
		</div>
	</div>

{+START,IF_NON_EMPTY,{COMMENT_URL}}
</form>
{+END}

{+START,IF,{$JS_ON}}{+START,IF,{$CONFIG_OPTION,enable_previews}}{+START,IF,{$NOT,{$VALUE_OPTION,xhtml_strict}}}
	{+START,IF,{$FORCE_PREVIEWS}}
		<script type="text/javascript">// <![CDATA[
			document.getElementById('submit_button').style.display='none';
		//]]></script>
	{+END}

	<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} title="{!PREVIEW}" name="preview_iframe" id="preview_iframe" src="{$BASE_URL*}/uploads/index.html" class="hidden_preview_frame">{!PREVIEW}</iframe>
{+END}{+END}{+END}

{+START,IF_PASSED,USE_CAPTCHA}
	{+START,IF,{USE_CAPTCHA}}
		<script type="text/javascript">// <![CDATA[
			var form=document.getElementById('comments_form');
			add_captcha_validation(form);
		//]]></script>
	{+END}
{+END}
