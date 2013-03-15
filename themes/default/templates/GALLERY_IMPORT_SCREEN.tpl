{TITLE}

{+START,IF_NON_EMPTY,{FORM2}}
	<h2>{!BATCH_IMPORT_ARCHIVE_CONTENTS}</h2>
{+END}

{FORM}

{+START,IF_NON_EMPTY,{FORM2}}
	<div class="orphaned_content">
		<h2>{!ORPHANED_IMAGES}</h2>

		{$REPLACE, for=", for="second_,{$REPLACE, id=", id="second_,{FORM2}}}

		<script type="text/javascript">// <![CDATA[
			function preview_generator_mouseover(event)
			{
				if (typeof event=='undefined') var event=window.event;
				if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'<img width="500" src="{$BASE_URL*}/uploads/galleries/'+window.encodeURI(this.value)+'" \/>','auto');
			}

			function preview_generator_mousemove(event)
			{
				if (typeof event=='undefined') var event=window.event;
				if (typeof window.activate_tooltip!='undefined') reposition_tooltip(this,event);
			}

			function preview_generator_mouseout(event)
			{
				if (typeof event=='undefined') var event=window.event;
				if (typeof window.deactivate_tooltip!='undefined') deactivate_tooltip(this,event);
			}

			function load_previews()
			{
				var files=document.getElementById('second_files');
				if (!files) return;
				for (var i=0;i<files.options.length;i++)
				{
					files[i].onmouseover=preview_generator_mouseover;
					files[i].onmousemove=preview_generator_mousemove;
					files[i].onmouseout=preview_generator_mouseout;
				}
			}
			load_previews();
		//]]></script>
	</div>
{+END}

