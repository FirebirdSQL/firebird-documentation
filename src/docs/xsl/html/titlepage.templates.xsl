<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


  <!--
    In the original stylesheet, the error is made that <revision> is mentioned instead of <edition>.
    We fix it here for article but in fact _all_ the templates have got this wrong:
    
    See also comment in fo/titlepage.templates.xsl about generating 
    new titlepage.templates.xsl!
  -->


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
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/edition"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/edition"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/edition"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/revhistory"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/revhistory"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/revhistory"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="articleinfo/abstract"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="artheader/abstract"/>
    <xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="info/abstract"/>
  </xsl:template>


  <xsl:template match="edition" mode="article.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="article.titlepage.recto.style">
      <xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
    </div>
  </xsl:template>



</xsl:stylesheet>
