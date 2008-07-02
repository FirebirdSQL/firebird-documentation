<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version='1.0'>



<xsl:template match="*" mode="no.anchor.mode">
  <!-- Switch to normal mode if no links or versioninfo
       (vi is a potential line-break trigger, so here too the mode must be passed on to the descendants) -->
  <xsl:choose>
    <xsl:when test="descendant-or-self::footnote or
                    descendant-or-self::anchor or
                    descendant-or-self::ulink or
                    descendant-or-self::link or
                    descendant-or-self::olink or
                    descendant-or-self::xref or
                    descendant-or-self::indexterm or
                    descendant-or-self::emphasis[@role='vi']">

      <xsl:apply-templates mode="no.anchor.mode"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!-- Dresses up a formalpara title with (conditional) punctuation and a hard space.
     Current node MUST be a formalpara/title or a formalpara/info/title
     when this template is called! -->
<xsl:template name="dress-formalpara-title">

  <xsl:variable name="bareTitle">
    <xsl:apply-templates/>
  </xsl:variable>

  <xsl:variable name="lastChar">
    <xsl:if test="$bareTitle != ''">
      <xsl:value-of select="substring($bareTitle,string-length($bareTitle),1)"/>
    </xsl:if>
  </xsl:variable>

  <!-- Add ending punct (conditionally) and hard space: -->
  <xsl:copy-of select="$bareTitle"/>
  <xsl:if test="not(@role='nopunct')
                and $lastChar != ''
                and not(contains($runinhead.title.end.punct, $lastChar))">
    <xsl:value-of select="$runinhead.default.title.end.punct"/>
  </xsl:if>
  <xsl:text>&#160;</xsl:text> <!-- non-breaking space, A0h = 160d -->

</xsl:template>



<!-- We should probably add more elements here, everywhere it is possible
     that the titleabbrev resides in an xxxinfo subelement and the shipped
     templates (copied further below) don't take care of it -->
<xsl:template match="set|book|part|index" mode="titleabbrev.markup">
  <xsl:param name="allow-anchors" select="0"/>
  <xsl:param name="verbose" select="1"/>

  <xsl:variable name="titleabbrev" select="(setinfo/titleabbrev
                                           |bookinfo/titleabbrev
                                           |partinfo/titleabbrev
                                           |indexinfo/titleabbrev
                                           |titleabbrev)[1]"/>

  <xsl:choose>
    <xsl:when test="$titleabbrev">
      <xsl:apply-templates select="$titleabbrev" mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="verbose" select="$verbose"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--
<xsl:template match="*" mode="titleabbrev.markup">
  <xsl:param name="allow-anchors" select="0"/>
  <xsl:param name="verbose" select="1"/>

  <xsl:choose>
    <xsl:when test="titleabbrev">
      <xsl:apply-templates select="titleabbrev[1]" mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="verbose" select="$verbose"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="preface|chapter|appendix" mode="titleabbrev.markup">
  <xsl:param name="allow-anchors" select="0"/>
  <xsl:param name="verbose" select="1"/>

  <xsl:variable name="titleabbrev" select="(docinfo/titleabbrev
                                           |info/titleabbrev
                                           |prefaceinfo/titleabbrev
                                           |chapterinfo/titleabbrev
                                           |appendixinfo/titleabbrev
                                           |titleabbrev)[1]"/>

  <xsl:choose>
    <xsl:when test="$titleabbrev">
      <xsl:apply-templates select="$titleabbrev" mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="verbose" select="$verbose"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="article" mode="titleabbrev.markup">
  <xsl:param name="allow-anchors" select="0"/>
  <xsl:param name="verbose" select="1"/>

  <xsl:variable name="titleabbrev" select="(artheader/titleabbrev
                                           |articleinfo/titleabbrev
                                           |info/titleabbrev
                                           |titleabbrev)[1]"/>

  <xsl:choose>
    <xsl:when test="$titleabbrev">
      <xsl:apply-templates select="$titleabbrev" mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="verbose" select="$verbose"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="section
                     |sect1|sect2|sect3|sect4|sect5
                     |refsect1|refsect2|refsect3
                     |simplesect"
              mode="titleabbrev.markup">
  <xsl:param name="allow-anchors" select="0"/>
  <xsl:param name="verbose" select="1"/>

  <xsl:variable name="titleabbrev" select="(info/titleabbrev
		                            |sectioninfo/titleabbrev
		                            |sect1info/titleabbrev
					    |sect2info/titleabbrev
					    |sect3info/titleabbrev
					    |sect4info/titleabbrev
					    |sect5info/titleabbrev
					    |refsect1info/titleabbrev
					    |refsect2info/titleabbrev
					    |refsect3info/titleabbrev
					    |titleabbrev)[1]"/>

  <xsl:choose>
    <xsl:when test="$titleabbrev">
      <xsl:apply-templates select="$titleabbrev" mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="verbose" select="$verbose"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="titleabbrev" mode="title.markup">
  <xsl:param name="allow-anchors" select="0"/>

  <xsl:choose>
    <xsl:when test="$allow-anchors != 0">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates mode="no.anchor.mode"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
-->

</xsl:stylesheet>

