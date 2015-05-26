(function() {
	CKEDITOR.plugins.add('ocportal', {
		init: function(editor) {
			var possibles=['block','comcode','page','quote','box','code'];
			for (var i=0;i<possibles.length;i++)
			{
				var buttonName=possibles[i];
				var elements=get_elements_by_class_name(editor.element.$.parentNode.parentNode,'comcode_button_'+buttonName);
				if (typeof elements[0]!='undefined')
				{
					var func= {
						exec: function(e) { return function() { e.onclick.call(e); } }(elements[0])
					};
					var label=elements[0].alt;
					var icon='plugins/ocportal/images/'+buttonName+'.png';

					editor.addCommand('ocportal_'+buttonName,func);
					editor.ui.addButton('ocportal_'+buttonName,{
						label: label,
						icon: icon,
						command: 'ocportal_'+buttonName
					});

					elements[0].parentNode.parentNode.style.display='none';
				}
			}

			var func= {
				exec: function(e) {
					if (typeof window.lang_PREFER_OCP_ATTACHMENTS=='undefined')
					{
						editor.execCommand('image');
					} else
					{
						fauxmodal_alert(window.lang_PREFER_OCP_ATTACHMENTS,function() {
							editor.execCommand('image');
						});
					}
				}
			};
			editor.addCommand('ocportal_image',func);
			editor.ui.addButton('ocportal_image',{
				label: editor.lang.common.image,
				command: 'ocportal_image'
			});
		}
	});
})();
