<div id="java_detect"></div>

<script type="text/javascript">// <![CDATA[
	var java_detect='';
	java_detect+='	<object width="1" height="1" classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" id="java_checker_1">';
	java_detect+='		<param name="codebase" value="{$BASE_URL*}/data/javaupload/" />';
	java_detect+='		<param name="code" value="Checker.class" />';
	java_detect+='		<param name="scriptable" VALUE="true" />';
	java_detect+='		<param name="mayscript" VALUE="true" />';
	java_detect+='		<comment>';
	java_detect+='			<embed width="1" height="1" id="java_checker_2" scriptable="true" mayscript="true" codebase="{$BASE_URL*}/data/javaupload/" code="Checker.class" type="application/x-java-applet" pluginspage="http://java.sun.com/products/plugin/index.html#download">';
	java_detect+='			</embed>';
	java_detect+='		</comment>';
	java_detect+='	</object>';
	set_inner_html(document.getElementById('java_detect'),java_detect);
//]]></script>
