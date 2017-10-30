<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                exclude-result-prefixes="src"
                version="1.0">


  <!-- OVERRIDDEN STYLESHEET PARAMETERS -->

  <xsl:param name="fop1.extensions" select="1"/>
    <!-- otherwise broken URLs, and no bookmarks! -->

  <!-- This connects to that URL everytime it is mentioned in the draft pagemasters!
    <xsl:param name="draft.watermark.image"
               select="'http://docbook.sourceforge.net/release/images/draft.png'"/>
    so we change it to: -->
  <xsl:param name="draft.watermark.image" select="''"/>

  <!-- Let's get rid of that draft pagemaster FO bloat anyhow: -->
  <xsl:param name="draft.mode" select="'no'"/> <!-- default is 'maybe' -->

  <!-- Without this, we get incorrect image file paths in the .fo,
       - resulting in missing images in the PDF - if the source document
       is in a subdir and xi:included in the docset: -->
  <xsl:param name="keep.relative.image.uris" select="1"/>

  <xsl:param name="paper.type" select="'A4'"/>
  <xsl:param name="double.sided" select="0"/>
  <xsl:param name="page.margin.inner">
    <xsl:choose>
      <xsl:when test="$double.sided != 0">1.0in</xsl:when>
      <xsl:otherwise>0.75in</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="page.margin.outer">
    <xsl:choose>
      <xsl:when test="$double.sided != 0">0.5in</xsl:when>
      <xsl:otherwise>0.75in</xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="body.start.indent">
    <xsl:choose>
      <xsl:when test="$fop.extensions != 0">0pt</xsl:when>
      <xsl:when test="$fop1.extensions != 0">0pt</xsl:when> <!-- DocBook stylesheets forgot this one -->
      <xsl:when test="$passivetex.extensions != 0">0pt</xsl:when>
      <xsl:otherwise>4pc</xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="body.font.master">11</xsl:param>

  <xsl:param name="title.margin.left">0pc</xsl:param>
  <xsl:param name="variablelist.as.blocks" select="1"/>
  <xsl:param name="segmentedlist.as.table" select="1"/>
  <xsl:param name="ulink.show" select="0"/>
  <xsl:param name="admon.textlabel" select="1"/>

  <xsl:param name="generate.index" select="1"/>
  <xsl:param name="make.index.markup" select="0"/>

  <xsl:param name="shade.verbatim" select="1"/>
     <!-- if 1, see also shade.*.styles (under attribute sets) -->

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


  <!-- PARAMETERS INTRODUCED BY US -->

  <xsl:param name="fop-093" select="1"/>
    <!-- some fixes:
         - extra space before blockquotes -->

  <xsl:param name="firebird.orange" select="'#FB2400'"/> <!-- also nice: #E03000 -->

  <xsl:param name="highlevel.title.color" select="'#404090'"/>  <!-- set, book, article -->
  <xsl:param name="midlevel.title.color"  select="'#404090'"/>  <!-- part, chapter... TODO: preface !!! -->
  <xsl:param name="lowlevel.title.color"  select="'#404090'"/>  <!-- section, sectN -->
