<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


  <xsl:template match="filename//text()">
    <xsl:call-template name="hyphenate-special">
      <xsl:with-param name="str"         select="."/>
      <xsl:with-param name="before"      select="$filename-hyph.before"/>
      <xsl:with-param name="after"       select="$filename-hyph.after"/>
      <xsl:with-param name="not-before"  select="$filename-hyph.not-before"/>
      <xsl:with-param name="not-after"   select="$filename-hyph.not-after"/>
      <xsl:with-param name="not-between" select="$filename-hyph.not-between"/>
      <xsl:with-param name="hyph-char"   select="$filename-hyph.char"/>
      <xsl:with-param name="min-before"  select="$filename-hyph.min-before"/>
      <xsl:with-param name="min-after"   select="$filename-hyph.min-after"/>
    </xsl:call-template>
  </xsl:template>


</xsl:stylesheet>
