<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">


  <!-- override: if an index's parent is not the top-of-build element, I want
       the page header to show the parent title instead of the index title.
       This way people can still see which index they're in.
       I want this to also show on the index's first page (which normally has no 
       text in the page header.

       If the index belongs directly to the top-of-build element, use the default
       (ie no title in first page header, other pages - except blank - show
       the index's title).
       
       A refinement would be: let t.o.b. index also show parent's title if there are
       other indices in the build.

       Better still would be if index showed parent title + ": Index" or so.
  -->

  <xsl:template name="header.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <!-- Our addition. We need the parent id value later: -->
    <xsl:variable name="parent-id">
      <xsl:if test="parent::*">  <!-- is there a parent ELEMENT? ".." might select root node! -->
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <!-- end of our addition -->

    <fo:block>

      <!-- sequence can be odd, even, first, blank -->
      <!-- position can be left, center, right -->
      <xsl:choose>
        <xsl:when test="$sequence = 'blank'">
          <!-- nothing -->
        </xsl:when>

        <xsl:when test="$position='left'">
          <!-- Same for odd, even, empty, and blank sequences -->
          <xsl:call-template name="draft.text"/>
        </xsl:when>

        <!-- Our addition: -->
        <xsl:when test="name()='index' and $position='center' and $pageclass != 'titlepage'
                        and ../parent::* and $parent-id!=$rootid">
                        <!-- last two tests exclude element if its parent is top-of-build -->
        <!-- sequence is first/odd/even - blank pages have already gone above -->
          <xsl:choose>
            <xsl:when test="ancestor::book and ($double.sided != 0)">
              <fo:retrieve-marker retrieve-class-name="section.head.marker"
                                  retrieve-position="first-including-carryover"
                                  retrieve-boundary="page-sequence"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="(ancestor::article|ancestor::book|/)[last()]" mode="titleabbrev.markup"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- end of our addition -->

        <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
          <xsl:if test="$pageclass != 'titlepage'">
            <xsl:choose>
              <xsl:when test="ancestor::book and ($double.sided != 0)">
                <fo:retrieve-marker retrieve-class-name="section.head.marker"
                                    retrieve-position="first-including-carryover"
                                    retrieve-boundary="page-sequence"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="." mode="titleabbrev.markup"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:when>

        <xsl:when test="$position='center'">
          <!-- nothing for empty and blank sequences -->
        </xsl:when>

        <xsl:when test="$position='right'">
          <!-- Same for odd, even, empty, and blank sequences -->
          <xsl:call-template name="draft.text"/>
        </xsl:when>

        <xsl:when test="$sequence = 'first'">
          <!-- nothing for first pages -->
        </xsl:when>

        <xsl:when test="$sequence = 'blank'">
          <!-- nothing for blank pages -->
        </xsl:when>
      </xsl:choose>
    </fo:block>
  </xsl:template>



  <!-- Standard header.table has cellwidths 1:1:1,
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

</xsl:stylesheet>
