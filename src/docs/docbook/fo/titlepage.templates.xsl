<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This stylesheet was created by template/titlepage.xsl; do not edit it by hand. -->

<xsl:template name="article.titlepage.recto">
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="(articleinfo/title|artheader/title|title)[1]"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="(articleinfo/subtitle|artheader/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/corpauthor|artheader/corpauthor"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/authorgroup|artheader/authorgroup"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/author|artheader/author"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/releaseinfo|artheader/releaseinfo"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/copyright|artheader/copyright"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/legalnotice|artheader/legalnotice"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/pubdate|artheader/pubdate"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/revision|artheader/revision"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/revhistory|artheader/revhistory"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/abstract|artheader/abstract"/>
</xsl:template>

<xsl:template name="article.titlepage.verso">
</xsl:template>

<xsl:template name="article.titlepage.separator">
</xsl:template>

<xsl:template name="article.titlepage.before.recto">
</xsl:template>

<xsl:template name="article.titlepage.before.verso">
</xsl:template>

<xsl:template name="article.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="article.titlepage.before.recto"/>
    <xsl:call-template name="article.titlepage.recto"/>
    <xsl:call-template name="article.titlepage.before.verso"/>
    <xsl:call-template name="article.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" margin-left="-4pc" keep-with-next="always" font-size="24.8832pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::article[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="article.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="set.titlepage.recto">
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="(setinfo/title|title)[1]"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="(setinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/corpauthor"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/authorgroup"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/author"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/releaseinfo"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/copyright"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/legalnotice"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/pubdate"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/revision"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/revhistory"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/abstract"/>
</xsl:template>

<xsl:template name="set.titlepage.verso">
</xsl:template>

<xsl:template name="set.titlepage.separator">
</xsl:template>

<xsl:template name="set.titlepage.before.recto">
</xsl:template>

<xsl:template name="set.titlepage.before.verso">
</xsl:template>

<xsl:template name="set.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="set.titlepage.before.recto"/>
    <xsl:call-template name="set.titlepage.recto"/>
    <xsl:call-template name="set.titlepage.before.verso"/>
    <xsl:call-template name="set.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::set[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="set.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="set.titlepage.recto.style" font-family="{$title.font.family}">
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

<xsl:template match="revision" mode="set.titlepage.recto.auto.mode">
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

<xsl:template name="book.titlepage.recto">
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="(bookinfo/title|title)[1]"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="(bookinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/corpauthor"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/authorgroup"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/author"/>
</xsl:template>

<xsl:template name="book.titlepage.verso">
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="(bookinfo/title|title)[1]"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/corpauthor"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/authorgroup"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/author"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/pubdate"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/copyright"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/abstract"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/legalnotice"/>
</xsl:template>

<xsl:template name="book.titlepage.separator"><fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
</xsl:template>

<xsl:template name="book.titlepage.before.recto">
</xsl:template>

<xsl:template name="book.titlepage.before.verso"><fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
</xsl:template>

<xsl:template name="book.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="book.titlepage.before.recto"/>
    <xsl:call-template name="book.titlepage.recto"/>
    <xsl:call-template name="book.titlepage.before.verso"/>
    <xsl:call-template name="book.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" font-size="20.736pt" space-before="15.552pt" font-family="{$title.font.family}">
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.recto.style" font-size="17.28pt" space-before="10.8pt" keep-with-next="always">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="title" mode="book.titlepage.verso.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style" font-size="14.4pt" font-weight="bold" font-family="{$title.font.family}">
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
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="book.titlepage.verso.auto.mode">
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="book.titlepage.verso.style" font-size="8pt">
<xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="part.titlepage.recto">
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="(partinfo/title|docinfo/title|title)[1]"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="(partinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
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
    <xsl:call-template name="part.titlepage.before.recto"/>
    <xsl:call-template name="part.titlepage.recto"/>
    <xsl:call-template name="part.titlepage.before.verso"/>
    <xsl:call-template name="part.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="part.titlepage.recto.style" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::part[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="part.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="part.titlepage.recto.style" font-size="20.736pt" space-before="15.552pt" font-weight="bold" font-style="italic" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="partintro.titlepage.recto">
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="(partintroinfo/title|docinfo/title|title)[1]"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="(partintroinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/corpauthor|docinfo/corpauthor"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/authorgroup|docinfo/authorgroup"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/author|docinfo/author"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/releaseinfo|docinfo/releaseinfo"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/copyright|docinfo/copyright"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/legalnotice|docinfo/legalnotice"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/pubdate|docinfo/pubdate"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/revision|docinfo/revision"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/revhistory|docinfo/revhistory"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/abstract|docinfo/abstract"/>
</xsl:template>

