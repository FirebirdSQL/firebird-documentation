<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                exclude-result-prefixes="src"
                version="1.0">

<!--
     param-refdocs.xsl
     ==================
     Here you can specify parameters for the Reference Documentation HTML builds.
     Params not found here will default to the values in param.xsl
     Params not found in param.xsl will default to the values in manual/tools/docbook-stylesheets/hmtl/param.xsl

     Only include params here if you want to OVERRIDE their default values!
-->


  <!-- Chunking -->
  <xsl:param name="chunk.first.sections" select="1"/>


</xsl:stylesheet>
