{+START,IF_NON_EMPTY,{COMMENT_URL}}
<form{$?,{$VALUE_OPTION,html5}, role="form"} title="{TITLE*}" id="comments_form" onsubmit="return ({+START,IF_PASSED,MORE_URL}(this.getAttribute('action')=='{MORE_URL*}') || {+END}(checkFieldForBlankness(this.elements['post'],event)){+START,IF,{$AND,{GET_EMAIL},{$NOT,{EMAIL_OPTIONAL}}}} &amp;&amp; (checkFieldForBlankness(this.elements['email'],event)){+END});" action="{COMMENT_URL*}{+START,IF_PASSED,COMMENTS}#last_comment{+END}" method="post" enctype="multipart/form-data">
<input type="hidden" name="_comment_form_post" value="1" />
{+END}

	<input type="hidden" name="_validated" value="1" />
	<input type="hidden" name="comcode__post" value="1" />

	<div class="standardbox_wrap_classic">
		{+START,IF_NON_EMPTY,{TITLE}}
			<div class="standardbox_classic">
				<h3 class="standardbox_title_classic toggle_div_title">
					{TITLE*}
					{+START,IF_PASSED,EXPAND_TYPE}
						&nbsp; <a class="hide_button hide_button_spacing" href="#" onclick="event.returnValue=false; toggleSectionInline('comments_posting_form_outer','block'); return false;"><img id="e_comments_posting_form_outer" alt="{$?,{$EQ,{EXPAND_TYPE},contract},{!CONTRACT},{!EXPAND}}" title="{$?,{$EQ,{EXPAND_TYPE},contract},{!CONTRACT},{!EXPAND}}" src="{$IMG*,{EXPAND_TYPE*}}" /></a>
					{+END}
				</h3>
			</div>
		{+END}
		<div class="toggler_main{+START,IF_PASSED,EXPAND_TYPE} hide_button_spacing{+END}" id="comments_posting_form_outer" style="{$JS_ON,display: {DISPLAY*},}">
			<div class="comments_posting_form_inner">
				{+START,IF,{$MOBILE}}
					<div class="contact-form">
						<ul>
							{+START,IF,{$AND,{$IS_GUEST},{$OCF}}}
								<li>
									<label for="poster_name_if_guest">{!ocf:GUEST_NAME}</label>
									<input maxlength="255" size="24" value="" type="text" id="poster_name_if_guest" name="poster_name_if_guest" />
									{+START,IF_PASSED,JOIN_BITS}{+START,IF_NON_EMPTY,{JOIN_BITS}}
										<span class="associated_link_to_small">({JOIN_BITS})</span>
									{+END}{+END}
								</li>
							{+END}

							{+START,IF,{GET_TITLE}}
								<li>
									<label for="title">{!POST_TITLE}</label>
									<input maxlength="255" class="wide_field" value="" type="text" id="title" name="title" />
								</li>
							{+END}

							{+START,IF,{GET_EMAIL}}
								<li>
									<label for="email">{!EMAIL_ADDRESS}{+START,IF,{EMAIL_OPTIONAL}} ({!OPTIONAL}){+END}</label>
									<input maxlength="255" class="wide_field{+START,IF,{$NOT,{EMAIL_OPTIONAL}}} input_text_required{+END}" id="email" type="text" value="{$MEMBER_EMAIL*}" name="email" />
								</li>
							{+END}

							{+START,IF_PASSED,REVIEW_RATING_CRITERIA}{+START,IF_PASSED,TYPE}{+START,IF_PASSED,ID}
								{+START,LOOP,REVIEW_RATING_CRITERIA}
									<li>
										<label for="review_rating__{TYPE*|}__{$FIX_ID,{REVIEW_TITLE}}__{ID*|}">{+START,IF_EMPTY,{REVIEW_TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{REVIEW_TITLE}}{REVIEW_TITLE*}:{+END}</label>
										<select id="review_rating__{TYPE*|}__{$FIX_ID,{REVIEW_TITLE}}__{ID*|}" name="review_rating">
											<option value="">{!NA}</option>
											<option value="10">*****</option>
											<option value="8">****</option>
											<option value="6">***</option>
											<option value="4">**</option>
											<option value="2">*</option>
										</select>
									</li>
								{+END}
							{+END}{+END}{+END}

							<li>
								<label for="post">{!POST_COMMENT}</label>
								<textarea accesskey="x" class="wide_field" onfocus="if ((this.value=='{POST_WARNING^*;}' &amp;&amp; '{POST_WARNING^*;}'!='') || (typeof this.strip_on_focus!='undefined' &amp;&amp; this.value==this.strip_on_focus)) this.value=''; this.style.color='black';" cols="42" rows="11" name="post" id="post">{POST_WARNING*}</textarea>
							</li>
						</ul>
					</div>
				{+END}

				{+START,IF,{$NOT,{$MOBILE}}}
					<div class="wide_table_wrap"><table class="wide_table" summary="{!MAP_TABLE}">
						<colgroup>
							<col style="width: 160px" />
							<col style="width: 100%" />
						</colgroup>

						<tbody>
							{+START,IF,{$AND,{$IS_GUEST},{$OCF}}}
								<tr>
									<th class="de_th">
										{!ocf:GUEST_NAME}:
									</th>

									<td>
										<label class="accessibility_hidden" for="poster_name_if_guest">{!ocf:GUEST_NAME}</label>
										<input maxlength="255" size="24" value="" type="text" tabindex="1" id="poster_name_if_guest" name="poster_name_if_guest" />
										{+START,IF_PASSED,JOIN_BITS}{+START,IF_NON_EMPTY,{JOIN_BITS}}
											<span class="associated_link_to_small">({JOIN_BITS})</span>
										{+END}{+END}
									</td>
								</tr>
							{+END}

							{+START,IF,{GET_TITLE}}
								<tr>
									<th class="de_th">
										{!POST_TITLE}:
									</th>

									<td>
										<label class="accessibility_hidden" for="title">{!POST_TITLE}</label>
										<div class="constrain_field">
											<input maxlength="255" class="wide_field" value="" type="text" tabindex="1" id="title" name="title" />
										</div>

										<div id="error_title" style="display: none" class="input_error_here">&nbsp;</div>
									</td>
								</tr>
							{+END}

							{+START,IF,{GET_EMAIL}}
								<tr>
									<th class="de_th">
										{!EMAIL_ADDRESS}{+START,IF,{EMAIL_OPTIONAL}} ({!OPTIONAL}){+END}:
									</th>

									<td>
										<label class="accessibility_hidden" for="email">{!EMAIL_ADDRESS}</label>
										<div class="constrain_field">
											<input maxlength="255" class="wide_field{+START,IF,{$NOT,{EMAIL_OPTIONAL}}} input_text_required{+END}" id="email" type="text" tabindex="2" value="{$MEMBER_EMAIL*}" name="email" />
										</div>

										<div id="error_email" style="display: none" class="input_error_here">&nbsp;</div>
									</td>
								</tr>
							{+END}

							{+START,IF_PASSED,REVIEW_RATING_CRITERIA}{+START,IF_PASSED,TYPE}{+START,IF_PASSED,ID}
								{+START,LOOP,REVIEW_RATING_CRITERIA}
									<tr>
										<th class="de_th">
											{+START,IF_EMPTY,{REVIEW_TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{REVIEW_TITLE}}{REVIEW_TITLE*}:{+END}
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
															setOpacity(bit,((review!=0) && (review/2>=i))?1.0:0.2);
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
												<label class="accessibility_hidden" for="review_rating__{TYPE*|}__{$FIX_ID,{REVIEW_TITLE}}__{ID*|}">{+START,IF_EMPTY,{REVIEW_TITLE}}{!RATING}:{+END}{+START,IF_NON_EMPTY,{REVIEW_TITLE}}{REVIEW_TITLE*}:{+END}</label>
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
								<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{!POST_COMMENT}"{+END} class="de_th">
									<img class="comcode_button" alt="" src="{$IMG*,comcode}" />
									{!POST_COMMENT}:

									{+START,IF_NON_EMPTY,{FIRST_POST}{COMMENT_TEXT}}
										<div class="comments_posting_form_links">
											(
											{+START,IF_NON_EMPTY,{FIRST_POST}}
												<a class="non_link" title="{!ocf:FIRST_POST}: {!LINK_NEW_WINDOW}" target="_blank" href="{FIRST_POST_URL*}" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{FIRST_POST^;~*}','30%',null,null,false,true);">{!ocf:FIRST_POST}</a>
												{+START,IF_NON_EMPTY,{COMMENT_TEXT}}
													|
												{+END}
											{+END}

											{+START,IF_NON_EMPTY,{COMMENT_TEXT}}
												<a class="non_link" href="{$PAGE_LINK*,:rules}" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$TRUNCATE_LEFT,{COMMENT_TEXT^;~*},1000,0,1}','30%',null,null,false,true);">{!HOVER_MOUSE_IMPORTANT}</a>
											{+END}
											)
										</div>
									{+END}

									{+START,IF,{$JS_ON}}
										{+START,IF,{$CONFIG_OPTION,is_on_emoticon_choosers}}
											<br />
											{+START,BOX,,,med}
												<div class="comments_posting_form_emoticons">
													{EM}

													{+START,IF,{$OCF}}
														<p>[ <a tabindex="6" href="#" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name=post{$KEEP*;}'),'site_emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;">{!EMOTICONS_POPUP}</a> ]</p>
													{+END}
												</div>
											{+END}
										{+END}
									{+END}
								</th>

								<td>
									<label class="accessibility_hidden" for="post">{!POST_COMMENT}</label>
									<div class="constrain_field">
										<textarea{+START,IF,{$NOT,{$MOBILE}}} onkeyup="manageScrollHeight(this);"{+END} accesskey="x" class="wide_field" onfocus="if ((this.value=='{POST_WARNING^*;}' &amp;&amp; '{POST_WARNING^*;}'!='') || (typeof this.strip_on_focus!='undefined' &amp;&amp; this.value==this.strip_on_focus)) this.value=''; this.style.color='black';" cols="42" rows="11" name="post" id="post">{POST_WARNING*}</textarea>
									</div>

									<div id="error_post" style="display: none" class="input_error_here">&nbsp;</div>
								</td>
							</tr>
						</tbody>
					</table></div>
				{+END}

				{$GET,EXTRA_COMMENTS_FIELDS_2}

				<div class="comments_posting_form_end">
					{$GET,EXTRA_COMMENTS_FIELDS_1}

					{+START,IF_PASSED,USE_CAPTCHA}
						{+START,IF,{USE_CAPTCHA}}
							<div class="comments_captcha">
								{+START,BOX,,,med}
									<label for="security_image">{!DESCRIPTION_SECURITY_IMAGE_2,<a target="_blank" title="{!AUDIO_VERSION}: {!LINK_NEW_WINDOW}" href="{$FIND_SCRIPT*,securityimage,1}?mode=audio{$KEEP*,0,1}">{!AUDIO_VERSION}</a>}</label><br /><br />
									{+START,IF,{$VALUE_OPTION,css_captcha_only}}
										<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} id="captcha" style="width:100px; height: 52px" title="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" src="{$FIND_SCRIPT*,securityimage}{$KEEP*,1,1}">{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}</iframe>
									{+END}
									{+START,IF,{$NOT,{$VALUE_OPTION,css_captcha_only}}}
										<img class="no_alpha" id="captcha" title="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" alt="{!CONTACT_STAFF_TO_JOIN_IF_IMPAIRED}" src="{$FIND_SCRIPT*,securityimage}{$KEEP*,1,1}" />
									{+END}
									<input maxlength="6" size="6" class="input_text_required" value="" type="text" id="security_image" name="security_image" /><br />
								{+END}
							</div>
						{+END}
					{+END}

					<div class="proceed_button">
						{+START,IF,{$JS_ON}}{+START,IF,{$CONFIG_OPTION,enable_previews}}{+START,IF,{$NOT,{$VALUE_OPTION,xhtml_strict}}}
							<button onclick="if (typeof this.form=='undefined') var form=window.form_submitting; else var form=this.form; if (do_form_preview(form,maintain_theme_in_link('{$PREVIEW_URL*;}{$KEEP*;}'))) form.submit();" id="preview_button" accesskey="p" tabindex="250" class="button_pageitem" type="button">{!PREVIEW}</button>
							&nbsp;
						{+END}{+END}{+END}
						{+START,IF_PASSED,MORE_URL}
							{+START,IF,{$JS_ON}}
								<button tabindex="5" accesskey="y" onclick="if (typeof this.form=='undefined') var form=window.form_submitting; else var form=this.form; form.setAttribute('target','_top'); if (!form.old_action) form.old_action=form.getAttribute('action'); form.setAttribute('action','{MORE_URL*;}'); if ((typeof this.form.elements['post'].strip_on_focus!='undefined') &amp;&amp; (this.form.elements['post'].value==this.form.elements['post'].strip_on_focus)) this.form.elements['post'].value=''; form.submit();" class="button_pageitem" type="button">{!FULL_EDITOR}</button>
								&nbsp;
							{+END}
						{+END}
						<button onclick="if (typeof this.form=='undefined') var form=window.form_submitting; else var form=this.form; form.setAttribute('target','_top'); if (form.old_action) form.setAttribute('action',form.old_action); if (form.onsubmit(event)) { disable_button_just_clicked(document.getElementById('submit_button')); form.submit(); }" tabindex="4" accesskey="u" id="submit_button" class="button_pageitem" {+START,IF,{$JS_ON}}type="button"{+END}{+START,IF,{$NOT,{$JS_ON}}}type="submit"{+END}><strong>{+START,IF_PASSED,SUBMIT_NAME}{SUBMIT_NAME*}{+END}{+START,IF_NON_PASSED,SUBMIT_NAME}{+START,IF_NON_EMPTY,{TITLE}}{TITLE*}{+END}{+START,IF_EMPTY,{TITLE}}{!SEND}{+END}{+END}</strong></button>
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
	<br />

	{+START,IF,{$FORCE_PREVIEWS}}
		<script type="text/javascript">// <![CDATA[
			document.getElementById('submit_button').style.display='none';
		//]]></script>
	{+END}

	<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} title="{!PREVIEW}" name="preview_iframe" id="preview_iframe" src="{$BASE_URL*}/uploads/index.html" class="preview_iframe">{!PREVIEW}</iframe>
{+END}{+END}{+END}

{+START,IF_PASSED,USE_CAPTCHA}
	{+START,IF,{USE_CAPTCHA}}
		<script type="text/javascript">// <![CDATA[
			var form=document.getElementById('comments_form');
			form.old_submit=form.onsubmit;
			form.onsubmit=function()
				{
					document.getElementById('submit_button').disabled=true;
					var url='{$FIND_SCRIPT;,snippet}?snippet=captcha_wrong&name='+window.encodeURIComponent(form.elements['security_image'].value);
					if (!do_ajax_field_test(url))
					{
						document.getElementById('captcha').src+='&'; // Force it to reload latest captcha
						document.getElementById('submit_button').disabled=false;
						return false;
					}
					document.getElementById('submit_button').disabled=false;
					if (typeof form.old_submit!='undefined' && form.old_submit) return form.old_submit();
					return true;
				};
			addEventListenerAbstract(window,'pageshow',function () {
				document.getElementById('captcha').src+='&'; // Force it to reload latest captcha
			} );
		//]]></script>
	{+END}
{+END}
