<?xml version='1.0'?>

<!--
  This stylesheet is used for the Firebird Reference Documentation
  fo (Formatting Objects) generation.
  It imports the standard Firebird docs fo.xsl stylesheet, and then
  includes param-refdocs.xsl in which some stuff is overridden.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="exsl"
                version='1.0'>

  <!-- Import default Firebirddocs stylesheet for fo generation: -->
  <xsl:import href="fo.xsl"/>

  <!-- Then include customizations for the Reference Docs: -->
  <xsl:include href="common/param-refdocs.xsl"/>
  <xsl:include href="fo/param-refdocs.xsl"/>

</xsl:stylesheet>
