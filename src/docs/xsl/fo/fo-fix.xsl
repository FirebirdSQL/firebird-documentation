<?xml version='1.0' encoding="UTF-8"?>

<!--
  This stylesheet applies a 2nd pass to the FO output in order to 
  fix a problem with Apache FOP: if a basic-link contains just a 
  page-number-citation and no explicit content, no link is generated.
  On a practical level, this means that:
  - the page numbers in the ToC aren't clickable (BFD - they're a mile
    off anyway!)
  - indexes don't work at all.
  This stylesheet fixes the problem by adding a zero-width space after
  page-number-citations where needed.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:saxon="http://icl.com/saxon"
                exclude-result-prefixes="exsl"
                version='1.0'>

<!-- with method foxon:foxon.FOIndenter, indentation always takes
     place regardless of the indent attrib (for now).

     The namespace prefix is required by the standard (if you use a custom
     method, that is), but ignored by Saxon.
     From the Saxon doc:
     "The prefix of the QName must correspond to a valid namespace URI.
      It is recommended to use the Saxon URI "http://saxon.sf.net/",
      but this is not enforced."
-->
<xsl:output method="saxon:net.sf.foxon.FOIndenter"/>


<!-- Default: copy-through -->
<xsl:template match="node() | @*">
  <xsl:copy>
    <xsl:apply-templates select="node() | @*"/>
  </xsl:copy>
</xsl:template>


<xsl:template match="fo:basic-link/fo:page-number-citation">
  <!-- always copy to output: -->
  <xsl:copy>
    <xsl:apply-templates select="node() | @*"/>
  </xsl:copy>
  <!-- If the parent has any PRINTABLE content at all (before or after current)
       or ANY content (even whitespace) after current, do nothing.
       Otherwise, append zero-width space. -->
  <xsl:choose>
    <xsl:when test="normalize-space(..) != ''"/>
    <xsl:when test="following-sibling::node()[self::text() or self::*][string(.) != '']"/>
    <xsl:otherwise>&#x200B;</xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>



