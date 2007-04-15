<?xml version='1.0'?>

<!--
  This stylesheet is used for the fo (Formatting Objects) generation.
  It imports the shipped "official" stylesheet, supplies parameters,
  and overrides stuff.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:saxon="http://icl.com/saxon"
                exclude-result-prefixes="exsl"
                version='1.0'>

  <!-- Import default DocBook stylesheet for fo generation: -->
  <xsl:import href="../../../tools/docbook-stylesheets/fo/docbook.xsl"/>


  <xsl:output method="xml"
              indent="no"
              saxon:next-in-chain="fo/fo-fix.xsl"/>
  <!-- if the 2nd pass (next-in-chain) is no longer necessary,
       we should change the method to saxon:net.sf.foxon.FOIndenter -->


  <!-- then include our own customizations: -->
  <xsl:include href="common/l10n.xsl"/>
  <xsl:include href="common/titles.xsl"/>
  <xsl:include href="common/gentext.xsl"/>
  <xsl:include href="common/special-hyph.xsl"/>
  <xsl:include href="fo/param.xsl"/>
  <xsl:include href="fo/pagesetup.xsl"/>
  <xsl:include href="fo/verbatim.xsl"/>
  <xsl:include href="fo/inline.xsl"/>
  <xsl:include href="fo/lists.xsl"/>
  <xsl:include href="fo/formal.xsl"/>
  <xsl:include href="fo/block.xsl"/>
  <xsl:include href="fo/htmltbl.xsl"/>
  <xsl:include href="fo/table.xsl"/>
  <xsl:include href="fo/sections.xsl"/>
  <xsl:include href="fo/titlepage.xsl"/>
  <xsl:include href="fo/titlepage.templates.xsl"/>
  <xsl:include href="fo/admon.xsl"/>
  <xsl:include href="fo/index.xsl"/>
  <xsl:include href="fo/xref.xsl"/>
  <xsl:include href="fo/autotoc.xsl"/>
  <xsl:include href="fo/fop1.xsl"/>
  <xsl:include href="fo/component.xsl"/>



</xsl:stylesheet>
