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
  
  <xsl:param name="generate.index" select="1"/>
  <xsl:param name="make.index.markup" select="1"/>


<!-- pakt in deze vorm ook screen en literallayout mee; wil alleen programlisting: -->
<!--  <xsl:param name="shade.verbatim" select="1"/> -->


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

  <xsl:param name="shade.verbatim" select="0"/>
     <!-- see also shade.verbatim.style (under attribute sets) -->



  <!-- ATTRIBUTE SETS: -->


  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$monospace.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">0.9em</xsl:attribute>
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

  <xsl:attribute-set name="list.block.spacing">
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.2em</xsl:attribute>
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



  <!-- OVERRIDES IN VARIOUS LISTS: NO VERTICAL SPACE BEFORE FIRST LISTITEM: -->

  <!-- IMPROVE: Must be able to select an attribute set as a variable. But how?
                Now we get lots of duplicated blocks :-(                    -->

  <!-- in itemizedlist: -->
  <xsl:template match="itemizedlist/listitem">
    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

    <xsl:variable name="itemsymbol">
      <xsl:call-template name="list.itemsymbol">
        <xsl:with-param name="node" select="parent::itemizedlist"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="item.contents">
      <fo:list-item-label end-indent="label-end()">
        <fo:block>
          <xsl:choose>
            <xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
            <xsl:when test="$itemsymbol='bullet'">&#x2022;</xsl:when>
            <!-- why do these symbols not work? -->
            <!--
            <xsl:when test="$itemsymbol='circle'">&#x2218;</xsl:when>
            <xsl:when test="$itemsymbol='round'">&#x2218;</xsl:when>
            <xsl:when test="$itemsymbol='square'">&#x2610;</xsl:when>
            <xsl:when test="$itemsymbol='box'">&#x2610;</xsl:when>
            -->
            <xsl:otherwise>&#x2022;</xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
  	<xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </xsl:variable>

    <!-- override: no vertical space before FIRST listitem: -->
    <xsl:choose>
      <xsl:when test="position()=1">
        <fo:list-item id="{$id}">
          <xsl:copy-of select="$item.contents"/>
        </fo:list-item>
      </xsl:when>
      <xsl:when test="parent::*/@spacing = 'compact'">
        <fo:list-item id="{$id}" xsl:use-attribute-sets="compact.list.item.spacing">
          <xsl:copy-of select="$item.contents"/>
        </fo:list-item>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
          <xsl:copy-of select="$item.contents"/>
        </fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end itemizedlist/listitem -->


  <!-- in orderedlist: -->
  <xsl:template match="orderedlist/listitem">
    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

    <xsl:variable name="item.contents">
      <fo:list-item-label end-indent="label-end()">
        <fo:block>
          <xsl:apply-templates select="." mode="item-number"/>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
  	<xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </xsl:variable>

    <!-- override: no vertical space before FIRST listitem: -->
    <xsl:choose>
      <xsl:when test="position()=1">
        <fo:list-item id="{$id}">
          <xsl:copy-of select="$item.contents"/>
        </fo:list-item>
      </xsl:when>
      <xsl:when test="parent::*/@spacing = 'compact'">
        <fo:list-item id="{$id}" xsl:use-attribute-sets="compact.list.item.spacing">
          <xsl:copy-of select="$item.contents"/>
        </fo:list-item>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
          <xsl:copy-of select="$item.contents"/>
        </fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end orderedlist/listitem -->


  <!-- in variablelist-as-list: -->
  <xsl:template match="varlistentry" mode="vl.as.list">
    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

    <!-- override: no vertical space before FIRST varlistentry: -->
    <xsl:choose>
      <xsl:when test="position()=1">
        <fo:list-item id="{$id}">
          <fo:list-item-label end-indent="label-end()" text-align="start">
            <fo:block>
              <xsl:apply-templates select="term"/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
      	<xsl:apply-templates select="listitem"/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:when>

      <xsl:otherwise>
        <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
          <fo:list-item-label end-indent="label-end()" text-align="start">
            <fo:block>
              <xsl:apply-templates select="term"/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
      	<xsl:apply-templates select="listitem"/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end variablelist-as-list/varlistentry -->


  <!-- in variablelist-as-block: -->
  <xsl:template match="varlistentry" mode="vl.as.blocks">
    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

    <!-- override: no vertical space before FIRST varlistentry: -->
    <xsl:choose>
      <xsl:when test="position()=1">
        <fo:block id="{$id}" keep-together.within-column="always"
                             keep-with-next.within-column="always">
          <xsl:apply-templates select="term"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block id="{$id}" xsl:use-attribute-sets="list.item.spacing"
                             keep-together.within-column="always"
                             keep-with-next.within-column="always">
          <xsl:apply-templates select="term"/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>

    <fo:block margin-left="0.25in">
      <xsl:apply-templates select="listitem"/>
    </fo:block>
  </xsl:template>
  <!-- end variablelist-as-block/varlistentry -->


  <!-- in procedure steps: -->
  <xsl:template match="procedure/step|substeps/step">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <!-- override: no vertical space before FIRST step: -->
    <xsl:choose>
      <xsl:when test="position()=1">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block id="{$id}">
              <!-- dwc: fix for one step procedures. Use a bullet if there's no step 2 -->
              <xsl:choose>
                <xsl:when test="count(../step) = 1">
                  <xsl:text>&#x2022;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="." mode="number">
                    <xsl:with-param name="recursive" select="0"/>
                  </xsl:apply-templates>.
                </xsl:otherwise>
              </xsl:choose>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:when>

      <xsl:otherwise>
        <fo:list-item xsl:use-attribute-sets="list.item.spacing">
          <fo:list-item-label end-indent="label-end()">
            <fo:block id="{$id}">
              <!-- dwc: fix for one step procedures. Use a bullet if there's no step 2 -->
              <xsl:choose>
                <xsl:when test="count(../step) = 1">
                  <xsl:text>&#x2022;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="." mode="number">
                    <xsl:with-param name="recursive" select="0"/>
                  </xsl:apply-templates>.
                </xsl:otherwise>
              </xsl:choose>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end procedure steps: -->


  <!-- in stepalternatives steps: -->
  <xsl:template match="stepalternatives/step">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <!-- override: no vertical space before FIRST step: -->
    <xsl:choose>
      <xsl:when test="position()=1">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block id="{$id}">
      	<xsl:text>&#x2022;</xsl:text>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
      	<xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:when>

      <xsl:otherwise>
        <fo:list-item xsl:use-attribute-sets="list.item.spacing">
          <fo:list-item-label end-indent="label-end()">
            <fo:block id="{$id}">
      	<xsl:text>&#x2022;</xsl:text>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block>
      	<xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end stepalternatives steps: -->


  <!-- No double lead-in space for procedures -->
  <xsl:template match="procedure">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
  
    <xsl:variable name="param.placement"
                  select="substring-after(normalize-space($formal.title.placement),
                                          concat(local-name(.), ' '))"/>
  
    <xsl:variable name="placement">
      <xsl:choose>
        <xsl:when test="contains($param.placement, ' ')">
          <xsl:value-of select="substring-before($param.placement, ' ')"/>
        </xsl:when>
        <xsl:when test="$param.placement = ''">before</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$param.placement"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
  
    <!-- Preserve order of PIs and comments -->
    <xsl:variable name="preamble"
          select="*[not(self::step
                    or self::title
                    or self::titleabbrev)]
                  |comment()[not(preceding-sibling::step)]
                  |processing-instruction()[not(preceding-sibling::step)]"/>
  
    <xsl:variable name="steps" 
                  select="step
                          |comment()[preceding-sibling::step]
                          |processing-instruction()[preceding-sibling::step]"/>
  
    <!-- override: don't apply list.block.spacing to outer block: -->
    <fo:block id="{$id}">
      <xsl:if test="./title and $placement = 'before'">
        <!-- n.b. gentext code tests for $formal.procedures and may make an "informal" -->
        <!-- heading even though we called formal.object.heading. odd but true. -->
        <xsl:call-template name="formal.object.heading"/>
      </xsl:if>
  
      <xsl:apply-templates select="$preamble"/>
  
      <fo:list-block xsl:use-attribute-sets="list.block.spacing"
                     provisional-distance-between-starts="2em"
                     provisional-label-separation="0.2em">
        <xsl:apply-templates select="$steps"/>
      </fo:list-block>
  
      <xsl:if test="./title and $placement != 'before'">
        <!-- n.b. gentext code tests for $formal.procedures and may make an "informal" -->
        <!-- heading even though we called formal.object.heading. odd but true. -->
        <xsl:call-template name="formal.object.heading"/>
      </xsl:if>
    </fo:block>
  </xsl:template>
  <!-- end procedure -->





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
          <fo:table-row keep-together="always">
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



  <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="color"><xsl:value-of select="'darkblue'"/></xsl:attribute>
<!--    <xsl:attribute name="text-decoration"><xsl:value-of select="'overline'"/></xsl:attribute> -->
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
