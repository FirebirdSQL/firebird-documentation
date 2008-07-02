<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">



  <!-- In the new DocBook stylesheets, indexterm children wreak havoc when building the ToC,
       PDF bookmarks etc. This takes care of it: -->

  <xsl:template match="indexterm/*"/>


  <!-- Allow index also with <article> scope; index on fresh page -->

  <xsl:template match="index">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:if test="$generate.index != 0">
    <xsl:choose>
      <xsl:when test="$make.index.markup != 0">
        <fo:block>
          <xsl:call-template name="generate-index-markup">
            <xsl:with-param name="scope" select="(ancestor::article|ancestor::book|/)[last()]"/>
                                                 <!-- last in document order is closest to self -->
          </xsl:call-template>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block id="{$id}" break-before="page">
          <xsl:call-template name="index.titlepage"/>
        </fo:block>
        <xsl:apply-templates/>
        <xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
          <xsl:call-template name="generate-index">
            <xsl:with-param name="scope" select="(ancestor::article|ancestor::book|/)[last()]"/>
                                                 <!-- last in document order is closest to self -->
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </xsl:template>


  <!-- Because overriding index (see above) also eclipses blah/index templates in
       the original ("import precedence is stronger than match priority")
       we have to explicitly give the imported template priority as if
       it was fully defined here: -->

  <xsl:template match="book/index|part/index">
    <xsl:apply-imports/>
  </xsl:template>


  <!-- article/index didn't exist; it is our ADDITION -->

  <!-- along the lines of book/part index, ie with own page-sequence and two columns: -->

  <xsl:template match="article/index">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:if test="$generate.index != 0">
      <xsl:variable name="master-reference">
        <xsl:call-template name="select.pagemaster">
          <xsl:with-param name="pageclass">
            <xsl:if test="$make.index.markup != 0">body</xsl:if>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>

      <fo:page-sequence hyphenate="{$hyphenate}"
                       master-reference="{$master-reference}">
        <xsl:attribute name="language">
          <xsl:call-template name="l10n.language"/>
        </xsl:attribute>
        <xsl:attribute name="format">
          <xsl:call-template name="page.number.format"/>
        </xsl:attribute>
        <xsl:if test="$double.sided != 0">
          <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
        </xsl:if>

        <xsl:attribute name="hyphenation-character">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'hyphenation-character'"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="hyphenation-push-character-count">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'hyphenation-push-character-count'"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="hyphenation-remain-character-count">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'hyphenation-remain-character-count'"/>
          </xsl:call-template>
        </xsl:attribute>

        <xsl:apply-templates select="." mode="running.head.mode">
          <xsl:with-param name="master-reference" select="$master-reference"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="." mode="running.foot.mode">
          <xsl:with-param name="master-reference" select="$master-reference"/>
        </xsl:apply-templates>

        <fo:flow flow-name="xsl-region-body">
          <fo:block id="{$id}" span="all"
                    space-after.minimum="0.8em"
                    space-after.optimum="1.0em"
                    space-after.maximum="1.2em">

            <xsl:if test="$fop-093=1">
              <fo:block keep-with-next.within-page="always">&#x200B;</fo:block>  <!-- to get spacing right with FOP 0.93 -->
            </xsl:if>

            <xsl:call-template name="index.titlepage"/>
            <xsl:if test="$fop-093=1">
              <fo:block>&#x200B;</fo:block>
            </xsl:if>
          </fo:block>
          <xsl:apply-templates/>
          <xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
            <xsl:choose>
              <xsl:when test="$make.index.markup != 0">
                <fo:block wrap-option='no-wrap'
                          white-space-collapse='false'
                          xsl:use-attribute-sets="monospace.verbatim.properties"
                          linefeed-treatment="preserve">
                  <xsl:call-template name="generate-index-markup">
                    <xsl:with-param name="scope" select="(ancestor::article|/)[last()]"/>
                  </xsl:call-template>
                </fo:block>
              </xsl:when>
              <xsl:when test="indexentry|indexdiv/indexentry">
                <xsl:apply-templates/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="generate-index">
                  <xsl:with-param name="scope" select="(ancestor::article|/)[last()]"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </fo:flow>
      </fo:page-sequence>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>
