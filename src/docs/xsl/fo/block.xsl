<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>



<!-- implement blockquote using a blind table.
     otherwise tables in blockquotes outdent back to the original margins,
     and nested blockquotes are all on the same indentation level -->

<xsl:variable name="blockquote-indent" select="'24pt'"/>

<xsl:template match="blockquote">
  <fo:table xsl:use-attribute-sets="blockquote.properties"
            table-layout="fixed" width="100%"
            start-indent="0pt" end-indent="0pt"> 
            <!-- override start-indent and end-indent from attrset! -->
    <fo:table-column column-number="1" column-width="{$blockquote-indent}"/>
    <fo:table-column column-number="2"/>
    <fo:table-column column-number="3" column-width="{$blockquote-indent}"/>

    <fo:table-body>
      <fo:table-row>
        <fo:table-cell/>
        <fo:table-cell>

          <xsl:call-template name="anchor"/>
          <fo:block>
            <xsl:if test="title">
              <fo:block xsl:use-attribute-sets="formal.title.properties">
                <xsl:apply-templates select="." mode="object.title.markup"/>
              </fo:block>
            </xsl:if>
            <xsl:apply-templates select="*[local-name(.) != 'title'
                                         and local-name(.) != 'attribution']"/>
          </fo:block>
          <xsl:if test="attribution">
            <fo:block text-align="right">
              <!-- mdash -->
              <xsl:text>&#x2014;</xsl:text>
              <xsl:apply-templates select="attribution"/>
            </fo:block>
          </xsl:if>

        </fo:table-cell>
        <fo:table-cell/>
      </fo:table-row>
    </fo:table-body>
  </fo:table>
</xsl:template>

<!--
<xsl:template match="blockquote">
  <fo:block xsl:use-attribute-sets="blockquote.properties">
    <xsl:call-template name="anchor"/>
    <fo:block>
      <xsl:if test="title">
        <fo:block xsl:use-attribute-sets="formal.title.properties">
          <xsl:apply-templates select="." mode="object.title.markup"/>
        </fo:block>
      </xsl:if>
      <xsl:apply-templates select="*[local-name(.) != 'title'
                                   and local-name(.) != 'attribution']"/>
    </fo:block>
    <xsl:if test="attribution">
      <fo:block text-align="right">
-->        <!-- mdash --> <!--
        <xsl:text>&#x2014;</xsl:text>
        <xsl:apply-templates select="attribution"/>
      </fo:block>
    </xsl:if>
  </fo:block>
</xsl:template>
-->




<xsl:template match="revhistory">

  <xsl:variable name="explicit.table.width">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="pis"
                      select="processing-instruction('dbfo')"/>
      <xsl:with-param name="attribute" select="'table-width'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="table.width">
    <xsl:choose>
      <xsl:when test="$explicit.table.width != ''">
        <xsl:value-of select="$explicit.table.width"/>
      </xsl:when>
      <xsl:when test="$default.table.width = ''">
        <xsl:text>100%</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default.table.width"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <fo:table table-layout="fixed" width="{$table.width}"
            space-before="1em" text-align="left">
    <fo:table-column column-number="1" column-width="proportional-column-width(2)"/>
    <fo:table-column column-number="2" column-width="proportional-column-width(3)"/>
    <fo:table-column column-number="3" column-width="proportional-column-width(2)"/>
    <fo:table-column column-number="4" column-width="proportional-column-width(10)"/>
    <fo:table-header>
      <fo:table-row>
        <fo:table-cell number-columns-spanned="17">
          <fo:block font-weight="bold" space-after="1em">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'RevHistory'"/>
            </xsl:call-template>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>
    <fo:table-body>
      <xsl:apply-templates/>
    </fo:table-body>
  </fo:table>
</xsl:template>


<xsl:template match="revhistory/revision">
  <xsl:variable name="revnumber" select=".//revnumber"/>
  <xsl:variable name="revdate"   select=".//date"/>
  <xsl:variable name="revauthor" select=".//authorinitials"/>
  <xsl:variable name="revremark" select=".//revremark|.//revdescription"/>

  <!-- spacer row before each revision except first: -->
  <xsl:if test="preceding-sibling::* or preceding-sibling::text()">
    <fo:table-row height="1em"/>
  </xsl:if>

  <fo:table-row>
    <fo:table-cell>
      <fo:block>
        <xsl:apply-templates select="$revnumber[1]"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block>
        <xsl:apply-templates select="$revdate[1]"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block>
        <xsl:apply-templates select="$revauthor[1]"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block>
        <xsl:apply-templates select="$revremark[1]"/>
      </fo:block>
    </fo:table-cell>
  </fo:table-row>
</xsl:template>


<xsl:template match="revdescription/para">
  <fo:block> <!-- No normal para spacing, ie no vertical whitespace before -->
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>


</xsl:stylesheet>
