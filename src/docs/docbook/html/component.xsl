<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->

<xsl:template name="component.title">
  <xsl:param name="node" select="."/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$node"/>
    </xsl:call-template>
  </xsl:variable>

  <h2 class="title">
    <a name="{$id}"/>
    <xsl:apply-templates select="$node" mode="title.ref">
      <xsl:with-param name="allow-anchors" select="'1'"/>
    </xsl:apply-templates>
  </h2>
</xsl:template>

<xsl:template name="component.subtitle">
  <xsl:param name="node" select="."/>
  <xsl:variable name="subtitle">
    <xsl:apply-templates select="$node" mode="subtitle.content"/>
  </xsl:variable>

  <xsl:if test="$subtitle != ''">
    <h3 class="subtitle">
      <i>
        <xsl:copy-of select="$subtitle"/>
      </i>
    </h3>
  </xsl:if>
</xsl:template>

<xsl:template name="component.separator">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="dedication" mode="dedication">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="dedication.titlepage"/>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="dedication"></xsl:template> <!-- see mode="dedication" -->
<xsl:template match="dedication/title"></xsl:template>
<xsl:template match="dedication/subtitle"></xsl:template>
<xsl:template match="dedication/titleabbrev"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="colophon">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="component.title"/>
    <xsl:call-template name="component.subtitle"/>

    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="colophon/title"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="preface">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="preface.titlepage"/>
    <xsl:if test="$generate.preface.toc != '0'">
      <xsl:call-template name="component.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="title" mode="preface.titlepage.recto.mode">
  <xsl:call-template name="component.title">
    <xsl:with-param name="node" select="ancestor::preface[1]"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="preface/docinfo|prefaceinfo"></xsl:template>
<xsl:template match="preface/title"></xsl:template>
<xsl:template match="preface/titleabbrev"></xsl:template>
<xsl:template match="preface/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="chapter">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="chapter.titlepage"/>
    <xsl:if test="$generate.chapter.toc != '0'">
      <xsl:call-template name="component.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="title" mode="chapter.titlepage.recto.mode">
  <xsl:call-template name="component.title">
    <xsl:with-param name="node" select="ancestor::chapter[1]"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="chapter/docinfo|chapterinfo"></xsl:template>
<xsl:template match="chapter/title"></xsl:template>
<xsl:template match="chapter/titleabbrev"></xsl:template>
<xsl:template match="chapter/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="appendix">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="appendix.titlepage"/>
    <xsl:if test="$generate.appendix.toc != '0'">
      <xsl:call-template name="component.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="title" mode="appendix.titlepage.recto.mode">
  <xsl:call-template name="component.title">
    <xsl:with-param name="node" select="ancestor::appendix[1]"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="appendix/docinfo|appendixinfo"></xsl:template>
<xsl:template match="appendix/title"></xsl:template>
<xsl:template match="appendix/titleabbrev"></xsl:template>
<xsl:template match="appendix/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="dedication" mode="component.number">
  <xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="preface" mode="component.number">
  <xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="chapter" mode="component.number">
  <xsl:param name="add.space" select="false()"/>

  <xsl:choose>
    <xsl:when test="@label">
      <xsl:value-of select="@label"/>
      <xsl:text>.</xsl:text>
      <xsl:if test="$add.space">
        <xsl:call-template name="gentext.space"/>
      </xsl:if>
    </xsl:when>
    <xsl:when test="$chapter.autolabel">
      <xsl:number from="book" count="chapter" format="1."/>
      <xsl:if test="$add.space">
        <xsl:call-template name="gentext.space"/>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="appendix" mode="component.number">
  <xsl:param name="add.space" select="false()"/>

  <xsl:choose>
    <xsl:when test="@label">
      <xsl:value-of select="@label"/>
      <xsl:text>.</xsl:text>
      <xsl:if test="$add.space">
        <xsl:call-template name="gentext.space"/>
      </xsl:if>
    </xsl:when>
    <xsl:when test="$chapter.autolabel">
      <xsl:number from="book" count="appendix" format="A."/>
      <xsl:if test="$add.space">
        <xsl:call-template name="gentext.space"/>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="article" mode="component.number">
  <xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="bibliography" mode="component.number">
  <xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="glossary" mode="component.number">
  <xsl:param name="add.space" select="false()"/>
</xsl:template>

<xsl:template match="index" mode="component.number">
  <xsl:param name="add.space" select="false()"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="article">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="article.titlepage"/>
    <xsl:if test="$generate.article.toc != '0'">
      <xsl:call-template name="component.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="article/artheader|article/articleinfo"></xsl:template>
<xsl:template match="article/title"></xsl:template>
<xsl:template match="article/subtitle"></xsl:template>

<xsl:template match="article/appendix">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="section.heading">
      <xsl:with-param name="level" select="2"/>
      <xsl:with-param name="title">
        <xsl:apply-templates select="." mode="title.ref"/>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates/>
    <xsl:if test="not(ancestor::article)">
      <xsl:call-template name="process.footnotes"/>
    </xsl:if>
  </div>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>

