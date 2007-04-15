<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">


<!-- Needed overriding because current FOP versions (latest
     is 0.91) do not support fo:table-and-caption at all -->

<!-- Also, the DocBook stylesheets implementation for HTML-style
     tables is very incomplete (no colors, no halign, empty cells
     get no border etc. -->

<xsl:template match="table|informaltable" mode="htmlTable">
  <xsl:if test="tgroup/tbody/row
                |tgroup/thead/row
                |tgroup/tfoot/row">
    <xsl:message terminate="yes">Broken table: row descendant of HTML table.</xsl:message>
  </xsl:if>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="keep-together">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="pis"
                      select="processing-instruction('dbfo')"/>
      <xsl:with-param name="attribute" select="'keep-together'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="numcols">
    <xsl:call-template name="widest-html-row">
      <xsl:with-param name="rows" select=".//tr"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="caption-placement">
    <xsl:choose>
      <xsl:when test="caption/@align='top'">before</xsl:when>
      <xsl:otherwise>after</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="table-proper"> <!-- without caption or footnotes -->
    <fo:table xsl:use-attribute-sets="table.table.properties">
      <xsl:choose>
        <xsl:when test="$fop.extensions != 0
                        or $fop1.extensions != 0
                        or $passivetex.extensions != 0">
          <xsl:attribute name="table-layout">fixed</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="@width">
            <xsl:value-of select="@width"/>
          </xsl:when>
          <xsl:otherwise>100%</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:call-template name="htmltable.get-bgcolor"/>

      <xsl:call-template name="make-html-table-columns">
        <xsl:with-param name="count" select="$numcols"/>
      </xsl:call-template>
      <xsl:apply-templates select="thead" mode="htmlTable"/>
      <xsl:apply-templates select="tfoot" mode="htmlTable"/>
      <xsl:choose>
        <xsl:when test="tbody">
          <xsl:apply-templates select="tbody" mode="htmlTable"/>
        </xsl:when>
        <xsl:otherwise>
          <fo:table-body>
            <xsl:apply-templates select="tr" mode="htmlTable"/>
          </fo:table-body>
        </xsl:otherwise>
      </xsl:choose>
    </fo:table>
  </xsl:variable>

  <xsl:variable name="footnotes">
    <xsl:if test=".//footnote">
      <fo:block font-family="{$body.fontset}"
                font-size="{$footnote.font.size}"
                keep-with-previous.within-column="always">
        <xsl:apply-templates select=".//footnote" mode="table.footnote.mode"/>
      </fo:block>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="self::table"> <!-- formal table -->
      <fo:block id="{$id}" xsl:use-attribute-sets="table.properties">
        <!-- table.properties by default uses formal.object.properties,
             which contains keep-together.within-column = "always" -->
        <xsl:if test="$keep-together != ''">
          <xsl:attribute name="keep-together.within-column">
            <xsl:value-of select="$keep-together"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="caption and $caption-placement='before'">
          <fo:block space-after="0.1em" keep-with-next.within-column="always">
            <xsl:apply-templates select="caption" mode="htmlTable"/>
          </fo:block>
        </xsl:if>
        <xsl:copy-of select="$table-proper"/>
        <xsl:if test="caption and $caption-placement='after'">
          <fo:block space-before="0.2em" keep-with-previous.within-column="always">
            <xsl:apply-templates select="caption" mode="htmlTable"/>
          </fo:block>
        </xsl:if>
      </fo:block>
    </xsl:when>
    <xsl:otherwise> <!-- informaltable -->
      <fo:block id="{$id}" xsl:use-attribute-sets="informaltable.properties">
        <xsl:if test="$keep-together != ''">
          <xsl:attribute name="keep-together.within-column">
            <xsl:value-of select="$keep-together"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:copy-of select="$table-proper"/>
      </fo:block>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:copy-of select="$footnotes"/>
</xsl:template>


<xsl:template match="caption" mode="htmlTable">
  <fo:block font-family="{$title.font.family}" font-size="{$body.font.master * 0.8}pt">
    <xsl:apply-templates select=".." mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </fo:block>
</xsl:template>


<xsl:template name="make-html-table-columns">
  <xsl:param name="count" select="0"/>
  <xsl:param name="number" select="1"/>

  <xsl:choose>
    <!-- FIXME: honour span attributes
         see http://www.w3.org/TR/html4/struct/tables.html#h-11.2.4 and on -->
    <xsl:when test="col|colgroup/col">
      <xsl:for-each select="col|colgroup/col">
        <fo:table-column>
          <xsl:attribute name="column-number">
            <xsl:number from="table" level="any" format="1"/>
          </xsl:attribute>
          <xsl:if test="@width">
            <xsl:attribute name="column-width">
              <xsl:value-of select="@width"/>
            </xsl:attribute>
          </xsl:if>
        </fo:table-column>
      </xsl:for-each>
    </xsl:when>
    <xsl:when test="$fop.extensions != 0">
      <xsl:if test="$number &lt;= $count">
        <fo:table-column column-number="{$number}"
                         column-width="proportional-column-width(1)"/>
        <xsl:call-template name="make-html-table-columns">
          <xsl:with-param name="count" select="$count"/>
          <xsl:with-param name="number" select="$number + 1"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template match="thead" mode="htmlTable">
  <fo:table-header border-bottom-width="0.25pt"
                   border-bottom-style="solid"
                   border-bottom-color="black"
                   font-weight="bold">
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-header>
</xsl:template>


<xsl:template match="tfoot" mode="htmlTable">
  <fo:table-footer>
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-footer>
</xsl:template>


<xsl:template match="tbody" mode="htmlTable">
  <fo:table-body border-bottom-width="0.25pt"
                 border-bottom-style="solid"
                 border-bottom-color="black">
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-body>
</xsl:template>


<xsl:template match="tr" mode="htmlTable">
  <fo:table-row>
    <xsl:call-template name="htmltable.get-width-height"/>
    <xsl:call-template name="htmltable.get-halign"/>
    <xsl:call-template name="htmltable.get-bgcolor"/>
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-row>
</xsl:template>


<xsl:template match="td|th" mode="htmlTable">
  <fo:table-cell xsl:use-attribute-sets="table.cell.padding">
    <xsl:if test="self::th">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:if>
    <xsl:call-template name="htmltable.get-colspan-rowspan"/>
    <xsl:call-template name="htmltable.get-width-height"/>
    <xsl:call-template name="htmltable.get-halign"/>
    <xsl:call-template name="htmltable.get-valign"/>
    <xsl:call-template name="htmltable.get-bgcolor"/>
    <xsl:call-template name="htmltable.get-border"/>
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </fo:table-cell>
</xsl:template>


<!-- FIXME: align and valign, as well as other attrs, may also
     occur in col or colgroup children of the (informal)table.
     See also the comment in template make-html-table-columns -->


<xsl:template name="htmltable.get-bgcolor">
  <xsl:if test="@bgcolor">
    <xsl:attribute name="background-color">
      <xsl:value-of select="@bgcolor"/>
    </xsl:attribute>
  </xsl:if>
</xsl:template>


<xsl:template name="htmltable.get-width-height">
  <xsl:if test="@width">
    <xsl:attribute name="width">
      <xsl:value-of select="@width"/>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="@height">
    <xsl:attribute name="height">
      <xsl:value-of select="@height"/>
    </xsl:attribute>
  </xsl:if>
</xsl:template>


<xsl:template name="htmltable.get-colspan-rowspan">
  <xsl:if test="@colspan &gt; 1">
    <xsl:attribute name="number-columns-spanned">
      <xsl:value-of select="@colspan"/>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="@rowspan &gt; 1">
    <xsl:attribute name="number-rows-spanned">
      <xsl:value-of select="@rowspan"/>
    </xsl:attribute>
  </xsl:if>
</xsl:template>


<xsl:template name="htmltable.get-halign">
  <xsl:variable name="use-align">
    <!-- left, right, center, char, justify :map to: start, end, center, <string> , justify -->
    <xsl:choose>
      <xsl:when test="@align='left'">start</xsl:when>
      <xsl:when test="@align='right'">end</xsl:when>
      <xsl:when test="@align='char'"><xsl:value-of select="@char"/></xsl:when>
      <xsl:when test="@align != ''"><xsl:value-of select="@align"/></xsl:when>
      <xsl:when test="self::th or parent::thead">center</xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="$use-align != ''">
    <xsl:attribute name="text-align">
      <xsl:value-of select="$use-align"/>
    </xsl:attribute>
  </xsl:if>
</xsl:template>


<xsl:template name="htmltable.get-valign">
  <xsl:variable name="source-valign">
    <!-- display-align can ONLY be applied to table-cell, not -row etc.: -->
    <xsl:if test="self::td or self::th">
      <xsl:choose>
        <xsl:when test="@valign != ''">
          <xsl:value-of select="@valign"/>
        </xsl:when>
        <xsl:when test="../@valign != ''"> <!-- from tr -->
          <xsl:value-of select="../@valign"/>
        </xsl:when>
        <xsl:when test="../../@valign != ''">  <!-- from tbody, thead, tfoot -->
          <xsl:value-of select="../../@valign"/>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:variable>
  <xsl:if test="$source-valign != ''">
    <!-- bottom, middle, top, baseline :map to: after, before, center, .... -->
    <xsl:attribute name="display-align">
      <xsl:choose>
        <xsl:when test="$source-valign='top'">before</xsl:when>
        <xsl:when test="$source-valign='middle'">center</xsl:when>
        <xsl:when test="$source-valign='bottom'">after</xsl:when>
        <xsl:when test="$source-valign='baseline'">
          <xsl:message>
            <xsl:text>"valign=baseline" not supported in XSL-FO, using "after"</xsl:text>
          </xsl:message>
          <xsl:text>after</xsl:text>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$source-valign"/></xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:if>
</xsl:template>


<xsl:template name="htmltable.get-border">
  <!-- borders are only applied to fo:table-cell (why?) but picked up from the table itself: -->
  <xsl:if test="self::td or self::th">
    <xsl:variable name="source-border"
                  select="(ancestor::table | ancestor::informaltable)[last()]/@border"/>
    <xsl:if test="$source-border != '' and $source-border != 0">
      <xsl:attribute name="border">
        <xsl:value-of select="$table.cell.border.thickness"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$table.cell.border.style"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$table.cell.border.color"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:if>
</xsl:template>



</xsl:stylesheet>