<xsl:template name="partintro.titlepage.verso">
</xsl:template>

<xsl:template name="partintro.titlepage.separator">
</xsl:template>

<xsl:template name="partintro.titlepage.before.recto">
</xsl:template>

<xsl:template name="partintro.titlepage.before.verso">
</xsl:template>

<xsl:template name="partintro.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="partintro.titlepage.before.recto"/>
    <xsl:call-template name="partintro.titlepage.recto"/>
    <xsl:call-template name="partintro.titlepage.before.verso"/>
    <xsl:call-template name="partintro.titlepage.verso"/>
    <xsl:call-template name="partintro.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="partintro.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="partintro.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style" font-size="17.28pt" font-weight="bold" margin-left="-4pc" space-before="1em" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style" font-size="14.4pt" font-weight="bold" font-style="italic" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="partintro.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="reference.titlepage.recto">
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="(referenceinfo/title|docinfo/title|title)[1]"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="(referenceinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/corpauthor|docinfo/corpauthor"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/authorgroup|docinfo/authorgroup"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/author|docinfo/author"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/releaseinfo|docinfo/releaseinfo"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/copyright|docinfo/copyright"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/legalnotice|docinfo/legalnotice"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/pubdate|docinfo/pubdate"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/revision|docinfo/revision"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/revhistory|docinfo/revhistory"/>
  <xsl:apply-templates mode="reference.titlepage.recto.auto.mode" select="referenceinfo/abstract|docinfo/abstract"/>
</xsl:template>

<xsl:template name="reference.titlepage.verso">
</xsl:template>

<xsl:template name="reference.titlepage.separator">
</xsl:template>

<xsl:template name="reference.titlepage.before.recto">
</xsl:template>

<xsl:template name="reference.titlepage.before.verso">
</xsl:template>

<xsl:template name="reference.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="reference.titlepage.before.recto"/>
    <xsl:call-template name="reference.titlepage.recto"/>
    <xsl:call-template name="reference.titlepage.before.verso"/>
    <xsl:call-template name="reference.titlepage.verso"/>
    <xsl:call-template name="reference.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="reference.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="reference.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style" font-size="24.8832pt" space-before="18.6624pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="division.title">
<xsl:with-param name="node" select="ancestor-or-self::reference[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="reference.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="reference.titlepage.recto.style">
<xsl:apply-templates select="." mode="reference.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="dedication.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="dedication.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-family="{$title.font.family}" font-weight="bold">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::dedication[1]"/>
</xsl:call-template></fo:block>
  <xsl:apply-templates mode="dedication.titlepage.recto.auto.mode" select="(dedicationinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
</xsl:template>

<xsl:template name="dedication.titlepage.verso">
</xsl:template>

<xsl:template name="dedication.titlepage.separator">
</xsl:template>

<xsl:template name="dedication.titlepage.before.recto">
</xsl:template>

<xsl:template name="dedication.titlepage.before.verso">
</xsl:template>

<xsl:template name="dedication.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="dedication.titlepage.before.recto"/>
    <xsl:call-template name="dedication.titlepage.recto"/>
    <xsl:call-template name="dedication.titlepage.before.verso"/>
    <xsl:call-template name="dedication.titlepage.verso"/>
    <xsl:call-template name="dedication.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="dedication.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="dedication.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="subtitle" mode="dedication.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="dedication.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="dedication.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="preface.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-family="{$title.font.family}" font-weight="bold">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::preface[1]"/>
