<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">



  <!-- new template to display logo above/below title -->
  <xsl:template name="titlepage.logo">
    <fo:block space-before.optimum="3em" space-after.optimum="3em" text-align="center">
       <fo:external-graphic src="images/firebird_logo_400x400.png"
                            width="33.9mm" height="33.9mm"
                            content-width="33.9mm" content-height="33.9mm"/>
    </fo:block>
  </xsl:template>



  <!-- HIGHLEVEL TITLES -->

  <xsl:template match="title" mode="set.titlepage.recto.auto.mode">
    <xsl:call-template name="titlepage.logo"/>  <!-- creates own block -->
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
          xsl:use-attribute-sets="set.titlepage.recto.style"
          text-align="center"
          font-size="24.8832pt"
          space-before="18.6624pt"
          space-after="2em"
          font-weight="bold"
          color="{$highlevel.title.color}"
          font-family="{$title.font.family}">
      <xsl:call-template name="division.title">
        <xsl:with-param name="node" select="ancestor-or-self::set[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="book.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
          xsl:use-attribute-sets="book.titlepage.recto.style"
          text-align="center" font-size="24.8832pt" font-weight="bold" color="{$highlevel.title.color}"
          space-before="18.6624pt" space-after="2em" font-family="{$title.font.family}">
      <xsl:call-template name="division.title">
        <xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
      </xsl:call-template>
    </fo:block>
    <xsl:call-template name="titlepage.logo"/>  <!-- creates own block -->
  </xsl:template>

  <xsl:template match="title" mode="book.titlepage.verso.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
          xsl:use-attribute-sets="book.titlepage.verso.style"
          font-size="14.4pt" font-weight="bold" color="{$highlevel.title.color}"
          font-family="{$title.font.family}">
      <xsl:call-template name="book.verso.title">
      </xsl:call-template>
    </fo:block>
  </xsl:template>


  <!-- MIDLEVEL TITLES -->

  <xsl:template match="title" mode="part.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="part.titlepage.recto.style"
      text-align="center" font-size="24.8832pt" space-before="18.6624pt"
      font-weight="bold" font-family="{$title.font.family}" color="{$midlevel.title.color}">
      <xsl:call-template name="division.title">
      <xsl:with-param name="node" select="ancestor-or-self::part[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="chapter.titlepage.recto.style"
      font-size="24.8832pt" font-weight="bold" color="{$midlevel.title.color}">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="article.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="article.titlepage.recto.style" keep-with-next="always"
      font-size="24.8832pt" font-weight="bold" color="{$midlevel.title.color}">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::article[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>


  <!-- LEGALNOTICES -->

  <xsl:template match="legalnotice" mode="article.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="article.titlepage.recto.style"
      text-align="justify"
      font-family="{$body.fontset}">
      <!-- original block attributes were:
        xsl:use-attribute-sets="article.titlepage.recto.style"
        text-align="start"
        margin-left="0.5in"
        margin-right="0.5in"
        font-family="{$body.fontset}"
      -->
      <xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
    </fo:block>
  </xsl:template>


  <xsl:template match="legalnotice" mode="book.titlepage.verso.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="book.titlepage.verso.style">
      <!-- original block attributes were:
        xsl:use-attribute-sets="book.titlepage.verso.style"
        font-size="8pt"
      -->
      <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
    </fo:block>
  </xsl:template>


  <!--
    In the original stylesheet, the error is made that <revision> is 
    mentioned instead of <edition>. We fix it here for article but in 
    fact _all_ the templates have got this wrong.

    Maybe we should edit titlepage.templates.xml and generate a whole
    new titlepage.templates.xsl !
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
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" 
        xsl:use-attribute-sets="article.titlepage.recto.style" 
        space-before="0.5em">
      <xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
    </fo:block>
  </xsl:template>




</xsl:stylesheet>

