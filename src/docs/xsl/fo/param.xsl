<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment" 
                exclude-result-prefixes="src"
                version="1.0">


  <!-- OVERRIDDEN STYLESHEET PARAMETERS: -->

  <xsl:param name="fop.extensions" select="1"/>
    <!-- otherwise broken URLs, and no bookmarks! -->

  <xsl:param name="paper.type" select="'A4'"/>

  <!-- Wit FOP 0.20.5, this doesn't break the fo2pdf stage anymore.
       But double-sided is less pleasant to read on-screen
       due to rather big inner/outer margin difference: -->
    <xsl:param name="double.sided" select="0"/>

  <xsl:param name="body.font.master">11</xsl:param>

  <xsl:param name="title.margin.left">0pc</xsl:param>
  <xsl:param name="variablelist.as.blocks" select="1"/>
  <xsl:param name="segmentedlist.as.table" select="1"/>
  <xsl:param name="ulink.show" select="0"/>
  <xsl:param name="admon.textlabel" select="1"/>
  
  <xsl:param name="generate.index" select="1"/>
  <xsl:param name="make.index.markup" select="0"/>

<!--
  Do something with this?

  "If not empty, the specified character (or more generally, content)
   is added to URLs after every /. If the character specified is a
   Unicode soft hyphen (0x00AD) or Unicode zero-width space (0x200B),
   some FO processors will be able to reasonably hyphenate long URLs.

   As of 28 Jan 2002, discretionary hyphens are more widely and
   correctly supported than zero-width spaces for this purpose."
-->
  <xsl:param name="ulink.hyphenate" select="'&#x00AD;'"/>
  <!-- Hmmmm... somehow those soft buggers don't make it into the .fo.
       Nor does anything else you specify here. -->

  <xsl:param name="shade.verbatim" select="0"/>
     <!-- see also shade.verbatim.style (under attribute sets) -->

<xsl:param name="generate.toc">
/appendix toc,title
article/appendix  nop
/article  toc,title
article   toc
book      toc,title,figure,table,example,equation
/chapter  toc,title
part      toc,title
/preface  toc,title
qandadiv  toc
qandaset  toc
reference toc,title
/sect1    toc
/sect2    toc
/sect3    toc
/sect4    toc
/sect5    toc
/section  toc
set       toc,title
</xsl:param>

  <!-- Our own params: -->

  <xsl:param name="highlevel.title.color" select="'#FB2400'"/>  <!-- set, book -->   <!-- also nice:  #E03000 -->
  <xsl:param name="midlevel.title.color" select="'darkblue'"/>  <!-- part, chapter, article... TODO: preface !!! -->
  <xsl:param name="lowlevel.title.color" select="'darkblue'"/>  <!-- section, sectN -->


  <!-- ATTRIBUTE SETS: -->

  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$monospace.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">0.95em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="background-color">#E0E0E0</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="verbatim.properties">
    <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
    <!-- Removed space-after. But this CAN pose a problem if a text node follows... -->
    <xsl:attribute name="space-after.minimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.2em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table.cell.padding">
    <xsl:attribute name="padding-left">4pt</xsl:attribute>
    <xsl:attribute name="padding-right">4pt</xsl:attribute>
    <xsl:attribute name="padding-top">4pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="color"><xsl:value-of select="$lowlevel.title.color"/></xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.80"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">1.12em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.40em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.68em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.40"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">1.04em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.30em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.56em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.20"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
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
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level6.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>


  <!--
    Brought space-after back to zero for lists and blockquotes.
    This *could* pose a problem if the list is followed by a node
    without leading space, e.g. in the case of a para/listitem
    followed by text. However, it solves the bigger problem that
    we have now: too much vertical space below lists etc.

    Also see the various listitem/step overrides further below
    (paulvink)
  -->

  <xsl:attribute-set name="blockquote.properties">
    <xsl:attribute name="space-after.minimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
  </xsl:attribute-set>

  <!-- override of list.block.spacing in param.xsl: -->
  <xsl:attribute-set name="list.block.spacing">
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.2em</xsl:attribute>
  </xsl:attribute-set>


  <!-- Admonitions' titles in normal font size: -->

  <xsl:attribute-set name="admonition.title.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Admonitions' text in small font: -->

  <xsl:attribute-set name="admonition.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="0.9*$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="color"><xsl:value-of select="'darkblue'"/></xsl:attribute>
  </xsl:attribute-set>





</xsl:stylesheet>

