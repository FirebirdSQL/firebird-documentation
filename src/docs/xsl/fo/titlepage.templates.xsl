<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">

<!-- This stylesheet was created by template/titlepage.xsl; do not edit it by hand. -->

<xsl:template name="article.titlepage.before.recto"><xsl:call-template name="titlepage.logo"/>
</xsl:template>

<xsl:template name="article.titlepage.recto">
  <xsl:choose>
    <xsl:when test="articleinfo/title">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/title"/>
    </xsl:when>
    <xsl:when test="artheader/title">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="articleinfo/subtitle">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="artheader/subtitle">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/corpauthor"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/corpauthor"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/authorgroup"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/authorgroup"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/author"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/author"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/edition"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/edition"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/edition"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/othercredit"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/othercredit"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/releaseinfo"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/releaseinfo"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/copyright"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/copyright"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/legalnotice"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/legalnotice"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/pubdate"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/pubdate"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/revhistory"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/revhistory"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/abstract"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/abstract"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="article.titlepage.before.verso">
</xsl:template>

<xsl:template name="article.titlepage.verso">
</xsl:template>

<xsl:template name="article.titlepage.separator">
</xsl:template>

<xsl:template name="article.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$title.fontset}">
    <xsl:variable name="recto.content">
      <xsl:call-template name="article.titlepage.before.recto"/>
      <xsl:call-template name="article.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block text-align="center"><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="article.titlepage.before.verso"/>
      <xsl:call-template name="article.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="article.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="article.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="article.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" keep-with-next="always" font-size="24.8832pt" font-weight="bold" color="{$highlevel.title.color}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::article[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em" font-size="14.4pt">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em" font-size="14.4pt">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em" font-size="14.4pt">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="edition" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" text-align="justify" font-family="{$body.fontset}">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" space-before="0.5em" text-align="start" margin-left="0.5in" margin-right="0.5in" font-family="{$body.fontset}">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="set.titlepage.before.recto"><xsl:call-template name="titlepage.logo"/>
</xsl:template>

<xsl:template name="set.titlepage.recto">
  <xsl:choose>
    <xsl:when test="setinfo/title">
      <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="setinfo/subtitle">
      <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/corpauthor"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/authorgroup"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/author"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/edition"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/edition"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/othercredit"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/releaseinfo"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/copyright"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/legalnotice"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/pubdate"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/revhistory"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/abstract"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="set.titlepage.before.verso">
</xsl:template>

<xsl:template name="set.titlepage.verso">
</xsl:template>

<xsl:template name="set.titlepage.separator">
</xsl:template>

<xsl:template name="set.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="recto.content">
      <xsl:call-template name="set.titlepage.before.recto"/>
      <xsl:call-template name="set.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="set.titlepage.before.verso"/>
      <xsl:call-template name="set.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="set.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="set.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="set.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style" text-align="center" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.fontset}" color="{$highlevel.title.color}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::set[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style" font-family="{$title.fontset}" text-align="center">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="edition" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="book.titlepage.before.recto"><xsl:call-template name="titlepage.logo"/>
</xsl:template>

<xsl:template name="book.titlepage.recto">
  <xsl:choose>
    <xsl:when test="bookinfo/title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="bookinfo/subtitle">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/corpauthor"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/authorgroup"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/author"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/edition"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/edition"/>
</xsl:template>

<xsl:template name="book.titlepage.before.verso"><fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
</xsl:template>

<xsl:template name="book.titlepage.verso">
  <xsl:choose>
    <xsl:when test="bookinfo/title">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="bookinfo/subtitle">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/edition"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/edition"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/corpauthor"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/authorgroup"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/author"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/othercredit"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/pubdate"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/copyright"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/abstract"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/abstract"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/legalnotice"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/legalnotice"/>
</xsl:template>

<xsl:template name="book.titlepage.separator"><fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
</xsl:template>

<xsl:template name="book.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="recto.content">
      <xsl:call-template name="book.titlepage.before.recto"/>
      <xsl:call-template name="book.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="book.titlepage.before.verso"/>
      <xsl:call-template name="book.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="book.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="book.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="book.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.fontset}" color="{$highlevel.title.color}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" space-before="0.5em" font-family="{$title.fontset}" font-style="italic" color="{$highlevel.title.color}">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" font-size="17.28pt" keep-with-next="always" space-before="2in">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" space-before="2in">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" font-size="17.28pt" space-before="2em" keep-with-next="always">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="edition" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" space-before="0.5em">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="title" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style" font-size="17.28pt" font-weight="bold" font-family="{$title.fontset}">
<xsl:call-template name="book.verso.title">
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style" font-weight="bold" font-style="italic" font-family="{$title.fontset}" space-after="1em">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="edition" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:call-template name="verso.authorgroup">
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style" space-before="1em">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="part.titlepage.recto">
  <xsl:choose>
    <xsl:when test="partinfo/title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/title"/>
    </xsl:when>
    <xsl:when test="docinfo/title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="partinfo/subtitle">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="docinfo/subtitle">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

</xsl:template>

<xsl:template name="part.titlepage.verso">
</xsl:template>

<xsl:template name="part.titlepage.separator">
</xsl:template>

<xsl:template name="part.titlepage.before.recto">
</xsl:template>

<xsl:template name="part.titlepage.before.verso">
</xsl:template>

