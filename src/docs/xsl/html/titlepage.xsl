<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>



<xsl:template match="edition" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <!-- We don't want this: -->
    <!--
      <xsl:call-template name="gentext.space"/>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Edition'"/>
      </xsl:call-template>
    -->
  </p>
</xsl:template>



<xsl:template match="revhistory" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

<xsl:template match="revhistory/revision" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

<xsl:template match="revision/revnumber" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

<xsl:template match="revision/date" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

<xsl:template match="revision/authorinitials" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

<xsl:template match="revision/revremark" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

<xsl:template match="revision/revdescription" mode="titlepage.mode">
  <xsl:apply-templates select="."/> <!-- use normal mode -->
</xsl:template>

</xsl:stylesheet>