</xsl:call-template></fo:block>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="(prefaceinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/corpauthor|docinfo/corpauthor"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/authorgroup|docinfo/authorgroup"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/author|docinfo/author"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/releaseinfo|docinfo/releaseinfo"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/copyright|docinfo/copyright"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/legalnotice|docinfo/legalnotice"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/pubdate|docinfo/pubdate"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/revision|docinfo/revision"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/revhistory|docinfo/revhistory"/>
  <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="prefaceinfo/abstract|docinfo/abstract"/>
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
    <xsl:call-template name="preface.titlepage.before.recto"/>
    <xsl:call-template name="preface.titlepage.recto"/>
    <xsl:call-template name="preface.titlepage.before.verso"/>
    <xsl:call-template name="preface.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="preface.titlepage.recto.style" font-family="{$title.font.family}">
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
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="(chapterinfo/title|docinfo/title|title)[1]"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="(chapterinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/corpauthor|docinfo/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/authorgroup|docinfo/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/author|docinfo/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/releaseinfo|docinfo/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/copyright|docinfo/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/legalnotice|docinfo/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/pubdate|docinfo/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/revision|docinfo/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/revhistory|docinfo/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/abstract|docinfo/abstract"/>
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
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="chapter.titlepage.before.recto"/>
    <xsl:call-template name="chapter.titlepage.recto"/>
    <xsl:call-template name="chapter.titlepage.before.verso"/>
    <xsl:call-template name="chapter.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style" space-before="0.5em" margin-left="-4pc" font-style="italic" font-size="14.4pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="chapter.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="chapter.titlepage.recto.auto.mode">
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

<xsl:template name="appendix.titlepage.recto">
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="(appendixinfo/title|docinfo/title|title)[1]"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="(appendixinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/corpauthor|docinfo/corpauthor"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/authorgroup|docinfo/authorgroup"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/author|docinfo/author"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/releaseinfo|docinfo/releaseinfo"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/copyright|docinfo/copyright"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/legalnotice|docinfo/legalnotice"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/pubdate|docinfo/pubdate"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/revision|docinfo/revision"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/revhistory|docinfo/revhistory"/>
  <xsl:apply-templates mode="appendix.titlepage.recto.auto.mode" select="appendixinfo/abstract|docinfo/abstract"/>
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
    <xsl:call-template name="appendix.titlepage.before.recto"/>
    <xsl:call-template name="appendix.titlepage.recto"/>
    <xsl:call-template name="appendix.titlepage.before.verso"/>
    <xsl:call-template name="appendix.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::appendix[1]"/>
</xsl:call-template>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="appendix.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style" font-family="{$title.font.family}">
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

<xsl:template name="section.titlepage.recto">
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="(sectioninfo/title|title)[1]"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="(sectioninfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/corpauthor"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/authorgroup"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/author"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/releaseinfo"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/copyright"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/legalnotice"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/pubdate"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/revision"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/revhistory"/>
  <xsl:apply-templates mode="section.titlepage.recto.auto.mode" select="sectioninfo/abstract"/>
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
    <xsl:call-template name="section.titlepage.before.recto"/>
    <xsl:call-template name="section.titlepage.recto"/>
    <xsl:call-template name="section.titlepage.before.verso"/>
    <xsl:call-template name="section.titlepage.verso"/>
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
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="section.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="section.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="section.titlepage.recto.style" font-family="{$title.font.family}">
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

<xsl:template name="sect1.titlepage.recto">
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="(sect1info/title|title)[1]"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="(sect1info/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/corpauthor"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/authorgroup"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/author"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/releaseinfo"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/copyright"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/legalnotice"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/pubdate"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/revision"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/revhistory"/>
  <xsl:apply-templates mode="sect1.titlepage.recto.auto.mode" select="sect1info/abstract"/>
</xsl:template>

<xsl:template name="sect1.titlepage.verso">
</xsl:template>

<xsl:template name="sect1.titlepage.separator">
</xsl:template>

