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

  <xsl:param name="rootid" select="''"/>

  <!-- TOC params -->
  <xsl:param name="toc.section.depth">1</xsl:param>
    <!-- OK. When set to 0, it only mentions the <book>s in the Grand ToC.
         When set to 1, it goes TWO levels deeper and includes the 
         <article>/<chapter> level and the top <section>/<sect1> level. Great :-(
     -->

 <xsl:param name="toc.max.depth">2</xsl:param>
    <!-- With the addition of this param, each ToC has max. two levels. This
         is OK for the <set> ToC and the  art/chap ToCs, but I would like
         <book> ToCs to be one level deep...
    -->

  <xsl:param name="generate.section.toc.level">1</xsl:param>
  <xsl:param name="generate.component.toc">1</xsl:param> <!-- obsolete param??? -->


  <!-- admonitions params -->
  <xsl:param name="admon.graphics">0</xsl:param>
  <xsl:param name="admon.style"></xsl:param>
    <!-- default margins overridden as this can't be done in
         the CSS; if we want margins we'll put them in the CSS -->

  <!-- misc params -->

  <!-- Hm. Index winds up in the wrong place (namely on the start page)
       and there's a broken link from the last page to a non-existing index
       that should have come after it. At least for article-level indices.
       Until solved, disable index in HTML: -->
  <xsl:param name="generate.index">0</xsl:param>
  <xsl:param name="make.index.markup">0</xsl:param>

  <xsl:param name="segmentedlist.as.table" select="1"/>
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


  <!-- Allow index also at <article> level -->

  <xsl:template match="index">
    <!-- some implementations use completely empty index tags to indicate -->
    <!-- where an automatically generated index should be inserted. so -->
    <!-- if the index is completely empty, skip it. Unless generate.index -->
    <!-- is non-zero, in which case, this is where the automatically -->
    <!-- generated index should go. -->

    <!-- count(indexentry) was count(*) in the original: -->
    <xsl:if test="count(indexentry) > 0 or $generate.index != '0'">
      <div class="{name(.)}">
        <xsl:if test="$generate.id.attributes != 0">
          <xsl:attribute name="id">
            <xsl:call-template name="object.id"/>
          </xsl:attribute>
        </xsl:if>
  
        <xsl:call-template name="index.titlepage"/>
        <xsl:apply-templates/>
  
        <xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
          <xsl:call-template name="generate-index">
            <xsl:with-param name="scope" select="(ancestor::book|ancestor::article|/)[last()]"/>
          </xsl:call-template>
        </xsl:if>
  
        <xsl:if test="not(parent::article)">
          <xsl:call-template name="process.footnotes"/>
        </xsl:if>
      </div>
    </xsl:if>
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

