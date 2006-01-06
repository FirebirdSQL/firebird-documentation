<?xml version='1.0'?>

<!--
  This stylesheet is used for the fo (Formatting Objects) generation.
  It imports the shipped "official" stylesheet, supplies parameters,
  and overrides stuff.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="exsl"
                version='1.0'>

  <!-- Import default DocBook stylesheet for fo generation: -->
  <xsl:import href="../docbook/fo/docbook.xsl"/>

  <!-- WARNING: the following override is intended to make the .fo
       more human-readable. However, with some processors, verbatim
       environments can get broken by indented tags when the callout
       extension is used.
       If this ever bites us, we must remove this line or comment
       it out: -->
  <xsl:output method="xml" indent="no"/>
  <!-- Hmm... indent should be "no" for proglistings/screens in blockquotes
       in procedure steps... because linefeed-treatment="preserve" for these
       verbatim elems and the prettifier (sometimes?) puts the closing </block>
       on the next line :-(  -->


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
  <xsl:include href="fo/block.xsl"/>
  <xsl:include href="fo/sections.xsl"/>
  <xsl:include href="fo/titlepage.xsl"/>
  <xsl:include href="fo/titlepage.templates.xsl"/>
  <xsl:include href="fo/admon.xsl"/>
  <xsl:include href="fo/index.xsl"/>
  <xsl:include href="fo/xref.xsl"/>
  <xsl:include href="fo/autotoc.xsl"/>
  <xsl:include href="fo/fop.xsl"/>
  <xsl:include href="fo/component.xsl"/>



</xsl:stylesheet>
