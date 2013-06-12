<?php

if (!isset($map['id'])) $map['id']=strval(db_get_first_id());
$id=intval($map['id']);

$subdownloads=new ocp_tempcode();
require_code('ocfiltering');
$filter_where=ocfilter_to_sqlfragment(strval($id).'*','id','download_categories','parent_id','category_id','id');
$all_rows=$GLOBALS['SITE_DB']->query('SELECT d.*,text_original FROM '.get_table_prefix().'download_downloads d LEFT JOIN '.get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND d.name=t.id WHERE '.$filter_where,20,NULL,false,true);
shuffle($all_rows);
require_code('images');
foreach ($all_rows as $d_row)
{
	if ($GLOBALS['RECORD_LANG_STRINGS_CONTENT'] || is_null($d_row['text_original'])) $d_row['text_original']=get_translated_text($d_row['description']);
	$d_url=build_url(array('page'=>'_SELF','type'=>'entry','id'=>$d_row['id']),'_SELF');
	if (addon_installed('galleries'))
	{
		$i_rows=$GLOBALS['SITE_DB']->query_select('images',array('url','thumb_url','id'),array('cat'=>'download_'.strval($d_row['id'])),'',1,$d_row['default_pic']-1);
		if (array_key_exists(0,$i_rows))
		{
			$thumb_url=ensure_thumbnail($i_rows[0]['url'],$i_rows[0]['thumb_url'],'galleries','images',$i_rows[0]['id']);
			$subdownloads->attach(hyperlink($d_url,do_image_thumb($thumb_url,render_download_box($d_row,false,false/*breadcrumbs?*/,'_SEARCH',NULL,false/*context?*/))));
		}
	}
}

require_lang('downloads');

require_lang('javascript_dyn_comcode');

$carousel_id=uniqid('',true);

$content='
	<div id="carousel_'.$carousel_id.'" class="carousel" style="display: none">
		<div class="move_left" onmousedown="carousel_move('.$carousel_id.',-100); return false;" onmouseover="this.className=\'move_left move_left_hover\';" onmouseout="this.className=\'move_left\';"></div>
		<div class="move_right" onmousedown="carousel_move('.$carousel_id.',+100); return false;" onmouseover="this.className=\'move_right move_right_hover\';" onmouseout="this.className=\'move_right\';"></div>

		<div class="main">
		</div>
	</div>

	<div class="carousel_temp" id="carousel_ns_'.$carousel_id.'">
		'.$subdownloads->evaluate().'
	</div>

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,\'load\',function () {
			initialise_carousel('.$carousel_id.');
		} );
	//]]></script>
';

put_in_standard_box(make_string_tempcode($content),do_lang('RANDOM_20_DOWNLOADS'));
