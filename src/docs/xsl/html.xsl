<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
		version="1.0"
                exclude-result-prefixes="exsl">

  <!--
    Driver stylesheet for the chunked (= multi-file) HTML generation.

    This one is a little more complicated than the fo and monohtml drivers.
    If you want to know why, read the comment in ../docbook/chunk.xsl

    IMPORTANT:
    - Files containing templates overriding chunking behaviour must
      be xsl:included here, AFTER the inclusion of the original
      chunk-code.xsl
    - Files overriding other stuff (element presentation etc.) must
      be xsl:included in htmlbase.xsl, AFTER the import of the original
      docbook.xsl
  -->

  <xsl:import href="htmlbase.xsl"/>

  <xsl:import href="../docbook/html/chunk-common.xsl"/>
  <xsl:include href="../docbook/html/manifest.xsl"/>
  <xsl:include href="../docbook/html/chunk-code.xsl"/>

  <!-- include templates overriding chunking behaviour here: -->
  <xsl:include href="html/chunker.xsl"/>
  <xsl:include href="html/chunk-common.xsl"/>

</xsl:stylesheet>

