<?xml version='1.0'?>

<!--
  This stylesheet is used for the fo (Formatting Objects) generation.
  It imports the shipped "official" stylesheet, supplies parameters,
  and overrides stuff.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="exsl"
                version='1.0'>

  <!-- Import default DocBook stylesheet for fo generation: -->
  <xsl:import href="docbook/fo/docbook.xsl"/>


  <!-- STYLESHEET PARAMETERS: -->

  <xsl:param name="rootid" select="''"/>

  <xsl:param name="fop.extensions" select="1"/>
    <!-- otherwise broken URLs, and no bookmarks! -->

  <xsl:param name="paper.type" select="'A4'"/>
  <!-- This currently breaks the fo2pdf stage: -->
  <!--  <xsl:param name="double.sided" select="1"/>  -->
  <xsl:param name="title.margin.left">0pc</xsl:param>
  <xsl:param name="variablelist.as.blocks" select="1"/>
  <xsl:param name="segmentedlist.as.table" select="1"/>
  <xsl:param name="ulink.show" select="0"/>
  <xsl:param name="admon.textlabel" select="1"/>


  <!-- Our own params: -->

  <xsl:param name="highlevel.title.color" select="'#FB2400'"/>  <!-- set, book -->
  <xsl:param name="midlevel.title.color" select="'green'"/>     <!-- part, chapter, article... TODO: preface !!! -->
  <xsl:param name="lowlevel.title.color" select="'green'"/>     <!-- section, sectN -->

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


  <!-- ATTRIBUTE SETS: -->


  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$monospace.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">0.9em</xsl:attribute>
  </xsl:attribute-set>


  <!-- Must include this one even if it's an exact copy from fo/param.xsl.
       If we leave it out, fo build fails with:
       <path>/fo/param.xsl:29: Fatal Error! Circular reference to attribute set -->
  <xsl:attribute-set name="article.appendix.title.properties"
                     use-attribute-sets="section.title.properties section.title.level1.properties">
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$title.margin.left"/>
    </xsl:attribute>
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



  <!-- OVERRIDES -->


  <!-- WARNING: the following override is intended to make the .fo
       more human-readable. However, with some processors, verbatim
       environments can get broken by indented tags when the callout
       extension is used.
       If this ever bites us, we must remove this line or comment
       it out: -->
  <xsl:output method="xml" indent="yes"/>



  <!-- HIGHLEVEL TITLES -->

  <xsl:template match="title" mode="set.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
          xsl:use-attribute-sets="set.titlepage.recto.style"
          text-align="left"
          font-size="24.8832pt"
          space-before="18.6624pt"
          space-after="2em"
          font-weight="bold"
          color="{$highlevel.title.color}"
          font-family="{$title.font.family}">
      <xsl:call-template name="division.title">
        <xsl:with-param name="node" select="ancestor-or-self::set[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="book.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
          xsl:use-attribute-sets="book.titlepage.recto.style"
          text-align="center" font-size="24.8832pt" font-weight="bold" color="{$highlevel.title.color}"
          space-before="18.6624pt" space-after="2em" font-family="{$title.font.family}">
      <xsl:call-template name="division.title">
        <xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="book.titlepage.verso.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
          xsl:use-attribute-sets="book.titlepage.verso.style"
          font-size="14.4pt" font-weight="bold" color="{$highlevel.title.color}"
          font-family="{$title.font.family}">
      <xsl:call-template name="book.verso.title">
      </xsl:call-template>
    </fo:block>
  </xsl:template>


  <!-- MIDLEVEL TITLES -->

  <xsl:template match="title" mode="part.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="part.titlepage.recto.style"
      text-align="center" font-size="24.8832pt" space-before="18.6624pt"
      font-weight="bold" font-family="{$title.font.family}" color="{$midlevel.title.color}">
      <xsl:call-template name="division.title">
      <xsl:with-param name="node" select="ancestor-or-self::part[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="chapter.titlepage.recto.style"
      font-size="24.8832pt" font-weight="bold" color="{$midlevel.title.color}">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::chapter[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>

  <xsl:template match="title" mode="article.titlepage.recto.auto.mode">
    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xsl:use-attribute-sets="article.titlepage.recto.style" keep-with-next="always"
      font-size="24.8832pt" font-weight="bold" color="{$midlevel.title.color}">
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::article[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>




  <!-- Standard header.table (see pagesetup.xsl) has cellwidths 1:1:1,
       which leads to ugliness with somewhat longer article/chapter
       names. And we don't use the left and right cells anyway...      -->

  <xsl:template name="header.table">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <!-- default is a single table style for all headers -->
    <!-- Customize it for different page classes or sequence location -->

    <xsl:variable name="candidate">
      <fo:table table-layout="fixed" width="100%">
        <xsl:call-template name="head.sep.rule"/>
        <fo:table-column column-number="1" column-width="proportional-column-width(1)"/>
        <fo:table-column column-number="2" column-width="proportional-column-width(200)"/>
        <fo:table-column column-number="3" column-width="proportional-column-width(1)"/>
        <fo:table-body>
          <fo:table-row height="14pt">
            <fo:table-cell text-align="left"
                           display-align="before">
              <xsl:if test="$fop.extensions = 0">
                <xsl:attribute name="relative-align">baseline</xsl:attribute>
              </xsl:if>
              <fo:block>
                <xsl:call-template name="header.content">
                  <xsl:with-param name="pageclass" select="$pageclass"/>
                  <xsl:with-param name="sequence" select="$sequence"/>
                  <xsl:with-param name="position" select="'left'"/>
                  <xsl:with-param name="gentext-key" select="$gentext-key"/>
                </xsl:call-template>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="center"
                           display-align="before">
              <xsl:if test="$fop.extensions = 0">
                <xsl:attribute name="relative-align">baseline</xsl:attribute>
              </xsl:if>
              <fo:block>
                <xsl:call-template name="header.content">
                  <xsl:with-param name="pageclass" select="$pageclass"/>
                  <xsl:with-param name="sequence" select="$sequence"/>
                  <xsl:with-param name="position" select="'center'"/>
                  <xsl:with-param name="gentext-key" select="$gentext-key"/>
                </xsl:call-template>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right"
                           display-align="before">
              <xsl:if test="$fop.extensions = 0">
                <xsl:attribute name="relative-align">baseline</xsl:attribute>
              </xsl:if>
              <fo:block>
                <xsl:call-template name="header.content">
                  <xsl:with-param name="pageclass" select="$pageclass"/>
                  <xsl:with-param name="sequence" select="$sequence"/>
                  <xsl:with-param name="position" select="'right'"/>
                  <xsl:with-param name="gentext-key" select="$gentext-key"/>
                </xsl:call-template>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </xsl:variable>

    <!-- Really output a header? -->
    <xsl:choose>
      <xsl:when test="$pageclass = 'titlepage' and $gentext-key = 'book'
                      and $sequence='first'">
        <!-- no, book titlepages have no headers at all -->
      </xsl:when>
      <xsl:when test="$sequence = 'blank' and $headers.on.blank.pages = 0">
        <!-- no output -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$candidate"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!-- Fix by Carlos Guzman Alvarez to generate the correct
       number of fo:table-column tags from segmentedlists:  -->

  <xsl:template match="segmentedlist" mode="seglist-table">
    <xsl:apply-templates select="title" mode="list.title.mode" />
    <fo:table>
      <xsl:apply-templates select="segtitle" mode="seglist-column"/>
      <fo:table-header>
        <fo:table-row>
          <xsl:apply-templates select="segtitle" mode="seglist-table"/>
        </fo:table-row>
      </fo:table-header>
      <fo:table-body>
        <xsl:apply-templates select="seglistitem" mode="seglist-table"/>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="segtitle" mode="seglist-column">
    <xsl:variable name="segtitlenum"
                select="count(preceding-sibling::segtitle)+1"/>
    <fo:table-column column-number="{$segtitlenum}"/>
  </xsl:template>


  <!-- Print seglist headers bold when displayed as table: -->

  <xsl:template match="segtitle" mode="seglist-table">
    <fo:table-cell>
      <fo:block font-weight="bold">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>


  <!-- Print varlist terms italic: -->

  <xsl:template match="varlistentry/term">
    <fo:inline font-style="italic"><xsl:apply-templates/>, </fo:inline>
  </xsl:template>

  <xsl:template match="varlistentry/term[position()=last()]" priority="2">
    <fo:inline font-style="italic"><xsl:apply-templates/></fo:inline>
  </xsl:template>


  <!-- Colored background for non-graphical admonitions,
       based on a solution by Carlos Guzman Alvarez     -->

  <xsl:template name="nongraphical.admonition">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="name()='note'">F0FFFF</xsl:when>
        <xsl:when test="name()='warning'">FFE4E1</xsl:when>
        <xsl:when test="name()='caution'">FFE4E1</xsl:when>
        <xsl:when test="name()='tip'">F0FFFF</xsl:when>
        <xsl:when test="name()='important'">FFE4E1</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <fo:block space-before.minimum="0.8em"
              space-before.optimum="1em"
              space-before.maximum="1.2em"
              background-color="#{$color}"
              id="{$id}">
      <fo:table>
        <fo:table-column/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell padding="6pt">

              <xsl:if test="$admon.textlabel != 0 or title">
                <fo:block keep-with-next='always'
                          xsl:use-attribute-sets="admonition.title.properties">
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
    </fo:block>
  </xsl:template>


  <!-- Admonitions' titles in normal font size: -->

  <xsl:attribute-set name="admonition.title.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>


  <!-- ulink appearance.  TODO: Parameterize color etc.  -->

  <xsl:template match="ulink" name="ulink">
    <fo:basic-link color="#000080" text-decoration="underline" xsl:use-attribute-sets="xref.properties">
      <xsl:attribute name="external-destination">
        <xsl:call-template name="fo-external-image">
          <xsl:with-param name="filename" select="@url"/>
        </xsl:call-template>
      </xsl:attribute>
  
      <xsl:choose>
        <xsl:when test="count(child::node())=0">
          <xsl:call-template name="hyphenate-url">
            <xsl:with-param name="url" select="@url"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
  	<xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </fo:basic-link>
  
    <xsl:if test="count(child::node()) != 0
                  and string(.) != @url
                  and $ulink.show != 0">
      <!-- yes, show the URI -->
      <xsl:choose>
        <xsl:when test="$ulink.footnotes != 0 and not(ancestor::footnote)">
          <fo:footnote>
            <xsl:call-template name="ulink.footnote.number"/>
            <fo:footnote-body font-family="{$body.font.family}"
                              font-size="{$footnote.font.size}">
              <fo:block>
                <xsl:call-template name="ulink.footnote.number"/>
                <xsl:text> </xsl:text>
                <fo:inline>
                  <xsl:value-of select="@url"/>
                </fo:inline>
              </fo:block>
            </fo:footnote-body>
          </fo:footnote>
        </xsl:when>
        <xsl:otherwise>
          <fo:inline hyphenate="false">
            <xsl:text> [</xsl:text>
            <xsl:call-template name="hyphenate-url">
              <xsl:with-param name="url" select="@url"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
          </fo:inline>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>
