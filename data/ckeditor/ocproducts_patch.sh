#!/bin/bash

echo 'Make sure data/ckeditor/plugins/ocportal is preserved'

echo "Removing unneeded files"
rm -rf skins/office2003 skins/v2 INSTALL.html ckeditor.asp CHANGES.html _samples _source ckeditor.pack config.js ckeditor_source.js ckeditor_basic.js ckeditor_basic_source.js ckeditor_php4.php ckeditor_php5.php ckeditor.php adapters plugins/adobeair plugins/ajax plugins/bbcode plugins/devtools plugins/docprops plugins/placeholder plugins/smiley plugins/wsc plugins/uicolor plugins/xml

echo "Patching..."

sed -i "" 's/CKEDITOR\.lang\['\''en-gb'\''\]={/CKEDITOR\.lang\['\''en-gb'\''\]={ocp_attach:'\''You can link to your manually-uploaded images here, although normally you would use attachments\.'\'',/' lang/en-gb.js

sed -i "" 's/CKEDITOR\.lang\['\''en'\''\]={/CKEDITOR\.lang\['\''en-gb'\''\]={ocp_attach:'\''You can link to your manually-uploaded images here, although normally you would use attachments\.'\'',/' lang/en.js

sed -i "" 's/,'\''default'\'':500/,'\''default'\'':'\''100%'\''/' plugins/table/dialogs/table.js

sed -i "" 's/'\''txtBorder'\'','\''default'\'':1/'\''txtBorder'\'','\''default'\'':'\''0'\''/' plugins/table/dialogs/table.js

sed -i "" 's/table\.cellSpace,'\''default'\'':1/table\.cellSpace,'\''default'\'':'\''0'\''/' plugins/table/dialogs/table.js

sed -i "" 's/table\.cellPad,'\''default'\'':1/table\.cellPad,'\''default'\'':'\''0'\''/' plugins/table/dialogs/table.js

sed -i "" 's/{type:'\''hbox'\'',widths:\['\''50%'\'','\''50%'\''\],children:\[{type:'\''vbox'\'',padding:1,children:/{type:'\''hbox'\'',style:'\''display: '\''+(b\.config\.imageShowSizing?'\''block'\'':'\''none'\''),widths:\['\''50%'\'','\''50%'\''\],children:\[{type:'\''vbox'\'',padding:1,children:/' plugins/image/dialogs/image.js

sed -i "" 's/onLoad:function(){var C=this;/onLoad:function(){var C=this; if ( !b\.config\.imageShowAdvancedTab ) C\.hidePage( '\''advanced'\'' ); if ( !b\.config\.imageShowLinkTab ) C\.hidePage( '\''Link'\'' );/' plugins/image/dialogs/image.js

sed -i "" 's/{type:'\''vbox'\'',padding:0,children:\[{/{type:'\''vbox'\'',padding:0,children:\[{ type : '\''html'\'', style : '\''width:100%;'\'', html : '\''\<p\>'\''\+(b\.lang\.common\.ocp_attach?b\.lang\.common\.ocp_attach:'\''You can link to your manually-uploaded images here, although normally you would use attachments\. You can also make fine adjustments to attached images here\.'\'')\+'\''\<\/p\>\<br \/\>'\'',/' plugins/image/dialogs/image.js

sed -i "" 's/if(b\.webkit\&\&this\.\$\.parent)this\.\$\.parent\.focus();this\.\$\.focus();/try { if(b\.webkit\&\&this\.\$\.parent)this\.\$\.parent\.focus();this\.\$\.focus(); } catch (e) {};/' ckeditor.js

echo "Converting line endings"
find . -name "*.js" -exec dos2unix {} \;
find . -name "*.css" -exec dos2unix {} \;
find . -name "*.html" -exec dos2unix {} \;
find . -name "*.txt" -exec dos2unix {} \;
dos2unix .htaccess

echo "Done!"
