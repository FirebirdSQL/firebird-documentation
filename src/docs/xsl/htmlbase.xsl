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
    Base stylesheet for both the chunked (= multi-file) and the
    monolith HTML generation.

    This stylesheet is imported by our driver stylesheets html.xsl
    and monohtml.xsl. If you want to know more about the mechanism,
    read the comment in tools/docbook-stylesheets/html/chunk.xsl

    IMPORTANT:
    - Files containing templates overriding chunking behaviour (or
      otherwise being specific to the chunked html builds) must be
      xsl:included in html.xsl, AFTER the inclusion of the original
      chunk-code.xsl

    - Files containing templates that should only be used for
      monohtml builds must be xsl:included in monohtml.xsl, AFTER the
      xsl:import of htmlbase.xsl

    - Files overriding other stuff (element presentation etc.) that
      should be used by both monohtml and chunked html must be
      xsl:included here, AFTER the import of the original docbook.xsl
  -->

  <!-- Import the original DocBook stylesheets: -->
  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl"/>

  <!-- ...and include our own overrides/additions
       EXCEPT THOSE THAT CONTROL CHUNKING BEHAVIOUR OR ARE OTHERWISE
       SPECIFIC TO EITHER CHUNKED OR MONOLITH HTML -->

  <xsl:output method="html"
              encoding="ISO-8859-1"
              indent="yes"/>

  <xsl:include href="common/param.xsl"/>
  <xsl:include href="common/l10n.xsl"/>
  <xsl:include href="common/titles.xsl"/>
  <xsl:include href="common/gentext.xsl"/>
  <xsl:include href="common/inline.xsl"/>
  <xsl:include href="html/param.xsl"/>
  <xsl:include href="html/graphics.xsl"/>
  <xsl:include href="html/index.xsl"/>
  <xsl:include href="html/autotoc.xsl"/>
  <xsl:include href="html/sections.xsl"/>
  <xsl:include href="html/inline.xsl"/>
  <xsl:include href="html/block.xsl"/>
  <xsl:include href="html/lists.xsl"/>
  <xsl:include href="html/titlepage.xsl"/>
  <xsl:include href="html/titlepage.templates.xsl"/>


</xsl:stylesheet>

