<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<!--
Modification history for the Firebird DocBook project:
- 2001.05.30 by Marcelo Lopez Ruiz
Copied over the skeleton from the html generation, added some comments,
and changed tags from html to format objects were the mapping was easy.

PENDING
Implementing optional styles and labels.
Implementing qandadiv elements.
-->

<xsl:variable name="qanda.defaultlabel">number</xsl:variable>
<xsl:variable name="generate.qandaset.toc" select="true()"/>
<xsl:variable name="generate.qandadiv.toc" select="false()"/>

<!-- ==================================================================== -->

<!--
elements:
  qandaset    - A question-and-answer set
  qandaentry  - A question/answer set within a qandaset
  qandadiv    - A titled division in a qandaset
  question    - A question in a qandaentry
  answer      - An answer to a question in a qandaentry
-->

<xsl:template match="qandaset">
  <xsl:variable name="title" select="title"/>
  <xsl:variable name="not_title" select="*[name(.)!='title']"/>  
  <fo:block space-before.minimum="0.8em"
            space-before.optimum="1em"
            space-before.maximum="1.2em">
    <xsl:apply-templates select="$title"/>
    <xsl:if test="$generate.qandaset.toc">      
      <xsl:call-template name="process.qanda.toc"/>
    </xsl:if>
    <xsl:apply-templates select="$not_title"/>
  </fo:block>
</xsl:template>

<xsl:template match="qandaset/title">
  <!-- TODO: take into account the $qalevel variable. -->
  <fo:block font-size="14pt" font-weight="bold" keep-with-next='always'>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="qandadiv">
  <xsl:variable name="title" select="title"/>
  <xsl:variable name="rest" select="*[name(.)!='title']"/>

  <fo:block space-before.minimum="0.8em"
            space-before.optimum="1em"
            space-before.maximum="1.2em"
            start-indent="0.25in"
            end-indent="0.25in">
    <xsl:apply-templates select="$title"/>
    <xsl:if test="$generate.qandadiv.toc != '0'">
      <xsl:call-template name="process.qanda.toc"/>
    </xsl:if>
    <xsl:apply-templates select="$rest"/>
  </fo:block>
</xsl:template>

<xsl:template match="qandadiv/title">
  <xsl:variable name="qalevel">
    <xsl:call-template name="qandadiv.section.level"/>
  </xsl:variable>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- TODO: take into account the $qalevel. -->
  <fo:block font-size="14pt" font-weight="bold" keep-with-next='always'>
    <!-- TODO: Give an id to the link. -->
    <xsl:apply-templates select="parent::qandadiv" mode="label.content"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="qandaentry">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="question">
  <xsl:variable name="firstch" select="(*[name(.)!='label'])[1]"/>
  <xsl:variable name="restch" select="(*[name(.)!='label'])[position()!=1]"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>

  <fo:block>
    <xsl:attribute name="id"><xsl:value-of select="$id"/>
    </xsl:attribute>  
    <fo:wrapper font-weight="bold"><xsl:apply-templates/></fo:wrapper>
  </fo:block>
</xsl:template>

<xsl:template match="answer">
  <xsl:variable name="firstch" select="(*[name(.)!='label'])[1]"/>
  <xsl:variable name="restch" select="(*[name(.)!='label'])[position()!=1]"/>

  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="label">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="process.qanda.toc">  
  <fo:block start-indent="0.25in"
            end-indent="0.25in"
            border-style="solid"
            border-width="thin">  
    <xsl:apply-templates select="qandadiv" mode="qandatoc.mode"/>
    <xsl:apply-templates select="qandaentry" mode="qandatoc.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="qandadiv" mode="qandatoc.mode">
  <fo:block>
    <xsl:apply-templates select="title" mode="qandatoc.mode"/>
    <xsl:call-template name="process.qanda.toc"/>
  </fo:block>
</xsl:template>

<xsl:template match="qandadiv/title" mode="qandatoc.mode">
  <xsl:variable name="qalevel">
    <xsl:call-template name="qandadiv.section.level"/>
  </xsl:variable>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:apply-templates select="parent::qandadiv" mode="label.content"/>
  <xsl:text> </xsl:text>
  <!-- TODO: make an link from this. -->
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="qandaentry" mode="qandatoc.mode">
  <xsl:apply-templates mode="qandatoc.mode"/>
</xsl:template>

<xsl:template match="question" mode="qandatoc.mode">  
  <!-- Create an id for this question. -->
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>
  <!-- Make this block a link. -->
  <fo:block font-weight="bold">    
    <fo:basic-link>
      <xsl:attribute name="internal-destination"><xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:apply-templates mode="no.wrapper.mode"/>
    </fo:basic-link>    
  </fo:block>
</xsl:template>

<xsl:template match="answer|revhistory" mode="qandatoc.mode">
  <!-- nop -->
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="no.wrapper.mode">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>