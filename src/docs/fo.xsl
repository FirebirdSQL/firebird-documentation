<?xml version='1.0'?>

<!--
  This stylesheet is used for the fo (Formatting Objects) generation.
  It imports the shipped "official" stylesheet, supplies parameters,
  and overrides stuff.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version='1.0'>

  <!-- Import default DocBook stylesheet for fo generation: -->
  <xsl:import href="docbook/fo/docbook.xsl"/>


  <!-- STYLESHEET PARAMETERS: -->

  <xsl:param name="title.margin.left">0pc</xsl:param>
  <xsl:param name="variablelist.as.blocks" select="1"/>
  <xsl:param name="segmentedlist.as.table" select="1"/>


  <!-- OVERRIDES -->


  <!-- WARNING: the following override is intended to make the .fo
       more human-readable. However, with some processors, verbatim
       environments can get broken by indented tags when the callout
       extension is used.
       If this ever bites us, we must remove this line or comment
       it out: -->
  <xsl:output method="xml" indent="yes"/>


  <!-- Print seglist headers bold when displayed as table: -->

  <xsl:template match="segtitle" mode="seglist-table">
    <fo:table-cell>
      <fo:block font-weight="bold">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>


</xsl:stylesheet>
