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

  <!-- Our addition. No template by that name in original stylesheets: -->
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

            <!--
              We must change the following - and the "prev" link too - 
              in such a way that next/prev links no longer step 
              forward/back across a <book> boundary. Maybe not even 
              across an <article> boundary. We'll have to be careful 
              though, because usually the context node is a level 1 
              <sect*>, but for the first HTML page of an article/chapter 
              it may be the article/chapter node itself. Also test how
              this is for a <book>'s first HTML page. And it depends
              on the config. The stylesheet should be aware of this
              and test accordingly.

              Something along the lines of not(count(following-sibling::*)=0)
              should be used, or something with position() = last() ?
              And test the parent too. Maybe compare the context
              node's parent with that of $next. Also compare the
              context node itself with $next's parent, and vice versa.

              This looks like it's gonna be pretty hairy... ;-)
            -->
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