<!-- our green: #108060 -->

  <xsl:param name="link.color"  select="'darkblue'"/>

  <!-- Default params for special word-breaking (e.g. in urls, filenames): -->
  <!--
    &#x200B; (zero-width space) WORKS - (and no more "stretching" as of FOP 0.93)
    &#x00AD; (soft hyphen) does NOT work - FOP 0.20.5 treats it as a normal hyphen,
             always displaying it!
  -->
  <xsl:param name="special-hyph.char"         select="'&#x200B;'"/>
  <xsl:param name="special-hyph.min-before"   select="3"/>
  <xsl:param name="special-hyph.min-after"    select="2"/>

  <!-- Just in case some other (future-version?) template refers to
       ulink.hyphenate, which is used in the original DocBook stylesheets: -->
  <xsl:param name="ulink.hyphenate"           select="$special-hyph.char"/>

  <!-- A convenience parameter: -->
  <xsl:param name="digits" select="'0123456789'"/>

  <!-- Element-specific params for special word-breaking follow here.
       They are explained in ../common/special-hyph.xsl -->

  <!-- Params for URL breaking (works only in ulinks, and then only if the
       text content is (almost) the same as the @url attvalue - see xref.xsl: -->
  <xsl:param name="url-hyph.char"             select="$special-hyph.char"/>
  <xsl:param name="url-hyph.before"           select="concat($digits, '?&amp;')"/>
  <xsl:param name="url-hyph.after"            select="concat($digits, '/.,-=:;_@')"/>
  <xsl:param name="url-hyph.not-before"       select="'/'"/>
  <xsl:param name="url-hyph.not-after"        select="''"/>
  <xsl:param name="url-hyph.not-between"      select="'./'"/>
  <xsl:param name="url-hyph.min-before"       select="$special-hyph.min-before"/>
  <xsl:param name="url-hyph.min-after"        select="$special-hyph.min-after"/>

  <!-- Params for filename breaking: -->
  <xsl:param name="filename-hyph.char"        select="$special-hyph.char"/>
  <xsl:param name="filename-hyph.before"      select="concat($digits, '?&amp;')"/>
  <xsl:param name="filename-hyph.after"       select="concat($digits, '\/.,-+=:;_')"/>
  <xsl:param name="filename-hyph.not-before"  select="'\/'"/>
  <xsl:param name="filename-hyph.not-after"   select="''"/>
  <xsl:param name="filename-hyph.not-between" select="'./\'"/>
  <xsl:param name="filename-hyph.min-before"  select="$special-hyph.min-before"/>
  <xsl:param name="filename-hyph.min-after"   select="$special-hyph.min-after"/>



  <!-- ATTRIBUTE SETS: -->

  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$monospace.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">0.97em</xsl:attribute>
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

  <xsl:attribute-set name="monospace.verbatim.properties">
    <!-- in default: uses verbatim.properties and monospace.properties, text-align=start -->
    <xsl:attribute name="font-size">0.9em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="padding">2pt</xsl:attribute>
    <xsl:attribute name="background-color">#FFFFEC</xsl:attribute>
  </xsl:attribute-set>

  <!-- shade.blah.styles are not *instead of*, but *on top of*
       shade.verbatim.style, adding and/or overriding attributes: -->

  <xsl:attribute-set name="shade.screen.style">
    <xsl:attribute name="background-color">#D8F8F0</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="shade.literallayout.style">
    <xsl:attribute name="padding">0pt</xsl:attribute>
    <xsl:attribute name="background-color">#FFFFFF</xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="table.cell.padding">
    <xsl:attribute name="padding-left">4pt</xsl:attribute>
    <xsl:attribute name="padding-right">4pt</xsl:attribute>
    <xsl:attribute name="padding-top">4pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
  </xsl:attribute-set>


  <!-- CHAPTER TITLE PROPERTIES - attribute sets created by us -->

  <!-- The label is the line just before the title, e.g. "Chapter 9".
       Anything not overidden in the next three sets (ch.label, ch.title,
       and ch.subtitle) will default to the settings in titlepage.templates.xml,
       template <t:titlepage t:element="chapter".../>
       Default color for all three is $midlevel.title.color (see above)
  -->

  <xsl:attribute-set name="chapter.label-plus-title.properties"> <!-- label plus title -->
    <xsl:attribute name="background-color">#D0D0D0</xsl:attribute>
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
    <xsl:attribute name="space-before.minimum">0.48em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">0.60em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.72em</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 3.0"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="chapter.subtitle.properties">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>


  <!-- SECTION TITLE PROPERTIES -->

  <!-- first set is for all sections, following sets are per level -->

  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="color"><xsl:value-of select="$lowlevel.title.color"/></xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.837"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">1.12em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.40em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.68em</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="background-color">#E8E8E8</xsl:attribute>
    <xsl:attribute name="padding">2pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.5"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.96em</xsl:attribute>   <!-- 1.04, 1.30, 1.56 -->
    <xsl:attribute name="space-before.optimum">1.20em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.44em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.225"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.91em</xsl:attribute>   <!-- 0.96, 1.20, 1.44 -->
    <xsl:attribute name="space-before.optimum">1.14em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.37em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.0"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.86em</xsl:attribute>   <!-- 0.88, 1.10, 1.32 -->
    <xsl:attribute name="space-before.optimum">1.08em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.30em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.95"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level6.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.95"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
  </xsl:attribute-set>


  <!-- titles for table, equation, example, etc.: -->
  <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
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
    <xsl:attribute name="space-after.maximum">0.2em</xsl:attribute>
  </xsl:attribute-set>
  <!-- Overriding the above leaves only start-indent and end-indent
       from the default set. However, these are currently overridden
       in the blockquote template itself... -->


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
    <xsl:attribute name="color"><xsl:value-of select="$link.color"/></xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="index.page.number.properties">
    <xsl:attribute name="color"><xsl:value-of select="$link.color"/></xsl:attribute>
<!--    <xsl:attribute name="font-style">italic</xsl:attribute> -->
  </xsl:attribute-set>


</xsl:stylesheet>