<xsl:template name="sect1.titlepage.before.recto">
</xsl:template>

<xsl:template name="sect1.titlepage.before.verso">
</xsl:template>

<xsl:template name="sect1.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="sect1.titlepage.before.recto"/>
    <xsl:call-template name="sect1.titlepage.recto"/>
    <xsl:call-template name="sect1.titlepage.before.verso"/>
    <xsl:call-template name="sect1.titlepage.verso"/>
    <xsl:call-template name="sect1.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="sect1.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="sect1.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="sect1.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect1.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect1.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="sect2.titlepage.recto">
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="(sect2info/title|title)[1]"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="(sect2info/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/corpauthor"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/authorgroup"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/author"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/releaseinfo"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/copyright"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/legalnotice"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/pubdate"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/revision"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/revhistory"/>
  <xsl:apply-templates mode="sect2.titlepage.recto.auto.mode" select="sect2info/abstract"/>
</xsl:template>

<xsl:template name="sect2.titlepage.verso">
</xsl:template>

<xsl:template name="sect2.titlepage.separator">
</xsl:template>

<xsl:template name="sect2.titlepage.before.recto">
</xsl:template>

<xsl:template name="sect2.titlepage.before.verso">
</xsl:template>

<xsl:template name="sect2.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="sect2.titlepage.before.recto"/>
    <xsl:call-template name="sect2.titlepage.recto"/>
    <xsl:call-template name="sect2.titlepage.before.verso"/>
    <xsl:call-template name="sect2.titlepage.verso"/>
    <xsl:call-template name="sect2.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="sect2.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="sect2.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="sect2.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect2.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect2.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="sect3.titlepage.recto">
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="(sect3info/title|title)[1]"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="(sect3info/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/corpauthor"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/authorgroup"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/author"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/releaseinfo"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/copyright"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/legalnotice"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/pubdate"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/revision"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/revhistory"/>
  <xsl:apply-templates mode="sect3.titlepage.recto.auto.mode" select="sect3info/abstract"/>
</xsl:template>

<xsl:template name="sect3.titlepage.verso">
</xsl:template>

<xsl:template name="sect3.titlepage.separator">
</xsl:template>

<xsl:template name="sect3.titlepage.before.recto">
</xsl:template>

<xsl:template name="sect3.titlepage.before.verso">
</xsl:template>

<xsl:template name="sect3.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="sect3.titlepage.before.recto"/>
    <xsl:call-template name="sect3.titlepage.recto"/>
    <xsl:call-template name="sect3.titlepage.before.verso"/>
    <xsl:call-template name="sect3.titlepage.verso"/>
    <xsl:call-template name="sect3.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="sect3.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="sect3.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="sect3.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect3.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect3.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="sect4.titlepage.recto">
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="(sect4info/title|title)[1]"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="(sect4info/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/corpauthor"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/authorgroup"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/author"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/releaseinfo"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/copyright"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/legalnotice"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/pubdate"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/revision"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/revhistory"/>
  <xsl:apply-templates mode="sect4.titlepage.recto.auto.mode" select="sect4info/abstract"/>
</xsl:template>

<xsl:template name="sect4.titlepage.verso">
</xsl:template>

<xsl:template name="sect4.titlepage.separator">
</xsl:template>

<xsl:template name="sect4.titlepage.before.recto">
</xsl:template>

<xsl:template name="sect4.titlepage.before.verso">
</xsl:template>

<xsl:template name="sect4.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="sect4.titlepage.before.recto"/>
    <xsl:call-template name="sect4.titlepage.recto"/>
    <xsl:call-template name="sect4.titlepage.before.verso"/>
    <xsl:call-template name="sect4.titlepage.verso"/>
    <xsl:call-template name="sect4.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="sect4.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="sect4.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="sect4.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect4.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect4.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="sect5.titlepage.recto">
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="(sect5info/title|title)[1]"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="(sect5info/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/corpauthor"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/authorgroup"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/author"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/releaseinfo"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/copyright"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/legalnotice"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/pubdate"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/revision"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/revhistory"/>
  <xsl:apply-templates mode="sect5.titlepage.recto.auto.mode" select="sect5info/abstract"/>
