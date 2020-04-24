<?xml version='1.0'?>

<!--
  This stylesheet is used for the Firebird Release Notes fo
  (Formatting Objects) generation.
  It imports the standard Firebird docs fo.xsl stylesheet, and then
  includes param-rlsnotes.xsl in which some stuff is overridden.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version='1.0'>

  <!-- Import default Firebirddocs stylesheet for fo generation: -->
  <xsl:import href="fo.xsl"/>

  <!-- Then include customizations for the Release Notes: -->
  <xsl:include href="fo/param-rlsnotes.xsl"/>

</xsl:stylesheet>
