<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src" 
                version="1.0">



  <!-- OVERRIDES IN VARIOUS LISTS: NO SPACE BEFORE LIST BLOCK IF spacing = "compact"
       AND SPACING OF NEAREST ANCESTOR W/ SPACING ATTRIBUTE IS COMPACT TOO:

       Also, spacing is inherited from nearest ancestor having spacing attribute,
       if list itself doesn't have it set (this may require overriding listtitle
       templates too... -->

  <!-- FIXME: Must be able to select an attribute set as a variable. But how?
              Now we get lots of duplicated blocks :-(                      -->

  <!-- in itemizedlist: -->
  <xsl:template match="itemizedlist">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="effspacing">
      <xsl:value-of select="ancestor-or-self::*[@spacing][1]/@spacing"/>
    </xsl:variable>

    <xsl:variable name="label-width">
      <xsl:call-template name="dbfo-attribute">
        <xsl:with-param name="pis"
                        select="processing-instruction('dbfo')"/>
        <xsl:with-param name="attribute" select="'label-width'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="title">
      <xsl:apply-templates select="title" mode="list.title.mode"/>
    </xsl:if>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates
        select="*[not(self::listitem
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::listitem)]
                |processing-instruction()[not(preceding-sibling::listitem)]"/>

    <xsl:choose>
      <xsl:when test="$effspacing='compact' and ancestor::*[@spacing][1]/@spacing = 'compact'">
        <fo:list-block id="{$id}" provisional-label-separation="0.2em">
          <xsl:attribute name="provisional-distance-between-starts">
            <xsl:choose>
              <xsl:when test="$label-width != ''">
                <xsl:value-of select="$label-width"/>
              </xsl:when>
              <xsl:otherwise>1.5em</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates
                select="listitem
                        |comment()[preceding-sibling::listitem]
                        |processing-instruction()[preceding-sibling::listitem]"/>
        </fo:list-block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block id="{$id}" xsl:use-attribute-sets="list.block.spacing"
                       provisional-label-separation="0.2em">
          <xsl:attribute name="provisional-distance-between-starts">
            <xsl:choose>
              <xsl:when test="$label-width != ''">
                <xsl:value-of select="$label-width"/>
              </xsl:when>
              <xsl:otherwise>1.5em</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates
                select="listitem
                        |comment()[preceding-sibling::listitem]
                        |processing-instruction()[preceding-sibling::listitem]"/>
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- in orderedlist: -->
  <xsl:template match="orderedlist">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="effspacing">
      <xsl:value-of select="ancestor-or-self::*[@spacing][1]/@spacing"/>
    </xsl:variable>

    <xsl:variable name="label-width">
      <xsl:call-template name="dbfo-attribute">
        <xsl:with-param name="pis"
                        select="processing-instruction('dbfo')"/>
        <xsl:with-param name="attribute" select="'label-width'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="title">
      <xsl:apply-templates select="title" mode="list.title.mode"/>
    </xsl:if>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates
        select="*[not(self::listitem
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::listitem)]
                |processing-instruction()[not(preceding-sibling::listitem)]"/>


    <xsl:choose>
      <xsl:when test="$effspacing='compact' and ancestor::*[@spacing][1]/@spacing = 'compact'">
        <fo:list-block id="{$id}" provisional-label-separation="0.2em">
          <xsl:attribute name="provisional-distance-between-starts">
            <xsl:choose>
              <xsl:when test="$label-width != ''">
                <xsl:value-of select="$label-width"/>
              </xsl:when>
              <xsl:otherwise>2em</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates
                select="listitem
                        |comment()[preceding-sibling::listitem]
                        |processing-instruction()[preceding-sibling::listitem]"/>
        </fo:list-block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block id="{$id}" xsl:use-attribute-sets="list.block.spacing"
                       provisional-label-separation="0.2em">
          <xsl:attribute name="provisional-distance-between-starts">
            <xsl:choose>
              <xsl:when test="$label-width != ''">
                <xsl:value-of select="$label-width"/>
              </xsl:when>
              <xsl:otherwise>2em</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates
                select="listitem
                        |comment()[preceding-sibling::listitem]
                        |processing-instruction()[preceding-sibling::listitem]"/>
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- variablelist, procedure and substeps do not have a spacing attribute (yet) -->



  <!-- OVERRIDES IN VARIOUS LISTS: NO VERTICAL SPACE BEFORE FIRST LISTITEM: -->

  <!-- IMPROVE: Must be able to select an attribute set as a variable. But how?
                Now we get lots of duplicated blocks :-(                    -->

  <!-- in itemizedlist: -->
  <xsl:template match="itemizedlist/listitem">
    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

    <xsl:variable name="effspacing">
      <xsl:value-of select="ancestor::*[@spacing][1]/@spacing"/>
    </xsl:variable>

    <xsl:variable name="itemsymbol">
      <xsl:call-template name="list.itemsymbol">
        <xsl:with-param name="node" select="parent::itemizedlist"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="item.contents">
      <fo:list-item-label end-indent="label-end()">
        <fo:block>
          <xsl:choose>
            <xsl:when test="$itemsymbol='dash'">-</xsl:when>
            <xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
              <!-- overridden: better than bullets on all levels: -->
            <xsl:when test="$itemsymbol='circle'">-</xsl:when>
            <xsl:when test="$itemsymbol='bullet'">&#x2022;</xsl:when>
            <!-- why do these symbols not work? -->
            <!--
            <xsl:when test="$itemsymbol='circle'">&#x2218;</xsl:when>    yields #
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
      <xsl:when test="$effspacing='compact'">
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

    <xsl:variable name="effspacing">
      <xsl:value-of select="ancestor::*[@spacing][1]/@spacing"/>
    </xsl:variable>

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
      <xsl:when test="$effspacing='compact'">
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


</xsl:stylesheet>
