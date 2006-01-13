<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>



  <!-- Override the graphics.xsl imageobjectco to correctly process
       the calloutlist child element -->
  <xsl:template match="imageobjectco">
    <xsl:apply-templates select="imageobject"/>
    <xsl:apply-templates select="calloutlist"/>
  </xsl:template>



</xsl:stylesheet>

