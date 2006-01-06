<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!--
  hyphenate-special can be used for e.g. filenames, URLs, etc.

  Parameter description:
  str         : string to hyphenate
  before      : characters in str before which a break may occur
  after       : characters in str after which a break may occur
  not-before  : characters in str before which a break may NOT occur
  not-after   : characters in str after which a break may NOT occur
  not-between : same-char sequences in str not to break. Just specify
                the SINGLE char(s). If this param is e.g. "./\", these
                sequences will not be broken: "..", "///", "\\", etc.
                But the following may still be broken, depending on
                the other rules: ".\", "\.\.", "./\", etc.
  hyph-char   : the character(s) to insert in an OK-to-break spot
  min-before  : the minimum allowed length of the part before the break
  min-after   : the minimum allowed length of the part after the break

  Notes:
  - "not-between" takes precedence to all *after/*before rules.
  - "not-before" will overrule "after", and "not-after" will overrule "before".
  - However, once a character is found in "before", "not-before" will not
    be checked. So if a char is present in both "before" and "not-before",
    the template will deem it OK to break str before that char.
    The same applies to "after" and "not-after".
-->
<xsl:template name="hyphenate-special">
  <xsl:param name="str"         select="''"/>
  <xsl:param name="before"      select="''"/>
  <xsl:param name="after"       select="''"/>
  <xsl:param name="not-before"  select="''"/>
  <xsl:param name="not-after"   select="''"/>
  <xsl:param name="not-between" select="''"/>
  <xsl:param name="hyph-char"   select="$special-hyph.char"/>
  <xsl:param name="min-before"  select="$special-hyph.min-before"/>
  <xsl:param name="min-after"   select="$special-hyph.min-after"/>

  <!-- minimal length at which splits are allowed: -->
  <xsl:variable name="minlen">
    <xsl:value-of select="$min-before + $min-after"/>
  </xsl:variable>

  <xsl:variable name="len" select="string-length($str)"/>

  <xsl:choose>
    <xsl:when test="$hyph-char = '' or concat($before, $after) = '' or $len &lt; $minlen">
      <xsl:value-of select="$str"/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:variable name="this" select="substring($str, 1, $min-before)"/>
      <xsl:variable name="rest" select="substring($str, $min-before + 1)"/>
      <xsl:variable name="restlen" select="$len - $min-before"/>

      <!-- Output first part: -->
      <xsl:value-of select="$this"/>

      <xsl:variable name="this-lastchar"  select="substring($this, $min-before)"/>
      <xsl:variable name="rest-firstchar" select="substring($rest, 1, 1)"/>

      <!-- Output hyph-char if and where appropriate -->
      <xsl:choose>
        <xsl:when test="$this-lastchar = $rest-firstchar
                        and contains($not-between, $this-lastchar)"/>
        <xsl:when test="contains($after, $this-lastchar)
                        and not (contains($not-before, $rest-firstchar))">
          <xsl:copy-of select="$hyph-char"/>
        </xsl:when>
        <xsl:when test="contains($before, $rest-firstchar)
                        and not (contains($not-after, $this-lastchar))">
          <xsl:copy-of select="$hyph-char"/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>

      <!-- Output the rest through a recursive call: -->
      <xsl:call-template name="hyphenate-special">
        <xsl:with-param name="str"         select="$rest"/>
        <xsl:with-param name="before"      select="$before"/>
        <xsl:with-param name="after"       select="$after"/>
        <xsl:with-param name="not-before"  select="$not-before"/>
        <xsl:with-param name="not-after"   select="$not-after"/>
        <xsl:with-param name="not-between" select="$not-between"/>
        <xsl:with-param name="hyph-char"   select="$hyph-char"/>
        <xsl:with-param name="min-before"  select="1"/>
        <xsl:with-param name="min-after"   select="$min-after"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>
