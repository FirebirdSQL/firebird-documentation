<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>



  <!-- Renders the current node as versioninfo: -->
  <xsl:template name="make-vi">
    <xsl:param name="break" select="''"/>
  
    <xsl:if test="$break='before'"><br/></xsl:if>        <!-- goes wrong within <pre> ! -->
    <span>
      <xsl:attribute name="class">vi</xsl:attribute>
      <xsl:call-template name="anchor"/>
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
           <strong><xsl:apply-templates/></strong>       <!-- or omit the strong and take care of this in CSS -->
        </xsl:with-param>
      </xsl:call-template>
    </span>
    <xsl:if test="$break='after'"><br/></xsl:if>         <!-- goes wrong within <pre> ! -->
  </xsl:template>



</xsl:stylesheet>
