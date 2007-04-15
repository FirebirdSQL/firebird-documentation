<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">



  <!-- FIXME: Must be able to select an attribute set as a variable. But how?
              Now we get lots of duplicated blocks :-(                      -->

  <!-- ITEMIZEDLIST and ORDEREDLIST -->

  <xsl:template match="itemizedlist|orderedlist">
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

    <xsl:variable name="labelcol-width">
      <xsl:choose>
        <xsl:when test="$label-width != ''">
          <xsl:value-of select="$label-width"/>
        </xsl:when>
        <xsl:when test="name()='orderedlist'">
          <xsl:choose>
            <!-- Could refine the following further: how many inheritnum levels? -->
            <xsl:when test="@inheritnum='inherit' and ancestor::listitem[parent::orderedlist]">
              <xsl:value-of select="'3em'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'2em'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'1.2em'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates
        select="*[not(self::listitem
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::listitem)]
                |processing-instruction()[not(preceding-sibling::listitem)]"/>

    <xsl:choose>
      <xsl:when test="$effspacing='compact' and ancestor::*[@spacing][1]/@spacing = 'compact'">
        <fo:table id="{$id}"
                  table-layout="fixed" width="100%"
                  start-indent="0pt" end-indent="0pt"
                  table-omit-header-at-break="true"
                  table-omit-footer-at-break="true">
          <!-- actually, that sucks (just like in the shipped template):
               preamble should not come BEFORE the block that has the id, but in table-header! -->
          <fo:table-column column-number="1" column-width="{$labelcol-width}"/>
          <fo:table-column column-number="2"/> <!-- maybe a "spacer column" of around 0.2em in between? -->

          <xsl:if test="title">
            <fo:table-header>
              <fo:table-row>
                <fo:table-cell number-columns-spanned="2">
                  <fo:block font-weight="bold">
                    <xsl:apply-templates select="." mode="object.title.markup">
                      <xsl:with-param name="allow-anchors" select="1"/>
                    </xsl:apply-templates>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-header>
          </xsl:if>

          <fo:table-body>
            <xsl:apply-templates
                  select="listitem
                          |comment()[preceding-sibling::listitem]
                          |processing-instruction()[preceding-sibling::listitem]"/>
            <!-- can you use "with-param" on apply-templates?
                 if so, use: <xsl:with-param name="numcols" select="2"/> -->
            <!-- listitems will generate their own rows. but what happens with the rest?
                 Couldn't find non-modal templates matching them! We'll see... -->
          </fo:table-body>
        </fo:table>
      </xsl:when>
      <xsl:otherwise>
        <fo:table id="{$id}"
                  table-layout="fixed" width="100%"
                  start-indent="0pt" end-indent="0pt"
                  table-omit-header-at-break="true"
                  table-omit-footer-at-break="true"
                  xsl:use-attribute-sets="list.block.spacing">
          <fo:table-column column-number="1" column-width="{$labelcol-width}"/>
          <fo:table-column column-number="2"/>

          <xsl:if test="title">
            <fo:table-header>
              <fo:table-row>
                <fo:table-cell number-columns-spanned="2">
                  <fo:block font-weight="bold">
                    <!-- no space-after for compact lists, even if not nested in another compact list: -->
                    <xsl:if test="not($effspacing='compact')">
                      <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates select="." mode="object.title.markup">
                      <xsl:with-param name="allow-anchors" select="1"/>
                    </xsl:apply-templates>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-header>
          </xsl:if>

          <fo:table-body>
            <xsl:apply-templates
                  select="listitem
                          |comment()[preceding-sibling::listitem]
                          |processing-instruction()[preceding-sibling::listitem]"/>
          </fo:table-body>
        </fo:table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!-- IMPROVE: Must be able to select an attribute set as a variable. But how?
                Now we get lots of duplicated blocks :-(                    -->

  <!-- (ITEMIZEDLIST | ORDEREDLIST) / LISTITEM -->

  <xsl:template match="itemizedlist/listitem|orderedlist/listitem">
    <xsl:param name="numcols" select="2"/>

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="effspacing">
      <xsl:value-of select="ancestor::*[@spacing][1]/@spacing"/>
    </xsl:variable>

    <xsl:variable name="itemlabel">
      <xsl:choose>
        <xsl:when test="name(..)='orderedlist'">
          <xsl:apply-templates select="." mode="item-number"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="itemsymbol">
            <xsl:call-template name="list.itemsymbol">
              <xsl:with-param name="node" select="parent::itemizedlist"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$itemsymbol='dash'">-</xsl:when>
            <xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
              <!-- overridden: better than bullets on all levels: -->
            <xsl:when test="$itemsymbol='circle'">-</xsl:when>
            <xsl:when test="$itemsymbol='bullet'">&#x2022;</xsl:when>
            <!-- why do these symbols not work:
                 circle|round &#x2218; (yields #), square|box &#x2610;  -->
            <xsl:otherwise>&#x2022;</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- No vertical space before first listitem. Otherwise, insert a spacer row: -->
    <xsl:if test="position()>1">
      <fo:table-row>
        <fo:table-cell number-columns-spanned="{$numcols}">
          <xsl:if test="$fop-093=1">
            <fo:block/>  <!-- to get spacing right with FOP 0.93 -->
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$effspacing='compact'">
              <fo:block xsl:use-attribute-sets="compact.list.item.spacing"/>
            </xsl:when>
            <xsl:otherwise>
              <fo:block xsl:use-attribute-sets="list.item.spacing"/>
            </xsl:otherwise>
          </xsl:choose>
        </fo:table-cell>
      </fo:table-row>
    </xsl:if>

    <fo:table-row id="{$id}">
      <fo:table-cell>
        <fo:block>
          <xsl:value-of select="$itemlabel"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>

  </xsl:template>



  <!-- VARIABLELIST AS LIST -->
    <!-- implement this as a table too! -->


  <!-- VARLISTENTRY AS LIST -->
    <!-- change this, implement as table too! -->

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



  <!-- VARIABLELIST AS BLOCKS-->

  <!-- maybe merge this with vl.as.list template later. maybe even
       merge with itemized/ordered as the basic framework is the same -->

  <xsl:template match="variablelist" mode="vl.as.blocks">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates
      select="*[not(self::varlistentry
                or self::title
                or self::titleabbrev)]
              |comment()[not(preceding-sibling::varlistentry)]
              |processing-instruction()[not(preceding-sibling::varlistentry)]"/>

    <fo:table id="{$id}"
              table-layout="fixed" width="100%"
              start-indent="0pt" end-indent="0pt"
              table-omit-header-at-break="true"
              table-omit-footer-at-break="true"
              xsl:use-attribute-sets="list.block.spacing">
      <!-- actually, that sucks (just like in the shipped template):
           preamble should not come BEFORE the block that has the id, but in table-header! -->
      <fo:table-column column-number="1" column-width="1.5em"/>
      <fo:table-column column-number="2"/>

      <xsl:if test="title">
        <fo:table-header>
          <fo:table-row>
            <fo:table-cell number-columns-spanned="2">
              <fo:block font-weight="bold" font-style="italic" space-after.optimum="1em">
                <xsl:apply-templates select="." mode="object.title.markup">
                  <xsl:with-param name="allow-anchors" select="1"/>
                </xsl:apply-templates>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-header>
      </xsl:if>

      <fo:table-body>
        <xsl:apply-templates mode="vl.as.blocks"
          select="varlistentry
                  |comment()[preceding-sibling::varlistentry]
                  |processing-instruction()[preceding-sibling::varlistentry]"/>
        <!-- varlistentries will generate their own rows. but what happens with the rest?
             We'll see... -->
      </fo:table-body>
    </fo:table>
  </xsl:template>



  <!-- VARLISTENTRY AS BLOCKS-->

  <xsl:template match="varlistentry" mode="vl.as.blocks">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <!-- No vertical space before first varlistentry. Otherwise, insert a spacer row: -->
    <xsl:if test="position()>1">
      <fo:table-row>
        <fo:table-cell number-columns-spanned="2">
          <xsl:if test="$fop-093=1">
            <fo:block/>  <!-- to get spacing right with FOP 0.93 -->
          </xsl:if>
          <fo:block xsl:use-attribute-sets="list.item.spacing"/>
        </fo:table-cell>
      </fo:table-row>
    </xsl:if>

    <!-- The row with the term: -->
    <fo:table-row id="{$id}"
                  keep-together.within-page="always"
                  keep-with-next.within-page="always">
                  <!-- STRANGE! FOP ought to honour keep-with-next in table rows, but doesn't here -
                       unless I drop the .within-page, but then it also keeps the next row (with the
                       listitem) together, causing large empty spaces on the previous page... -->
      <fo:table-cell number-columns-spanned="2">
        <fo:block space-after.optimum="0.2em">
          <xsl:apply-templates select="term"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>

    <!-- The row with the listitem: -->
    <fo:table-row>
      <fo:table-cell><fo:block/></fo:table-cell>
      <fo:table-cell>
        <fo:block>
          <xsl:apply-templates select="listitem"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>



  <!-- VARLIST TERM -->

  <xsl:template match="varlistentry/term">
    <fo:inline font-style="italic"><xsl:apply-templates/>, </fo:inline>
  </xsl:template>

  <xsl:template match="varlistentry/term[position()=last()]" priority="2">
    <fo:inline font-style="italic"><xsl:apply-templates/></fo:inline>
  </xsl:template>

  <!-- Place author in varlist term on line of his own: -->
  <xsl:template match="varlistentry/term/author">
    <fo:block font-weight="normal" font-style="italic"><xsl:apply-imports/></fo:block>
  </xsl:template>



  <!-- PROCEDURE | SUBSTEPS | STEPALTERNATIVES -->

  <!-- "substeps" occurs within step, and contains steps. It's much like a procedure,
       except that it doesn't have title etc. Also, a procedure can have many types
       of parent and child. A substeps can ony have "step" as parent and "step" as child. 

       "stepalternatives", like substeps, only has step as parent and as child.
       It's used for a) alternatives of which ONE must be chosen, and b) alternatives
       which are all optional. See the performance attribute (which substeps has, too). -->

  <xsl:template match="procedure|substeps|stepalternatives">
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

    <fo:block>
      <!-- TODO: Place preamble *within* table? -->
      <xsl:apply-templates select="$preamble"/>
    </fo:block>

    <fo:table id="{$id}"
              table-layout="fixed" width="100%"
              start-indent="0pt" end-indent="0pt"
              table-omit-header-at-break="true"
              table-omit-footer-at-break="true"
              xsl:use-attribute-sets="list.block.spacing">
      <fo:table-column column-number="1" column-width="2em"/> <!-- width as with orderedlist! -->
      <fo:table-column column-number="2"/>

      <xsl:if test="./title and $placement = 'before'">
        <!-- n.b. gentext code tests for $formal.procedures and may make an "informal" -->
        <!-- heading even though we called formal.object.heading. odd but true. -->
        <fo:table-header>
          <fo:table-row>
            <fo:table-cell number-columns-spanned="2">
              <fo:block font-weight="bold" space-after.optimum="1em">
                <xsl:apply-templates select="." mode="object.title.markup">
                  <xsl:with-param name="allow-anchors" select="1"/>
                </xsl:apply-templates>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-header>
      </xsl:if>

      <fo:table-body>
        <xsl:apply-templates select="$steps"/>
      </fo:table-body>

      <xsl:if test="./title and $placement != 'before'">
        <!-- n.b. gentext code tests for $formal.procedures and may make an "informal" -->
        <!-- heading even though we called formal.object.heading. odd but true. -->
        <fo:table-footer>
          <fo:table-row>
            <fo:table-cell number-columns-spanned="2">
              <fo:block font-weight="bold" space-before.optimum="1em">
                <xsl:apply-templates select="." mode="object.title.markup">
                  <xsl:with-param name="allow-anchors" select="1"/>
                </xsl:apply-templates>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-footer>
      </xsl:if>
    </fo:table>

  </xsl:template>
  <!-- end procedure | substeps | stepalternatives -->



  <!-- (PROCEDURE | SUBSTEPS | STEPALTERNATIVES ) / STEP -->

  <xsl:template match="procedure/step|substeps/step|stepalternatives/step">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <!-- No vertical space before first listitem. Otherwise, insert a spacer row: -->
    <xsl:if test="position()>1">
      <fo:table-row>
        <fo:table-cell number-columns-spanned="2">
          <xsl:if test="$fop-093=1">
            <fo:block/>  <!-- to get spacing right with FOP 0.93 -->
          </xsl:if>
          <fo:block xsl:use-attribute-sets="list.item.spacing"/>
        </fo:table-cell>
      </fo:table-row>
    </xsl:if>

    <!-- the row with the label: -->
    <fo:table-row id="{$id}">
      <fo:table-cell>
        <fo:block>
          <!-- dwc: fix for one step procedures. Use a bullet if there's no step 2 -->
          <xsl:choose>
            <xsl:when test="count(../step) = 1 or parent::stepalternatives">
              <xsl:text>&#x2022;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="." mode="number">
                <xsl:with-param name="recursive" select="0"/>
              </xsl:apply-templates>.   <!-- what's that dot doing here? -->
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>

  </xsl:template>
  <!-- end steps -->





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




</xsl:stylesheet>
