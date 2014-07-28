{+START,IF,{$NOT,{$BROWSER_MATCHES,itunes}}}<?xml version="1.0" encoding="{$CHARSET*}"?>
<?xml-stylesheet href="{$FIND_SCRIPT*,backend}?type=xslt-rss{$KEEP*,0,1}" type="text/xsl"?>
<rss version="2.0">
{+END}
{+START,IF,{$BROWSER_MATCHES,itunes}}<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
{+END}
	<channel>
		<title>{$SITE_NAME*}: {MODE_NICE*}</title>
		<link>{$BASE_URL*}</link>
		<language>{$LANG*}</language>
		<copyright>{COPYRIGHT`}</copyright>
		<description>{ABOUT`}</description>
		{+START,IF,{$NOT,{$BROWSER_MATCHES,itunes}}}
			<managingEditor>{$STAFF_ADDRESS} ({$SITE_NAME*})</managingEditor>
			<docs>http://blogs.law.harvard.edu/tech/rss</docs>
			<category>{$SITE_SCOPE*}</category>
			{RSS_CLOUD}
			<image><url>{LOGO_URL`}</url><title>{$SITE_NAME*}</title><link>{$BASE_URL*}</link></image>
		{+END}
		{+START,IF,{$BROWSER_MATCHES,itunes}}
			<itunes:summary>{ABOUT}</itunes:summary>
			<itunes:author>{$STAFF_ADDRESS} ({$SITE_NAME*})</itunes:author>
			<itunes:owner>
				<itunes:name>{$SITE_NAME*}</itunes:name>
				<itunes:email>{$STAFF_ADDRESS}</itunes:email>
			</itunes:owner>
			<itunes:image href="{LOGO_URL}" />
			<itunes:category text="{$SITE_SCOPE*}" />
			<itunes:keywords>{$CONFIG_OPTION*,keywords}</itunes:keywords>
			<atom:link type="application/rss+xml" href="{SELF_URL*}" rel="self" />
		{+END}
		<webMaster>{$STAFF_ADDRESS} ({$SITE_NAME*})</webMaster>
		<lastBuildDate>{DATE*}</lastBuildDate>
		<generator>ocPortal</generator>
		{CONTENT}
	</channel>
</rss>