</xsl:template>

<xsl:template name="sect5.titlepage.verso">
</xsl:template>

<xsl:template name="sect5.titlepage.separator">
</xsl:template>

<xsl:template name="sect5.titlepage.before.recto">
</xsl:template>

<xsl:template name="sect5.titlepage.before.verso">
</xsl:template>

<xsl:template name="sect5.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="sect5.titlepage.before.recto"/>
    <xsl:call-template name="sect5.titlepage.recto"/>
    <xsl:call-template name="sect5.titlepage.before.verso"/>
    <xsl:call-template name="sect5.titlepage.verso"/>
    <xsl:call-template name="sect5.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="sect5.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="sect5.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="sect5.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="sect5.titlepage.recto.style">
<xsl:apply-templates select="." mode="sect5.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="simplesect.titlepage.recto">
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="(simplesectinfo/title|docinfo/title|title)[1]"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="(simplesectinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/corpauthor|docinfo/corpauthor"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/authorgroup|docinfo/authorgroup"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/author|docinfo/author"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/releaseinfo|docinfo/releaseinfo"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/copyright|docinfo/copyright"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/legalnotice|docinfo/legalnotice"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/pubdate|docinfo/pubdate"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/revision|docinfo/revision"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/revhistory|docinfo/revhistory"/>
  <xsl:apply-templates mode="simplesect.titlepage.recto.auto.mode" select="simplesectinfo/abstract|docinfo/abstract"/>
</xsl:template>

<xsl:template name="simplesect.titlepage.verso">
</xsl:template>

<xsl:template name="simplesect.titlepage.separator">
</xsl:template>

<xsl:template name="simplesect.titlepage.before.recto">
</xsl:template>

<xsl:template name="simplesect.titlepage.before.verso">
</xsl:template>

<xsl:template name="simplesect.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="simplesect.titlepage.before.recto"/>
    <xsl:call-template name="simplesect.titlepage.recto"/>
    <xsl:call-template name="simplesect.titlepage.before.verso"/>
    <xsl:call-template name="simplesect.titlepage.verso"/>
    <xsl:call-template name="simplesect.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="simplesect.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="simplesect.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style" margin-left="-4pc" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="corpauthor" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="author" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="copyright" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="pubdate" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revision" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="revhistory" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="abstract" mode="simplesect.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="simplesect.titlepage.recto.style">
<xsl:apply-templates select="." mode="simplesect.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="bibliography.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="bibliography.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-family="{$title.font.family}" font-weight="bold">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::bibliography[1]"/>
</xsl:call-template></fo:block>
  <xsl:apply-templates mode="bibliography.titlepage.recto.auto.mode" select="(bibliographyinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
</xsl:template>

<xsl:template name="bibliography.titlepage.verso">
</xsl:template>

<xsl:template name="bibliography.titlepage.separator">
</xsl:template>

<xsl:template name="bibliography.titlepage.before.recto">
</xsl:template>

<xsl:template name="bibliography.titlepage.before.verso">
</xsl:template>

<xsl:template name="bibliography.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="bibliography.titlepage.before.recto"/>
    <xsl:call-template name="bibliography.titlepage.recto"/>
    <xsl:call-template name="bibliography.titlepage.before.verso"/>
    <xsl:call-template name="bibliography.titlepage.verso"/>
    <xsl:call-template name="bibliography.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="bibliography.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="bibliography.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="subtitle" mode="bibliography.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="bibliography.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="bibliography.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="glossary.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="glossary.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-family="{$title.font.family}" font-weight="bold">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::bibliography[1]"/>
</xsl:call-template></fo:block>
  <xsl:apply-templates mode="glossary.titlepage.recto.auto.mode" select="(glossaryinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
</xsl:template>

<xsl:template name="glossary.titlepage.verso">
</xsl:template>

