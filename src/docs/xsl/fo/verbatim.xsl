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


  <!-- Our addition: Is there a preceding element or text node,
       or is space-before necessary because daddy is a blockquote? -->

  <xsl:variable name="no-space-before">
    <xsl:if test="not( preceding-sibling::*
                       or preceding-sibling::text()
                       or parent::blockquote )">1</xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$shade.verbatim != 0">
      <fo:block wrap-option='no-wrap'
                white-space-collapse='false'
		white-space-treatment='preserve'
                linefeed-treatment='preserve'
                xsl:use-attribute-sets="monospace.verbatim.properties shade.verbatim.style">
        <xsl:if test="$no-space-before=1">
          <xsl:attribute name="space-before.optimum">0em</xsl:attribute>
          <xsl:attribute name="space-before.minimum">0em</xsl:attribute>
          <xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>
        </xsl:if>
        <xsl:copy-of select="$content"/>
      </fo:block>
    </xsl:when>
    <xsl:otherwise>
      <fo:block wrap-option='no-wrap'
                white-space-collapse='false'
		white-space-treatment='preserve'
                linefeed-treatment="preserve"
                xsl:use-attribute-sets="monospace.verbatim.properties">
        <xsl:if test="$no-space-before=1">
          <xsl:attribute name="space-before.optimum">0em</xsl:attribute>
          <xsl:attribute name="space-before.minimum">0em</xsl:attribute>
          <xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>
        </xsl:if>
        <xsl:copy-of select="$content"/>
      </fo:block>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



</xsl:stylesheet>
