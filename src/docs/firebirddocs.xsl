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


  <!-- STYLESHEET PARAMETERS: -->

  <!-- TOC params -->
  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="generate.section.toc.level">1</xsl:param>
  <xsl:param name="generate.component.toc">1</xsl:param> <!-- obsolete param??? -->

  <!-- admonitions params -->
  <xsl:param name="admon.graphics">0</xsl:param>
  <xsl:param name="admon.style"></xsl:param>
    <!-- default margins overridden as this can't be done in
         the CSS; if we want margins we'll put them in the CSS -->

  <!-- misc params -->
  <xsl:param name="spacing.paras">1</xsl:param>
  <xsl:param name="chunker.output.indent">yes</xsl:param>
  <xsl:param name="use.id.as.filename">1</xsl:param>
  <xsl:param name="chapter.autolabel" select="1"/>
  <xsl:param name="html.stylesheet">firebirddocs.css</xsl:param>
  <!-- Override the callout images location -->
  <xsl:param name="callout.graphics.path" select="'images/callouts/'"/>


  <!-- Override the graphics.xsl imageobjectco to correctly process the calloutlist child element -->
  <xsl:template match="imageobjectco">
    <xsl:apply-templates select="imageobject"/>
    <xsl:apply-templates select="calloutlist"/>
  </xsl:template>



  <!-- Header/footer logo and navigation stuff, merged into one 
       template now or we'll have a maintenance nightmare later: -->

  <xsl:template name="header-footer.navigation">

    <xsl:param name="kind" select="'footer'"/>
      <!-- default to footer because that's the "lightest" variant -->
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:if test="$suppress.navigation = '0'">
      <table border="0" cellpadding="0" cellspacing="0" height="65">
        <tr height="65">

          <xsl:choose>
            <xsl:when test="$kind='header'">
              <!-- header-specific: -->
              <td rowspan="2">
                <a href="http://www.firebirdsql.org/">
                  <img src="images/firebirdlogo.png"
		       alt="Firebird home"
		       border="0" width="85" height="84"/>
                  <img src="images/titleblackgill.gif"
		       alt="Firebird home"
		       border="0" width="215" height="40"
		       align="center"/>
		</a>
              </td>
            </xsl:when>
	    <xsl:otherwise>
              <!-- footer-specific: -->
              <td rowspan="2" width="100%" align="right" valign="center">
              </td>
	    </xsl:otherwise>
          </xsl:choose>

          <td rowspan="2" width="100%" align="right" valign="center">
            <a>
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$home"/>
                </xsl:call-template>
              </xsl:attribute>
              <img src="images/top.gif"
	           alt="Topmost table of contents"
		   width="30" height="30" border="0"/>
            </a>

            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <img src="images/toc.gif"
		       alt="Up one level"
		       width="30" height="30" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>

            <xsl:if test="count($prev)>0">
              <a>
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
                <img src="images/prev.gif"
		     alt="Previous page"
		     width="30" height="30" border="0"/>
              </a>
            </xsl:if>

            <xsl:if test="count($next)>0">
              <a>
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <img src="images/next.gif"
		     alt="Next page"
		     width="30" height="30" border="0"/>
              </a>
            </xsl:if>

          </td>
        </tr>
        <tr/>
      </table>
    </xsl:if>

  </xsl:template>  <!-- end header/footer logo + nav -->



  <!-- Header logo and navigation: -->
  <xsl:template name="header.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:call-template name="header-footer.navigation">
      <xsl:with-param name="kind" select="'header'"/>
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
  </xsl:template>  <!-- end header logo + nav -->


  <!-- Footer navigation: -->
  <xsl:template name="footer.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:call-template name="header-footer.navigation">
      <xsl:with-param name="kind" select="'footer'"/>
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
  </xsl:template>  <!-- end footer nav -->


</xsl:stylesheet>

