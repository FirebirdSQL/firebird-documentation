<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:db="http://docbook.org/ns/docbook"
    xmlns:m="http://docbook.org/ns/docbook/modes"
    xmlns:f="http://docbook.org/ns/docbook/functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="db xs"
    version="3.0">

  <xsl:import href="https://cdn.docbook.org/release/xsltng/current/xslt/docbook.xsl"/>

  <!-- Ensure filenames are derived from id -->
  <xsl:template match="db:chapter|db:section|db:appendix|db:part" mode="m:chunk-filename">
    <xsl:sequence select="f:generate-id(.)"/>
  </xsl:template>

</xsl:stylesheet>