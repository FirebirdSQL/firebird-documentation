<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This stylesheet was created by template/titlepage.xsl; do not edit it by hand. -->

<xsl:template name="article.titlepage.before.recto">
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
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/othercredit"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/othercredit"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/edition"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/edition"/>
  <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/edition"/>
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

<xsl:template name="article.titlepage.separator"><hr/>
</xsl:template>

<xsl:template name="article.titlepage">
  <div class="titlepage">
    <div>
    <xsl:call-template name="article.titlepage.before.recto"/>
    <xsl:call-template name="article.titlepage.recto"/>
    </div>
    <div>
    <xsl:call-template name="article.titlepage.before.verso"/>
    <xsl:call-template name="article.titlepage.verso"/>
    </div>
    <xsl:call-template name="article.titlepage.separator"/>
  </div>
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
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="subtitle" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="corpauthor" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="edition" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="releaseinfo" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="pubdate" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="article.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template name="set.titlepage.before.recto">
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
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/othercredit"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="setinfo/edition"/>
  <xsl:apply-templates mode="set.titlepage.recto.auto.mode" select="info/edition"/>
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

<xsl:template name="set.titlepage.separator"><hr/>
</xsl:template>

<xsl:template name="set.titlepage">
  <div class="titlepage">
    <div>
    <xsl:call-template name="set.titlepage.before.recto"/>
    <xsl:call-template name="set.titlepage.recto"/>
    </div>
    <div>
    <xsl:call-template name="set.titlepage.before.verso"/>
    <xsl:call-template name="set.titlepage.verso"/>
    </div>
    <xsl:call-template name="set.titlepage.separator"/>
  </div>
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
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="subtitle" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="corpauthor" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="edition" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="releaseinfo" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="pubdate" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="set.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="set.titlepage.recto.style">
<xsl:apply-templates select="." mode="set.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template name="book.titlepage.before.recto">
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
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/othercredit"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/edition"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/edition"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/releaseinfo"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/copyright"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/legalnotice"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/pubdate"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/revhistory"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/abstract"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="book.titlepage.before.verso">
</xsl:template>

<xsl:template name="book.titlepage.verso">
</xsl:template>

<xsl:template name="book.titlepage.separator"><hr/>
</xsl:template>

<xsl:template name="book.titlepage">
  <div class="titlepage">
    <div>
    <xsl:call-template name="book.titlepage.before.recto"/>
    <xsl:call-template name="book.titlepage.recto"/>
    </div>
    <div>
    <xsl:call-template name="book.titlepage.before.verso"/>
    <xsl:call-template name="book.titlepage.verso"/>
    </div>
    <xsl:call-template name="book.titlepage.separator"/>
  </div>
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
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="corpauthor" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="edition" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="releaseinfo" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="pubdate" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
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

  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/corpauthor"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/authorgroup"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/author"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/othercredit"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/releaseinfo"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/releaseinfo"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/copyright"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/legalnotice"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/pubdate"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/pubdate"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/revision"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/revision"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/revhistory"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="partinfo/abstract"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="info/abstract"/>
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
  <div class="titlepage">
    <div>
    <xsl:call-template name="part.titlepage.before.recto"/>
    <xsl:call-template name="part.titlepage.recto"/>
    </div>
    <div>
    <xsl:call-template name="part.titlepage.before.verso"/>
    <xsl:call-template name="part.titlepage.verso"/>
    </div>
    <xsl:call-template name="part.titlepage.separator"/>
  </div>
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
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="subtitle" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="corpauthor" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="releaseinfo" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="pubdate" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revision" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="part.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="part.titlepage.recto.style">
<xsl:apply-templates select="." mode="part.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template name="partintro.titlepage.before.recto">
</xsl:template>

<xsl:template name="partintro.titlepage.recto">
  <xsl:choose>
    <xsl:when test="partintroinfo/title">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/title"/>
    </xsl:when>
    <xsl:when test="docinfo/title">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="partintroinfo/subtitle">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="docinfo/subtitle">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/corpauthor"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/authorgroup"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/author"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/othercredit"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/edition"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/edition"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/edition"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/releaseinfo"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/releaseinfo"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/copyright"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/legalnotice"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/pubdate"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/pubdate"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/revhistory"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="partintroinfo/abstract"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="partintro.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="partintro.titlepage.before.verso">
</xsl:template>

<xsl:template name="partintro.titlepage.verso">
</xsl:template>

<xsl:template name="partintro.titlepage.separator">
</xsl:template>

<xsl:template name="partintro.titlepage">
  <div>
    <div>
    <xsl:call-template name="partintro.titlepage.before.recto"/>
    <xsl:call-template name="partintro.titlepage.recto"/>
    </div>
    <div>
    <xsl:call-template name="partintro.titlepage.before.verso"/>
    <xsl:call-template name="partintro.titlepage.verso"/>
    </div>
    <xsl:call-template name="partintro.titlepage.separator"/>
  </div>
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
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="subtitle" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="corpauthor" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="edition" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="releaseinfo" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="pubdate" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="partintro.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="partintro.titlepage.recto.style">
<xsl:apply-templates select="." mode="partintro.titlepage.recto.mode"/>
</div>
</xsl:template>

</xsl:stylesheet>