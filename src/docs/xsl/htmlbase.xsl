<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
  xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
  version="1.0"
  exclude-result-prefixes="doc"
  extension-element-prefixes="saxon xalanredirect lxslt">

  <!--
    Base stylesheet for the chunked (= multi-file) HTML generation.

    This stylesheet is imported by our driver stylesheet html.xsl
    If you want to know why, read the comment in ../docbook/html/chunk.xsl

    IMPORTANT:
    - Files containing templates overriding chunking behaviour must be
      xsl:included in html.xsl, AFTER the inclusion of the original 
      chunk-code.xsl
    - Files overriding other stuff (element presentation etc.) must be
      xsl:included here, AFTER the import of the original docbook.xsl
  -->

  <!-- Import the original DocBook stylesheets: -->
  <xsl:import href="../docbook/html/docbook.xsl"/>


  <!-- ...and include our own overrides/additions
       EXCEPT THOSE THAT CONTROL CHUNKING BEHAVIOUR: -->

  <xsl:include href="common/l10n.xsl"/>
  <xsl:include href="common/titles.xsl"/>
  <xsl:include href="html/param.xsl"/>
  <xsl:include href="html/graphics.xsl"/>
  <xsl:include href="html/index.xsl"/>
  <xsl:include href="html/autotoc.xsl"/>
  <xsl:include href="html/sections.xsl"/>
  <xsl:include href="html/block.xsl"/>
  <xsl:include href="html/titlepage.xsl"/>
  <xsl:include href="html/titlepage.templates.xsl"/>


</xsl:stylesheet>

