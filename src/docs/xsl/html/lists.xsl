<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


  <!-- Place author in varlist term on line of his own: -->
  <xsl:template match="varlistentry/term/author">
    <br/>
    <xsl:apply-imports/>
  </xsl:template>



</xsl:stylesheet>

