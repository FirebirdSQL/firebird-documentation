<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:saxon="http://icl.com/saxon"
	xmlns:lxslt="http://xml.apache.org/xslt"
	xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
	xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
	version="1.0"
	exclude-result-prefixes="doc"
	extension-element-prefixes="saxon xalanredirect lxslt">

	<xsl:import href="docbook/html/chunk.xsl"/>
	<xsl:param name="html.stylesheet">firebirddocs.css</xsl:param>
	<xsl:param name="toc.section.depth">1</xsl:param>
	<xsl:param name="generate.component.toc">1</xsl:param>
	<xsl:param name="chapter.autolabel" select="1"/>
	<!-- Override the callout images location -->
	<xsl:param name="callout.graphics.path" select="'images/callouts/'"/>

	<!-- Override the graphics.xsl imageobjectco to correctly process the calloutlist child element -->
	<xsl:template match="imageobjectco">
		<xsl:apply-templates select="imageobject"/>
		<xsl:apply-templates select="calloutlist"/>
	</xsl:template>

	<xsl:template name="header.navigation">
		<xsl:param name="prev" select="/foo"/>
		<xsl:param name="next" select="/foo"/>
		<xsl:variable name="home" select="/*[1]"/>
		<xsl:variable name="up" select="parent::*"/>
		<xsl:if test="$suppress.navigation = '0'">
			<table border="0" cellpadding="0" cellspacing="0" height="65">
				<tr height="65">
					<td rowspan="2">
						<img src="images/firebirdlogo.png" width="85" height="84"/>
						<img src="images/titleblackgill.gif" width="215" height="40" align="center"/>
					</td>
					<td rowspan="2" 	width="100%" align="right" valign="center">
						<a>
							<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$home"/></xsl:call-template></xsl:attribute>
							<img src="images/top.gif" width="30" height="30" border="0"/>
						</a>
						<xsl:choose>
							<xsl:when test="count($up)>0">
								<a>
									<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$up"/></xsl:call-template></xsl:attribute>
									<img src="images/toc.gif" width="30" height="30" border="0"/>
								</a>
							</xsl:when>
							<xsl:otherwise>&#160;</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="count($prev)>0">
							<a>
								<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$prev"/></xsl:call-template></xsl:attribute>
								<img src="images/prev.gif" width="30" height="30" border="0"/>
							</a>
						</xsl:if>
						<xsl:if test="count($next)>0">
							<a>
								<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$next"/></xsl:call-template></xsl:attribute>
								<img src="images/next.gif" width="30" height="30" border="0"/>
							</a>
						</xsl:if>
					</td>
				</tr>
				<tr/>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="footer.navigation">
		<xsl:param name="prev" select="/foo"/>
		<xsl:param name="next" select="/foo"/>
		<xsl:variable name="home" select="/*[1]"/>
		<xsl:variable name="up" select="parent::*"/>
		<xsl:if test="$suppress.navigation = '0'">
			<table border="0" cellpadding="0" cellspacing="0" height="65">
				<tr height="65">
					<td rowspan="2" 	width="100%" align="right" valign="center">

					</td>
					<td rowspan="2"  width="100%" align="right" valign="center">
						<a>
							<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$home"/></xsl:call-template></xsl:attribute>
							<img src="images/top.gif" width="30" height="30" border="0"/>
						</a>
						<xsl:choose>
							<xsl:when test="count($up)>0">
								<a>
									<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$up"/></xsl:call-template></xsl:attribute>
									<img src="images/toc.gif" width="30" height="30" border="0"/>
								</a>
							</xsl:when>
							<xsl:otherwise>&#160;</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="count($prev)>0">
							<a>
								<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$prev"/></xsl:call-template></xsl:attribute>
								<img src="images/prev.gif" width="30" height="30" border="0"/>
							</a>
						</xsl:if>
						<xsl:if test="count($next)>0">
							<a>
								<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="object" select="$next"/></xsl:call-template></xsl:attribute>
								<img src="images/next.gif" width="30" height="30" border="0"/>
							</a>
						</xsl:if>
					</td>
				</tr>
				<tr/>
			</table>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
