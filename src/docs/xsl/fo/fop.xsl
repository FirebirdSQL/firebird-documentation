<?xml version='1.0' encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xml.apache.org/fop/extensions"
                version='1.0'>


  <xsl:template match="set|book|part|reference|preface|chapter|appendix|article
                       |glossary|bibliography|index|setindex
                       |refentry
                       |sect1|sect2|sect3|sect4|sect5|section"
                mode="fop.outline">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <xsl:variable name="bookmark-label">
      <xsl:apply-templates select="." mode="object.title.markup"/>
    </xsl:variable>

    <!-- Put the root element bookmark at the same level as its children.
         Do the same for a non-root element if it's the top element of
         the current build, ie the top of what winds up in this PDF file -->

    <xsl:choose>
      <xsl:when test="not(parent::*) or $id=$rootid">
        <fox:outline internal-destination="{$id}">
          <fox:label>
            <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
          </fox:label>
        </fox:outline>

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
          <fox:outline internal-destination="toc...{$id}">
            <fox:label>
              <xsl:call-template name="gentext">
                <xsl:with-param name="key" select="'TableofContents'"/>
              </xsl:call-template>
            </fox:label>
          </fox:outline>
        </xsl:if>
        <xsl:apply-templates select="*" mode="fop.outline"/>
      </xsl:when>

      <xsl:otherwise>
        <fox:outline internal-destination="{$id}">
          <fox:label>
            <xsl:value-of select="normalize-space(translate($bookmark-label, $a-dia, $a-asc))"/>
          </fox:label>
          <xsl:apply-templates select="*" mode="fop.outline"/>
        </fox:outline>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
