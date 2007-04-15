<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>

<xsl:template match="*" mode="fop1.outline">
  <xsl:apply-templates select="*" mode="fop1.outline"/>
</xsl:template>

<xsl:template match="set|book|part|reference|
                     preface|chapter|appendix|article
                     |glossary|bibliography|index|setindex
                     |refentry
                     |sect1|sect2|sect3|sect4|sect5|section"
              mode="fop1.outline">

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="bookmark-label">
    <!-- mode unlabeled.title.markup is defined up to part level,
         but not for book and set - and some others -->
    <!-- TODO : For appendix objects, I would like "A.", "B." prefixes,
         but object.title.markup prepends a complete "Appendix A:" -->
    <xsl:choose>
      <xsl:when test="self::appendix">
        <xsl:variable name="label">
          <xsl:apply-templates select="." mode="label.markup"/>
        </xsl:variable>
        <xsl:if test="$label != ''">
          <xsl:copy-of select="$label"/>
          <xsl:value-of select="$autotoc.label.separator"/>
        </xsl:if>
        <xsl:apply-templates select="." mode="unlabeled.title.markup"/>
      </xsl:when>
      <xsl:when test="self::set or self::book or self::article or self::index">
        <xsl:apply-templates select="." mode="object.title.markup"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="unlabeled.title.markup"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:variable>

  <!-- Put the root element bookmark at the same level as its children -->
  <!-- If the object is a set or book, generate a bookmark for the toc -->

  <xsl:choose>
    <xsl:when test="parent::* and $id!=$rootid">
      <fo:bookmark starting-state="hide" internal-destination="{$id}">
        <fo:bookmark-title>
          <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
        </fo:bookmark-title>
        <xsl:apply-templates select="*" mode="fop1.outline"/>
      </fo:bookmark>
    </xsl:when>
    <xsl:otherwise>
      <fo:bookmark internal-destination="{$id}">
        <fo:bookmark-title>
          <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
        </fo:bookmark-title>
      </fo:bookmark>

      <xsl:variable name="toc.params">
        <xsl:call-template name="find.path.params">
          <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="contains($toc.params, 'toc')
                    and (book|part|reference|preface|chapter|appendix|article
                         |glossary|bibliography|index|setindex
                         |refentry
                         |sect1|sect2|sect3|sect4|sect5|section)">
        <fo:bookmark internal-destination="toc...{$id}">
          <fo:bookmark-title>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'TableofContents'"/>
            </xsl:call-template>
          </fo:bookmark-title>
        </fo:bookmark>
      </xsl:if>
      <xsl:apply-templates select="*" mode="fop1.outline"/>
    </xsl:otherwise>
  </xsl:choose>
<!--
  <fo:bookmark internal-destination="{$id}"/>
-->
</xsl:template>


</xsl:stylesheet>
