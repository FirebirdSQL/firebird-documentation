<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



  <!-- This param originally appears in 3 files (not param.xsl),
       with values 0/1: -->
  <xsl:param name="chunk.fast" select="1"/>



  <!-- TOC params -->
  <xsl:param name="toc.section.depth">1</xsl:param>
    <!-- OK. When set to 0, it only mentions the <book>s in the Grand ToC.
         When set to 1, it goes TWO levels deeper and includes the
         <article>/<chapter> level and the top <section>/<sect1> level. Great :-(
     -->

  <xsl:param name="toc.max.depth">2</xsl:param>
    <!-- With the addition of this param, each ToC has max. two levels. This
         is OK for the <set> ToC and the art/chap ToCs, but I would like
         <book> ToCs to be one level deep...                               -->

  <xsl:param name="generate.section.toc.level">1</xsl:param>

  <!-- admonitions params -->
  <xsl:param name="admon.graphics">0</xsl:param>
  <xsl:param name="admon.style"></xsl:param>
    <!-- default margins overridden as this can't be done in
         the CSS; if we want margins we'll put them in the CSS -->

  <!-- misc params -->

  <xsl:param name="generate.index">1</xsl:param>

  <xsl:param name="segmentedlist.as.table" select="1"/>
  <xsl:param name="spacing.paras">1</xsl:param>
  <xsl:param name="use.id.as.filename">1</xsl:param>

  <xsl:param name="chapter.autolabel" select="1"/>
  <xsl:param name="html.stylesheet">firebirddocs.css</xsl:param>
  <!-- Override the callout images location -->
  <xsl:param name="callout.graphics.path" select="'images/callouts/'"/>



</xsl:stylesheet>