<xsl:template name="glossary.titlepage.separator">
</xsl:template>

<xsl:template name="glossary.titlepage.before.recto">
</xsl:template>

<xsl:template name="glossary.titlepage.before.verso">
</xsl:template>

<xsl:template name="glossary.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="glossary.titlepage.before.recto"/>
    <xsl:call-template name="glossary.titlepage.recto"/>
    <xsl:call-template name="glossary.titlepage.before.verso"/>
    <xsl:call-template name="glossary.titlepage.verso"/>
    <xsl:call-template name="glossary.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="glossary.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="glossary.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="subtitle" mode="glossary.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="glossary.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="glossary.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="index.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="index.titlepage.recto.style" margin-left="-4pc" font-size="17.28pt" font-family="{$title.font.family}" font-weight="bold">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::bibliography[1]"/>
</xsl:call-template></fo:block>
  <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="(indexinfo/subtitle|docinfo/subtitle|subtitle)[1]"/>
</xsl:template>

<xsl:template name="index.titlepage.verso">
</xsl:template>

<xsl:template name="index.titlepage.separator">
</xsl:template>

<xsl:template name="index.titlepage.before.recto">
</xsl:template>

<xsl:template name="index.titlepage.before.verso">
</xsl:template>

<xsl:template name="index.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="index.titlepage.before.recto"/>
    <xsl:call-template name="index.titlepage.recto"/>
    <xsl:call-template name="index.titlepage.before.verso"/>
    <xsl:call-template name="index.titlepage.verso"/>
    <xsl:call-template name="index.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="index.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="index.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="subtitle" mode="index.titlepage.recto.auto.mode">
<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="index.titlepage.recto.style" font-family="{$title.font.family}">
<xsl:apply-templates select="." mode="index.titlepage.recto.mode"/>
</fo:block>
</xsl:template>

<xsl:template name="table.of.contents.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="table.of.contents.titlepage.recto.style" space-after="1em" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="gentext.element.name">
<xsl:with-param name="element.name" select="'TableofContents'"/>
</xsl:call-template></fo:block>
</xsl:template>

<xsl:template name="table.of.contents.titlepage.verso">
</xsl:template>

<xsl:template name="table.of.contents.titlepage.separator">
</xsl:template>

<xsl:template name="table.of.contents.titlepage.before.recto">
</xsl:template>

<xsl:template name="table.of.contents.titlepage.before.verso">
</xsl:template>

<xsl:template name="table.of.contents.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="table.of.contents.titlepage.before.recto"/>
    <xsl:call-template name="table.of.contents.titlepage.recto"/>
    <xsl:call-template name="table.of.contents.titlepage.before.verso"/>
    <xsl:call-template name="table.of.contents.titlepage.verso"/>
    <xsl:call-template name="table.of.contents.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="table.of.contents.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="table.of.contents.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template name="list.of.tables.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="list.of.tables.titlepage.recto.style" space-after="1em" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="gentext.element.name">
<xsl:with-param name="element.name" select="'ListofTables'"/>
</xsl:call-template></fo:block>
</xsl:template>

<xsl:template name="list.of.tables.titlepage.verso">
</xsl:template>

<xsl:template name="list.of.tables.titlepage.separator">
</xsl:template>

<xsl:template name="list.of.tables.titlepage.before.recto">
</xsl:template>

<xsl:template name="list.of.tables.titlepage.before.verso">
</xsl:template>

<xsl:template name="list.of.tables.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="list.of.tables.titlepage.before.recto"/>
    <xsl:call-template name="list.of.tables.titlepage.recto"/>
    <xsl:call-template name="list.of.tables.titlepage.before.verso"/>
    <xsl:call-template name="list.of.tables.titlepage.verso"/>
    <xsl:call-template name="list.of.tables.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="list.of.tables.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="list.of.tables.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template name="list.of.figures.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="list.of.figures.titlepage.recto.style" space-after="1em" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="gentext.element.name">
<xsl:with-param name="element.name" select="'ListofFigures'"/>
</xsl:call-template></fo:block>
</xsl:template>

