<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">


  <xsl:template match="ulink//text()">
    <xsl:variable name="me" select="string(.)"/>
    <xsl:variable name="url-attr" select="ancestor::ulink[1]/@url"/>
    <xsl:choose>
      <xsl:when test="$me = $url-attr
                      or $me = substring-after($url-attr, ':')
                      or $me = substring-after($url-attr, '://')">
        <xsl:call-template name="hyphenate-url">
          <xsl:with-param name="url" select="."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template name="hyphenate-url">
    <xsl:param name="url" select="''"/>
    <xsl:call-template name="hyphenate-special">
      <xsl:with-param name="str"         select="$url"/>
      <xsl:with-param name="before"      select="$url-hyph.before"/>
      <xsl:with-param name="after"       select="$url-hyph.after"/>
      <xsl:with-param name="not-before"  select="$url-hyph.not-before"/>
      <xsl:with-param name="not-after"   select="$url-hyph.not-after"/>
      <xsl:with-param name="not-between" select="$url-hyph.not-between"/>
      <xsl:with-param name="hyph-char"   select="$url-hyph.char"/>
      <xsl:with-param name="min-before"  select="$url-hyph.min-before"/>
      <xsl:with-param name="min-after"   select="$url-hyph.min-after"/>
    </xsl:call-template>
  </xsl:template>


  <!-- ulink appearance.  TODO: Parameterize color etc.  -->

  <xsl:template match="ulink" name="ulink">
    <fo:basic-link color="#000080" text-decoration="underline" xsl:use-attribute-sets="xref.properties">
      <xsl:attribute name="external-destination">
        <xsl:call-template name="fo-external-image">
          <xsl:with-param name="filename" select="@url"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="count(child::node())=0">
          <xsl:call-template name="hyphenate-url">
            <xsl:with-param name="url" select="@url"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
  	  <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </fo:basic-link>
  
    <xsl:if test="count(child::node()) != 0
                  and string(.) != @url
                  and $ulink.show != 0">
      <!-- yes, show the URI -->
      <xsl:choose>
        <xsl:when test="$ulink.footnotes != 0 and not(ancestor::footnote)">
          <fo:footnote>
            <xsl:call-template name="ulink.footnote.number"/>
            <fo:footnote-body font-family="{$body.font.family}"
                              font-size="{$footnote.font.size}">
              <fo:block>
                <xsl:call-template name="ulink.footnote.number"/>
                <xsl:text> </xsl:text>
                <fo:inline>
                  <xsl:value-of select="@url"/>
                </fo:inline>
              </fo:block>
            </fo:footnote-body>
          </fo:footnote>
        </xsl:when>
        <xsl:otherwise>
          <fo:inline hyphenate="false">
            <xsl:text> [</xsl:text>
            <xsl:call-template name="hyphenate-url">
              <xsl:with-param name="url" select="@url"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
          </fo:inline>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>
