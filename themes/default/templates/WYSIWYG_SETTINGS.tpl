// Carefully work out toolbar
var precision_editing=((typeof window.take_errors!='undefined') && window.take_errors) || (typeof get_elements_by_class_name(document.body,'comcode_button_box')[0]!='undefined'); // Look to see if this Comcode button is here as a hint whether we are doing an advanced editor. Unfortunately we cannot put contextual Tempcode inside a Javascript file, so this trick is needed.
var toolbar=[];
if (precision_editing)
	toolbar.push(['Source','-']);
toolbar.push(['Cut','Copy','Paste',precision_editing?'PasteText':null,precision_editing?'PasteFromWord':null{+START,IF,{$VALUE_OPTION,commercial_spellchecker}},'-','SpellChecker', 'Scayt'{+END}]);
toolbar.push(['Undo','Redo',precision_editing?'-':null,precision_editing?'Find':null,precision_editing?'Replace':null,'-',precision_editing?'SelectAll':null,'RemoveFormat']);
toolbar.push(['Link','Unlink']);
toolbar.push(precision_editing?'/':'-');
var formatting=['Bold','Italic','Strike','-','Subscript','Superscript'];
toolbar.push(formatting);
toolbar.push(['NumberedList','BulletedList',precision_editing?'-':null,precision_editing?'Outdent':null,precision_editing?'Indent':null]);
if (precision_editing)
	toolbar.push(['JustifyLeft','JustifyCenter','JustifyRight',precision_editing?'JustifyBlock':null]);
toolbar.push([precision_editing?'Image':null,'Table']);
if (precision_editing)
	toolbar.push('/');
toolbar.push(['Format','Font','FontSize']);
toolbar.push(['TextColor']);
if (precision_editing)
	toolbar.push(['Maximize', 'ShowBlocks']);
if (precision_editing)
	toolbar.push(['HorizontalRule','SpecialChar']);
var use_ocportal_toolbar=true;
if (use_ocportal_toolbar)
	toolbar.push(['ocportal_block','ocportal_comcode','ocportal_page','ocportal_quote','ocportal_box','ocportal_code']);

var editor_settings={
	enterMode : CKEDITOR.ENTER_BR,
	uiColor : wysiwyg_color,
	fontSize_sizes : '0.6em;0.85em;1em;1.1em;1.2em;1.3em;1.4em;1.5em;1.6em;1.7em;1.8em;2em',
	removePlugins: 'smiley,uicolor,contextmenu,forms',
	extraPlugins: ''+(use_ocportal_toolbar?'ocportal':''),
	customConfig : '',
	bodyId : 'htmlarea',
	baseHref : get_base_url()+'/',
	linkShowAdvancedTab : {$?,{$CONFIG_OPTION,eager_wysiwyg},false,true},
	imageShowAdvancedTab : {$?,{$CONFIG_OPTION,eager_wysiwyg},false,true},
	imageShowLinkTab : {$?,{$CONFIG_OPTION,eager_wysiwyg},false,true},
	imageShowSizing : {$?,{$CONFIG_OPTION,eager_wysiwyg},false,true},
	autoUpdateElement : true,
	contentsCss : pageStyleSheets,
	cssStatic : css,
	startupOutlineBlocks : true,
	language : (window.ocp_lang)?ocp_lang.toLowerCase():'en',
	emailProtection : false,
	resize_enabled : true,
	width : find_width(element),
	height : (window.location.href.indexOf('cms_comcode_pages')==-1)?250:500,
	{+START,IF,{$NOT,{$VALUE_OPTION,commercial_spellchecker}}}
		disableNativeSpellChecker : false,
	{+END}
	toolbar : toolbar
};
