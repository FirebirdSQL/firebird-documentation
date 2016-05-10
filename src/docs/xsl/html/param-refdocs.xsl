<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                exclude-result-prefixes="src"
                version="1.0">

<!--
     param-refdocs.xsl
     ==================
     Here you can specify parameters for the Reference Documentation multi-page HTML builds.
     Params not found here will default to the values in param.xsl
     Params not found in param.xsl will default to the values in manual/tools/docbook-stylesheets/hmtl/param.xsl

     Only include params here if you want to OVERRIDE their default values!
-->


  <!-- Chunking -->
  <xsl:param name="chunk.first.sections" select="1"/>

  <!-- Add title to section1 toc en section toc as well: -->
  <xsl:param name="generate.toc">
    appendix  toc,title
    article/appendix  nop
    article   toc,title
    book      toc,title,figure,table,example,equation
    chapter   toc,title
    part      toc,title
    preface   toc,title
    qandadiv  toc
    qandaset  toc
    reference toc,title
    sect1     toc,title
    sect2     toc
    sect3     toc
    sect4     toc
    sect5     toc
    section   toc,title
    set       toc,title
  </xsl:param>

  <!-- Depths of ToCs -->
  <xsl:param name="toc.max.depth">2</xsl:param>               <!-- max number of levels in any ToC                      -->
  <xsl:param name="toc.section.depth">2</xsl:param>           <!-- deepest section level referenced in any ToC          -->
  <xsl:param name="generate.section.toc.level">2</xsl:param>  <!-- deepest section level that will get a ToC of its own -->

  <!--
    NOTE: If generate.section.toc.level >= toc.section.depth, the parameters conflict, because a ToC at section
          level n will have entries of section level n+1, which is 'forbidden' if n >= toc.section.depth.
		  In such a case, generate.section.toc.level takes precedence, but the ToC will only be one level deep.
  -->

</xsl:stylesheet>
