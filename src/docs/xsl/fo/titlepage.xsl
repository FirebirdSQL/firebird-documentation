<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>




<!-- new template to display logo on titlepage -->
<xsl:template name="titlepage.logo">
  <fo:block space-before.optimum="3em" space-after.optimum="3em" text-align="center">
     <fo:external-graphic src="images/firebird_logo_400x400.png"
                          width="33.9mm" height="33.9mm"
                          content-width="33.9mm" content-height="33.9mm"/>
  </fo:block>
</xsl:template>



<!-- OVERRIDE: Not everything in bold 
     (finetuning in titlepage.templates.xml) -->

<xsl:attribute-set name="book.titlepage.recto.style">
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.fontset"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>



<!-- OVERRIDE: Toplevel articleinfo/legalnotice on fresh page.
  And nice formatting of course...   -paulvink
-->

<xsl:template match="legalnotice" mode="titlepage.mode">

  <!-- 0 pt margin must be there, otherwise padding will push the margin 6pt outwards: -->
  <fo:block background-color="#FFFFF0"
            margin="0pt"
            padding="6pt"
            border-width="0.50pt"
            border-style="solid"
            border-color="black">

    <xsl:variable name="insert-pagebreak">
      <xsl:if test="parent::articleinfo">
        <xsl:variable name="grandpa-id">
          <!-- is there a grandparent ELEMENT? "../.." might select root node! -->
          <xsl:if test="../parent::*">
            <xsl:call-template name="object.id">
              <xsl:with-param name="object" select="../.."/>
            </xsl:call-template>
          </xsl:if>
        </xsl:variable>
        <!-- toplevel article? legalnotice on fresh page. otherwise: on "shipped" default spot -->
        <xsl:if test="not(../../parent::*) or $grandpa-id=$rootid">1</xsl:if>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$insert-pagebreak='1'">
        <xsl:attribute name="break-before">page</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="space-before.optimum">2em</xsl:attribute>
        <xsl:attribute name="space-before.minimum">1.6em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">2.4em</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="title"> <!-- FIXME: add param for using default title? -->
    <xsl:call-template name="formal.object.heading">
        <xsl:with-param name="title">
          <xsl:apply-templates select="." mode="title.markup"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates mode="titlepage.mode"/>

  </fo:block>

</xsl:template>



<!-- make revhistory a little nicer: -->

<xsl:template match="revhistory" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates select="."/> <!-- use normal mode -->
  </fo:block>
</xsl:template>


<xsl:template match="revhistory/revision" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates select="."/> <!-- use normal mode -->
  </fo:block>
</xsl:template>


<!-- edition: -->

<xsl:template match="edition" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
  <!-- We don't want this: -->
  <!--
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Edition'"/>
    </xsl:call-template>
  -->
</xsl:template>



</xsl:stylesheet>
