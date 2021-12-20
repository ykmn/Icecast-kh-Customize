<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0" >
<xsl:output method="xml" media-type="text/html" indent="yes" encoding="UTF-8"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template match = "/icestats" >
<html>
<head>
<title>Icecast Streaming Media Server</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" type="text/css" href="player/css/player.min.css" />
<script type="text/javascript" src="player/script/howler.min.js"></script>
<script type="text/javascript" src="player/script/player.min.js"></script>

<!-- here goes google chart -->
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
// View documentation at https://developers.google.com/chart/interactive/docs/gallery/piechart
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);

function drawVisualization() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Mount');
  data.addColumn('number', 'Clients');


  data.addRows([
	['TOTAL', <xsl:value-of select="listeners" />],
	<xsl:for-each select="source">
		['<xsl:value-of select="@mount" />', <xsl:value-of select="listeners" />]
		<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
	</xsl:for-each>
  ]);


// Options for PieChart:
  var options = {
      title: 'Icecast Mounts Status',
      fontName: 'Cuprum, "Segoe UI", tahoma',
      titleTextStyle: {fontSize: 28, bold: false, color: '#000000'},
      vAxis: {title: 'Clients'},
      hAxis: {title: 'Mounts'},
      seriesType: 'bars',
      pieHole: 0.3,
      pieSliceText: 'label',
      pieSliceTextStyle: {fontSize: 12},
  };
// pieSliceText can be percentage, value, label or none
  var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
  chart.draw(data, options);
}


</script>
<!-- here ends google chart -->



</head>
<body>
<div class="main">

<!--mount google chart -->
<br />
<br />
<div class="roundcont">
<div class="roundtop">
<img src="/images/corner_topleft.jpg" class="corner" style="display: none" alt=""/>
</div>
<div class="newscontent">
<div id="chart_div" style="width:100%; height:360px;"></div>
<div class="roundbottom">
<img src="/images/corner_bottomleft.jpg" class="corner" style="display: none" alt="" />
</div>
</div>
</div>



<br />
<br />
<!-- Yandex.Metrika counter -->
<script type="text/javascript">
    (function (d, w, c) {
        (w[c] = w[c] || []).push(function() {
            try {
                w.yaCounter38540800 = new Ya.Metrika({
                    id:38540800,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true
                });
            } catch(e) { }
        });

        var n = d.getElementsByTagName("script")[0],
            s = d.createElement("script"),
            f = function () { n.parentNode.insertBefore(s, n); };
        s.type = "text/javascript";
        s.async = true;
        s.src = "https://mc.yandex.ru/metrika/watch.js";

        if (w.opera == "[object Opera]") {
            d.addEventListener("DOMContentLoaded", f, false);
        } else { f(); }
    })(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="https://mc.yandex.ru/watch/38540800" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->





<!--mount point stats-->
<xsl:for-each select="source">
<div class="roundcont">
<div class="roundtop">
<img src="/images/corner_topleft.jpg" class="corner" style="display: none" alt=""/>
</div>
<div class="newscontent">
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
                        <td align="right">
			<a href="{@mount}.m3u">M3U</a> <a href="{@mount}.xspf">XSPF</a>
                        <xsl:if test="server_type and ((server_type = 'application/ogg') or (server_type = 'audio/ogg') or (server_type = 'audio/mpeg') or (server_type = 'audio/aacp') or (server_type = 'audio/aac'))">
				<div class="audioplayer" style="margin-top:10px;">
					<ul class="graphic">
					<li><a href="{@mount}" class="inline-playable"></a></li>
					</ul>
				</div>
			</xsl:if>
			</td>
                    </xsl:otherwise>
                </xsl:choose>
        </tr></table>
    </div>


<table border="0" cellpadding="4">
<xsl:if test="server_name">
<tr><td>Stream Title:</td><td class="streamdata"> <xsl:value-of select="server_name" /></td></tr>
</xsl:if>
<xsl:if test="server_description">
<tr><td>Stream Description:</td><td class="streamdata"> <xsl:value-of select="server_description" /></td></tr>
</xsl:if>
<xsl:if test="server_type">
<tr><td>Content Type:</td><td class="streamdata"><xsl:value-of select="server_type" /></td></tr>
</xsl:if>
<xsl:if test="stream_start">
<tr><td>Mount Start:</td><td class="streamdata"><xsl:value-of select="stream_start" /></td></tr>
</xsl:if>
<xsl:if test="bitrate">
<tr><td>Bitrate:</td><td class="streamdata"> <xsl:value-of select="bitrate" /></td></tr>
</xsl:if>
<xsl:if test="quality">
<tr><td>Quality:</td><td class="streamdata"> <xsl:value-of select="quality" /></td></tr>
</xsl:if>
<xsl:if test="video_quality">
<tr><td>Video Quality:</td><td class="streamdata"> <xsl:value-of select="video_quality" /></td></tr>
</xsl:if>
<xsl:if test="frame_size">
<tr><td>Framesize:</td><td class="streamdata"> <xsl:value-of select="frame_size" /></td></tr>
</xsl:if>
<xsl:if test="frame_rate">
<tr><td>Framerate:</td><td class="streamdata"> <xsl:value-of select="frame_rate" /></td></tr>
</xsl:if>
<xsl:if test="listeners">
<tr><td>Current Listeners:</td><td class="streamdata"> <xsl:value-of select="listeners" /></td></tr>
</xsl:if>
<xsl:if test="listener_peak">
<tr><td>Peak Listeners:</td><td class="streamdata"> <xsl:value-of select="listener_peak" /></td></tr>
</xsl:if>
<xsl:if test="genre">
<tr><td>Stream Genre:</td><td class="streamdata"> <xsl:value-of select="genre" /></td></tr>
</xsl:if>
<xsl:if test="server_url">
<tr><td>Stream URL:</td><td class="streamdata"> <a target="_blank" href="{server_url}"><xsl:value-of select="server_url" /></a></td></tr>
</xsl:if>
<xsl:if test="video_preview">
<xsl:choose>
<xsl:when test="authenticator">
<tr><td>Preview:</td><td class="videopreview"> <a href="auth.xsl"><img src="{video_preview}" border="1" align="left" height="400" width="300" alt="frame preview" title="click to start watching the video!" /></a></td></tr>
</xsl:when>
<xsl:otherwise>
<tr><td>Preview:</td><td class="videopreview"> <a href="{@mount}.m3u"><img src="{video_preview}" border="1" align="left" height="200"  alt="frame preview" title="click to start watching the video!" /></a></td></tr>
</xsl:otherwise>
</xsl:choose>
</xsl:if>

<tr><td>Current Song:</td><td class="streamdata"> 
<xsl:if test="artist"><xsl:value-of select="artist" /> - </xsl:if><xsl:value-of select="title" /></td></tr>
</table>
</div>
<div class="roundbottom">
<img src="/images/corner_bottomleft.jpg" class="corner" style="display: none" alt="" />
</div>
</div>
<br />
<br />

</xsl:for-each>
<xsl:text disable-output-escaping="yes">&amp;</xsl:text>nbsp;

<div class="poster">
Support Icecast development at <a target="_blank" href="http://www.icecast.org">www.icecast.org</a>
</div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
