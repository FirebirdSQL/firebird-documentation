<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
		version="1.0"
                exclude-result-prefixes="exsl">

  <!--
    Driver stylesheet for the chunked (= multi-file) HTML generation.

    IMPORTANT:
    - Files containing templates specific to the chunked html builds
      must be xsl:included here, AFTER the inclusion of the original
      chunk-code.xsl

    - Files overriding other stuff (element presentation etc.) that
      is common to chunked and monolith html must be xsl:included in
      htmlbase.xsl, AFTER the import of the original docbook.xsl
  -->

  <!-- Import the base HTML stylesheets
       (common to chunked html and monohtml): -->
  <xsl:import href="htmlbase.xsl"/>

  <!-- Import/include the standard DocBook chunking stylesheets: -->
  <xsl:import href="../../../tools/docbook-stylesheets/html/chunk-common.xsl"/>
  <xsl:include href="../../../tools/docbook-stylesheets/html/manifest.xsl"/>
  <xsl:include href="../../../tools/docbook-stylesheets/html/chunk-code.xsl"/>

  <!-- Include our custom templates specific to chunked html: -->
  <xsl:include href="html/chunker.xsl"/>
  <xsl:include href="html/chunk-common.xsl"/>

</xsl:stylesheet>
