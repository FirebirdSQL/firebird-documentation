<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                exclude-result-prefixes="src"
                version="1.0">

<!--
     param-rlsnotes.xsl
     ==================
     Here you can specify parameters for the Release Notes fo (-> pdf) builds.
     Params not found here will default to the values in param.xsl
     Params not found in param.xsl will default to the values in manual/tools/docbook-stylesheets/fo/param.xsl

     Only include params here if you want to OVERRIDE their default values!
-->


  <!-- Our own params: -->

  <xsl:param name="highlevel.title.color" select="'#FB2400'"/>  <!-- set, book -->   <!-- also nice:  #E03000 -->
  <xsl:param name="midlevel.title.color" select="'#103090'"/>  <!-- part, chapter, article... TODO: preface !!! -->
  <!--  <xsl:param name="lowlevel.title.color" select="'darkblue'"/> --> <!-- section, sectN -->
  <xsl:param name="lowlevel.title.color" select="'#108060'"/> <!-- section, sectN -->

  <xsl:param name="shade.verbatim" select="0"/>


  <!-- CHAPTER TITLE PROPERTIES - attribute sets created by us -->

  <!-- The label is the line just before the title, e.g. "Chapter 9".
       Anything not overidden in the next three sets (ch.label, ch.title,
       and ch.subtitle) will default to the settings in titlepage.templates.xml,
       template <t:titlepage t:element="chapter".../>
       Default color for all three is $midlevel.title.color (see above)
  -->

  <xsl:attribute-set name="chapter.label-plus-title.properties"> <!-- label plus title -->
    <!-- Change bg to white (#FFFFFF) if you don't want chapter title shading.
         If you comment it out, it will get the default shading (currently grey). -->
    <xsl:attribute name="background-color">#F0F8FF</xsl:attribute><!-- aliceblue -->
    <xsl:attribute name="padding">2pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="chapter.label.properties">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="chapter.title.properties">
    <!-- space between label and title: -->
    <xsl:attribute name="space-before.minimum">0.20em</xsl:attribute><!-- 0.48 -->
    <xsl:attribute name="space-before.optimum">0.20em</xsl:attribute><!-- 0.6 -->
    <xsl:attribute name="space-before.maximum">0.20em</xsl:attribute><!-- 0.72 -->
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 3.0"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.20em</xsl:attribute> <!-- 0.8 -->
    <xsl:attribute name="space-after.optimum">0.20em</xsl:attribute> <!-- 1.0 -->
    <xsl:attribute name="space-after.maximum">0.20em</xsl:attribute>  <!-- 1.2 -->
  </xsl:attribute-set>


  <!-- SECTION TITLE PROPERTIES -->

  <!-- first set is for all sections, following sets are per level -->

  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="color"><xsl:value-of select="$lowlevel.title.color"/></xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.45"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="background-color">#F0F8FF</xsl:attribute><!-- aliceblue -->
    <xsl:attribute name="space-before.minimum">1.12em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.40em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.68em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.27"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">1.04em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.30em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.56em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.09"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.96em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.20em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.44em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.88em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.10em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.32em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level6.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.82"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>



  <!-- SMALLER MONOSPACE FONT IN CODE SAMPLES, SCREENS ETC. -->

  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">9.4pt</xsl:attribute>
  </xsl:attribute-set>


</xsl:stylesheet>
