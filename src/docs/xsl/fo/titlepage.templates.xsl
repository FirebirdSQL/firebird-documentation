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



</xsl:stylesheet>