<xsl:template name="list.of.figures.titlepage.verso">
</xsl:template>

<xsl:template name="list.of.figures.titlepage.separator">
</xsl:template>

<xsl:template name="list.of.figures.titlepage.before.recto">
</xsl:template>

<xsl:template name="list.of.figures.titlepage.before.verso">
</xsl:template>

<xsl:template name="list.of.figures.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="list.of.figures.titlepage.before.recto"/>
    <xsl:call-template name="list.of.figures.titlepage.recto"/>
    <xsl:call-template name="list.of.figures.titlepage.before.verso"/>
    <xsl:call-template name="list.of.figures.titlepage.verso"/>
    <xsl:call-template name="list.of.figures.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="list.of.figures.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="list.of.figures.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template name="list.of.examples.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="list.of.examples.titlepage.recto.style" space-after="1em" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="gentext.element.name">
<xsl:with-param name="element.name" select="'ListofExamples'"/>
</xsl:call-template></fo:block>
</xsl:template>

<xsl:template name="list.of.examples.titlepage.verso">
</xsl:template>

<xsl:template name="list.of.examples.titlepage.separator">
</xsl:template>

<xsl:template name="list.of.examples.titlepage.before.recto">
</xsl:template>

<xsl:template name="list.of.examples.titlepage.before.verso">
</xsl:template>

<xsl:template name="list.of.examples.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="list.of.examples.titlepage.before.recto"/>
    <xsl:call-template name="list.of.examples.titlepage.recto"/>
    <xsl:call-template name="list.of.examples.titlepage.before.verso"/>
    <xsl:call-template name="list.of.examples.titlepage.verso"/>
    <xsl:call-template name="list.of.examples.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="list.of.examples.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="list.of.examples.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template name="list.of.equations.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="list.of.equations.titlepage.recto.style" space-after="1em" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="gentext.element.name">
<xsl:with-param name="element.name" select="'ListofEquations'"/>
</xsl:call-template></fo:block>
</xsl:template>

<xsl:template name="list.of.equations.titlepage.verso">
</xsl:template>

<xsl:template name="list.of.equations.titlepage.separator">
</xsl:template>

<xsl:template name="list.of.equations.titlepage.before.recto">
</xsl:template>

<xsl:template name="list.of.equations.titlepage.before.verso">
</xsl:template>

<xsl:template name="list.of.equations.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="list.of.equations.titlepage.before.recto"/>
    <xsl:call-template name="list.of.equations.titlepage.recto"/>
    <xsl:call-template name="list.of.equations.titlepage.before.verso"/>
    <xsl:call-template name="list.of.equations.titlepage.verso"/>
    <xsl:call-template name="list.of.equations.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="list.of.equations.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="list.of.equations.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template name="list.of.unknowns.titlepage.recto">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="list.of.unknowns.titlepage.recto.style" space-after="1em" margin-left="-4pc" font-size="17.28pt" font-weight="bold" font-family="{$title.font.family}">
<xsl:call-template name="gentext.element.name">
<xsl:with-param name="element.name" select="'ListofUnknown'"/>
</xsl:call-template></fo:block>
</xsl:template>

<xsl:template name="list.of.unknowns.titlepage.verso">
</xsl:template>

<xsl:template name="list.of.unknowns.titlepage.separator">
</xsl:template>

<xsl:template name="list.of.unknowns.titlepage.before.recto">
</xsl:template>

<xsl:template name="list.of.unknowns.titlepage.before.verso">
</xsl:template>

<xsl:template name="list.of.unknowns.titlepage">
  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:call-template name="list.of.unknowns.titlepage.before.recto"/>
    <xsl:call-template name="list.of.unknowns.titlepage.recto"/>
    <xsl:call-template name="list.of.unknowns.titlepage.before.verso"/>
    <xsl:call-template name="list.of.unknowns.titlepage.verso"/>
    <xsl:call-template name="list.of.unknowns.titlepage.separator"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="list.of.unknowns.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="list.of.unknowns.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

</xsl:stylesheet>