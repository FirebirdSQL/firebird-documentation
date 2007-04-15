<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">




  <xsl:template name="division.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>

    <xsl:variable name="cid">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$toc-context"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="nodes"
                  select="$toc-context/part
                          |$toc-context/reference
                          |$toc-context/preface
                          |$toc-context/chapter
                          |$toc-context/appendix
                          |$toc-context/article
                          |$toc-context/bibliography
                          |$toc-context/glossary
                          |$toc-context/index"/>

    <xsl:if test="$nodes">
      <fo:block id="toc...{$cid}"
                xsl:use-attribute-sets="toc.margin.properties">
        <xsl:if test="$axf.extensions != 0">
          <xsl:attribute name="axf:outline-level">1</xsl:attribute>
          <xsl:attribute name="axf:outline-expand">false</xsl:attribute>
          <xsl:attribute name="axf:outline-title">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'TableofContents'"/>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="$fop-093=1">
          <fo:block keep-with-next.within-page="always">&#x200B;</fo:block>  <!-- to get spacing right with FOP 0.93 -->
        </xsl:if>

        <xsl:if test="$toc.title.p">
          <xsl:call-template name="table.of.contents.titlepage"/>
        </xsl:if>
        <xsl:apply-templates select="$nodes" mode="toc">
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:apply-templates>
      </fo:block>
    </xsl:if>
  </xsl:template>



  <!-- A component (e.g. article) index should be in the ToC: -->

  <xsl:template name="component.toc">
    <xsl:param name="toc-context" select="."/>

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="cid">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$toc-context"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="nodes" select="section|sect1|refentry
                                       |article|bibliography|glossary
                                       |appendix|index"/>               <!-- added index -->
    <xsl:if test="$nodes">
      <fo:block id="toc...{$id}"
                xsl:use-attribute-sets="toc.margin.properties">

        <xsl:if test="$fop-093=1">
          <fo:block keep-with-next.within-page="always">&#x200B;</fo:block>  <!-- to get spacing right with FOP 0.93 -->
        </xsl:if>

        <xsl:call-template name="table.of.contents.titlepage"/>
        <xsl:apply-templates select="$nodes" mode="toc">
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:apply-templates>
      </fo:block>
    </xsl:if>
  </xsl:template>


  <!-- only refer to index in toc if index is really gonna be there -->
  <xsl:template match="index" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != 0">
      <!-- original first test used to be *, causing index toc entry to be
           generated if empty index had title! -->
      <xsl:call-template name="toc.line"/>
    </xsl:if>
  </xsl:template>


  <!-- Full titles, not titleabbrevs, in ToC: -->

  <xsl:template name="toc.line">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>

    <fo:block text-align-last="justify"
              end-indent="{$toc.indent.width}pt"
              last-line-end-indent="-{$toc.indent.width}pt">
      <fo:inline keep-with-next.within-line="always">
        <fo:basic-link internal-destination="{$id}">
          <xsl:choose>
            <xsl:when test="name()='appendix'">
              <xsl:apply-templates select="." mode="xref-number.markup"/>
              <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:when test="$label != ''">
              <xsl:copy-of select="$label"/>
              <xsl:value-of select="$autotoc.label.separator"/>
            </xsl:when>
          </xsl:choose>
          <xsl:apply-templates select="." mode="title.markup"/>
        </fo:basic-link>
      </fo:inline>
      <fo:inline keep-together.within-line="always">
        <xsl:text> </xsl:text>
        <fo:leader leader-pattern="dots"
                   leader-pattern-width="3pt"
                   leader-alignment="reference-area"
                   keep-with-next.within-line="always"/>
        <xsl:text> </xsl:text>
        <fo:basic-link internal-destination="{$id}">
          <fo:page-number-citation ref-id="{$id}"/>
        </fo:basic-link>
      </fo:inline>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>
