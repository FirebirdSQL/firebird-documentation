<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
                version='1.0'>


<!-- The header has been extended to also match xxxinfo/title elements.
     In the original templates, these elements didn't get the
     section.title.levelN.properties attribute sets.
-->



<xsl:template match="section/title | section/sectioninfo/title
                     | simplesect/title
                     | sect1/title | sect1/sect1info/title
                     | sect2/title | sect2/sect2info/title
                     | sect3/title | sect3/sect3info/title
                     | sect4/title | sect4/sect4info/title
                     | sect5/title | sect5/sect5info/title"
              mode="titlepage.mode"
              priority="2">
  <xsl:if test="$fop-093=1">
    <fo:block keep-with-next.within-page="always">&#x200B;</fo:block>  <!-- to get spacing right with FOP 0.93 -->
  </xsl:if>
  <xsl:choose>
    <xsl:when test="parent::sectioninfo | parent::sect1info | parent::sect2info
                    | parent::sect3info | parent::sect4info | parent::sect5info">
      <xsl:call-template name="section.title">
        <xsl:with-param name="section" select="../.."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="section.title">
        <xsl:with-param name="section" select=".."/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- better reintegrate and select ancestor::*(self::section or self::sect1 or ...)[1] 
but watch out, you need the nearest to the context node, some expressions invert the direction!
-->


<xsl:template name="section.title">
  <xsl:param name="section"/>

  <fo:block keep-with-next.within-column="always">
    <xsl:variable name="id">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$section"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="level">
      <xsl:call-template name="section.level">
        <xsl:with-param name="node" select="$section"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="marker">
      <xsl:choose>
        <xsl:when test="$level &lt;= $marker.section.level">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="title">
      <xsl:apply-templates select="$section" mode="object.title.markup">
        <xsl:with-param name="allow-anchors" select="1"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="titleabbrev">
      <xsl:apply-templates select="$section" mode="titleabbrev.markup"/>
    </xsl:variable>

    <!-- Use for running head only if actual titleabbrev element -->
    <xsl:variable name="titleabbrev.elem">
      <xsl:if test="$section/titleabbrev">
        <xsl:apply-templates select="$section" mode="titleabbrev.markup"/>
      </xsl:if>
    </xsl:variable>

    <xsl:if test="$passivetex.extensions != 0">
      <fotex:bookmark xmlns:fotex="http://www.tug.org/fotex"
                      fotex-bookmark-level="{$level + 2}"
                      fotex-bookmark-label="{$id}">
        <xsl:value-of select="$titleabbrev"/>
      </fotex:bookmark>
    </xsl:if>

    <xsl:if test="$axf.extensions != 0">
      <xsl:attribute name="axf:outline-level">
        <xsl:value-of select="count(ancestor::*)-1"/>
      </xsl:attribute>
      <xsl:attribute name="axf:outline-expand">false</xsl:attribute>
      <xsl:attribute name="axf:outline-title">
        <xsl:value-of select="$title"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:call-template name="section.heading">
      <xsl:with-param name="level" select="$level"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="marker" select="$marker"/>
      <xsl:with-param name="titleabbrev" select="$titleabbrev.elem"/>
    </xsl:call-template>
  </fo:block>
</xsl:template>
                                               
                                
<!-- BRIDGEHEAD -->

<!-- Original DocBook template forgets to place a keep-with-next on the outermost block here -->

<xsl:template match="bridgehead">
  <xsl:variable name="container"
                select="(ancestor::appendix
                        |ancestor::article
                        |ancestor::bibliography
                        |ancestor::chapter
                        |ancestor::glossary
                        |ancestor::glossdiv
                        |ancestor::index
                        |ancestor::partintro
                        |ancestor::preface
                        |ancestor::refsect1
                        |ancestor::refsect2
                        |ancestor::refsect3
                        |ancestor::sect1
                        |ancestor::sect2
                        |ancestor::sect3
                        |ancestor::sect4
                        |ancestor::sect5
                        |ancestor::section
                        |ancestor::setindex
                        |ancestor::simplesect)[last()]"/>

  <xsl:variable name="clevel">
    <xsl:choose>
      <xsl:when test="local-name($container) = 'appendix'
                      or local-name($container) = 'chapter'
                      or local-name($container) = 'article'
                      or local-name($container) = 'bibliography'
                      or local-name($container) = 'glossary'
                      or local-name($container) = 'index'
                      or local-name($container) = 'partintro'
                      or local-name($container) = 'preface'
                      or local-name($container) = 'setindex'">2</xsl:when>
      <xsl:when test="local-name($container) = 'glossdiv'">
        <xsl:value-of select="count(ancestor::glossdiv)+2"/>
      </xsl:when>
      <xsl:when test="local-name($container) = 'sect1'
                      or local-name($container) = 'sect2'
                      or local-name($container) = 'sect3'
                      or local-name($container) = 'sect4'
                      or local-name($container) = 'sect5'
                      or local-name($container) = 'refsect1'
                      or local-name($container) = 'refsect2'
                      or local-name($container) = 'refsect3'
                      or local-name($container) = 'section'
                      or local-name($container) = 'simplesect'">
        <xsl:variable name="slevel">
          <xsl:call-template name="section.level">
            <xsl:with-param name="node" select="$container"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$slevel + 1"/>
      </xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="level">
    <xsl:choose>
      <xsl:when test="@renderas = 'sect1'">1</xsl:when>
      <xsl:when test="@renderas = 'sect2'">2</xsl:when>
      <xsl:when test="@renderas = 'sect3'">3</xsl:when>
      <xsl:when test="@renderas = 'sect4'">4</xsl:when>
      <xsl:when test="@renderas = 'sect5'">5</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$clevel"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="marker">
    <xsl:choose>
      <xsl:when test="$level &lt;= $marker.section.level">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="marker.title">
    <xsl:apply-templates/>
  </xsl:variable>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block id="{$id}" keep-with-next.within-column="always">
    <xsl:call-template name="section.heading">
      <xsl:with-param name="level" select="$level"/>
      <xsl:with-param name="title">
        <xsl:apply-templates/>
      </xsl:with-param>
      <xsl:with-param name="marker" select="$marker"/>
      <xsl:with-param name="marker.title" select="$marker.title"/>
    </xsl:call-template>
  </fo:block>
</xsl:template>


</xsl:stylesheet>

