<!--
  This stylesheet is used for the Firebird Reference Documentation
  multi-page HTML generation.
  It imports the standard Firebird docs html.xsl stylesheet, and then
  includes param-refdocs.xsl in which some stuff is overridden.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
		version="1.0"
                exclude-result-prefixes="exsl">

  <!-- Import default Firebirddocs stylesheet for multi-page HTML generation: -->
  <xsl:import href="html.xsl"/>

  <!-- Then include customizations for the Reference Docs: -->
  <xsl:include href="common/param-refdocs.xsl"/>
  <xsl:include href="html/param-refdocs.xsl"/>

</xsl:stylesheet>
