<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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




  <!-- Header/footer logo and navigation stuff, merged into one
       template now or we'll have a maintenance nightmare later: -->

  <!-- Our addition. No stylesheet by that name in riginal stylesheets: -->
  <xsl:template name="header-footer.navigation">

    <xsl:param name="kind" select="'footer'"/>
      <!-- default to footer because that's the "lightest" variant -->
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>

    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:if test="$suppress.navigation = '0'">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr height="64">

          <xsl:choose>
            <xsl:when test="$kind='header'">
              <!-- header-specific: -->
              <td valign="top">
                <a href="http://www.firebirdsql.org/">
                  <img src="images/firebirdlogo.png"
		       alt="Firebird home"
		       border="0" width="85" height="84"/>
		</a>
              </td>
              <td width="100%">
                <a href="http://www.firebirdsql.org/">
                  <img src="images/titleblackgill.gif"
		       alt="Firebird home" align="top"
		       border="0" width="215" height="40"/>
		</a>
              </td>
            </xsl:when>
	    <xsl:otherwise>
              <!-- footer-specific: -->
              <td align="right" valign="center">
              </td>
	    </xsl:otherwise>
          </xsl:choose>

          <td colspan="2" align="right">

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

            <a>
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$home"/>
                </xsl:call-template>
              </xsl:attribute>
              <img src="images/toc.gif"
	           alt="Overall table of contents"
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
                  <img src="images/top.gif"
		       alt="Up one level"
		       width="30" height="30" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>

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
      </table>
    </xsl:if>

  </xsl:template>  <!-- end header/footer logo + nav -->


</xsl:stylesheet>

