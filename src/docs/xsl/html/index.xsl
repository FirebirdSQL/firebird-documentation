<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


  <!-- Allow index also with <article> scope -->

  <xsl:template match="index">
    <!-- some implementations use completely empty index tags to indicate -->
    <!-- where an automatically generated index should be inserted. so -->
    <!-- if the index is completely empty, skip it. Unless generate.index -->
    <!-- is non-zero, in which case, this is where the automatically -->
    <!-- generated index should go. -->

    <!-- count(.//indexentry) was count(*) in the original: -->
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != '0'">
      <div class="{name(.)}">
        <xsl:if test="$generate.id.attributes != 0">
          <xsl:attribute name="id">
            <xsl:call-template name="object.id"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:call-template name="index.titlepage"/>
        <xsl:apply-templates/>

        <xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
          <xsl:call-template name="generate-index">
            <xsl:with-param name="scope" select="(ancestor::book|ancestor::article|/)[last()]"/>
          </xsl:call-template>
        </xsl:if>

        <xsl:if test="not(parent::article)">
          <xsl:call-template name="process.footnotes"/>
        </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>


  
</xsl:stylesheet>


