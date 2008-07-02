<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:sverb="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Verbatim"
                xmlns:xverb="com.nwalsh.xalan.Verbatim"
                xmlns:lxslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="sverb xverb lxslt"
                version='1.0'>


<xsl:template match="programlisting|screen|synopsis">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:variable name="content">
    <xsl:choose>
      <xsl:when test="$suppress-numbers = '0'
                      and @linenumbering = 'numbered'
                      and $use.extensions != '0'
                      and $linenumbering.extension != '0'">
        <xsl:call-template name="number.rtf.lines">
          <xsl:with-param name="rtf">
            <xsl:apply-templates/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="no-space-before">
    <xsl:if test="not( preceding-sibling::*
                       or preceding-sibling::text()
                       or parent::blockquote )">1</xsl:if>
  </xsl:variable>

  <xsl:variable name="inside-admon">
    <xsl:if test="ancestor::note
                  or ancestor::tip
                  or ancestor::caution
                  or ancestor::important
                  or ancestor::warning">1</xsl:if>
  </xsl:variable>

  <fo:block wrap-option='no-wrap'
            white-space-collapse='false'
            white-space-treatment='preserve'
            linefeed-treatment='preserve'
            xsl:use-attribute-sets="monospace.verbatim.properties">
    <xsl:if test="$no-space-before=1">
      <xsl:attribute name="space-before.optimum">0em</xsl:attribute>
      <xsl:attribute name="space-before.minimum">0em</xsl:attribute>
      <xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$shade.verbatim = 0 or $inside-admon = 1">
        <xsl:copy-of select="$content"/>
      </xsl:when>
      <xsl:when test="self::screen">
        <fo:block xsl:use-attribute-sets="shade.verbatim.style shade.screen.style">
          <xsl:copy-of select="$content"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="shade.verbatim.style">
          <xsl:copy-of select="$content"/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>



<xsl:template match="literallayout">
  <xsl:param name="suppress-numbers" select="'0'"/>

  <xsl:variable name="content">
    <xsl:choose>
      <xsl:when test="$suppress-numbers = '0'
                      and @linenumbering = 'numbered'
                      and $use.extensions != '0'
                      and $linenumbering.extension != '0'">
        <xsl:call-template name="number.rtf.lines">
          <xsl:with-param name="rtf">
            <xsl:apply-templates/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="possibly-shaded-content">
    <xsl:choose>
      <xsl:when test="$shade.verbatim = 0">
        <xsl:copy-of select="$content"/>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="shade.verbatim.style shade.literallayout.style">
          <xsl:copy-of select="$content"/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <fo:block wrap-option='no-wrap'
            white-space-collapse='false'
	    white-space-treatment='preserve'
            linefeed-treatment="preserve">
    <xsl:choose>
      <xsl:when test="@class='monospaced'">
        <fo:block xsl:use-attribute-sets="monospace.verbatim.properties">
          <xsl:copy-of select="$possibly-shaded-content"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block text-align='start'
                  xsl:use-attribute-sets="verbatim.properties">
          <xsl:copy-of select="$possibly-shaded-content"/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>



</xsl:stylesheet>
