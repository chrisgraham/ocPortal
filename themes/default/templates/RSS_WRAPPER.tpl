<?xml version="1.0" encoding="{$CHARSET*}"?>
<?xml-stylesheet href="{$FIND_SCRIPT*,backend}?type=xslt-rss" type="text/xsl"?>
{+START,IF,{$NOT,{$BROWSER_MATCHES,itunes}}}
<rss version="2.0">
{+END}
{+START,IF,{$BROWSER_MATCHES,itunes}}
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
{+END}
	<channel>
		<title>{$SITE_NAME*}: {MODE_NICE*}</title>
		<link>{$BASE_URL*}</link>
		<language>{$LANG*}</language>
		<copyright>{COPYRIGHT`}</copyright>
		{+START,IF,{$NOT,{$BROWSER_MATCHES,itunes}}}
		<description>{ABOUT`}</description>
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
		{+END}
		<webMaster>{$STAFF_ADDRESS} ({$SITE_NAME*})</webMaster>
		<lastBuildDate>{DATE*}</lastBuildDate>
		<generator>ocPortal</generator>
		{CONTENT}
	</channel>
</rss>


