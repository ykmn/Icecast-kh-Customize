<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0" >
<xsl:output method="xml" media-type="text/html" indent="yes" encoding="UTF-8"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template match = "/icestats" >
<html>
<head>
<title>Icecast Streaming Media Server</title>
<link rel="stylesheet" type="text/css" href="/style.css" />
</head>
<body bgcolor="#000" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

<div class="main">

<div class="roundcont">
<div class="roundtop">
<img src="/images/corner_topleft.jpg" class="corner" style="display: none" />
</div>
<div class="newscontent">
<xsl:for-each select="source">
    <div class="streamheader">
        <table cellspacing="0" cellpadding="0">
            <colgroup align="left" />
            <colgroup align="right" width="300" />
            <tr>
                <td><h3>Mount Point <xsl:value-of select="@mount" /></h3></td>
                <xsl:choose>
                    <xsl:when test="authenticator">
                        <td align="right"><a class="auth" href="/auth.xsl">Login</a></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right"> <a href="{@mount}.m3u">M3U</a> <a href="{@mount}.xspf">XSPF</a></td>
                    </xsl:otherwise>
                </xsl:choose>
        </tr></table>
    </div>

	<table border="0" cellpadding="1" cellspacing="5" bgcolor="444444">
	<tr>        
	    <td align="center">
			<a class="nav2" href="listclients.xsl?mount={@mount}">List Clients</a>
        	<a class="nav2" href="moveclients.xsl?mount={@mount}">Move Listeners</a>
			<a class="nav2" href="updatemetadata.xsl?mount={@mount}">Update Metadata</a>
        	<a class="nav2" href="killsource.xsl?mount={@mount}">Kill Source</a>
	    </td></tr>
	</table>
<br />
<table cellpadding="5" border="1" bordercolor="#C0C0C0" >
		<thead>
				<td ><center><b>IP</b></center></td>
				<td ><center><b>Connected (d:h:m:s)</b></center></td>
				<td ><center><b>Lag (bytes)</b></center></td>
				<td ><center><b>User Agent</b></center></td>
				<td ><center><b>Action</b></center></td>
		</thead>
    <tbody>
<xsl:variable name = "themount" ><xsl:value-of select="@mount" /></xsl:variable>

<!-- v2.2 modified by R.E 2016-12-14 -->

<xsl:for-each select="listener">

<xsl:variable name = "theIP" ><xsl:value-of select="IP" /></xsl:variable>
		<tr>
                <td align="center">
			<a href="https://www.whois.com/whois/{$theIP}" target="_blank">
			<xsl:value-of select="IP" /></a>
			<xsl:if test="username"> (<xsl:value-of select="username" />)</xsl:if></td>
		<td align="center">
			<xsl:variable name="seconds" ><xsl:value-of select="Connected" /></xsl:variable>    
			<xsl:variable name="d" select="floor($seconds div 86400)"/>
			<xsl:variable name="h" select="floor($seconds div 3600) mod 24"/>
			<xsl:variable name="m" select="floor($seconds div 60) mod 60"/>
			<xsl:variable name="s" select="$seconds mod 60"/>
			<xsl:value-of select="format-number($d, '00d ')" />
			<xsl:value-of select="format-number($h, '00h ')" />
			<xsl:value-of select="format-number($m, '00m ')" />
			<xsl:value-of select="format-number($s, '00s ')" />
			<!-- (<xsl:value-of select="$seconds" /> sec) -->
		</td>
		<td align="center"><xsl:value-of select="lag" /></td>
		<td align="center"><xsl:value-of select="UserAgent" /></td>
		<td align="center"><a href="killclient.xsl?mount={$themount}&amp;id={@id}">Kick</a></td>
		</tr>
</xsl:for-each>
    </tbody>
</table>
<br />
<br />
</xsl:for-each>
<xsl:text disable-output-escaping="yes">&amp;</xsl:text>nbsp;
</div>
<div class="roundbottom">
<img src="/images/corner_bottomleft.jpg" class="corner" style="display: none" />
</div>
</div>
<div class="poster">Support icecast development at <a class="nav" href="http://www.icecast.org">www.icecast.org</a></div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
