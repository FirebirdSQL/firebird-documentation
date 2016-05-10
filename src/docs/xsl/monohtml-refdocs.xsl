<!--
  This stylesheet is used for the Firebird Reference Documentation
  single-page HTML generation.
  It imports the standard Firebird docs monohtml.xsl stylesheet, and then
  includes param-refdocs.xsl in which some stuff is overridden.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
		version="1.0"
                exclude-result-prefixes="exsl">

  <!-- Import default Firebirddocs stylesheet for single-page HTML generation: -->
  <xsl:import href="monohtml.xsl"/>

  <!-- Then include customizations for the Reference Docs: -->
  <xsl:include href="common/param-refdocs.xsl"/>
  
  <!-- Do *not* include html/param-refdocs.xsl, because that one is meant for the multi-page target -->

</xsl:stylesheet>
