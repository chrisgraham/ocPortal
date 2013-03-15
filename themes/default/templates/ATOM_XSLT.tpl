<?xml version="1.0" encoding="{$CHARSET*}"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" version="1.0">
	<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<xsl:template match="/">
		<html lang="{$LANG*}" dir="{!dir}">
			<head>
				<title><xsl:value-of select="/atom:feed/atom:title" disable-output-escaping="yes" /></title>
				<meta name="GENERATOR" content="{$BRAND_NAME*}" />
				<script type="text/javascript" src="{JAVASCRIPT_XSL_MOPUP*}"></script>
				<xsl:element name="meta">
					<xsl:attribute name="name"><xsl:text>description</xsl:text></xsl:attribute>
					<xsl:attribute name="content"><xsl:value-of select="/atom:feed/atom:subtitle" /></xsl:attribute>
				</xsl:element>
				<meta http-equiv="Content-Type" content="text/html; charset={$CHARSET*}" />
				{$CSS_TEMPCODE}
			</head>
			<body class="website_body" onload="go_decoding();">
				<div id="cometestme" style="display: none;">
					<xsl:text disable-output-escaping="yes">&amp;amp;</xsl:text>
				</div>
				<div class="rss_main">
					<xsl:element name="img">
						<xsl:attribute name="src"><xsl:value-of select="/atom:feed/atom:logo" /></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="/atom:feed/atom:subtitle" /></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="/atom:feed/atom:title" /></xsl:attribute>
					</xsl:element>
				</div>

				<div class="rss_main_inner">
					<div class="box box___atom_xslt"><div class="box_inner">
						<h1><span name="decodeable"><xsl:value-of disable-output-escaping="yes" select="/atom:feed/atom:title" /></span></h1>

						<p id="xslt_introduction">{!RSS_XSLT_INTRODUCTION}</p>
						<xsl:apply-templates select="atom:feed" />
						<p class="rss_copyright"><span name="decodeable"><xsl:value-of select="/atom:feed/atom:rights" disable-output-escaping="yes" /></span></p>
					</div></div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="atom:feed">
		<xsl:apply-templates select="atom:entry" />
	</xsl:template>
	<xsl:template match="atom:entry">
		<h2>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="atom:link[@rel='alternate']/@href" /></xsl:attribute>
				<span name="decodeable"><xsl:value-of select="atom:title" disable-output-escaping="yes" /></span>
			</xsl:element>
		</h2>
		<p><span name="decodeable"><xsl:value-of select="atom:summary" disable-output-escaping="yes" /></span></p>
		<xsl:if test="atom:content">
			<p><span name="decodeable"><xsl:value-of select="atom:content" disable-output-escaping="yes" /></span></p>
		</xsl:if>
		<cite>
			<xsl:text>{!_SUBMITTED_BY} </xsl:text>
			<xsl:value-of select="atom:author/atom:name" />
			<xsl:text>, "</xsl:text>
			<xsl:value-of select="atom:category/@label" />
			<xsl:text>", </xsl:text>
			<xsl:value-of select="atom:published" />
			<xsl:if test="atom:modified and atom:modified!=atom:published">
				<xsl:text> ({!MODIFIED}: </xsl:text>
				<xsl:value-of select="atom:modified" />
				<xsl:text>)</xsl:text>
			</xsl:if>
		</cite>
	</xsl:template>
</xsl:stylesheet>