<xsl:template name="part.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="recto.content">
      <xsl:call-template name="part.titlepage.before.recto"/>
      <xsl:call-template name="part.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="part.titlepage.before.verso"/>
      <xsl:call-template name="part.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="part.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="part.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="part.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="part.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="part.titlepage.recto.style" text-align="center" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.fontset}" color="{$midlevel.title.color}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::part[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="part.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="part.titlepage.recto.style" text-align="center" font-size="20.736pt" space-before="15.552pt" font-weight="bold" font-style="italic" font-family="{$title.fontset}">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="preface.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style" margin-left="{$title.margin.left}" font-size="24.8832pt" font-family="{$title.fontset}" font-weight="bold" color="{$midlevel.title.color}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::preface[1]"/>
</xsl:call-template></fo:block>
  <xsl:choose>
    <xsl:when test="prefaceinfo/subtitle">
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="docinfo/subtitle">
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/corpauthor"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/authorgroup"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/author"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/othercredit"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/releaseinfo"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/releaseinfo"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/copyright"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/legalnotice"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/pubdate"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/pubdate"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/revision"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/revision"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/revhistory"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/abstract"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="preface.titlepage.verso">
</xsl:template>

<xsl:template name="preface.titlepage.separator">
</xsl:template>

<xsl:template name="preface.titlepage.before.recto">
</xsl:template>

<xsl:template name="preface.titlepage.before.verso">
</xsl:template>

<xsl:template name="preface.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="recto.content">
      <xsl:call-template name="preface.titlepage.before.recto"/>
      <xsl:call-template name="preface.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="preface.titlepage.before.verso"/>
      <xsl:call-template name="preface.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="preface.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="preface.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="preface.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="subtitle" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style" font-family="{$title.fontset}">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="preface.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style">
<xsl:apply-templates select="." mode="preface.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="chapter.titlepage.recto">
  <xsl:choose>
    <xsl:when test="chapterinfo/title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/title"/>
    </xsl:when>
    <xsl:when test="docinfo/title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="chapterinfo/subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="docinfo/subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/othercredit"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/abstract"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="chapter.titlepage.verso">
</xsl:template>

<xsl:template name="chapter.titlepage.separator">
</xsl:template>

<xsl:template name="chapter.titlepage.before.recto">
</xsl:template>

<xsl:template name="chapter.titlepage.before.verso">
</xsl:template>

<xsl:template name="chapter.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$title.fontset}" space-after="2em">
    <xsl:variable name="recto.content">
      <xsl:call-template name="chapter.titlepage.before.recto"/>
      <xsl:call-template name="chapter.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block margin-left="{$title.margin.left}"><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="chapter.titlepage.before.verso"/>
      <xsl:call-template name="chapter.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="chapter.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="chapter.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="chapter.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" font-size="24.8832pt" font-weight="bold" color="{$midlevel.title.color}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" space-before="0.5em" font-style="italic" font-size="14.4pt" font-weight="bold" color="{$midlevel.title.color}">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" space-before="0.5em" space-after="0.5em" font-size="14.4pt">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" space-before="0.5em" space-after="0.5em" font-size="14.4pt">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" space-before="0.5em" space-after="0.5em" font-size="14.4pt">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="section.titlepage.recto">
  <xsl:choose>
    <xsl:when test="sectioninfo/title">
      <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="sectioninfo/subtitle">
      <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/corpauthor"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/authorgroup"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/author"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/othercredit"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/releaseinfo"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/copyright"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/legalnotice"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/pubdate"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/revision"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/revhistory"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/abstract"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="section.titlepage.verso">
</xsl:template>

<xsl:template name="section.titlepage.separator">
</xsl:template>

<xsl:template name="section.titlepage.before.recto">
</xsl:template>

<xsl:template name="section.titlepage.before.verso">
</xsl:template>

<xsl:template name="section.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="recto.content">
      <xsl:call-template name="section.titlepage.before.recto"/>
      <xsl:call-template name="section.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block keep-with-next.within-page="always"><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="section.titlepage.before.verso"/>
      <xsl:call-template name="section.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="section.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="section.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="section.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style" margin-left="{$title.margin.left}" font-family="{$title.fontset}">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style" font-family="{$title.fontset}">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="appendix.titlepage.recto">
  <xsl:choose>
    <xsl:when test="appendixinfo/title">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/title"/>
    </xsl:when>
    <xsl:when test="docinfo/title">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="appendixinfo/subtitle">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="docinfo/subtitle">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/corpauthor"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/authorgroup"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/author"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/othercredit"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/releaseinfo"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/releaseinfo"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/copyright"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/legalnotice"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/pubdate"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/pubdate"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/revision"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/revision"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/revhistory"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/abstract"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="appendix.titlepage.verso">
</xsl:template>

<xsl:template name="appendix.titlepage.separator">
</xsl:template>

<xsl:template name="appendix.titlepage.before.recto">
</xsl:template>

<xsl:template name="appendix.titlepage.before.verso">
</xsl:template>

<xsl:template name="appendix.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:variable name="recto.content">
      <xsl:call-template name="appendix.titlepage.before.recto"/>
      <xsl:call-template name="appendix.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$recto.content"/></fo:block>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="appendix.titlepage.before.verso"/>
      <xsl:call-template name="appendix.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <fo:block><xsl:copy-of select="$verso.content"/></fo:block>
    </xsl:if>
    <xsl:call-template name="appendix.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="appendix.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="appendix.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style" margin-left="{$title.margin.left}" font-size="24.8832pt" font-weight="bold" font-family="{$title.fontset}" color="{$midlevel.title.color}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::appendix[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style" font-family="{$title.fontset}">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style">
<xsl:apply-templates select="." mode="appendix.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

</xsl:stylesheet>
