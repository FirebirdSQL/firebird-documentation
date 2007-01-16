<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">



  <!-- Colored background for non-graphical admonitions,
       based on a solution by Carlos Guzman Alvarez     -->

  <xsl:template name="nongraphical.admonition">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="bgcolor">
      <xsl:choose>
        <xsl:when test="name()='note'">F0F8FF</xsl:when>
        <xsl:when test="name()='warning'">FFE4E1</xsl:when>
        <xsl:when test="name()='caution'">FFE4E1</xsl:when>
        <xsl:when test="name()='tip'">F0F8FF</xsl:when>
        <xsl:when test="name()='important'">FFE4E1</xsl:when>
      </xsl:choose>
    </xsl:variable>

<!--
    <xsl:variable name="bgcolor">F0F0F0</xsl:variable>
-->

    <xsl:variable name="bordercolor">
      <xsl:choose>
        <xsl:when test="name()='note'">blue</xsl:when>
        <xsl:when test="name()='warning'">red</xsl:when>
        <xsl:when test="name()='caution'">red</xsl:when>
        <xsl:when test="name()='tip'">blue</xsl:when>
        <xsl:when test="name()='important'">red</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <fo:table keep-together.within-page="always"
              space-before.minimum="0.8em"
              space-before.optimum="1em"
              space-before.maximum="1.2em"
              id="{$id}">
      <fo:table-column column-width="40pt"/>
      <fo:table-column/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell padding="6pt"><fo:block/></fo:table-cell>
          <fo:table-cell padding="6pt"
                         border-width="0.50pt"
                         border-style="solid"
                         border-color="{$bordercolor}"
                         background-color="#{$bgcolor}">
            <xsl:if test="$admon.textlabel != 0 or title">
              <fo:block xsl:use-attribute-sets="admonition.title.properties">
                 <xsl:apply-templates select="." mode="object.title.markup"/>
              </fo:block>
            </xsl:if>
            <fo:block xsl:use-attribute-sets="admonition.properties">
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>



</xsl:stylesheet>

