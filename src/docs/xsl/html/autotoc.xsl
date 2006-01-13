<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


  <!-- A component (e.g. article) index should be in the ToC: -->

  <xsl:template name="component.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>

    <xsl:call-template name="make.toc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
      <xsl:with-param name="nodes" select="section|sect1|refentry
                                           |article|bibliography|glossary
                                           |appendix
                                           |bridgehead[not(@renderas)
                                                       and $bridgehead.in.toc != 0]
                                           |.//bridgehead[@renderas='sect1'
                                                          and $bridgehead.in.toc != 0]
                                           |index"/>  <!-- added index -->
    </xsl:call-template>
  </xsl:template>



  <!-- only refer to setindex in toc if setindex is really gonna be there -->
  <xsl:template match="setindex" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != 0">
      <!-- original first test used to be *, causing setindex toc entry to be
           generated if empty setindex had title! -->
      <xsl:call-template name="subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- only refer to index in toc if index is really gonna be there -->
  <xsl:template match="index" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != 0">
      <!-- original first test used to be *, causing index toc entry to be
           generated if empty index had title! -->
      <xsl:call-template name="subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <!-- Full titles, not titleabbrevs, in ToC: -->

  <xsl:template name="toc.line">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="depth" select="1"/>
    <xsl:param name="depth.from.context" select="8"/>

   <span>
    <xsl:attribute name="class"><xsl:value-of select="local-name(.)"/></xsl:attribute>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="context" select="$toc-context"/>
        </xsl:call-template>
      </xsl:attribute>

      <xsl:variable name="label">
        <xsl:apply-templates select="." mode="label.markup"/>
      </xsl:variable>
      <xsl:copy-of select="$label"/>
      <xsl:if test="$label != ''">
        <xsl:value-of select="$autotoc.label.separator"/>
      </xsl:if>

      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    </span>
  </xsl:template>


  <xsl:template match="refentry" mode="toc">
    <xsl:param name="toc-context" select="."/>
  
    <xsl:variable name="refmeta" select=".//refmeta"/>
    <xsl:variable name="refentrytitle" select="$refmeta//refentrytitle"/>
    <xsl:variable name="refnamediv" select=".//refnamediv"/>
    <xsl:variable name="refname" select="$refnamediv//refname"/>
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="$refentrytitle">
          <xsl:apply-templates select="$refentrytitle[1]" mode="title.markup"/>
        </xsl:when>
        <xsl:when test="$refname">
          <xsl:apply-templates select="$refname[1]" mode="title.markup"/>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
  
    <xsl:element name="{$toc.listitem.type}">
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target"/>
        </xsl:attribute>
        <xsl:copy-of select="$title"/>
      </a>
      <xsl:if test="$annotate.toc != 0">
        <xsl:text> - </xsl:text>
        <xsl:value-of select="refnamediv/refpurpose"/>
      </xsl:if>
    </xsl:element>
  </xsl:template>


  <xsl:template name="manual-toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="tocentry"/>
    <!-- be careful, we don't want to change the current document to the other tree! -->
    <xsl:if test="$tocentry">
      <xsl:variable name="node" select="key('id', $tocentry/@linkend)"/>

      <xsl:element name="{$toc.listitem.type}">
        <xsl:variable name="label">
          <xsl:apply-templates select="$node" mode="label.markup"/>
        </xsl:variable>
        <xsl:copy-of select="$label"/>
        <xsl:if test="$label != ''">
          <xsl:value-of select="$autotoc.label.separator"/>
        </xsl:if>
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$node"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates select="$node" mode="title.markup"/>
        </a>
      </xsl:element>

      <xsl:if test="$tocentry/*">
        <xsl:element name="{$toc.list.type}">
          <xsl:call-template name="manual-toc">
            <xsl:with-param name="tocentry" select="$tocentry/*[1]"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:if>
  
      <xsl:if test="$tocentry/following-sibling::*">
        <xsl:call-template name="manual-toc">
          <xsl:with-param name="tocentry" select="$tocentry/following-sibling::*[1]"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>


  <xsl:template match="figure|table|example|equation|procedure" mode="toc">
    <xsl:param name="toc-context" select="."/>
  
    <xsl:element name="{$toc.listitem.type}">
      <xsl:variable name="label">
        <xsl:apply-templates select="." mode="label.markup"/>
      </xsl:variable>
      <xsl:copy-of select="$label"/>
      <xsl:if test="$label != ''">
        <xsl:value-of select="$autotoc.label.separator"/>
      </xsl:if>
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target"/>
        </xsl:attribute>
        <xsl:apply-templates select="." mode="title.markup"/>
      </a>
    </xsl:element>
  </xsl:template>


</xsl:stylesheet>


