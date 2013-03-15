<?xml version="1.0" encoding="{$CHARSET*}"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<xsl:template match="/">
		<html lang="{$LANG*}" dir="{!dir}">
			<head>
				<title><xsl:value-of select="/opml/head/title" disable-output-escaping="yes" /></title>
				<meta name="GENERATOR" content="{$BRAND_NAME*}" />
				<script type="text/javascript" src="{JAVASCRIPT_XSL_MOPUP*}"></script>
				<xsl:element name="meta">
					<xsl:attribute name="name"><xsl:text>description</xsl:text></xsl:attribute>
					<xsl:attribute name="content"><xsl:value-of select="/opml/head/title" /></xsl:attribute>
				</xsl:element>
				{$CSS_TEMPCODE}
			</head>
			<body class="website_body" onload="go_decoding();">
				<div id="cometestme" style="display: none;">
					<xsl:text disable-output-escaping="yes">&amp;amp;</xsl:text>
				</div>

				<div class="rss_main_inner">
					<div class="box box___opml_xslt"><div class="box_inner">
						<h1><span name="decodeable"><xsl:value-of disable-output-escaping="yes" select="/opml/head/title" /></span></h1>

						<p id="xslt_introduction">{!OPML_INDEX_DESCRIPTION}</p>
						<xsl:apply-templates select="/opml/body" />
						<p class="rss_copyright"><span name="decodeable"><xsl:value-of select="/opml/head/ownerName" disable-output-escaping="yes" /></span></p>
					</div></div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="body">
		<h2>Atom</h2>
		<ul>
			<xsl:apply-templates select="outline[@text='Atom']/outline" />
		</ul>
		<h2>RSS</h2>
		<ul>
			<xsl:apply-templates select="outline[@text='RSS']/outline" />
		</ul>
	</xsl:template>
	<xsl:template match="outline">
		<li>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="@xmlUrl" /></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="@title" /></xsl:attribute>
				<xsl:value-of select="@text" />
			</xsl:element>
		</li>
	</xsl:template>
</xsl:stylesheet>
